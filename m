Return-Path: <netstv@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.180])
	by ozlabs.org (Postfix) with ESMTP id CDA0E67B3D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 May 2006 07:29:29 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id c59so488812pyc
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 May 2006 14:29:27 -0700 (PDT)
Message-ID: <b4b98b690605301429q4f474ec4g9545005de192e1d6@mail.gmail.com>
Date: Tue, 30 May 2006 14:29:27 -0700
From: "Steve Iribarne (GMail)" <netstv@gmail.com>
To: "Anantharaman Chetan-W16155" <Chetan.S.Anantharaman@motorola.com>
Subject: Re: execve of /sbin/init fails
In-Reply-To: <EDF27F298D4B03498AE0C249A941DFF803D6DE@de01exm68.ds.mot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <EDF27F298D4B03498AE0C249A941DFF803D6DE@de01exm68.ds.mot.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 5/30/06, Anantharaman Chetan-W16155
<Chetan.S.Anantharaman@motorola.com> wrote:
>
>
>
>
> Hi,
>
> I am trying to bring up a custom board with a PPC405 processor running Linux
> 2.4.20 (MontaVista Release) and am having problems with the call to
> execve("/sbin/init", argv_init, envp_init) not returning in the file main.c.


Hmm.. Ok.. so I've read the other suggestions all good, but I think we
are missing some info.  Are you running Busybox?  If you are using
Busybox, what version?  Also, what init are you using?  Are you using
busyboxes?

The ramdisk suggestion was a good one.  First off, check what is in
your ramdisk.  Also check the rights of the files in the ramdisk.
Make sure you have the execute bit set.  I've seen exactly what you
are seeing when my rights on the file init were messed up.

Also I think I've seen a hang with an older version of Busybox using
their version of init.  I just got sysinit and that seemed to fix it,
(Although I had to reconfig Busybox to not use their version of init)




> The processor just hangs and there is no output on the terminal.


When you say the process just "hangs", where are you in the boot
cycle?  Is it before you see the linux kernel starting to load?  Or do
you see any kernel messages start to spew out?

Hope this helps a little.

-stv
