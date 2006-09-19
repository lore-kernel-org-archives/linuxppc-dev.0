Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 2A9CB67B53
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Sep 2006 04:53:36 +1000 (EST)
Date: Tue, 19 Sep 2006 13:52:59 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: linas@austin.ibm.com (Linas Vepstas)
Subject: Re: [POWERPC] convert string i/o operations to C
Message-Id: <20060919135259.303706d3.kim.phillips@freescale.com>
In-Reply-To: <20060919182953.GK29167@austin.ibm.com>
References: <20060919222351.d27a1a06.sfr@canb.auug.org.au>
	<20060919182953.GK29167@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: sfr@canb.auug.org.au, paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 19 Sep 2006 13:29:53 -0500
linas@austin.ibm.com (Linas Vepstas) wrote:

> 
> What does this twi do? According to my powerpc docs, this would be a
> no-op.  Does this have some magic synchronizing powers on certain
> implementations? If so, there should be at least a comment card added
> about why the twi is there. (This special ability of twi might be
> well-known to some, but still, this is not immediately obvious,
> and not immedately documented in e.g. the PEM.)

include/asm-p[ower]pc/io.h sheds some light on the matter:

 * With the sequence below (twi; isync; nop), we have found that
 * the machine check occurs on one of the three instructions on
 * all PPC implementations tested so far.  The twi and isync are
 * needed on the 601 (in fact twi; sync works too), the isync and
 * nop are needed on 604[e|r], and any of twi, sync or isync will
 * work on 603[e], 750, 74xx.
 * The twi creates an explicit data dependency on the returned
 * value which seems to be needed to make the 601 wait for the
 * load to finish.

Kim
