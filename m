Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9092E60A3820
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 03:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sEGlYvsx
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVPPC1yy8z2yRn;
	Thu, 19 Nov 2026 14:40:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795059615;
	cv=none; b=gBafdXn/tblPPkTuhY8KeB4N/W6as/e6ba24/rxqFOcGI6iixMc5ZrEcp4IRXqz0Ov4gYs4Z5KsHnICSrQuauiOAQQXQbbpVfN5y98bGjHGgMglz1LSIV2faPkuYcLEw1q4CpUzhMYXIUGEqQx7biWtbvffyFtrRohLUfjKjvEWGQvY0SOS0eodoD/ilUD0ZktcETFaCyW+Qepxd1kEDG51gIxIiLep6wWWmEBF3kHzhsg654COeG8zxBJeXdTtyqvRT7zIXqbqxp7DQSMoL6D5F4EogYCprw7IAZZZX3e05GQu/Ui2pXsP19LMVsnG9dle4PCw63Z58PxCLlZK8QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795059615; c=relaxed/relaxed;
	bh=gNfLUpbUrpvHXxk7v5s6Ji6TChmuV33nC5/6JAhIS7E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XUYvCpbLVPY10jHj2fzk20E4cY40B37D6rh7WhAy9G6sjfGr7qtmjAW4U+un5JmGUOcW8BJxV7Bma4TG4pU5KxL/u6s+BI96q2qlS4oP6S5t144ElW0GxDEo/yY8ABW2U38gNo9i/eASE3LnNzkQE1zn0AA77qLVIZ30O08eE4LSln/v7NVZO/Af/PVyIB1zW016guRpheuoKO0ZG21hV4//JC9k3vabt+gy72ODDRjYlABzqr7fx0P5Du5Qy11rVa9WszC+5ZbiveE1kjI1Cg1Fu3Z/TeLc46mvin86XxkdcENQ3Q7zhwvUZSHKHBwOUZLaIKCGiC8u/vabI1BOgw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sEGlYvsx; dkim-atps=neutral; spf=pass (client-ip=74.125.82.172; helo=mail-dy1-f172.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sEGlYvsx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=74.125.82.172; helo=mail-dy1-f172.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVPPB2qqhz2yR1
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 14:40:14 +1100 (AEDT)
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3282db206d3so4766939eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 19:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795059612; x=1795664412; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gNfLUpbUrpvHXxk7v5s6Ji6TChmuV33nC5/6JAhIS7E=;
        b=sEGlYvsxjfaW2Vg6/651JSkKZtgk3MX4KzsG0Knw4JEZJMqHyzQdEHdwWXQMe++3fC
         MHOwkUFOnCFg7xs/sWCeqmtpGksJafSLo0oEywZ97Tj+lIZYl35jeNZ09w0zjW7Fvb0Y
         f4ghaXqiwUm0/wqxfff++opym62crRp5svwN/0ydA10WLrj7lCX2KShnKE1nGmL6Ev9Y
         KA8eHR+wrOEtnN9NJJA8fUyl9DqRsjXr1mZN6PrGY3ZMbgjR7bwj/4/jm5NPkDkw7Aw7
         2i7Kql7vasdknd6ypF3F5lU1TCKSC1kE5Y32N3Q8Vm4uzvzdqUC1FwgHihQ4PLPDhQFD
         kydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795059612; x=1795664412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gNfLUpbUrpvHXxk7v5s6Ji6TChmuV33nC5/6JAhIS7E=;
        b=SR5Sp61zRcvlvn+LIhLWuYlKfhvd8SbISCeut5UrV5RfuZVszCru4v9+fMRjyEOivF
         AXQZusZYZzaO1xR+AHZ2Dk4dJm/5OiDXW2PUp1AuOPWX+W84cr263gh+RkOH/UeXTsTr
         OcRYrAANIkAvBtLd0rFfE2UyfIpeltKj4ismfAP9dLIxqVcGzsPnP5X+xRLY8/ry77oS
         iECid5E9D2g4WBLvo1YH0Hmbn3Sd02ikAKRwmbyr9O4sBoij9WAvgZw6M/T0tEqoR94C
         gdTYWd4mJIIy4Lwevquxz81yurW+cQgpRLjIgwyVZn45qC5WCCqFFbtlhLxr3hfMA3WD
         YldQ==
X-Gm-Message-State: APuU4Z/XyD0njIW0vKycqo4RYteVxZ99tkE5h+QJiFSgaM517a/T1mqa
	d7pOgah7fgodb0PoLlJi29p/MrOzpIFwFnWRYhqbireOGGo3paU8Cip+MeZvdA==
X-Gm-Gg: AZFdTZcHgGvL+DrgO8nyfvt5AKT2B9aKZqtOL7tXzcYnQHS0N33NvJmM2VaCA7B7kfl
	sjpRO/SEwnL1BVukTd2o4mFWQ9z1L3xBmFYtP1CKGRNdGewbO7HxR5zm1tYsQmF2eh8ryZyKDXA
	dJiiLWD2PkbANBO4tlpzVuHZTeOyMLAo10DrnhIX3hiqNTMZxqG/c/8ROH4wQ0z0xqpFMrHXdt/
	ghzB3iFCvgOp5UQZ6AAWuf3H4jVWZNbI568JiJ2VcWZBHZMAVE7O8ObBZsKaEEUd9KyWcdgJdZY
	8R8gitdGCYF5cAWK5t0PIuWccyJw2eGnEuFZJvfJZ/Otl1HRFIeU92m+vbGT+Avzwkql4cgvX8d
	ABckHGhdjHtVKm9oPNizWdG+8DamwPN1ZJ1oHdSf5R7xXByohCJx+JpG1q43X4yonSOqDvoMqDM
	KQ1pj5sf5A0NZiME+EEv2avwJ+ZaIt8gABC0XGdFmrUV+IQX07DkVM414KyEsSknuRfaGmBrfl1
	ail2j/LZwhBBEfsw5gtCc7ENKpr/a9gnfZRi5tcKqYBFHapmDNkJhNieu8FAxviaUDCni+CPU2p
	+e46hCn8SxKjTvw6UsZfhL7BEY3N6BNkug==
X-Received: by 2002:a05:7300:bc03:b0:369:fc93:eda5 with SMTP id 5a478bee46e88-38281427c34mr5865682eec.39.1795059611987;
        Wed, 18 Nov 2026 19:40:11 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a4522829sm12699465eec.1.2026.11.18.19.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 19:40:11 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	Marco Elver <elver@google.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv2 11/18] powerpc/pseries: Annotate the VPD sequence lock context
Date: Thu, 19 Nov 2026 09:09:06 +0530
Message-Id: <38627563f85b033e3ad50297d811a68b13588a62.1795058683.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1795058683.git.ritesh.list@gmail.com>
References: <cover.1795058683.git.ritesh.list@gmail.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Clang's context analysis reports:
  papr-vpd.c:151:1: error: mutex 'rtas_ibm_get_vpd_lock' is still held at the end of function [-Werror,-Wthread-safety-analysis]
  papr-vpd.c:165:2: error: releasing mutex 'rtas_ibm_get_vpd_lock' that was not held [-Werror,-Wthread-safety-analysis]

Add the necessary annotations to in vpd_sequence_{begin|end}(),
to fix these errors for enabling Clang context analysis.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/platforms/pseries/papr-vpd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/papr-vpd.c b/arch/powerpc/platforms/pseries/papr-vpd.c
index f38c188fc4a1..8d210454cff1 100644
--- a/arch/powerpc/platforms/pseries/papr-vpd.c
+++ b/arch/powerpc/platforms/pseries/papr-vpd.c
@@ -123,8 +123,10 @@ static int rtas_ibm_get_vpd(struct rtas_ibm_get_vpd_params *params)
  * @seq: vpd call parameters from sequence struct
  *
  * Context: May sleep.
+ * Returns with rtas_ibm_get_vpd_lock held. vpd_sequence_end() releases it.
  */
 static void vpd_sequence_begin(struct papr_rtas_sequence *seq)
+		__acquires(&rtas_ibm_get_vpd_lock)
 {
 	struct rtas_ibm_get_vpd_params *vpd_params;
 	/*
@@ -157,6 +159,7 @@ static void vpd_sequence_begin(struct papr_rtas_sequence *seq)
  * Releases resources obtained by vpd_sequence_begin().
  */
 static void vpd_sequence_end(struct papr_rtas_sequence *seq)
+		__releases(&rtas_ibm_get_vpd_lock)
 {
 	struct rtas_ibm_get_vpd_params *vpd_params;
 
-- 
2.39.5


