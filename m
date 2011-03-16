Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F1790B6FFC
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Mar 2011 21:15:23 +1100 (EST)
Subject: Re: linux-next: build failure after merge of the final tree (ubi
	tree related)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Artem.Bityutskiy@nokia.com
In-Reply-To: <1300260170.2817.4.camel@localhost>
References: <20110316175041.67c4f371.sfr@canb.auug.org.au>
	<1300260170.2817.4.camel@localhost>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 16 Mar 2011 21:15:08 +1100
Message-ID: <1300270508.22236.1168.camel@pasglop>
Mime-Version: 1.0
Cc: ext Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-03-16 at 09:22 +0200, Artem Bityutskiy wrote:
> On Wed, 2011-03-16 at 17:50 +1100, ext Stephen Rothwell wrote:
> > Hi all,
> > 
> > After merging the final tree, today's linux-next build (powerpc
> > allyesconfig) failed like this:
> > 
> > drivers/mtd/ubi/io.c: In function 'ubi_dbg_check_write':
> > drivers/mtd/ubi/io.c:1348: error: 'PAGE_KERNEL' undeclared (first use in this function)
> > drivers/mtd/ubi/io.c: In function 'ubi_dbg_check_all_ff':
> > drivers/mtd/ubi/io.c:1412: error: 'PAGE_KERNEL' undeclared (first use in this function)
> > 
> > Caused by commit 823ed5091113 ("UBI: allocate write checking buffer on demand").
> > 
> > I don't know how to fix this, so I have left it for today.
> 
> Hmm, strange, include <linux/vmalloc.h> should be enough to use
> __vmalloc with 'PAGE_KERNEL' AFAICS, and we have this include... I'll
> try to look better.

Try adding asm/pgtable.h 

Cheers,
Ben.
