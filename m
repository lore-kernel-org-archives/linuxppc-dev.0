Return-Path: <shawnxjin@gmail.com>
Received: from mail-pz0-f42.google.com (mail-pz0-f42.google.com
	[209.85.210.42]) by ozlabs.org (Postfix) with ESMTP id BE7E1B70A6
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Aug 2010 15:13:40 +1000 (EST)
Received: by pzk30 with SMTP id 30so3392803pzk.15
	for <linuxppc-dev@ozlabs.org>; Wed, 04 Aug 2010 22:13:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTi=x-EA59xfn_r5xMuJL6mufObSvSSEOeY9KTjQS@mail.gmail.com>
References: <AANLkTi=x-EA59xfn_r5xMuJL6mufObSvSSEOeY9KTjQS@mail.gmail.com>
Date: Wed, 4 Aug 2010 22:13:39 -0700
Message-ID: <AANLkTin3u=U-L2grncS_UtWqkGnb9bNUy4a4nqkRhQQ9@mail.gmail.com>
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

> I'm trying to relocate the bootwrapper from the default address
> (0x400000) to a higher address (e.g. 0x800000) in order to support a
> larger than 4MB initramfs. However the kernel panic when trying to
> access the device tree blob which was relocated accordingly to a
> higher address. The kernel message from __log_buf is shown below.
>
> The flat tree located at 0xbe4300 as the kerne message showed. Why
> cannot the kernel access this area? No TLB set for this area?
>
> <1>Unable to handle kernel paging request for data at address 0xc0be4308
> <1>Faulting instruction address: 0xc01fdabc
> <4>Oops: Kernel access of bad area, sig: 11 [#1]

Before the flat tree was accessed, I checked the DTLB and didn't find
any entry related to 0xc0be4300. After the exception, I found the
following DTLBs.

30 : 02  c0be4000   4KB ------ -> 00000000
31 : 00  fa000000   8MB VI-S-M -> fa000000

The DTLB#30 doesn't seem right. Why would it map to 0x0? I think this
should be something like 00be4000?

Thanks,
-Shawn.
