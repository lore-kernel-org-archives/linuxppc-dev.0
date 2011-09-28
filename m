Return-Path: <cel@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9BCC21007D3
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Sep 2011 07:23:44 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e8.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p8SL8eOo017519
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Sep 2011 17:08:40 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p8SLNZSU206382
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Sep 2011 17:23:35 -0400
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p8SLNYa6003833
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Sep 2011 15:23:34 -0600
Subject: [PATCH REPOST] perf event, POWER 6: L1 cache read and write access
	event code fix]
From: "Carl E. Love" <cel@linux.vnet.ibm.com>
To: pmac@au1.ibm.com, bherren@au1.ibm.com, linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 28 Sep 2011 14:23:33 -0700
Message-ID: <1317245013.5461.11.camel@oc5652146517.ibm.com>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ben, Paul:
 
I posted this patch to lkml but did not copy the linuxppc-dev@ozlabs.org
mailing list.  

                   Carl Love
---------------------------------------------------------------------

The current L1 cache read event code 0x80082 only counts for thread 0. The
event code 0x280030 should be used to count events on thread 0 and 1. The
patch fixes the event code for the L1 cache read.

The current L1 cache write event code 0x80086 only counts for thread 0. The
event code 0x180032 should be used to count events on thread 0 and 1. The
patch fixes the event code for the L1 cache write.

FYI, the documentation lists three event codes for the L1 cache read event
and three event codes for the L1 cache write event.  The event description
for the event codes is as follows:

L1 cache read requests  0x80082  LSU 0 only
L1 cache read requests  0x8008A  LSU 1 only
L1 cache read requests  0x80030  LSU 1 or LSU 0, counter 2 only.

L1 cache store requests 0x80086  LSU 0 only
L1 cache store requests 0x8008E  LSU 1 only
L1 cache store requests 0x80032  LSU 0 or LSU 1, counter 1 only.

There can only be one request from either LSU 0 or 1 active at a time.

Signed-off-by: Carl Love <cel@us.ibm.com>
---
 arch/powerpc/kernel/power6-pmu.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/power6-pmu.c b/arch/powerpc/kernel/power6-pmu.c
index 03b95e2..0bbc901 100644
--- a/arch/powerpc/kernel/power6-pmu.c
+++ b/arch/powerpc/kernel/power6-pmu.c
@@ -487,8 +487,8 @@ static int power6_generic_events[] = {
  */
 static int power6_cache_events[C(MAX)][C(OP_MAX)][C(RESULT_MAX)] = {
        [C(L1D)] = {            /*      RESULT_ACCESS   RESULT_MISS */
-               [C(OP_READ)] = {        0x80082,        0x80080         },
-               [C(OP_WRITE)] = {       0x80086,        0x80088         },
+               [C(OP_READ)] = {        0x280030,       0x80080         },
+               [C(OP_WRITE)] = {       0x180032,       0x80088         },
                [C(OP_PREFETCH)] = {    0x810a4,        0               },
        },
        [C(L1I)] = {            /*      RESULT_ACCESS   RESULT_MISS */
