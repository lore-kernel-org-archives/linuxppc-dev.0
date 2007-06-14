Return-Path: <chuck@ThePTRGroup.com>
Received: from mail.theptrgroup.com (mail.theptrgroup.com [71.246.247.9])
	by ozlabs.org (Postfix) with ESMTP id F4217DDEEC
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jun 2007 22:39:18 +1000 (EST)
Message-ID: <4671321E.9000204@ThePTRGroup.com>
Date: Thu, 14 Jun 2007 08:18:38 -0400
From: Chuck Meade <chuck@ThePTRGroup.com>
MIME-Version: 1.0
To: joakim.tjernlund@transmode.se
Subject: Re: ucc_geth DPRAM alloc error, 2.6.22-rc3
References: <989B956029373F45A0B8AF0297081890D2ADB4@zch01exm26.fsl.freescale.net>
	<1181807671.30670.358.camel@gentoo-jocke.transmode.se>
In-Reply-To: <1181807671.30670.358.camel@gentoo-jocke.transmode.se>
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Liu Dave-r63238 <DaveLiu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This output looks buggy:

Joakim Tjernlund wrote:
> On Thu, 2007-06-14 at 15:37 +0800, Li Yang-r58472 wrote:
>> Try remove the following lines in rheap.c
>>
>>          /* given alignment larger that default rheap alignment */
>>          if (alignment > info->alignment)
>>                  size += alignment - 1;
>>
>> I don't know if this breaks other things, just have a try.
> I did and got this alloc:
> MURAM alloc, start:400, size:200(512), align:8(8)
> MURAM alloc, start:600, size:208(520), align:8(8)
> MURAM alloc, start:880, size:80(128), align:80(128)

Bogus -- note the overlap below
> MURAM alloc, start:900, size:1a0(416), align:100(256)
> MURAM alloc, start:a40, size:40(64), align:20(32)

> MURAM alloc, start:b00, size:100(256), align:100(256)

Another overlap(s) below-- all of these overlap
> MURAM alloc, start:c00, size:a0(160), align:100(256)
> MURAM alloc, start:c40, size:c(12), align:40(64)
> MURAM alloc, start:c18, size:30(48), align:8(8)
> MURAM alloc, start:c80, size:80(128), align:80(128)

> MURAM alloc, start:d00, size:80(128), align:80(128)
> MURAM alloc, start:d80, size:80(128), align:80(128)
> MURAM alloc, start:e00, size:80(128), align:80(128)
> MURAM alloc, start:e80, size:40(64), align:40(64)
> MURAM alloc, start:ec0, size:40(64), align:40(64)
> MURAM alloc, start:f00, size:40(64), align:40(64)

Another overlap--
> MURAM alloc, start:f40, size:40(64), align:40(64)
> MURAM alloc, start:f44, size:5d(93), align:4(4)

> MURAM alloc, start:f48, size:200(512), align:8(8)
> MURAM alloc, start:1148, size:208(520), align:8(8)
> MURAM alloc, start:1380, size:80(128), align:80(128)

And here-
> MURAM alloc, start:1400, size:1a0(416), align:100(256)
> MURAM alloc, start:1580, size:40(64), align:20(32)

> MURAM alloc, start:1600, size:100(256), align:100(256)

Here- note the start address moving backward.  All overlap.
> MURAM alloc, start:1700, size:a0(160), align:100(256)
> MURAM alloc, start:1780, size:c(12), align:40(64)
> MURAM alloc, start:1758, size:30(48), align:8(8)

> MURAM alloc, start:1800, size:80(128), align:80(128)
> MURAM alloc, start:1880, size:80(128), align:80(128)
> MURAM alloc, start:1900, size:80(128), align:80(128)

And-
> MURAM alloc, start:1980, size:80(128), align:80(128)
> MURAM alloc, start:19c0, size:40(64), align:40(64)

> MURAM alloc, start:1a00, size:40(64), align:40(64)
> MURAM alloc, start:1a40, size:40(64), align:40(64)

And-
> MURAM alloc, start:1a80, size:40(64), align:40(64)
> MURAM alloc, start:1a88, size:5d(93), align:4(4)
> MURAM alloc, start:1a88, size:200(512), align:8(8)

> MURAM alloc, start:1c88, size:208(520), align:8(8)
> MURAM alloc, start:1f00, size:80(128), align:80(128)

And-
> MURAM alloc, start:2000, size:1a0(416), align:100(256)
> MURAM alloc, start:20c0, size:40(64), align:20(32)

> MURAM alloc, start:2100, size:100(256), align:100(256)
> MURAM alloc, start:2200, size:a0(160), align:100(256)

An overlap exists here too-
> MURAM alloc, start:22c0, size:c(12), align:40(64)
> MURAM alloc, start:22a0, size:30(48), align:8(8)

> MURAM alloc, start:2300, size:80(128), align:80(128)
> MURAM alloc, start:2380, size:80(128), align:80(128)
> MURAM alloc, start:2400, size:80(128), align:80(128)
> MURAM alloc, start:2480, size:80(128), align:80(128)
> MURAM alloc, start:2500, size:40(64), align:40(64)
> MURAM alloc, start:2540, size:40(64), align:40(64)
> MURAM alloc, start:2580, size:40(64), align:40(64)

And-
> MURAM alloc, start:25c0, size:40(64), align:40(64)
> MURAM alloc, start:25cc, size:5d(93), align:4(4)
> 
> But I can't ping anymore

These buffer overlaps probably have a lot to do with your pings stopping.
I would say first order of business would be to investigate what could
be generating all these overlapped allocations.  Some of these make me think
the allocator code could be racy, like allocations are not aware of other
"recent" or ongoing allocations.  But in any case the allocator is broken.

Chuck
