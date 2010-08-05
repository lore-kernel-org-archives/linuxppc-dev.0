Return-Path: <shawnxjin@gmail.com>
Received: from mail-px0-f170.google.com (mail-px0-f170.google.com
	[209.85.212.170]) by ozlabs.org (Postfix) with ESMTP id 79F371007D6
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Aug 2010 17:23:19 +1000 (EST)
Received: by pxi6 with SMTP id 6so3403714pxi.15
	for <linuxppc-dev@ozlabs.org>; Thu, 05 Aug 2010 00:23:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTin3u=U-L2grncS_UtWqkGnb9bNUy4a4nqkRhQQ9@mail.gmail.com>
References: <AANLkTi=x-EA59xfn_r5xMuJL6mufObSvSSEOeY9KTjQS@mail.gmail.com>
	<AANLkTin3u=U-L2grncS_UtWqkGnb9bNUy4a4nqkRhQQ9@mail.gmail.com>
Date: Thu, 5 Aug 2010 00:23:17 -0700
Message-ID: <AANLkTikS3f8q+Kuq8aYX1vhRotfSMHN_S+qKPwrfDn2j@mail.gmail.com>
Subject: Re: Relocating bootwrapper causes kernel panic
From: Shawn Jin <shawnxjin@gmail.com>
To: ppcdev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> The flat tree located at 0xbe4300 as the kerne message showed. Why
>> cannot the kernel access this area? No TLB set for this area?
>>
>> <1>Unable to handle kernel paging request for data at address 0xc0be4308
>> <1>Faulting instruction address: 0xc01fdabc
>> <4>Oops: Kernel access of bad area, sig: 11 [#1]
>
> Before the flat tree was accessed, I checked the DTLB and didn't find
> any entry related to 0xc0be4300. After the exception, I found the
> following DTLBs.
>
> 30 : 02 =A0c0be4000 =A0 4KB ------ -> 00000000
> 31 : 00 =A0fa000000 =A0 8MB VI-S-M -> fa000000
>
> The DTLB#30 doesn't seem right. Why would it map to 0x0? I think this
> should be something like 00be4000?

When the early_debug is enabled, the kernel can boot successfully. I
checked the TLB settings and found the following.

28 : 00  c0000000   8MB V--S-M -> 00000000
29 : 00  fa000000   8MB VI-S-M -> fa000000
30 : 00  c0800000   8MB V--S-M -> 00800000
31 : 14  04919000   ?KB V---WM -> 00e45000

So the kernel can access the dtb at 0xbe4300 because of the pinned down DTL=
B#30.

I think the cause is clear now. But how to fix it? Two questions:
1. Should this DTLB miss exception properly set a new TLB entry for
the new dtb address 0xbe4300?
2. If the DTLB miss exception handler is not the right guy to load a
proper TLB entry, how can I set one entry based on the link_address
and the address of the flat dt blob?

Thanks a lot,
-Shawn.
