Return-Path: <linuxppc-dev+bounces-22081-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC68ACD6E75
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2026 02:15:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWlR151Mbz2xjN;
	Fri, 05 Jun 2026 12:15:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::535"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780585321;
	cv=none; b=Z+63inJkwAAqNl3qps9ltZ761J1wEFF7pxofeGdTWlx4/qH3v8BNcrbtEXl/ROOYrBnMRvoWQiFejuaQ1Z9lv1E5Qm5tnUJbyVetydXbqMLG3L/nO9AroChoB0ZVGmoJFzlWbycqRUzaX9XuEkxLGv4VYN/80mMM3X+w4doRzfuna0Yy1sIL+R5U/iOSLfwr4ppWxtkC0SIIYEWbZpxLwiCYr/gvwcrft79kKngKbYGD/9tIiry+CXrtGtQ6Vr1996HV0/0jj+9fpg+FU9u00LkhKQiCYsSUnAuGT2zyd8S3v+n1okDHhOyYudztYgQkStM8O3GbC/rS6zv2BCviWg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780585321; c=relaxed/relaxed;
	bh=jnSLmeLJV6kE0iVS5+3SJmFGhHsRiD3c0F7TGZf1V5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Elh/oMFDkgfP34nBhbFBhVCf2e1d64lwY81EearQRet4YTuTJcRsI1W//54naL/2FDhCfAvAOijTbvvSIcpzjr7mE7tjBGq4FD5RQkg/8K89pFLsnJMp+ZWwzMTxa+1Vdv+MQli+epa+OCpruouT/KnMBctwkIKaY0k0RK4XTtnG9y/mXuoWvrZbMxlfsVu9hkX1FZIfXs6eCqqWI2c+t/mJ8y6zwt3plS5JrT9dEfR+KTmlbJ3n3TUHHTVpYVVaKSzqxVeyElGAgPgdUMInCW7Oc+y+JRHPgurTme4z30mAfPasMbPk1qpuXd+wLEmj1FeTbLiGr7T5dsyj024MJw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=T+g3PjeR; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com; envelope-from=dimitri.daskalakis1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=T+g3PjeR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com; envelope-from=dimitri.daskalakis1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWSTM2w4mz2y1Y
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 01:01:59 +1000 (AEST)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-c85b73ffb52so358309a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 08:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780585317; x=1781190117; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jnSLmeLJV6kE0iVS5+3SJmFGhHsRiD3c0F7TGZf1V5w=;
        b=T+g3PjeRI5+swlsaNV2IwkIK1Wm/AVmBa3Z3Ym2mE1WdFowHHL4MTIAqV8l65DOybo
         qS1QsX8Mf1mOHzbci2+qBdMuuM4wR8yV/IbUvB6tNg7pcCLPdwnrVolqraXQCI3ziKXW
         gP7zMAfnJbVnuuOFA+R8ojspe9GPcJd9E2mS6GPlgYuDuMI/2YpZB5V6VWtFfQFtR/Ov
         +SX/miC+sjMBxmLs/ygZrayzrGCqJ+jL7ydTEWukgMeNlo0NJEjbR0gj9ipOSyh+RDGI
         jHm8wfpgTRVG2oERNWoxu8He7uBWCvNvIa8zirale/lhS+EIHKBhnkRFwJ7XfT6HZ2fO
         UvOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780585317; x=1781190117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jnSLmeLJV6kE0iVS5+3SJmFGhHsRiD3c0F7TGZf1V5w=;
        b=EFHp5b4zQNRwytVM+R5EOPjtwtVtnXTZZ775hPg6bUjH0HzEijyDDWS3AIszRDQVD+
         PRZhsqGPhEfdLfWsUXGccIU35lD4gKI/qKVmMxUHKj5ohslgP1RNcIBuo3qAvevlkRnO
         kPlOMO1ezKuSQdhRlXvSAkiKkMt7PQg98fJ8qI568JihwIDnLNmTqzVmEqVtosOFavDq
         BWX0xQwOiwmocdURrZcbytZaRPqNCe7qQp/QB3tNMUhAo8e1Sf90N+NsyU9wHNKAp2F4
         uUPl/0HXhC4IEAK4r2VMxFWZTX2mGietmUxtjdqgfRoR1KdKNXk8DppnJ47drywegxLy
         7s/w==
X-Forwarded-Encrypted: i=1; AFNElJ8OeQ6fz540ASQZoLd4KNK2Zq4ndS31BONWXee+iS3VNX77Jp1nUIsS+iNQv7OZmasJ0htKCXN9hTCTwU0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywk5WRljZGSHxKZPIlKXJzHnlGvx8oF8OZFoV/uC9xfUyv1dQEP
	m8MQu/zqWKGCq2kvCH7xDdASfQaHjETe3wk/N3FLzfocPlzgsSm1zVSa
X-Gm-Gg: Acq92OGI8wv9TSH0POOPzdeehDJzmNgaCKxCN+78cJ5vhtAfjb7jsan+84vWBk8DcX7
	35osN3JNL5eQjbjjYY642OUi2jCxUyWlMJ6dVYGMpGipkgnLq1AklBDruLUQyi8HPFl8wtbvYMn
	IWek2L2kFZiLbaKn5mrIE10sjg7G/8UIMxcEQqrlTBO/QMgDjkHzWLw8NialgyqPw3F92rECHTJ
	KLhS54ZihA2T9SbuYjkhLj2IJprMNwb2kpF0r1S4idDi6rtJhZBamuRD+oNwqztRriaPr8OY9V1
	rXHFX6t/8DhfQfhl3lmzAUfzKTDIH5z5xUhG3VBM4c28KDWbFw8UPAMyDBHht40Vkq9X4u5tl6c
	CvkqR+ipTwSP8ZjcJgEuph+VO1F5t0hc/VbmoyITEwuzSH0ykC2HUZSB+XJH2MTIe5R9lq3PWEi
	iK+JXpmRCpUJNvqvU81/1oT6LROB/6LjUsH7AH+Lc=
X-Received: by 2002:a05:6a21:6083:b0:3a3:a9c4:3d60 with SMTP id adf61e73a8af0-3b4975cdbe8mr9228482637.27.1780585316708;
        Thu, 04 Jun 2026 08:01:56 -0700 (PDT)
Received: from localhost ([2a03:2880:7ff:5e::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0bdbe4sm5661594a12.32.2026.06.04.08.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 08:01:56 -0700 (PDT)
From: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alex Williamson <alex@shazbot.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Keith Busch <kbusch@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Dimitri Daskalakis <daskald@meta.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	xen-devel@lists.xenproject.org
Subject: [RFC 01/12] PCI: Add helpers to identify SR-IOV PFs/VFs.
Date: Thu,  4 Jun 2026 08:01:42 -0700
Message-ID: <20260604150153.3619662-2-dimitri.daskalakis1@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260604150153.3619662-1-dimitri.daskalakis1@gmail.com>
References: <20260604150153.3619662-1-dimitri.daskalakis1@gmail.com>
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

From: Dimitri Daskalakis <daskald@meta.com>

Throughout core the pci_dev attribute is_physfn is used to determine
whether or not a PF has SR-IOV active. And is_virtfn is used to check
if a device is a SR-IOV VF.

These attributes should be generalized to represent PFs/VFs for any type
of virtualization. So in preparation, wrap the existing usage in
helpers and use helpers in subsequent patches to ease the transition.

Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Dimitri Daskalakis <daskald@meta.com>
---
 include/linux/pci.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2c4454583c11..28892243f49f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -604,6 +604,16 @@ static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
 	return dev;
 }
 
+static inline bool pci_is_sriov_physfn(const struct pci_dev *dev)
+{
+	return dev->is_physfn;
+}
+
+static inline bool pci_is_sriov_virtfn(const struct pci_dev *dev)
+{
+	return dev->is_virtfn;
+}
+
 struct pci_dev *pci_alloc_dev(struct pci_bus *bus);
 
 #define	to_pci_dev(n) container_of(n, struct pci_dev, dev)
@@ -1277,6 +1287,7 @@ void pcibios_setup_bridge(struct pci_bus *bus, unsigned long type);
 void pci_sort_breadthfirst(void);
 #define dev_is_pci(d) ((d)->bus == &pci_bus_type)
 #define dev_is_pf(d) ((dev_is_pci(d) ? to_pci_dev(d)->is_physfn : false))
+#define dev_is_sriov_pf(d) ((dev_is_pci(d) ? pci_is_sriov_physfn(to_pci_dev(d)) : false))
 
 /* Generic PCI functions exported to card drivers */
 
@@ -2207,6 +2218,7 @@ static inline struct pci_dev *pci_dev_get(struct pci_dev *dev) { return NULL; }
 
 #define dev_is_pci(d) (false)
 #define dev_is_pf(d) (false)
+#define dev_is_sriov_pf(d) (false)
 static inline bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags)
 { return false; }
 static inline int pci_irqd_intx_xlate(struct irq_domain *d,
-- 
2.52.0


