Return-Path: <bzolnier@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.170])
	by ozlabs.org (Postfix) with ESMTP id 534B9DDEBB
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 06:08:29 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so337943uge
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 13:08:27 -0700 (PDT)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Emil Medve <Emilian.Medve@freescale.com>
Subject: Re: [PATCH v2] [POWERPC] Fix build errors when BLOCK=n
Date: Wed, 19 Sep 2007 22:00:56 +0200
References: <1190227172-593-1-git-send-email-Emilian.Medve@Freescale.com>
In-Reply-To: <1190227172-593-1-git-send-email-Emilian.Medve@Freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200709192200.56605.bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org,
	kumar.gala@freescale.com, paulus@samba.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 19 September 2007, Emil Medve wrote:
> These are the symptom error messages:
> 
>   CC      arch/powerpc/kernel/setup_32.o
> In file included from include/linux/blkdev.h:17,
>                  from include/linux/ide.h:13,
>                  from arch/powerpc/kernel/setup_32.c:13:
> include/linux/bsg.h:67: warning: 'struct request_queue' declared inside parameter list
> include/linux/bsg.h:67: warning: its scope is only this definition or declaration, which is probably not what you want
> include/linux/bsg.h:71: warning: 'struct request_queue' declared inside parameter list
> In file included from arch/powerpc/kernel/setup_32.c:13:
> include/linux/ide.h:857: error: field 'wrq' has incomplete type
> 
>   CC      arch/powerpc/kernel/ppc_ksyms.o
> In file included from include/linux/blkdev.h:17,
>                  from include/linux/ide.h:13,
>                  from arch/powerpc/kernel/ppc_ksyms.c:15:
> include/linux/bsg.h:67: warning: 'struct request_queue' declared inside parameter list
> include/linux/bsg.h:67: warning: its scope is only this definition or declaration, which is probably not what you want
> include/linux/bsg.h:71: warning: 'struct request_queue' declared inside parameter list
> In file included from arch/powerpc/kernel/ppc_ksyms.c:15:
> include/linux/ide.h:857: error: field 'wrq' has incomplete type
> 
> The fix tries to use the smallest scope CONFIG_* symbols that will fix the build
> problem. In this case <linux/ide.h> needs to be included only if IDE=y or
> IDE=m were selected. Also, ppc_ide_md is needed only if BLK_DEV_IDE=y or
> BLK_DEV_IDE=m
> 
> Moved the EXPORT_SYMBOL(ppc_ide_md) from ppc_ksysms.c next to its declaration
> in setup_32.c
> 
> Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>

looks OK for me

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
