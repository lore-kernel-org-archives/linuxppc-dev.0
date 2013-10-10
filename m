Return-Path: <computersforpeace@gmail.com>
Received: from mail-oa0-x231.google.com (mail-oa0-x231.google.com
 [IPv6:2607:f8b0:4003:c02::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9961B2C00A9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Oct 2013 05:23:58 +1100 (EST)
Received: by mail-oa0-f49.google.com with SMTP id i4so1641989oah.8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Oct 2013 11:23:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20131010180948.4350ebda@crub>
References: <1380295718-10700-1-git-send-email-gsi@denx.de>
 <20131009192931.GC23337@ld-irv-0074.broadcom.com>
 <20131010180948.4350ebda@crub>
Date: Thu, 10 Oct 2013 11:23:55 -0700
Message-ID: <CAN8TOE8o-34zFP=0q3NjondqpA6UA1szitN+kgKcbaNOWhrscg@mail.gmail.com>
Subject: Re: [v1] powerpc/mpc512x: silence build warning upon disabled DIU
From: Brian Norris <computersforpeace@gmail.com>
To: Anatolij Gustschin <agust@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
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

On Thu, Oct 10, 2013 at 9:09 AM, Anatolij Gustschin <agust@denx.de> wrote:
> On Wed, 9 Oct 2013 12:29:31 -0700
> Brian Norris <computersforpeace@gmail.com> wrote:
> ...
>> > +#else
>> > +void __init mpc512x_setup_diu(void) { /* EMPTY */ }
>> > +void __init mpc512x_init_diu(void) { /* EMPTY */ }
>> >  #endif
>> >
>> >  void __init mpc512x_init_IRQ(void)
>>
>> I see an alternative solution:
>>
>> Can't almost all of the code in mpc512x_shared.c be declared 'static'?
>
> making mpc512x_setup_diu(), mpc512x_release_bootmem(),
> mpc512x_valid_monitor_port() and void mpc512x_set_pixel_clock()
> should be okay.

And mpc512x_init_diu()?

>> Then, you can get the real benefit of IS_ENABLED() by removing the
>>
>>     #if IS_ENABLED(CONFIG_FB_FSL_DIU)
>>
>> from around all the DIU code, and it will automatically be removed by
>> the compiler when it is not used.
>>
>> I think the current patch is necessary for immediate use, and it can be
>> sent to stable. But I might suggest a follow-up patch or 2 that makes
>> the functions static and kills the #ifdef entirely.
>
> Yes, we also have to remove CONFIG_FB_FSL_DIU ifdef in
> arch/powerpc/sysdev/fsl_soc.h and building should work then.

Still want it around this line, probably, so we'll get compiler errors
and not linker errors if someone tries to use it?

    extern struct platform_diu_data_ops diu_ops;

But otherwise that looks OK to me. Shall I send a patch?

Brian
