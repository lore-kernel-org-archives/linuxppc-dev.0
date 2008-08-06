Return-Path: <glikely@secretlab.ca>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.172])
	by ozlabs.org (Postfix) with ESMTP id DA5A7DDED5
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Aug 2008 16:02:22 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so5593181wfg.15
	for <linuxppc-dev@ozlabs.org>; Tue, 05 Aug 2008 23:02:21 -0700 (PDT)
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [RFC/PATCH 0/3] Attempt at making 32bit BAT assignment more
	intelligent
To: linuxppc-dev@ozlabs.org, benh@kernel.crashing.org, paulus@samba.org,
	galak@kernel.crashing.org, jwboyer@linux.vnet.ibm.com
Date: Wed, 06 Aug 2008 00:02:17 -0600
Message-ID: <20080806055214.30717.86092.stgit@trillian.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: Grant Likely <glikely@secretlab.ca>
Cc: miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here is my attempt to make BAT allocations dynamic instead of hard coded.
The first patch changes setbat() to dynamically assign BATs instead of requiring
the caller to select a BAT on its own.

A primary user of setbat is mmu_mapin_ram() which used to hard code BATs
2 and 3 for mapping as much of RAM as can fit in 2 BATs.  The first patch
changes the routine to try to use as many BATs as it needs to map all of RAM.
(Note: I've still got BAT0 reserved for mapping RAM, so even if lots of other
users of setbat() appear, RAM is guaranteed to be allocated at least 1 BAT).

The first patch also adds an ioremap_bat() function which works like
ioremap(), but uses BATs instead of page tables and can be called really
early (before MMU_init()).  ioremap_bat() mappings persist after MMU_init
is called too so it can be used to map all of an SoC's IMMR region, or
any other IO device for that matter.  I've seen about a 2.5% performance
improvement by using this on a simple network workload with SoC registers
BAT mapped.

The second patch is just a utility function required by the third patch.

The third patch is a new user of ioremap_bat() to implement early debug
support for the mpc5200 platform.

The first patch is the one I really want feedback on.  It shouldn't break
any 32 bit platforms, but I need testing to make sure.  Also, this is my
first attempt at messing with MMU code, so please let me know if I'm doing
anything foolish or dangerous.

Kumar, Josh; I'd appreciate testing to make sure patch 1 doesn't break stuff.

Thanks,
g.

--
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
