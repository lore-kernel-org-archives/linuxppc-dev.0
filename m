Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B1E4E67BBD
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Aug 2006 00:20:22 +1000 (EST)
In-Reply-To: <000401c6bf9b$9be32ab0$99dfdfdf@bakuhatsu.net>
References: <000401c6bf9b$9be32ab0$99dfdfdf@bakuhatsu.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E4BC5B1C-329D-48D7-A605-81931B83011D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: PowerPC paxtest results w/ gcc-4.1
Date: Mon, 14 Aug 2006 09:20:09 -0500
To: matt@genesi-usa.com
Cc: 'Albert Cahalan' <acahalan@gmail.com>, linuxppc-dev@ozlabs.org,
	'debian-powerpc' <debian-powerpc@lists.debian.org>,
	'Paul Mackerras' <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 14, 2006, at 7:17 AM, Matt Sealey wrote:

>
>
>> That looks like a 64-bit system, which doesn't have the
>> granularity problem anyway. 32-bit powerpc seems to be
>> decent. The heap shares with the executable itself, and of
>> course there is the yucky 2 GB limit.
>
> One thing I'm curious about, has anyone EVER made a system which
> actually used the 36-bit addressing on the G4?

I believe Marvell was the only one that had chipsets that supported  
the larger addressing.  Looks like the TSI 108 does as well.

The 44x has some "hacks" to allow support for larger pages for IO  
operations.  Having struct resource now be 64-bits and some of the  
page mapping functions takes pfn's make it easier to support 36-bit  
physical.

> I always wondered why such support was never in Linux but then
> again if nobody connected the other 4 address lines on any PowerPC
> board ever made that ran Linux, there's nothing ever to test it
> on anyway. It wouldn't be any more problematic (same way as the NX
> bit..) than Intel PAE support, right?

True, there is more infrastructure now to support it better.  I'm not  
sure how well PAE is supported in stock kernels.  Go look for  
discussions on the 4G/4G patches.

- kumar
