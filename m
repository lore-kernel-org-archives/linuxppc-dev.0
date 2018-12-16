Return-Path: <SRS0=MdcX=OZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED10C43387
	for <linuxppc-dev@archiver.kernel.org>; Sun, 16 Dec 2018 23:19:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F093206C2
	for <linuxppc-dev@archiver.kernel.org>; Sun, 16 Dec 2018 23:19:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F093206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43J0bt0vGmzDqjM
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 10:19:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=46.105.50.32; helo=7.mo69.mail-out.ovh.net;
 envelope-from=groug@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
X-Greylist: delayed 1199 seconds by postgrey-1.36 at bilbo;
 Mon, 17 Dec 2018 09:07:46 AEDT
Received: from 7.mo69.mail-out.ovh.net (7.mo69.mail-out.ovh.net [46.105.50.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Hz1G2ybMzDqZV
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Dec 2018 09:07:45 +1100 (AEDT)
Received: from player699.ha.ovh.net (unknown [10.109.143.249])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id DA2BA370D2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Dec 2018 22:28:59 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player699.ha.ovh.net (Postfix) with ESMTPSA id 7FC0CE0A2FF;
 Sun, 16 Dec 2018 21:28:50 +0000 (UTC)
Subject: [PATCH] ocxl: Fix endiannes bug in ocxl_link_update_pe()
From: Greg Kurz <groug@kaod.org>
To: linuxppc-dev@lists.ozlabs.org
Date: Sun, 16 Dec 2018 22:28:50 +0100
Message-ID: <154499573000.310603.8247296576061305045.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 14094859460442757426
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtkedrudehledgudehtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
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
Cc: Christophe Lombard <clombard@linux.vnet.ibm.com>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, stable@vger.kernel.org,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Alastair D'Silva <alastair@d-silva.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

All fields in the PE are big-endian. Use cpu_to_be32() like everywhere
else something is written to the PE. Otherwise a wrong TID will be used
by the NPU. If this TID happens to point to an existing thread sharing
the same mm, it could be woken up by error. This is highly improbable
though. The likely outcome of this is the NPU not finding the target
thread and forcing the AFU into sending an interrupt, which userspace
is supposed to handle anyway.

Fixes: e948e06fc63a ("ocxl: Expose the thread_id needed for wait on POWER9")
Cc: stable@vger.kernel.org      # v4.18
Signed-off-by: Greg Kurz <groug@kaod.org>
---

This bug remained unnoticed so far because the current OCXL test suite
happens to call OCXL_IOCTL_ENABLE_P9_WAIT before attaching a context.
This causes ocxl_link_update_pe() to be called before ocxl_link_add_pe()
which re-writes the TID in the PE with the appropriate endianness.

I have some patches that change the behavior of the OCXL test suite so that
it can catch the issue:

https://github.com/gkurz/libocxl/commits/wake-host-thread-rework
---
 drivers/misc/ocxl/link.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/ocxl/link.c b/drivers/misc/ocxl/link.c
index 31695a078485..646d16450066 100644
--- a/drivers/misc/ocxl/link.c
+++ b/drivers/misc/ocxl/link.c
@@ -566,7 +566,7 @@ int ocxl_link_update_pe(void *link_handle, int pasid, __u16 tid)
 
 	mutex_lock(&spa->spa_lock);
 
-	pe->tid = tid;
+	pe->tid = cpu_to_be32(tid);
 
 	/*
 	 * The barrier makes sure the PE is updated

