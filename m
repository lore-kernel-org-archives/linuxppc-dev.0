Return-Path: <SRS0=rj9n=MU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECEDC65C20
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 15:46:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F9112077C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 15:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QH7n6mj2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F9112077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42TPq61ccZzDrNV
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 02:46:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QH7n6mj2";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=srs0=urq0=mu=linuxfoundation.org=gregkh@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="QH7n6mj2"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42TPlq6m1ZzF3BQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Oct 2018 02:43:35 +1100 (AEDT)
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net
 [213.127.77.176])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B1C722087D;
 Mon,  8 Oct 2018 15:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1539013414;
 bh=LtUILUJjEndjXR7iGVGDis6hNQhEvBldOwuM3NMs7wM=;
 h=Subject:To:Cc:From:Date:From;
 b=QH7n6mj2gy/bGfGLc9L+utminKp638QbMKVvIrmUahiXX8kYArJboQparRMxspSHY
 EeiP38ITfwv9LVWtosKj5cI9bwiMZmkTxmOKgRg4g2vzvRBrY2o4TBuPt3WY3JYyRc
 j8GqwLoTqQhT4DiVxqeF2AxxZhzfGL9QbCKebpgA=
Subject: Patch "sched/topology: Set correct NUMA topology type" has been added
 to the 4.18-stable tree
To: 1533920419-17410-1-git-send-email-srikar@linux.vnet.ibm.com,
 alexander.levin@microsoft.com, gregkh@linuxfoundation.org,
 heiko.carstens@de.ibm.com, linuxppc-dev@lists.ozlabs.org,
 mgorman@techsingularity.net, mingo@kernel.org, mpe@ellerman.id.au,
 peterz@infradead.org, riel@surriel.com, srikar@linux.vnet.ibm.com,
 suravee.suthikulpanit@amd.com, tglx@linutronix.de,
 torvalds@linux-foundation.org, wild@linux.vnet.ibm.com
From: <gregkh@linuxfoundation.org>
Date: Mon, 08 Oct 2018 17:41:03 +0200
Message-ID: <153901326394211@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: stable-commits@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


This is a note to let you know that I've just added the patch titled

    sched/topology: Set correct NUMA topology type

to the 4.18-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     sched-topology-set-correct-numa-topology-type.patch
and it can be found in the queue-4.18 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From foo@baz Mon Oct  8 17:39:53 CEST 2018
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Date: Fri, 10 Aug 2018 22:30:18 +0530
Subject: sched/topology: Set correct NUMA topology type

From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

[ Upstream commit e5e96fafd9028b1478b165db78c52d981c14f471 ]

With the following commit:

  051f3ca02e46 ("sched/topology: Introduce NUMA identity node sched domain")

the scheduler introduced a new NUMA level. However this leads to the NUMA topology
on 2 node systems to not be marked as NUMA_DIRECT anymore.

After this commit, it gets reported as NUMA_BACKPLANE, because
sched_domains_numa_level is now 2 on 2 node systems.

Fix this by allowing setting systems that have up to 2 NUMA levels as
NUMA_DIRECT.

While here remove code that assumes that level can be 0.

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andre Wild <wild@linux.vnet.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Fixes: 051f3ca02e46 "Introduce NUMA identity node sched domain"
Link: http://lkml.kernel.org/r/1533920419-17410-1-git-send-email-srikar@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/sched/topology.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1295,7 +1295,7 @@ static void init_numa_topology_type(void
 
 	n = sched_max_numa_distance;
 
-	if (sched_domains_numa_levels <= 1) {
+	if (sched_domains_numa_levels <= 2) {
 		sched_numa_topology_type = NUMA_DIRECT;
 		return;
 	}
@@ -1380,9 +1380,6 @@ void sched_init_numa(void)
 			break;
 	}
 
-	if (!level)
-		return;
-
 	/*
 	 * 'level' contains the number of unique distances
 	 *


Patches currently in stable-queue which might be from srikar@linux.vnet.ibm.com are

queue-4.18/sched-topology-set-correct-numa-topology-type.patch
