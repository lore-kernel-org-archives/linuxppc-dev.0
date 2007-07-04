Return-Path: <clifford@clifford.at>
Received: from phoenix.clifford.at (phoenix.clifford.at [88.198.7.52])
	by ozlabs.org (Postfix) with ESMTP id B0B9EDDDE7
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  4 Jul 2007 19:02:27 +1000 (EST)
Date: Wed, 4 Jul 2007 11:05:54 +0200
From: Clifford Wolf <clifford@clifford.at>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Mem-2-Mem DMA - Generalized API
Message-ID: <20070704090554.GA30693@clifford.at>
References: <20070624193932.GA11797@clifford.at>
	<200706242221.57507.arnd@arndb.de>
	<467FA0EA.3000607@genesi-usa.com> <467FBABD.9040103@anagramm.de>
	<467FD1DF.4000602@genesi-usa.com>
	<20070625180110.GH20463@clifford.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070625180110.GH20463@clifford.at>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

On Mon, Jun 25, 2007 at 08:01:10PM +0200, Clifford Wolf wrote:
> I've put a 'draft header file' of an api as I would have expected it
> online: [...]

Ok, so here comes the first implementation:
(I also have other projects, so it took a while.. ;-)

	http://www.clifford.at/priv/dmatransfer-20070704.diff

This is just for the MPC8349 DMA now, registers are still hardcoded in the
driver instead of beeing taken from the platform files and support for
scatter-gather is still missing and the Kconfig integration isn't checking
if we are building for the mpc8349 (or even ppc) yet. But I think the
direction of the API is pretty clear.

The patch also contains a hackish demo client (dma_demo_client.ko) which is
performing some dma transfers in the 256th MB of physical memory. So it
should only be used on a machine with 256MB of memory bootet with mem=255M
(but changing that should be trivial). The demo client shows well how the
API works and how much overhead the API adds.

Any feedback this time?

yours,
 - clifford

-- 
#!/usr/bin/perl
$p="1"x1002;for$c(2..1000){if($p=~/^.{$c}0/){next;};printf"%3d\%s",
$c,++$x%14?" ":"\n";while($p=~s/^((.{$c})+)1/${1}0/){}}$_="lPSFZQ".
"SJNFTZBUZ<IUUQ:;;XXX.DMJGGPSE.BU;QSJNF;>\n";y:B-Zl;:a-x M/:;print;
