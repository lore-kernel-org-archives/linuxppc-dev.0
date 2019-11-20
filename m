Return-Path: <SRS0=DyCn=ZM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1503C432C0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Nov 2019 02:44:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DC8C222AB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Nov 2019 02:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8DUZ+UG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DC8C222AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47Hn826w6WzDqhC
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Nov 2019 13:44:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::544;
 helo=mail-pg1-x544.google.com; envelope-from=oohall@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="D8DUZ+UG"; 
 dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47HlWQ6yg9zDqfY
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Nov 2019 12:30:42 +1100 (AEDT)
Received: by mail-pg1-x544.google.com with SMTP id r18so12443783pgu.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Nov 2019 17:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JTT3tPd8+RcrneaEkrPWPPR9fRUHGh9SyuUFqrF+VIA=;
 b=D8DUZ+UGDwxBTS/j0buPtLpEPkASirXrI4eXH1n3OkBV0BItxQjzKTeZXqxYUNXtcI
 b6+fS8KoazLtdkD3yc8ZdsIrLR5INKw00IqMGbIqUCDdwQRyWYz8bNybosDfdBCVsWXF
 3H6EiFh8p0muV9IbpVLHY8p7cxTVKa1jJp/AjSDBho6GNLW5yFNRVLrgotNZWPD2Lo9H
 wHcO7Rk7oETWU+7Zjx7+Ryl5CYpAk4XkI6zK5ZRVj2FugxMfBjjt+4lXAKTEEuGZm6Tg
 9lnTUrSDm04qEy79D86J+2v27G1j1ngst7PCj+i/+0AD9H3HCQygKvObvCijtwjqt/Uw
 441A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JTT3tPd8+RcrneaEkrPWPPR9fRUHGh9SyuUFqrF+VIA=;
 b=uXeiF+/vkLJR+Qp0tMsU1pxKmygHez3CvzWvpQjAMnlmCpBpibIb7GY08+toqa4Fj4
 wWtmlcKKqNurFgdqGLI8MIxz5d44U84Y+8si7HRGR045P7RDn1Dn+AOaNoVE4SvBmfSp
 5+5q7bJvfP9efEWwy9bl1S1lBTJQHwnbFl8mAwjz5yyTR/67gbg5GCWuKw45CM0ns+EA
 2EnHhH3S1zHAXf0JhqLsUereQnxto4gUIIDCDq4EJrZJl4VnvxDJqBwDdzX11p9gk6vc
 LI8tsgTHeq1suT5y9LMTXs2ouIT8oc1JHC6u52YMCxhEmasXbgjhdk/bxBtTnlE8Fyqu
 kDnQ==
X-Gm-Message-State: APjAAAUo1AEfdEB03lvvILYtqWZS8JuRSu4UNTTzUj4daL4iGzoktzub
 z/MqJsC/UVUzTYEoz2riYGvRktrn
X-Google-Smtp-Source: APXvYqytVVaW/9IeFfpawG1Bnsdl+J0kZQu14GL1WljQqi1rvmAnM02TNnS6kx+8bNh3tbzw4WXyYQ==
X-Received: by 2002:a65:418d:: with SMTP id a13mr194595pgq.208.1574213439873; 
 Tue, 19 Nov 2019 17:30:39 -0800 (PST)
Received: from wafer.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id b24sm26662116pfi.148.2019.11.19.17.30.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2019 17:30:39 -0800 (PST)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [Very RFC 37/46] powernv/pci: Use the PHB's rmap for pnv_ioda_to_pe()
Date: Wed, 20 Nov 2019 12:28:50 +1100
Message-Id: <20191120012859.23300-38-oohall@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191120012859.23300-1-oohall@gmail.com>
References: <20191120012859.23300-1-oohall@gmail.com>
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
Cc: alistair@popple.id.au, Oliver O'Halloran <oohall@gmail.com>,
 s.miroshnichenko@yadro.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Rather than using the pdn->pe_number for a device as an index into the
IODA PE array we can use the reverse map. This maps the RID (i.e. bdfn)
to the PE number associated with it. Firmware maintains a copy of the
rmap which is used by the hardware for determining which PE to use
when handling a DMA so this gets us a bit closer to the model used
by the HW, which is comprensible by mortals, rather than... whatever
the hell is going on currently.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 8525642b1256..d111a50fbe68 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -672,13 +672,9 @@ struct pnv_ioda_pe *__pnv_ioda_get_pe(struct pnv_phb *phb, u16 bdfn)
 struct pnv_ioda_pe *pnv_ioda_get_pe(struct pci_dev *dev)
 {
 	struct pnv_phb *phb = pci_bus_to_pnvhb(dev->bus);
-	struct pci_dn *pdn = pci_get_pdn(dev);
+	u16 bdfn = (dev->bus->number << 8) | dev->devfn;
 
-	if (!pdn)
-		return NULL;
-	if (pdn->pe_number == IODA_INVALID_PE)
-		return NULL;
-	return &phb->ioda.pe_array[pdn->pe_number];
+	return __pnv_ioda_get_pe(phb, bdfn);
 }
 
 static int pnv_ioda_set_one_peltv(struct pnv_phb *phb,
-- 
2.21.0

