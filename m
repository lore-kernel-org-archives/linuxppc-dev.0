Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CF0192C014E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jan 2014 15:18:39 +1100 (EST)
Message-ID: <1389154706.4672.21.camel@pasglop>
Subject: Re: [PATCH] powerpc: Fix alignment of secondary cpu spin vars
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
Date: Wed, 08 Jan 2014 15:18:26 +1100
In-Reply-To: <1389154189.2076.5.camel@concordia>
References: <1388264507-5100-1-git-send-email-olof@lixom.net>
 <CAOesGMhHw-G-T7ZfNsVU92ftOucCNe9shNJtA7SWzqX=dQBQng@mail.gmail.com>
 <CAOesGMgsY0R6KBXXH_ibTBYb1i_auWESwnoDkvi-esb58Pc+2A@mail.gmail.com>
 <20140103081219.GA10233@quad.lixom.net> <1389154189.2076.5.camel@concordia>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Anton Blanchard <anton@samba.org>, chzigotzky@xenosoft.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-01-08 at 15:09 +1100, Michael Ellerman wrote:
> > Of course, main worry is that this is just hiding some latent NULL
> deref in
> > the kernel now... :-/
> 
> Wow, that would have to come close to winning the
> grossest-hack-in-arch-powerpc
> award :)
> 
> Have you tried changing the value at 8 to point to a reserved page?
> 
> Some other possibilities:
> 
>  * Change the #define so FIXUP_ENDIAN is empty for PASEMI, that would
> mean
>    you'd only be able to boot pasemi_defconfig.
>  * Move the hack into FIXUP_ENDIAN

We actually found the root cause on irc the other day, I was waiting for
Olof to send a fix :-)

Olof: Can you try this totally untested patch ?

--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -1986,8 +1986,6 @@ static void __init prom_init_stdout(void)
        /* Get the full OF pathname of the stdout device */
        memset(path, 0, 256);
        call_prom("instance-to-path", 3, 1, prom.stdout, path, 255);
-       stdout_node = call_prom("instance-to-package", 1, 1, prom.stdout);
-       val = cpu_to_be32(stdout_node);
        prom_setprop(prom.chosen, "/chosen", "linux,stdout-package",
                     &val, sizeof(val));
        prom_printf("OF stdout device is: %s\n", of_stdout_device);
@@ -1995,10 +1993,14 @@ static void __init prom_init_stdout(void)
                     path, strlen(path) + 1);
 
        /* If it's a display, note it */
-       memset(type, 0, sizeof(type));
-       prom_getprop(stdout_node, "device_type", type, sizeof(type));
-       if (strcmp(type, "display") == 0)
-               prom_setprop(stdout_node, path, "linux,boot-display", NULL, 0);
+       stdout_node = call_prom("instance-to-package", 1, 1, prom.stdout);
+       if (stdout_node != PROM_ERROR) {
+               val = cpu_to_be32(stdout_node);
+               memset(type, 0, sizeof(type));
+               prom_getprop(stdout_node, "device_type", type, sizeof(type));
+               if (strcmp(type, "display") == 0)
+                       prom_setprop(stdout_node, path, "linux,boot-display", NU
+       }
 }
