Return-Path: <SRS0=NHc8=OL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECADC04EB8
	for <linuxppc-dev@archiver.kernel.org>; Sun,  2 Dec 2018 21:17:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4676320892
	for <linuxppc-dev@archiver.kernel.org>; Sun,  2 Dec 2018 21:17:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4676320892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=m3y3r.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 437LYG15c5zDqVT
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 08:17:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=m3y3r.de
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=m3y3r.de
 (client-ip=213.133.104.17; helo=www17.your-server.de;
 envelope-from=thomas@m3y3r.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=m3y3r.de
X-Greylist: delayed 1153 seconds by postgrey-1.36 at bilbo;
 Mon, 03 Dec 2018 08:14:41 AEDT
Received: from www17.your-server.de (www17.your-server.de [213.133.104.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 437LVT4jmKzDqTk
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Dec 2018 08:14:41 +1100 (AEDT)
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
 by www17.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
 (Exim 4.89_1) (envelope-from <thomas@m3y3r.de>)
 id 1gTYlr-00016V-3v; Sun, 02 Dec 2018 21:55:19 +0100
Received: from [2a02:908:4c28:3f60:fff6:43c5:695c:41d6]
 (helo=localhost.localdomain)
 by sslproxy06.your-server.de with esmtpsa
 (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <thomas@m3y3r.de>)
 id 1gTYlq-0002mQ-U0; Sun, 02 Dec 2018 21:55:18 +0100
Subject: [PATCH] KVM: PPC: Book3S HV: NULL check before some freeing
 functions is not needed.
From: Thomas Meyer <thomas@m3y3r.de>
To: paulus@ozlabs.org, benh@kernel.crashing.org, mpe@ellerman.id.au,
 kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Patch: Cocci
X-Mailer: DiffSplit
Message-ID: <1543760930051-2094322096-1-diffsplit-thomas@m3y3r.de>
References: <1543760930050-1499171309-0-diffsplit-thomas@m3y3r.de>
In-Reply-To: <1543760930050-1499171309-0-diffsplit-thomas@m3y3r.de>
X-Serial-No: 1
Date: Sun, 02 Dec 2018 21:52:11 +0100
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: thomas@m3y3r.de
X-Virus-Scanned: Clear (ClamAV 0.100.2/25173/Sun Dec  2 15:13:44 2018)
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

NULL check before some freeing functions is not needed.

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---

diff -u -p a/arch/powerpc/kvm/book3s_hv_nested.c b/arch/powerpc/kvm/book3s_hv_nested.c
--- a/arch/powerpc/kvm/book3s_hv_nested.c
+++ b/arch/powerpc/kvm/book3s_hv_nested.c
@@ -1252,8 +1252,7 @@ static long int __kvmhv_nested_page_faul
 	rmapp = &memslot->arch.rmap[gfn - memslot->base_gfn];
 	ret = kvmppc_create_pte(kvm, gp->shadow_pgtable, pte, n_gpa, level,
 				mmu_seq, gp->shadow_lpid, rmapp, &n_rmap);
-	if (n_rmap)
-		kfree(n_rmap);
+	kfree(n_rmap);
 	if (ret == -EAGAIN)
 		ret = RESUME_GUEST;	/* Let the guest try again */
 
