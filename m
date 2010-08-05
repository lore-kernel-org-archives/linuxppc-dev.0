Return-Path: <shawnxjin@gmail.com>
Received: from mail-pz0-f42.google.com (mail-pz0-f42.google.com
	[209.85.210.42]) by ozlabs.org (Postfix) with ESMTP id B09F9B6EED
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Aug 2010 04:33:45 +1000 (EST)
Received: by pzk30 with SMTP id 30so3761927pzk.15
	for <linuxppc-dev@ozlabs.org>; Thu, 05 Aug 2010 11:33:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100805123725.63d009b1@schlenkerla.am.freescale.net>
References: <AANLkTi=x-EA59xfn_r5xMuJL6mufObSvSSEOeY9KTjQS@mail.gmail.com>
	<AANLkTin3u=U-L2grncS_UtWqkGnb9bNUy4a4nqkRhQQ9@mail.gmail.com>
	<AANLkTikS3f8q+Kuq8aYX1vhRotfSMHN_S+qKPwrfDn2j@mail.gmail.com>
	<20100805123725.63d009b1@schlenkerla.am.freescale.net>
Date: Thu, 5 Aug 2010 11:33:44 -0700
Message-ID: <AANLkTinqLCvRii4zCArHG=whHa0H6bparf=5sUkGDUTw@mail.gmail.com>
Subject: Re: Relocating bootwrapper causes kernel panic
From: Shawn Jin <shawnxjin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> > Before the flat tree was accessed, I checked the DTLB and didn't find
>> > any entry related to 0xc0be4300. After the exception, I found the
>> > following DTLBs.
>> >
>> > 30 : 02 =A0c0be4000 =A0 4KB ------ -> 00000000
>> > 31 : 00 =A0fa000000 =A0 8MB VI-S-M -> fa000000
>> >
>> > The DTLB#30 doesn't seem right. Why would it map to 0x0? I think this
>> > should be something like 00be4000?
>
> Note that the valid bit is clear -- it's not mapping to anything.

Did the exception handler try to set a TLB here but the setting was
not completed?

>> I think the cause is clear now. But how to fix it? Two questions:
>> 2. If the DTLB miss exception handler is not the right guy to load a
>> proper TLB entry, how can I set one entry based on the link_address
>> and the address of the flat dt blob?
>
> Given how early in the boot process it is, it's probably going to need
> to be handled specially.

What APIs can I use to set up DTLBs?

Thanks,
-Shawn.
