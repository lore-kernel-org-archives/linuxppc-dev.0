Return-Path: <bzolnier@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.174])
	by ozlabs.org (Postfix) with ESMTP id BA19CDDDD8
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 07:07:12 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k40so348835ugc
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 14:07:10 -0700 (PDT)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: compile error if CONFIG_BLOCK not enabled related to linux/ide.h
	include
Date: Wed, 18 Jul 2007 22:44:40 +0200
References: <Pine.LNX.4.64.0707172353050.29097@blarg.am.freescale.net>
	<200707181247.26262.bzolnier@gmail.com>
	<162F0B67-44AB-4955-873A-150224C128CB@kernel.crashing.org>
In-Reply-To: <162F0B67-44AB-4955-873A-150224C128CB@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707182244.40282.bzolnier@gmail.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 18 July 2007, Kumar Gala wrote:
> 
> On Jul 18, 2007, at 5:47 AM, Bartlomiej Zolnierkiewicz wrote:
> 
> >
> > Hi,
> >
> > On Wednesday 18 July 2007, Kumar Gala wrote:
> >> M:      bzolnier@gmail.com
> >> L:      linux-ide@vger.kernel.org
> >>
> >> We get the following compile error if CONFIG_BLOCK isn't enabled:
> >>
> >>   CC      arch/powerpc/kernel/setup_32.o
> >> In file included from arch/powerpc/kernel/setup_32.c:14:
> >> include/linux/ide.h:558: error: expected specifier-qualifier-list  
> >> before 'request_queue_t'
> >> include/linux/ide.h:696: warning: 'struct request' declared inside  
> >> parameter list
> >> include/linux/ide.h:696: warning: its scope is only this  
> >> definition or declaration, which is probably not what you want
> >> include/linux/ide.h:820: warning: 'struct request' declared inside  
> >> parameter list
> >> include/linux/ide.h:853: error: field 'wrq' has incomplete type
> >> include/linux/ide.h:1205: error: expected ')' before '*' token
> >> make[1]: *** [arch/powerpc/kernel/setup_32.o] Error 1
> >> make: *** [arch/powerpc/kernel] Error 2
> >
> > include/linux/ide.h is exclusively for IDE subsystem
> >
> >> What I'm trying to figure out is if include/linux/ide.h should be  
> >> wrapped
> >> in a #if defined(CONFIG_IDE) || defined(CONFIG_IDE_MODULE) or if  
> >> there is
> >> some other desired way to handle this.
> >
> > Plese remove <linux/ide.h> include, there doesn't seem to be any  
> > piece of
> > code in arch/powerpc/kernel/setup_32.c which needs it anyway.
> 
> Its needed for:
> 
> struct ide_machdep_calls ppc_ide_md;
> 
> which gets defined in asm/ide.h which needs linux/ide.h for the defn  
> of ide_init_hwif.

Ah, this is a PPC special case.

In this case I think the best solution for now is to just add #ifdefs
(the proper/clean solution would be adding IDE host drivers for PPC
platforms needing special handling).

Thanks,
Bart
