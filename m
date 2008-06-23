Return-Path: <adrian@rhlx01.hs-esslingen.de>
Received: from rhlx01.hs-esslingen.de (rhlx01.hs-esslingen.de [129.143.116.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "rhlx01.hs-esslingen.de", Issuer "HE CA - G02" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A0B03DDEE3
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jun 2008 19:36:23 +1000 (EST)
Date: Mon, 23 Jun 2008 11:30:24 +0200
From: Adrian Reber <adrian@lisas.de>
To: Tony Breeds <tony@bakeyournoodle.com>
Subject: Re: [PATCH 1/1] Change the default link address for pSeries zImage
	kernels.
Message-ID: <20080623093024.GA9377@lisas.de>
References: <1a551391a3c4925271cc86cb2e957aaccb0b599c.1214208801.git.tony@bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1a551391a3c4925271cc86cb2e957aaccb0b599c.1214208801.git.tony@bakeyournoodle.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jun 23, 2008 at 06:13:23PM +1000, Tony Breeds wrote:
> Currently we set the start of the .text section to be 4Mb for pSeries.
> In situations where the zImage is > 8Mb we'll fail to boot (due to
> overlapping with OF).  Move .text in a zImage from 4MB to 64MB (well past OF).
> 
> We still will not be able to load large zImage unless we also move OF,
> to that end, add a note to the zImage ELF to move OF to 32Mb.  If this
> is the very first kernel booted then we'll need to moev OF manually by
> setting real-base.

Does this change also affect kernels for SLOF based systems (JS20, JS21,
Bimini/Powerstation, QS21, QS22)?

To avoid exactly that problem SLOF moved to a bit below 256MB on all
those platforms (about 220MB). There should be still enough space
between 64MB and 220MB to boot large kernels. It is, however, decreased
by 60MB.

		Adrian
