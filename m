Return-Path: <shawnxjin@gmail.com>
Received: from mail-ey0-f170.google.com (mail-ey0-f170.google.com
	[209.85.215.170]) by ozlabs.org (Postfix) with ESMTP id 27AF9B6EDD
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Aug 2010 15:55:42 +1000 (EST)
Received: by eyh6 with SMTP id 6so11383535eyh.15
	for <linuxppc-dev@ozlabs.org>; Sun, 08 Aug 2010 22:55:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1281134958.2168.39.camel@pasglop>
References: <AANLkTi=x-EA59xfn_r5xMuJL6mufObSvSSEOeY9KTjQS@mail.gmail.com>
	<AANLkTin3u=U-L2grncS_UtWqkGnb9bNUy4a4nqkRhQQ9@mail.gmail.com>
	<AANLkTikS3f8q+Kuq8aYX1vhRotfSMHN_S+qKPwrfDn2j@mail.gmail.com>
	<20100805123725.63d009b1@schlenkerla.am.freescale.net>
	<AANLkTinqLCvRii4zCArHG=whHa0H6bparf=5sUkGDUTw@mail.gmail.com>
	<20100805134654.70f8f787@schlenkerla.am.freescale.net>
	<1281134958.2168.39.camel@pasglop>
Date: Sun, 8 Aug 2010 22:55:40 -0700
Message-ID: <AANLkTikkRTNU=HWdpvTH-PryeL1mfA12HHFjkXUO8zaU@mail.gmail.com>
Subject: Re: Relocating bootwrapper causes kernel panic
From: Shawn Jin <shawnxjin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>, ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> > >> I think the cause is clear now. But how to fix it? Two questions:
>> > >> 2. If the DTLB miss exception handler is not the right guy to load =
a
>> > >> proper TLB entry, how can I set one entry based on the link_address
>> > >> and the address of the flat dt blob?
>> > >
>> > > Given how early in the boot process it is, it's probably going to ne=
ed
>> > > to be handled specially.
>> >
>> > What APIs can I use to set up DTLBs?
>>
>> I don't think there is one that works on 8xx. =A0You'll could hack up
>> initial_mmu, or else write some C code to insert an 8xx TLB entry.
>
> Yup, I think he just ends up getting out of the initial mapping which is
> smallish on 8xx, no ? Might be worth sticking in one more entry during
> boot...

If CONFIG_PIN_TLB is on, two more entries are pinned down, which gives
16MB mappings. Just curious. Why is there only one entry by default?
what's the trade-off to pin down all 4 entries?

THanks,
-Shawn.
