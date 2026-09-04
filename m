Return-Path: <linuxppc-dev+bounces-26590-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30691C624DB
	for <linuxppc-dev@archiver.kernel.org>; Sat,  5 Sep 2026 06:10:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hcNGv6HChz2yvB;
	Sat, 05 Sep 2026 16:10:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1031"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788525954;
	cv=none; b=DKE+fDhOWTWAVQ+Cs7cdQ2ycsZqspR46v6mXvmyjU0fRt5i4DCMwAzoXfGD3OgDvtIGjokFI+1foF3eW8/1i1WMMgmH7dEgGGBXZzeVpxBYbVyjVeUiOF8AON8cCwvYxl6f6pq2ZraDhHWo+tG/ftUdaFFqs3dzbl6XsyqQAbrR9AaFN64TGdm8CsxKXt8AL9gJbzdx+oxsUufiQP+w/ijflqsiDJtPYYuY2Tgk+auPe8pg75r2uDs50nDe92EaiEe6c+5P/VUJlpCi2nDa8b8aE8re3OHnDnEjx9cac+yKKdtPIhyfOfX6J2AC7s8ayGS/TomRbmJK6edkyBUXSWA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788525954; c=relaxed/relaxed;
	bh=9IRt2KlI91RpY4t7Vuou/M47pK7hKqwpxLHWK9iGk5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jk/wvGNHwxFD0Z1ZcgRvujboIMlyuuxYK7bsjcg1OUlYI4sSLWxBf8BC91Q4f0r5ZpRyFYJNKkPBD8ToVAoNqNYrrwko5ZKZLjberz2lHbgpQNfhwJsIEHCQ+wij0C9I4M6+xjhEVSmkM7yn+YWHm+d1rqxosd4ayqkQbhWD2HBHtGRLdvqbfv0F/JmyiAMnG1zZmD4fHoX4A5covC+gXxmlPGY58t84ehdgCCHlRvQT5A4BwaPD171jG/Ngv8EwqezEL9qedl87R8LMHaRsogrlZwTUk0cldScB3esvreM5ptJG0j9shcfssgX7QoRxOdWsa66HiLtGmppRoRRBig==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SqIZJjjQ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=hemanth.selam@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SqIZJjjQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=hemanth.selam@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbx5t148Dz2y2b
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 22:45:54 +1000 (AEST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-39647aa9d52so1061847a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 05:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788525952; x=1789130752; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9IRt2KlI91RpY4t7Vuou/M47pK7hKqwpxLHWK9iGk5Y=;
        b=SqIZJjjQt91W2Zg7VmF/J11YNjKfqBrjDEhrJw1bvpUupraoS/OqwF4qn2E5DQw5ZO
         qLKz3/s1DBgGHNG3FKXtoHuVALP/Bo+qAb+9UTWmHNkH300HR54sHcSEHSPrnD9+Lxbm
         jTq/ix5vxxnOuyPPrfd9VimSkwlmoDfDJhPx6GJXwPcelcMu4i1+8FybbOSEYkKxzH22
         rbK5O0TKEPRbcLFqEXsEaC8xyFDxjSXepWrXKRSmRkJV65JtlEipTHqDgccdEf3uz2Is
         72RX40jb0hNQnkwE54T143MGqPqqmct5Duqtc8q/7EUDrHZR5s6H8ZOfiwgw5pbgBjpO
         pAKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788525952; x=1789130752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9IRt2KlI91RpY4t7Vuou/M47pK7hKqwpxLHWK9iGk5Y=;
        b=hsMD60CU+BPK6V9VrTda6xDTlVHgSRvbu4tdo+CcgDuwIhJ2SxRc1JuUA0HPwZnJyp
         pLE71wKpskrT/UMdZyDWI6mXUryurE9qioJA2kBxpH6WLtUG15Lv6PSTcrLMElpccJTt
         KW55pD3R2BMoENWrKBHwjYhRybxrq0XwVIxQp840fcISn/biylMcpQg75W0AYq6Tdymh
         y/FM69e3Dn0UOoerQxt2bsB/pKVBoQ5gRrM8fXg0Zksx0atmwe6gvSucPQtAQqDKSroE
         UmWX8pIw9s9MGipFloAK9wfUPxrny7uvFvi/np0W2COmyWFxQSBiSCkzpBx+SYs8H17A
         Iyng==
X-Forwarded-Encrypted: i=1; AKwUvBzR7XvCIXp5Go9sy9tCGaT/DRGAKL3KXwJJv2ry4XTSoejT8r4IhGnmNhIK5BcV/fBR74Hm5uPvTUQ+ZgY=@lists.ozlabs.org
X-Gm-Message-State: AFuF++l5dP3cWTNYv6VQrl3pmRji7vVMyVs3Tk1u9DDAHabwnBNzGlbM
	P3ni226n5y5Afpn+eFUkhY0CZSc2SGe7ViYQalY9goQ2X5/MNBq2jrpt
X-Gm-Gg: AYBFou022d9cuyBkJrsQkHRS5o4DdEpjd0o3ez0oGWZDuaLP322LszkI99J1+DKncsk
	2V+sQcjf8wySLluD8Ikji9FHMequJ+shUBoRooqz81g81vTp9jTFJYY/d2lvRrr+nlw7vauYSPF
	9z2O2JE/zwdP+b3Bnt4bvZHWirXoMXQ51bjqC4uKps2Ddtx3IKHTre1ypaLmgoj2oEjh+yYKHrF
	ZIYtNmOuCeEALyNBD0Sz0stKeUVMI3VgzRHTW32ZkNs+YEXKRUpwpyZDnkoBrdryX1B08dG3clv
	p+3sywAIi2Svc4JNg4qu2iziRu9OAOjjTl5ojVj6KTvLPmeHctzIAKjruXFZvPDJx+85kou+LA7
	QHrITu4lP3qSS9BBmS+s8QHZhX3/hg6p5T2KZurI26pQ8TCm0QUKO/Y+3+7BWMzlrjvlu/wXT9d
	U8BTbupCx6B/fRDGx1ca9fnqawAvH87Y3X++/lJiqbOoTxWWSVHYg6cRBMn3U+ig/tfetPaGUGF
	RfLs1tojkFnJ1OEXdq6SSHEM/0=
X-Received: by 2002:a17:90b:5242:b0:381:10a3:8b10 with SMTP id 98e67ed59e1d1-39b08046aaamr15009313a91.14.1788525951767;
        Fri, 04 Sep 2026 05:45:51 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143243f780csm6477419c88.13.2026.09.04.05.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 05:45:51 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/3] bus: fsl-mc: fix repeated word 'for' in comment
Date: Fri,  4 Sep 2026 18:15:36 +0530
Message-ID: <20260904124540.7652-3-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260904124540.7652-1-hemanth.selam@gmail.com>
References: <20260904124540.7652-1-hemanth.selam@gmail.com>
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

Drop the second 'for', reported by checkpatch.pl as a possible repeated
word.  Only touches a comment, no code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/bus/fsl-mc/fsl-mc-msi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-msi.c b/drivers/bus/fsl-mc/fsl-mc-msi.c
index be38b43803de..7d760bfa63c1 100644
--- a/drivers/bus/fsl-mc/fsl-mc-msi.c
+++ b/drivers/bus/fsl-mc/fsl-mc-msi.c
@@ -57,7 +57,7 @@ static void fsl_mc_write_msi_msg(struct msi_desc *msi_desc, struct msi_msg *msg)
 		}
 	} else {
 		/*
-		 * IRQ is for for a child device of mc_bus_dev
+		 * IRQ is for a child device of mc_bus_dev
 		 */
 		error = dprc_set_obj_irq(mc_bus_dev->mc_io,
 					 MC_CMD_FLAG_INTR_DIS | MC_CMD_FLAG_PRI,
-- 
2.48.1


