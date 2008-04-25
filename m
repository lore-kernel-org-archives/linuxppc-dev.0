Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 52C0DDDEF5
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Apr 2008 16:13:06 +1000 (EST)
Subject: Re: [PATCH] Change the default link address for pSeries zImage
	kernels.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tony Breeds <tony@bakeyournoodle.com>
In-Reply-To: <20080425053941.GT20457@bakeyournoodle.com>
References: <20080425053941.GT20457@bakeyournoodle.com>
Content-Type: text/plain
Date: Fri, 25 Apr 2008 16:12:50 +1000
Message-Id: <1209103970.9060.226.camel@pasglop>
Mime-Version: 1.0
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2008-04-25 at 15:39 +1000, Tony Breeds wrote:
> Currently we set the start of the .text section to be 4Mb for pSeries.
> In situations where the zImage is > 8Mb we'll fail to boot (due to
> overlapping with OF).  Move .text in a pSeries zImage from 4MB to 64MB
> (well past OF).
> 
> Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
> ---
>  - Compile tested for *_defconfig with only pSeries chaning it's link
>    address.
>  - Boot tested on POWER6

Considering how bad OF can be on some machines, I'd like this to be
boot-tested on a wider range of machines. Also, it might depend on the
OF real-base setting as well...

At least, we should be able to test at ozlabs on cell blades, POWER4
bare metal (ie "SMP mode"), POWER5 and POWER5+.

Cheers,
Ben.
