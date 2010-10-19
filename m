Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 00E07B6EEE
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 20 Oct 2010 07:48:27 +1100 (EST)
Message-ID: <56111.84.105.60.153.1287521237.squirrel@gate.crashing.org>
In-Reply-To: <20101019181021.22456.qmail@kosh.dhis.org>
References: <20101019181021.22456.qmail@kosh.dhis.org>
Date: Tue, 19 Oct 2010 22:47:17 +0200 (CEST)
Subject: Re: PROBLEM: memory corrupting bug, bisected to 6dda9d55
From: "Segher Boessenkool" <segher@kernel.crashing.org>
To: pacman@kosh.dhis.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> I made a new discovery.

And this nails it :-)

> So then I ran
>   dd if=/dev/mem bs=4 count=1 skip=$((0xfc5c080/4)) | od -t x4
> a few times very fast, plucking the first affected word directly out of
> memory by its physical address. The result:
>
> The low 16 bits are always zero as before. The high 16 bits are a counter,
> being incremented at about 1000Hz (as close as I could measure with a
> crude
> shell script. 1024Hz would also be within the margin of error). And it's
> little-endian.

> So what type of driver, firmware, or hardware bug puts a 16-bit 1000Hz
> timer
> in memory, and does it in little-endian instead of the CPU's native byte
> order? And why does it stop doing it some time during the early init
> scripts,
> shortly after the root filesystem fsck?

It looks like it is the frame counter in an USB OHCI HCCA.
16-bit, 1kHz update, offset x'80 in a page.

So either the kernel forgot to call quiesce on it, or the firmware
doesn't implement that, or the firmware messed up some other way.


Segher
