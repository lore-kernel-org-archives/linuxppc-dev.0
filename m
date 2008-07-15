Return-Path: <rdreier@cisco.com>
Received: from sj-iport-5.cisco.com (sj-iport-5.cisco.com [171.68.10.87])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "sj-iport-5.cisco.com", Issuer "Cisco SSCA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 75725DEFC9
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jul 2008 06:34:43 +1000 (EST)
From: Roland Dreier <rdreier@cisco.com>
To: arnd@arndb.de
Subject: Re: [patch 9/9] powerpc/cell: Add DMA_ATTR_STRONG_ORDERING dma
	attribute and use in IOMMU code
References: <20080715195139.316677337@arndb.de>
	<20080715195740.098068951@arndb.de>
Date: Tue, 15 Jul 2008 13:34:38 -0700
In-Reply-To: <20080715195740.098068951@arndb.de> (arnd@arndb.de's message of
	"Tue, 15 Jul 2008 21:51:48 +0200")
Message-ID: <ada3amaevj5.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Nelson <markn@au1.ibm.com>, cbe-oss-dev@ozlabs.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sorry for the late comments, I missed this when it went by before.

 > +DMA_ATTR_STRONG_ORDERING
 > +----------------------
 > +
 > +DMA_ATTR_STRONG_ORDERING specifies that previous reads and writes are
 > +performed in the order in which they're received by the IOMMU; thus
 > +reads and writes may not pass each other.

I don't understand what this is trying to say.  What is "previous"
referring to?  What does "received by the IOMMU" mean -- do you mean
issued onto the bus by the CPU? When you say "reads and writes may not
pass each other," do you mean just that reads may not pass writes and
writes may not pass reads, or do you mean that reads also can't pass
reads and writes can't pass writes?

Since I don't know exactly what this attribute does, I can't be sure,
but it seems that making weak ordering the default is dangerous in that
it breaks drivers that expect usual memory ordering semantics.  Would it
be safer/better to make strong ordering the default and then add a
"WEAK_ORDERING" attribute that drivers can use as an optimization?

 - R.
