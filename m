Return-Path: <linuxppc-dev+bounces-28958-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B17CA5FF0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Oct 2026 10:30:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hzXZZ1pDRz30Sx;
	Tue, 06 Oct 2026 21:30:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791282614;
	cv=none; b=nO465DQFcL8OKjdRAGi4UwmelDsHezEOAAqUn0nVCC+BY9eg5LwkPG9YfV/a/+/suWHjuZ3yLh6IQ7+Pfp6DgDi8wMqTh58JYhpcVnTuFg67btlRbv3BODGs4EP7ihX33yNlda2RFjbwxP7LZVZw2PNapUcj6kPyxetcZ7JBoDGDK7Oq+dyx6hqZn11rTTumUZYZG5HH1IYOBOZ8gHpb6wF75pj4yt/yub3+4SV1l/8VtY//5k0H3giznzAIxq0Gb9+ZG22szZHe+QJoDyUQ36SHG399jcAg0zKAGxZMd2MBPpmj/YF7rOMZTAUchle/mECDWZ5TL9SQKD62ZkoI5g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791282614; c=relaxed/relaxed;
	bh=s2Zcwb3I3/jpfEE/S/vABdVy3sksCEmjvmUeEvSUJ10=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RrhWUOyAGxcfvdQ2N8X0yTQiihgR00/Mg5+MPVHj3Hql/elc12Qp91BAbcA/w3D6blLYbaSTK87nORtNT70k3VECLJrCzuLTzfQKLL5i55NrgAdz3xQDAJKf1pzoNDG0ib+kbJmz35yptfsWrxF84S9mdw/bMamcTw19AFWv+t4B86RX7tQCebwuMDcYKYiX4Np6tKp37j4ZFLJtuAdEM/ZMYZjTeXnEy9c5m0ULtia/LKRrK2obNInr4AreoQ521fyU8+NCd1itWZ8EoyRU0VqkbWGSlgHyHJqck2S7GHmRwf3i9ZkJXflCr/ipzHBQPzUNo5VcKBdiP+/VK2RnDg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=tK2wZaxp; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132a; helo=mail-dy1-x132a.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=tK2wZaxp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132a; helo=mail-dy1-x132a.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132a.google.com (mail-dy1-x132a.google.com [IPv6:2607:f8b0:4864:20::132a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hzXZY3jxkz2xwd
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Oct 2026 21:30:13 +1100 (AEDT)
Received: by mail-dy1-x132a.google.com with SMTP id 5a478bee46e88-35120d43ecaso3868867eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Oct 2026 03:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791282612; x=1791887412; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s2Zcwb3I3/jpfEE/S/vABdVy3sksCEmjvmUeEvSUJ10=;
        b=tK2wZaxpGHzpLo49pmJ7Lcoq/H88zGqq/qcMV1jIaEykhXKwwNa+8Zisc3/trDo0SR
         BKYAaL5SJWDF60+lvrAw1EQ2UF6gu/7cbNiB9/MFo+tR8bvXEd6+w5MyBc/qoDleA/5X
         7NFlmrjrRA24HZZmG39rSSAtdWbGxSOB/Oj+WLXoqIk4yZaygDefkiD78Ai7BMprv+87
         4Di4utLs/8aajQGeUwVR/8Wnzy0sDBODSN7Wac179V5+k9QaA+H3+Xi4mXGvyoFUBm4t
         BKpnHXc0R2f1sDB+9GdkMApCWRIx6YgH1/FP4XT5DCQzf/UqDL/tM6fTnyA9VDyZEvfw
         g7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791282612; x=1791887412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s2Zcwb3I3/jpfEE/S/vABdVy3sksCEmjvmUeEvSUJ10=;
        b=fW3OS6uXI3Be7elOaRKG4Shwbp6hsZszbC5qwXuoPMu6aGdsKMIoEUuri8BCeYL1fP
         ZBg00enTUyntkrtz5dTydpV7fv2pevoI6IQEzMmh6fRkDidEljjvHM3le8DFQ0q6uYjX
         VgbhMG/Yr084Nc03jRnOuFcmKi9A3DrsKca0+svLSHyHXaAF0VGRx/YLcgd4bOlrn34Y
         IPXn0mUi4bljRplYkv7At2bn7XiIXpBGUUBNYxbry4snHY/K8d4jJehQbJ/mSDQ4Qmwx
         83Xti8JnII1wuSJt+4E9P9M9i1Pl7sZkatWSDJK3fKyvDZnMweynR78WJwcOe0NCaLSA
         AZ9g==
X-Forwarded-Encrypted: i=1; AKwUvBz2NFvk7QfNRT7ufTgIcte7Hbr6aEWh1HeCSmrWCzoeG+w0FcleeGcFKrvgIGI9fl26HrGfVMkdiiUjWnI=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYI2p30wE+Cgb8pbRZhxxSN9Bw4K9ONIMu6XwGJ7tg+c6WWsXb5I
	X7c95KYR/fr2nF8SxyIFG+/4Ogffwf2VAfR2GKk5rXftd6E/GitMvGzc
X-Gm-Gg: AYBFou28jUTCxgjADxAKl1w98cRXzC3eUHpU1BN9iLiH0Ci3KiQdnfv1Lbv+/3Z459d
	+yqoqa8mjsOXyrBNTeJk1Ynm7vVLKk+lhy8bfgmixyeLdrA23dh1p9yMbFyFVCdKX5gdI+B+Vfq
	aedassbcDNok7g99bG2h//QWTNSKHuXVutQaNOVvjrzmU1SvYFEGHlBK8+4wvee3YmZUngXUaLX
	4nqHQONv8ihpZGlZ2C/TZDT74J8gfN6AbStRDX6kCaJqjUO6JEPi64oriS1wISJQy6UngFLQkrw
	qoApe4KO4673lQh6wXCtT98Irc0syAj3Ap3ZQVyBDU6Xcen+oCzRjZEn7j3VIEnwDsCmMNcqw7Z
	TDxslHXH+5bdrAfHZyzkdP+omMWpJuXmVytb1ITmW4XXgbIuEdFMjaJG+YiTiSPhJwJUYkiEkcw
	n0/gZLvIaaGVMt5eGgZUjthFCtBuVdfu+9/ZAQKucjokyglGw46o/XDUETW9m+9cmBrUsnxoV4E
	kiaQlgXJi9dtnbqPe6Me978dUd7r/BmhD9EWoXbGavkSY/+I9bbefKbQjwl
X-Received: by 2002:a05:693c:88cc:10b0:33c:b64a:3b82 with SMTP id 5a478bee46e88-3514df98ecamr955005eec.10.1791282611239;
        Tue, 06 Oct 2026 03:30:11 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-351469fa189sm7443970eec.6.2026.10.06.03.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 03:30:09 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	linuxppc-dev@lists.ozlabs.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v7 5/8] KVM: selftests: Add helper for checking if running on powerpc pseries LPAR
Date: Tue,  6 Oct 2026 15:58:39 +0530
Message-Id: <294c0fcd19d6b00626e230985cf9906f98934d1c.1791280439.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1791280439.git.ritesh.list@gmail.com>
References: <cover.1791280439.git.ritesh.list@gmail.com>
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

PowerPC's PAPR L0 does not guarantee H_GUEST_CREATE/H_GUEST_CREATE_VCPU
hcalls to create upto MAX_VCPUS or hundreds of VMs, this is due to
limited resouces at L0 for guest management space. This helper allows us
to skip such tests which creates a lot of VMs/VCPUs, when we are running
nested.

Note that there is no easy way to differentiate between running nested
on PowerNV v/s kvm-on-powervm case. So we use a common helper to detect
any nested case.

The helper is added to the common kvm_util header file to avoid
sprinkling multiple #ifdef __powerpc64__ everywhere.

Suggested-by: Sean Christopherson <seanjc@google.com>
Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 tools/testing/selftests/kvm/include/kvm_util.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 9df16c8dc82a..258ae5879a5e 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -14,6 +14,7 @@
 #include <linux/kvm.h>
 #include "linux/rbtree.h"
 #include <linux/types.h>
+#include <unistd.h>
 
 #include <asm/atomic.h>
 #include <asm/kvm.h>
@@ -1063,6 +1064,22 @@ const char *exit_reason_str(unsigned int exit_reason);
 
 bool kvm_arch_needs_naturally_aligned_page_tables(void);
 
+/*
+ * True on powerpc when this host is a pseries LPAR (nested case).
+ * PowerPC's PAPR L0 does not guarantee H_GUEST_CREATE / H_GUEST_CREATE_VCPU up
+ * to MAX_VCPUS or creating hundreds of VMs - due to limited resouces at L0 for
+ * guest management space. This helper allows us to skip such tests when we are
+ * running nested.
+ */
+static inline bool kvm_is_ppc_pseries_lpar(void)
+{
+#ifdef __powerpc64__
+	return !access("/proc/device-tree/rtas/ibm,hypertas-functions", F_OK);
+#else
+	return false;
+#endif
+}
+
 gpa_t ____vm_phy_pages_alloc(struct kvm_vm *vm, size_t nr_pages, gpa_t min_gpa,
 			     u32 memslot, bool protected, bool naturally_aligned);
 gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t nr_pages,
-- 
2.39.5


