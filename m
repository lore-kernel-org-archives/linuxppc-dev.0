Return-Path: <matt@genesi-usa.com>
Received: from mail.pegasosppc.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F0B1D6862A
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Oct 2005 11:11:26 +1100 (EST)
Received: from yukito.bakuhatsu.net ([66.93.214.113] helo=yukito)
	by mail.pegasosppc.com with esmtpa (Exim 4.51 (FreeBSD))
	id 1EWHES-0004Ex-H3
	for linuxppc-dev@ozlabs.org; Sun, 30 Oct 2005 17:44:36 +0000
From: "Matt Sealey" <matt@genesi-usa.com>
To: <linuxppc-dev@ozlabs.org>
Date: Sun, 30 Oct 2005 17:38:50 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Message-Id: <E1EWHES-0004Ex-H3@mail.pegasosppc.com>
Subject: PowerPC PVR version bug (G4 etc.)
Reply-To: matt@genesi-usa.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


There is a small, innocuous but annoying processor version reporting bug.

/proc/cpuinfo for my 1Ghz 7447 says

revision : 0.1 (pvr 8002 0101)

In fact the processor is version 1.1. You can see it is properly encoded
but the macro used to decode it is (in asm-ppc/reg.h):

#define PVR_MAJ(pvr)	(((pvr) >>  4) & 0xF)	/* Major revision field */
#define PVR_MIN(pvr)	(((pvr) >>  0) & 0xF)	/* Minor revision field */

When Freescale processors are detected, it sets maj and min to the results
of these macros.

Then it prints:

seq_printf(m, "revision\t: %hd.%hd (pvr %04x %04x)\n",
	maj, min, PVR_VER(pvr), PVR_REV(pvr));

Obviously for standalone Freescale processors, at least this is plain wrong;
the correct shift is >> 8 for the major revision field. There is a comment
above the PVR_ macros that this is an IBM encoding scheme, so..

Any chance of a minor fix for this? It will affect every G4 processor ever
made which is a lot of chips in a lot of machines, and for systems that can
use a 7447, 7447A, 7448 there are two or three PVRs (7448 especially which
has a 1.1 and a 2.1 version) that can produce a 0.1 result which may cause
problems if someone accidentally decides to grep that string and ignore the
PVR.

As I said it's innocuous but it's there.

Thanks :)

-- 
Matt Sealey <matt@genesi-usa.com>
Manager, Genesi, Developer Relations
