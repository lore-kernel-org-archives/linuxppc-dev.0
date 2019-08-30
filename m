Return-Path: <SRS0=2dbP=W2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B61DC3A5A4
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Aug 2019 09:01:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0F32206BB
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Aug 2019 09:01:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0F32206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46KYPN0dgPzDr2k
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Aug 2019 19:01:28 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46KYM357tGzDqxZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Aug 2019 18:59:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=sina.com
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 46KYM32BHYz8swq
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Aug 2019 18:59:27 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 46KYM31nmXz9s7T; Fri, 30 Aug 2019 18:59:27 +1000 (AEST)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=sina.com
 (client-ip=202.108.3.11; helo=r3-11.sinamail.sina.com.cn;
 envelope-from=hdanton@sina.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=sina.com
X-Greylist: delayed 135 seconds by postgrey-1.36 at bilbo;
 Fri, 30 Aug 2019 18:59:25 AEST
Received: from r3-11.sinamail.sina.com.cn (r3-11.sinamail.sina.com.cn
 [202.108.3.11]) by ozlabs.org (Postfix) with SMTP id 46KYM158syz9s5b
 for <linuxppc-dev@ozlabs.org>; Fri, 30 Aug 2019 18:59:23 +1000 (AEST)
Received: from unknown (HELO localhost.localdomain)([114.254.173.51])
 by sina.com with ESMTP
 id 5D68E4D800036310; Fri, 30 Aug 2019 16:56:57 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
X-SMAIL-MID: 74094749327896
From: Hillf Danton <hdanton@sina.com>
To: Sachin Sant <sachinp@linux.vnet.ibm.com>
Subject: Re: Oops (request_key_auth_describe) while running cve-2016-7042 from
 LTP
Date: Fri, 30 Aug 2019 16:56:46 +0800
Message-Id: <20190830085646.14740-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: dhowells@redhat.com, linuxppc-dev@ozlabs.org, keyrings@vger.kernel.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


On Fri, 30 Aug 2019 12:18:07 +0530 Sachin Sant wrote:
> 
> [ 8074.351033] BUG: Kernel NULL pointer dereference at 0x00000038
> [ 8074.351046] Faulting instruction address: 0xc0000000004ddf30
> [ 8074.351052] Oops: Kernel access of bad area, sig: 11 [#1]
> [ 8074.351056] LE PAGE_SIZE=64K MMU=Hash SMP NR_CPUS=2048 NUMA pSeries

Add rcu gp.

--- a/security/keys/request_key_auth.c
+++ b/security/keys/request_key_auth.c
@@ -64,12 +64,19 @@ static int request_key_auth_instantiate(
 static void request_key_auth_describe(const struct key *key,
 				      struct seq_file *m)
 {
-	struct request_key_auth *rka = dereference_key_rcu(key);
+	struct request_key_auth *rka;
+
+	rcu_read_lock();
+	rka = dereference_key_rcu(key);
+	if (!rka)
+		goto out;
 
 	seq_puts(m, "key:");
 	seq_puts(m, key->description);
 	if (key_is_positive(key))
 		seq_printf(m, " pid:%d ci:%zu", rka->pid, rka->callout_len);
+out:
+	rcu_read_unlock();
 }
 
 /*

