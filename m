Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id ED6CD2C00C3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Oct 2013 06:37:52 +1100 (EST)
Date: Thu, 10 Oct 2013 21:37:47 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [v1] powerpc/mpc512x: silence build warning upon disabled DIU
Message-ID: <20131010213747.4e56ca1f@crub>
In-Reply-To: <CAN8TOE8o-34zFP=0q3NjondqpA6UA1szitN+kgKcbaNOWhrscg@mail.gmail.com>
References: <1380295718-10700-1-git-send-email-gsi@denx.de>
 <20131009192931.GC23337@ld-irv-0074.broadcom.com>
 <20131010180948.4350ebda@crub>
 <CAN8TOE8o-34zFP=0q3NjondqpA6UA1szitN+kgKcbaNOWhrscg@mail.gmail.com>
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

Hello,

On Thu, 10 Oct 2013 11:23:55 -0700
Brian Norris <computersforpeace@gmail.com> wrote:
...
> > making mpc512x_setup_diu(), mpc512x_release_bootmem(),
> > mpc512x_valid_monitor_port() and void mpc512x_set_pixel_clock()
> > should be okay.
> 
> And mpc512x_init_diu()?

yes, it can be static, too.

> 
> >> Then, you can get the real benefit of IS_ENABLED() by removing the
> >>
> >>     #if IS_ENABLED(CONFIG_FB_FSL_DIU)
> >>
> >> from around all the DIU code, and it will automatically be removed by
> >> the compiler when it is not used.
> >>
> >> I think the current patch is necessary for immediate use, and it can be
> >> sent to stable. But I might suggest a follow-up patch or 2 that makes
> >> the functions static and kills the #ifdef entirely.
> >
> > Yes, we also have to remove CONFIG_FB_FSL_DIU ifdef in
> > arch/powerpc/sysdev/fsl_soc.h and building should work then.
> 
> Still want it around this line, probably, so we'll get compiler errors
> and not linker errors if someone tries to use it?
> 
>     extern struct platform_diu_data_ops diu_ops;
> 
> But otherwise that looks OK to me. Shall I send a patch?

yes, please.

Thanks,

Anatolij
