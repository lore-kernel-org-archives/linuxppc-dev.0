Return-Path: <SRS0+4b5715398c2ed5d70d4f+1150+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A7A61679E7
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 18 Oct 2006 03:37:48 +1000 (EST)
Subject: Re: JFFS2 on Lite5200
From: David Woodhouse <dwmw2@infradead.org>
To: Andrey Volkov <avolkov@varma-el.com>
In-Reply-To: <4534E078.9030301@varma-el.com>
References: <1161081183.22948.58.camel@localhost.localdomain>
	<4534D8A5.7060206@varma-el.com> <1161092193.3260.61.camel@sauron>
	<4534E078.9030301@varma-el.com>
Content-Type: text/plain
Date: Tue, 17 Oct 2006 18:37:10 +0100
Message-Id: <1161106630.23666.109.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Cc: dedekind@infradead.org, Andrea Galbusera <andrea.galbusera@teamware.it>,
	linux-mtd@lists.infradead.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 2006-10-17 at 17:54 +0400, Andrey Volkov wrote:
> No, MPC5200 could write any size chunks, but it must be aligned (same
> restrictions as in SH4), and this restriction applied only to LPB, but
> not SDRAM.
> 
> Also, I've in view that jffs2(jffs3 ?) read/write stuff already used
> functions which MTD drivers exported, but jffs2_scan_dirent_node and
> friends - doesn't.

There are two modes of operation for JFFS2 scan. Either it can use the
MTD device's read() function to read from the flash into memory and scan
from there, or -- IF the flash can be accessed as if it were normal
memory -- it can use the point() method and skip the read() call by
using a pointer directly into the flash.

In your case, the flash cannot be accessed directly as if it were normal
memory. So your map driver probably shouldn't be allowing point() to
succeed.

Having said that, I'm not entirely sure we have the code set up so that
'simple' map drivers _can_ prevent point(). We may need to fix that.

-- 
dwmw2
