Return-Path: <linuxppc-dev+bounces-28315-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5107EC9832F
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Sep 2026 14:35:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ht6RD2qWNz30TL;
	Mon, 28 Sep 2026 00:35:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:36::e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790519704;
	cv=none; b=D+UW+MZv1soCA1ZCtjWKeuOT9rU5ccT5/AIQYE17/JFBHlnOF3J1+ug1YrlVDtDLX/dRWJY9IudIIO2Xh6/er5juCdaJljAgxC8G5cSGqZUKABWux0MyWmVEtSd8wP3fpYLirjgHYn70yglevOH3mBA9FTg6nrozT6xWCZoRwp/+WIKnOZZsXk3mErk+Fvr9A/c/Euj71TMzoxl1B2cBzKFtMB8jeEY6JllOF6qVbwmFZFsM7YIye6qIxZXfb12E3pmVvYic/I+ieExtjOH3ktdjhFVSsXJGEcEy+SRi6X7h98IaS/RTBaqWFdu/ejM9GZv00qsR5QcWXrj+BqXKOA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790519704; c=relaxed/relaxed;
	bh=15P/O4uHafhoF2a9GtiIC0oqae4Qc4Z1UYDUjewxzlo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sztkfn/u+engpGFNwch2AwrxvEL+61fex8hZuj8X3MtANz+vnFRGdiH28hdXSTfA0ZjJlcVe2gLTmTVGpqUdm2VGj4NgzxKOlyoRUhbhCwf1gYdNxxDFj/RDIUxMiqJTilKiSrfEcNSwLnpHaugEkFkCaAM3tkuPZF2O6guUP+0XNW1HdkShwWOUL1mmfmx8R2YnXkcb7Z7SJbfEPjRADK22Ylnq9H460rIGgSA7wyfAQRNeQXj9LbS1xqJ53kNtIf8G9ArPXWBEFWLTSsofew4o/dFiw9ZV9YHOC6lUENHpVrKZr/8kLoKBK+u8Z7jRvS/IJALVdHe61j/KDxNV0Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gr6SUWrI; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:36::e; helo=mail-dy2-x0e.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gr6SUWrI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:36::e; helo=mail-dy2-x0e.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy2-x0e.google.com (mail-dy2-x0e.google.com [IPv6:2607:f8b0:4864:36::e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ht6RC3rySz2yr0
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 00:35:03 +1000 (AEST)
Received: by mail-dy2-x0e.google.com with SMTP id 5a478bee46e88-341d5303884so1423303eec.3
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2026 07:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790519701; x=1791124501; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=15P/O4uHafhoF2a9GtiIC0oqae4Qc4Z1UYDUjewxzlo=;
        b=gr6SUWrIMPUYCJlSeXyqRHpEAqap//ZMGU2BO8M97VUunia5f579UMWoncLJbgCYzx
         p6rTglQHZswkaZ5HEocNQvM2cJGVfEQ8lTSJfW/Qtz4eABCmYFmJ0vDmSHCyJZxTLgUQ
         o6D3LCD8q5x2j1y2Ora+3hyt0nf9VRAaS5vDDg5nJP5DlNTXYDDNoH654rJA19CKSzk+
         WKwzLOPw9EoZXWq2uwIQ5SlBEvR0YHhTUq3RQyYV8+7707caSWY+CIdrV5Xk7Xelu7eL
         NSvkF1RPnLAVOR18L3dkPXvOrRUFG8yGdHHs2MSnTwjMq284guqs5Dcl3TsmXISa11EW
         RrLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790519701; x=1791124501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=15P/O4uHafhoF2a9GtiIC0oqae4Qc4Z1UYDUjewxzlo=;
        b=EkUA2BIrrPVZrii/5oe5Otg2qHMcMn2CLpkRSV0lTnOTR90gd7DnfIqEA+9S9vpWdM
         +8rZX/b6CGbAiR9IgLlXS1tBNnj9GMf0kKzgqEgT8rJ9YkhiVJCVft8WWdxbFp/1jf+u
         I1gZXsXQl7q3NZDVBsi8vx25cLcz3OCzu6s4LGtLn9tRNNYbSZy4uBbTKjOQZr5Ttp5L
         AUv08CixvOmHDzgRoheWt3GqHAdLmtLaGbTZ/q1+X/PJSr8JGrb6eFEQgCYNL8IpeZTT
         kneSHoHjdsYNcwG7y+RbO0y5fF9xQihD5BZmxO5RQpyjx2lUMo3a5mXTYTBc/1Dojdf/
         UiuA==
X-Gm-Message-State: AFq9FYLrN32aPj0g0UMlI0wl0yniyMtcAYb3T3PWw8EW8WwO9bQrJC+o
	VlOZkvVS09r2Eb8xd/vsqAHbn63Qc/cj+tkAsNmtd3lwE/o1N6rg0yFf/X+baw==
X-Gm-Gg: AYBFou2TRjBb2tSZlI0IJvea9V7/ougYnx37ByXKpbBN6hKbInGOpwVLtrwwX69RP0n
	NSDPzjhq34fW7ojgUHkI9jX417t11PyXLqQrnsc6n5RfRhLUY7wKMLAp7qE64FtC1XxMaR3d5Fn
	d5BxV6hH+TsYVx0NvzAM+GXWIJbZdjvG7+PYXEzPAjnNexn+PwBc9i+g2B1bm2wynK2GP54Rzil
	DRA+ib5KGLwyAfkhnn8hLKhCAWWdRTIffoHYU3EpnmOfpONNL38lWjnwFjiL384cS2lI3UXuLTe
	+6MW1zDeQHwjE8/RSi9OC6nk4pduYzF8PHzMb9UFJUstLNTqGE5WVzKZdLagI2m7Xxku3SCLrE1
	J2SArFhhhe6Em3q2SmxQFViP7ZCJE8U5W01+JbpyiyZqPP4Iam1p93HSN5BqDIYzR77weEgAeuj
	A8xHbXn+/WTWj1al+vmGjgYlTLw7Mv0z0oldNSRvSeJljyJYNFlZRAOepeK+DYF01h3OeGCm1+A
	l03Uc68vXMVEOTTWMdJfZ9F+NnVQIXEpGSTRQN/oRmcALtqS6J6B9sfoPGUKnW+Vfktmjs=
X-Received: by 2002:a05:693c:26c9:b0:328:3944:ee53 with SMTP id 5a478bee46e88-3426f9bf753mr5911416eec.2.1790519700325;
        Sun, 27 Sep 2026 07:35:00 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34144b4ae50sm21869436eec.17.2026.09.27.07.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 07:34:59 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Marco Elver <elver@google.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC 06/12] powerpc/pseries: Annotate the RTAS indices sequence lock context
Date: Sun, 27 Sep 2026 20:03:47 +0530
Message-Id: <fb39a6ae865a14d277a2cc0332f4fa853152c1a5.1790517984.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1790517984.git.ritesh.list@gmail.com>
References: <cover.1790517984.git.ritesh.list@gmail.com>
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clang's context analysis reports:
  papr-indices.c:145:1: error: mutex 'rtas_ibm_get_indices_lock' is still held at the end of function [-Werror,-Wthread-safety-analysis]
  papr-indices.c:158:2: error: releasing mutex 'rtas_ibm_get_indices_lock' that was not held [-Werror,-Wthread-safety-analysis]

Add the necessary annotations to indices_sequence_{begin|end}(),
to fix these errors for enabling Clang context analysis.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/platforms/pseries/papr-indices.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/papr-indices.c b/arch/powerpc/platforms/pseries/papr-indices.c
index 3c7545591c45..3f3b88f708a3 100644
--- a/arch/powerpc/platforms/pseries/papr-indices.c
+++ b/arch/powerpc/platforms/pseries/papr-indices.c
@@ -126,8 +126,10 @@ static int rtas_ibm_get_indices(struct rtas_get_indices_params *params)
  * indices_sequence_begin() - Begin a indices retrieval sequence.
  *
  * Context: May sleep.
+ * Returns with rtas_ibm_get_indices_lock held. indices_sequence_end() releases it.
  */
 static void indices_sequence_begin(struct papr_rtas_sequence *seq)
+		__acquires(&rtas_ibm_get_indices_lock)
 {
 	struct rtas_get_indices_params  *param;
 
@@ -150,6 +152,7 @@ static void indices_sequence_begin(struct papr_rtas_sequence *seq)
  * Releases resources obtained by indices_sequence_begin().
  */
 static void indices_sequence_end(struct papr_rtas_sequence *seq)
+		__releases(&rtas_ibm_get_indices_lock)
 {
 	struct rtas_get_indices_params *param;
 
-- 
2.39.5


