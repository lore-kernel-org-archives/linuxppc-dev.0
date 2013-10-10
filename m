Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E6E892C0185
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Oct 2013 03:10:04 +1100 (EST)
Date: Thu, 10 Oct 2013 18:09:48 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [v1] powerpc/mpc512x: silence build warning upon disabled DIU
Message-ID: <20131010180948.4350ebda@crub>
In-Reply-To: <20131009192931.GC23337@ld-irv-0074.broadcom.com>
References: <1380295718-10700-1-git-send-email-gsi@denx.de>
 <20131009192931.GC23337@ld-irv-0074.broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Gerhard Sittig <gsi@denx.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Wed, 9 Oct 2013 12:29:31 -0700
Brian Norris <computersforpeace@gmail.com> wrote:
...
> > +#else
> > +void __init mpc512x_setup_diu(void) { /* EMPTY */ }
> > +void __init mpc512x_init_diu(void) { /* EMPTY */ }
> >  #endif
> >  
> >  void __init mpc512x_init_IRQ(void)
> 
> I see an alternative solution:
> 
> Can't almost all of the code in mpc512x_shared.c be declared 'static'?

making mpc512x_setup_diu(), mpc512x_release_bootmem(),
mpc512x_valid_monitor_port() and void mpc512x_set_pixel_clock()
should be okay.

> Then, you can get the real benefit of IS_ENABLED() by removing the
> 
>     #if IS_ENABLED(CONFIG_FB_FSL_DIU)
> 
> from around all the DIU code, and it will automatically be removed by
> the compiler when it is not used.
> 
> I think the current patch is necessary for immediate use, and it can be
> sent to stable. But I might suggest a follow-up patch or 2 that makes
> the functions static and kills the #ifdef entirely.

Yes, we also have to remove CONFIG_FB_FSL_DIU ifdef in
arch/powerpc/sysdev/fsl_soc.h and building should work then.

Thanks,

Anatolij
