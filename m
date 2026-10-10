Return-Path: <linuxppc-dev+bounces-29180-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D729DCA9EBE
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Oct 2026 12:22:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j22sp3kHPz2yqx;
	Sat, 10 Oct 2026 23:22:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1232"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791634926;
	cv=none; b=EnGfCI/w9gveML/LNdynaPl1fCXBDlLSINNm43Gc8wT3ziBD5KSB8YqPR2FBei9S3KhGJOvoEyJRYuYYTigjXQ7ihVjzG5PbeoF2VX0z2+SD766oKD7Kopyo1tdlQWCYGtWam7TfUTRpiIBhWdMsRuBy0LaGvKQc06lCSHruB+orBmFMg2o4JpU2dM0UOE5ViwgVJAWWmI+HiA0gUJZtiw20f/6DAlVSXw03O/hJ25ZrKwpRloDfx8Ybjz2PmVCfTsyuDHouUg3QUGY9d9TK4kRBRiXIkShrT3Ol0iYVU2l6aiqtoYoYzN8Ns2atCTauvhr6KfreDpYqIsKMyTmFiA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791634926; c=relaxed/relaxed;
	bh=CaO3MyXW3zZwT9bgT7JpMqD2h92koUbOcIHQ/S1CmUA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BmMxk0NmPrGw+jBJJmN2Cx11IedaSXnUzxV39plOfmyUqk4uBaQXwUgT6C2JcRc2kyyiFghEa0cFNolDGqXojqzHP3Z92ZR81nAsU924VXqcrNGWWKIrXe4y6G5y0xrio6r7RVJk57sWaeGrN9YdtxTTrD6SU5zUUfL8+ShzYf/A+FOVxHIg+8D+Zi2acBTUCRMMcLWgm9yQ7alkeOdYkv9lW3Mk3Vr39U34gR+k2aE9xGTb9PBgyMh50uMcKduLG/vc5PwQH1Cl4sttNr5WLyXBGoi3AQvTMucoL30ciwnFRDmlUa/t8EnJiZl6nMKWPM7nqvX0aHURJyrqEuV3XA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ASy5zGDi; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1232; helo=mail-dl1-x1232.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ASy5zGDi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1232; helo=mail-dl1-x1232.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1232.google.com (mail-dl1-x1232.google.com [IPv6:2607:f8b0:4864:20::1232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j22sn5dQ9z3bSn
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Oct 2026 23:22:05 +1100 (AEDT)
Received: by mail-dl1-x1232.google.com with SMTP id a92af1059eb24-141395927feso967191c88.0
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Oct 2026 05:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791634924; x=1792239724; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CaO3MyXW3zZwT9bgT7JpMqD2h92koUbOcIHQ/S1CmUA=;
        b=ASy5zGDiH63nYvif1RpmysqNAT3Fde4/Wv4RE0Z9I7iirM+VNA8T/f2r2CHlRjUJqb
         +AnUGxSIFHHURUsTsKmYajPyjzQcStI2tq0VSU+HpjOYQnzNLBOehEwjni+AfkLYgmUi
         e2j6fQgtX7lRdJduTbc91ltvmEaiD416P6oLse4uPrnzIc3ptVyV+lI1gj/lZjiPReJS
         bsX6XEIhm53EoRK4jl/5WJnCMBP67jfS55ksBo2rXAe9A110ytjykA0+/9pY8aob56Ff
         LyI/kR/HmB9W1KXykXoiZxW7nt6UNnwHrwqKFnGnqtPeaK64vM9YQzZAM0Ks7s1VXoCl
         MemA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791634924; x=1792239724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CaO3MyXW3zZwT9bgT7JpMqD2h92koUbOcIHQ/S1CmUA=;
        b=z9gOm02k3btaHZxzgVyDfi20ATKVUW9ocRI4BggGlbG4dMIotbS6V6ePdQ4R/yV4S/
         chrZaWbdjclh8cCZP0fEpzOAk9jUM0KQhtK34vichNnluYGH+QjuA65ZMN4iuqjM3To9
         w5rKPQ1QlrR+nkj4V3tbKQuleWS4e7+x/MqFDSVWFH4BLdLUVSRYjwUWQUSi2+4Z1E3K
         GVhUOIg+EOUX20wtLOY0W5FkVcIE5Vu3IXLhRavsEL9oa12mBYu+FZ1MkHXEmis2EjUD
         3eI9KCOsn3Swh3QV9TqxUl88bEcXpsaEUxDm4ziwV5EJoCqwOnwss+apoPkwiu8n8WaV
         Ui+A==
X-Gm-Message-State: AFq9FYJTTRSF7Du//Ke5m7IJsirEs/Dgeiut4/uZq9STKJviqz01wsEy
	kZHXmWS9FDowTdVzyXMjTcwpzSP5agWQGWSB3xIfAjIy06BewKPcS54/tawLrLap
X-Gm-Gg: AYBFou2AZthkWivcuhQkceFFlGomhs9oqnvSUk0kbi/wEYSYFpQBySuxsC09/OUmdBx
	oTf0Qi+gRBgnTx/KC2wGsaDBgwxvtbYIE8JJdLw7fuBHA7cIdetn0ZHfh6S2JRjJh5UzNzGKhP5
	YKvrzPFLnzhTXOoxTxbQKoBfK+SjmiGpmBcibIrcneLwEOCMI08s637fcKL1ifoYn2XAczq+cTn
	AoiD1nj8Rb0YZ4YVWPo0DLdfc88lutJMyglUwFLzqDsSh0aXpA0Mi4Tu0fxN1Nqc7uDGdmu2YjS
	30lWGgjb4UdEV2G+eScMfFFavNylY//h5qZjtSjeR1j7heAX/B4GR9wE9FQ/afefOWtWcGy/f+B
	NCFYoA/gmaNRSQWvnRbrpPvEU9UYx99q5gUErmGtv/P5GVHzjT3HyTmpLj+F4SBUrAaRimh1H0Z
	gNfsO00SsDD7wNBZmMZGh28ZXIqR4xk5YSrhFNWMO9rchOOrc5irux/i0V5pVP1sr8s7zHRirKQ
	IxtxqN3x8q2ulCvC2tJsjEsrQyPKf64LYbc5GAL6hF4PjSL0dZmEV4wEKhnphZjSA8/kWs=
X-Received: by 2002:a05:7022:1581:b0:167:5402:dc96 with SMTP id a92af1059eb24-16a606260e9mr7991587c88.33.1791634923685;
        Sat, 10 Oct 2026 05:22:03 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a1becf08sm15401816c88.5.2026.10.10.05.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 05:22:02 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC 3/4] powerpc: Wire memfd_secret syscall
Date: Sat, 10 Oct 2026 17:51:11 +0530
Message-Id: <4b0d9e39b98f2684d03ee1365b3651492ddf7081.1791608423.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1791608423.git.ritesh.list@gmail.com>
References: <cover.1791608423.git.ritesh.list@gmail.com>
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

Wire the memfd_secret syscall. Currently this is only implemented for
Book3S64 radix. On every other PowerPC configuration, either
ARCH_HAS_SET_DIRECT_MAP is not enabled in Kconfig, or
can_set_direct_map() returns false because the configuration is not
supported. The syscall checks for that and returns -ENOSYS.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/kernel/syscalls/syscall.tbl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index cfbb70039ff0..81677fdd0d05 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -537,7 +537,7 @@
 444	common	landlock_create_ruleset		sys_landlock_create_ruleset
 445	common	landlock_add_rule		sys_landlock_add_rule
 446	common	landlock_restrict_self		sys_landlock_restrict_self
-# 447 reserved for memfd_secret
+447	common	memfd_secret			sys_memfd_secret
 448	common	process_mrelease		sys_process_mrelease
 449	common  futex_waitv                     sys_futex_waitv
 450 	nospu	set_mempolicy_home_node		sys_set_mempolicy_home_node
-- 
2.39.5


