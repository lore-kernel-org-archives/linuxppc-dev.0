Return-Path: <SRS0=1eNT=OV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE0AC04EB8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Dec 2018 10:01:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C433820849
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Dec 2018 10:01:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C433820849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hxt-semitech.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43FC4v5g3tzDqWg
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Dec 2018 21:01:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=hxt-semitech.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=hxt-semitech.com
 (client-ip=223.203.96.7; helo=barracuda.hxt-semitech.com;
 envelope-from=yanjiang.jin@hxt-semitech.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=hxt-semitech.com
Received: from barracuda.hxt-semitech.com (mx01.hxt-semitech.com
 [223.203.96.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43F9WD4mn1zDqj1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Dec 2018 19:50:31 +1100 (AEDT)
X-ASG-Debug-ID: 1544603579-093b7e7c6213d20002-v7v7hK
Received: from HXTBJIDCEMVIW02.hxtcorp.net ([10.128.0.15]) by
 barracuda.hxt-semitech.com with ESMTP id 1Q6f355qG8b5diUP (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO);
 Wed, 12 Dec 2018 16:33:00 +0800 (CST)
X-Barracuda-Envelope-From: yanjiang.jin@hxt-semitech.com
Received: from controller.hxtcorp.net (10.5.21.105) by
 HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 12 Dec 2018 16:32:07 +0800
From: Yanjiang Jin <yanjiang.jin@hxt-semitech.com>
To: <bhelgaas@google.com>, <keith.busch@intel.com>
Subject: [PATCH] PCI/AER: only insert one element into kfifo
Date: Wed, 12 Dec 2018 16:32:30 +0800
X-ASG-Orig-Subj: [PATCH] PCI/AER: only insert one element into kfifo
Message-ID: <1544603550-14208-2-git-send-email-yanjiang.jin@hxt-semitech.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1544603550-14208-1-git-send-email-yanjiang.jin@hxt-semitech.com>
References: <1544603550-14208-1-git-send-email-yanjiang.jin@hxt-semitech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.5.21.105]
X-ClientProxiedBy: HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14) To
 HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15)
Content-Transfer-Encoding: quoted-printable
X-Barracuda-Connect: UNKNOWN[10.128.0.15]
X-Barracuda-Start-Time: 1544603580
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA384
X-Barracuda-URL: https://192.168.50.101:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at hxt-semitech.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5000 1.0000 0.0000
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.63648
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
X-Mailman-Approved-At: Wed, 12 Dec 2018 20:56:40 +1100
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
Cc: yanjiang.jin@hxt-semitech.com, sbobroff@linux.ibm.com,
 linux-pci@vger.kernel.org, jinyanjiang@gmail.com, linux-kernel@vger.kernel.org,
 oohall@gmail.com, linuxppc-dev@lists.ozlabs.org, yu.zheng@hxt-semitech.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

'commit ecae65e133f2 ("PCI/AER: Use kfifo_in_spinlocked() to
insert locked elements")' replace kfifo_put() with kfifo_in_spinlocked().

But as "kfifo_in(fifo, buf, n)" describes:
" * @n: number of elements to be added".

We want to insert only one element into kfifo, not "sizeof(entry) =3D 16".
Without this patch, we would get 15 uninitialized elements.

Signed-off-by: Yanjiang Jin <yanjiang.jin@hxt-semitech.com>
---
 drivers/pci/pcie/aer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index a90a919..fed29de 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1064,7 +1064,7 @@ void aer_recover_queue(int domain, unsigned int bus, =
unsigned int devfn,
                .regs           =3D aer_regs,
        };

-       if (kfifo_in_spinlocked(&aer_recover_ring, &entry, sizeof(entry),
+       if (kfifo_in_spinlocked(&aer_recover_ring, &entry, 1,
                                 &aer_recover_ring_lock))
                schedule_work(&aer_recover_work);
        else
--
1.8.3.1




This email is intended only for the named addressee. It may contain informa=
tion that is confidential/private, legally privileged, or copyright-protect=
ed, and you should handle it accordingly. If you are not the intended recip=
ient, you do not have legal rights to retain, copy, or distribute this emai=
l or its contents, and should promptly delete the email and all electronic =
copies in your system; do not retain copies in any media. If you have recei=
ved this email in error, please notify the sender promptly. Thank you.


