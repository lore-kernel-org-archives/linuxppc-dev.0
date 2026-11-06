Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3F5606A328
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Nov 2026 00:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kftnyqWz
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLL504nbHz3c5M;
	Fri, 06 Nov 2026 11:43:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.167.199
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793925796;
	cv=none; b=d6k+eBeZQskx/jsCj4qVd4KcvGM18prRJzPhIvVUDoAQZMIOzqh90iYOjPl448x5D+xc/jW4vm24CTslskOh+2iIdBHfH7NzU74V2FHV1ec5APtzL5EbnwtLjK1typVqvsF+dQYYyFpYdS8uieK5q3lt/MC47f207pRTEW29agEP9+JYgnzaP4oWEzCgnvQygE3cM1cOyAUEK6gffsnCOoqJc7yZ2Ft7T6bPsR+7R7TdaJ/fpVaOjfWUttKbD/wEdMdM5wES37nLKDyGA4xAYqsw/lVVos1AO//9KaWQUSYyPVJ5EdTQUFv+mS9yVWPitspcd6K45N4QmG1pLddMyw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793925796; c=relaxed/relaxed;
	bh=Ko9lBiZy6mSuKQIVTlOLgBpFZr5J5ifQKI8Or80My08=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J2CzOTOaR2TJjLD4rggEDUivF42DjdYtAwDROhEByCAHY2suDoswTyYCPTlmQEJElPz7XhkusUN3TYhdYA6ywCBkyY2LDfGLt8i6Oty/zmDc6i/swKemvV8RA3W8drDvqrmeG1T+PWPiG/0Ol3yg9gEJz6iry3FONdyKHzgfq02AS15wi4edcrZbcjUvzzoOeItq3r4KeJ3eqvzFddKOJed3wuI5eWyQXMxD6qIjhp50suMVxN8JdWai+Rqh3gIBRD40hHUF4iVvY8aqK7+IwIcvEE5aLaPDDFUY2U//wEU0hGn7/WFSIUrsjnu7OOUHnyfYTx9Kuk/Phnm+5+Y/bw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kftnyqWz; dkim-atps=neutral; spf=pass (client-ip=209.85.167.199; helo=mail-oi1-f199.google.com; envelope-from=3ocltaggkdpcclzskzbjfnnfkd.bnlkhmtwoob-cdukhrsr.nykzar.nqf@flex--dmatlack.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kftnyqWz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dmatlack.bounces.google.com (client-ip=209.85.167.199; helo=mail-oi1-f199.google.com; envelope-from=3ocltaggkdpcclzskzbjfnnfkd.bnlkhmtwoob-cdukhrsr.nykzar.nqf@flex--dmatlack.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLL4z5dwVz3c2P
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 11:43:15 +1100 (AEDT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4db3db8687fso127712b6e.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 16:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793925793; x=1794530593; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ko9lBiZy6mSuKQIVTlOLgBpFZr5J5ifQKI8Or80My08=;
        b=kftnyqWzqux5wJyxkTZMSdvZaggvU4ZhqaL2g9odt/1s3GDaZMq6L+7f2dmCz3CXol
         jrSHIPZEOThG8RawAd8a4deteQ1K+2m+bCN7tjnC3TaJYvYH6bNMnL6X4J3r3nhlZO3T
         Zrsa2mb2GkY22AJyq4SvinYbsynY+l68N9ib+wJb3aXSofUNjkQ/pEc+tviLAJQSB3KG
         nEpjZRORJNSwYoGZ4EEzjBwMXTxvbERL1z5widBqAkFqKdCJJzFL3LZU/pjptQp8enEj
         2D0s6lz7vs+zGOY+R8em7dSqWdNlXgdo7ssKkE0w/my8s7n39EgFmnMf0p0ikvxgLWnF
         yHVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793925793; x=1794530593;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ko9lBiZy6mSuKQIVTlOLgBpFZr5J5ifQKI8Or80My08=;
        b=saI/7a6xeWxbfbd3Tmg1q1rH2YkbgGFWSgre+it+7VHDgDe/Xo/jAiOoL7ZQZMl1QO
         Qxgg8D+II3BbgV9P26ExaDbxDLQhGJVnDcJQfto8eByDgBScnOYC30SEbrgmSV1UFqKY
         KGhRDTh66aTfqBAOpPVmozx+usO/e8UfOpmFv3RVMBzPdguDHE20ss8jjfSzrOGkxiDE
         ko/847V7GZBnf2wzK6D+CLyUHxZUo5rIdu8l0ptkfWQCGGMona/J/g7qWa48+Ec8fKfM
         +N6NV/NrH7BzyxChZjbO646zws8BoUvDe8NntX5fXbICPGlpB5XnqdWpYtAYVdqkKAig
         FAaA==
X-Forwarded-Encrypted: i=1; AKwUvBya3ucQas7H2bsO0vcta6qQ6Oowwci3opA1RboTPM462roxW8dwo0YWMq+etdXpBX+81lmtqU+ZQwYBkhk=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z98SZ5J3MLhPlA0frIhF1J7FFnQ9IeB+cnwItUCdgwR1viU0k9I
	PBRjrQ/0aeXx3FH+hQYeFrUWM5w8udtJr0lk8WgOSNemMq3F7xDx9bqfIALT0GJOpy/5+WRKPr+
	RWYLpVcpy3hlIRw==
X-Received: from iobgs6.prod.google.com ([2002:a05:6602:4fc6:b0:9c7:69c7:3d52])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:5087:b0:4f4:857c:98ae with SMTP id 5614622812f47-567e0faea86mr686749b6e.11.1793925792669;
 Thu, 05 Nov 2026 16:43:12 -0800 (PST)
Date: Fri,  6 Nov 2026 00:42:14 +0000
In-Reply-To: <20261106004218.604799-1-dmatlack@google.com>
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
Mime-Version: 1.0
References: <20261106004218.604799-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261106004218.604799-14-dmatlack@google.com>
Subject: [PATCH v2 13/17] PCI/VC: Split the VC Resource Control restore into a helper
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Cc: Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, David Matlack <dmatlack@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Lukas Wunner <lukas@wunner.de>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Mike Rapoport <rppt@kernel.org>, 
	"Oliver O'Halloran" <oohall@gmail.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Move the restore of the VC Resource Control register out of
pci_vc_do_save_buffer() and into pci_vc_restore_res_ctrl().

Restoring this register is more involved than the rest of the walk: the
enable bit has to be preserved across the write, the port arbitration
table may have to be reloaded, and the VC may have to be re-enabled
afterwards. Inlined in the middle of a loop that is already sizing,
saving and restoring three kinds of register, it is hard to see where
that sequence begins and ends.

No functional change intended.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/vc.c | 51 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/vc.c b/drivers/pci/vc.c
index a4ff7f5f66dd..5b507207d56d 100644
--- a/drivers/pci/vc.c
+++ b/drivers/pci/vc.c
@@ -168,6 +168,37 @@ static void pci_vc_enable(struct pci_dev *dev, int pos, int res)
 		pci_err(link, "VC%d negotiation stuck pending\n", id);
 }
 
+/**
+ * pci_vc_restore_res_ctrl - Restore a VC Resource Control Register
+ * @dev: device
+ * @pos: starting position of VC capability (VC/VC9/MFVC)
+ * @res: VC resource number, ie. VCn (0-7)
+ * @ctrl: saved VC Resource Control Register
+ */
+static void pci_vc_restore_res_ctrl(struct pci_dev *dev, int pos, int res,
+				    u32 ctrl)
+{
+	int ctrl_pos = pos + PCI_VC_RES_CTRL + (res * PCI_CAP_VC_PER_VC_SIZEOF);
+	u32 tmp;
+
+	/*
+	 * For an FLR case, the VC config may remain.  Preserve enable bit,
+	 * restore the rest.
+	 */
+	pci_read_config_dword(dev, ctrl_pos, &tmp);
+	tmp &= PCI_VC_RES_CTRL_ENABLE;
+	tmp |= ctrl & ~PCI_VC_RES_CTRL_ENABLE;
+	pci_write_config_dword(dev, ctrl_pos, tmp);
+
+	/* Load port arbitration table if used */
+	if (ctrl & PCI_VC_RES_CTRL_ARB_SELECT)
+		pci_vc_load_port_arb_table(dev, pos, res);
+
+	/* Re-enable if needed */
+	if ((ctrl ^ tmp) & PCI_VC_RES_CTRL_ENABLE)
+		pci_vc_enable(dev, pos, res);
+}
+
 /**
  * pci_vc_do_save_buffer - Size, save, or restore VC state
  * @dev: device
@@ -311,23 +342,9 @@ static int pci_vc_do_save_buffer(struct pci_dev *dev, int pos,
 			if (save)
 				pci_read_config_dword(dev, ctrl_pos,
 						      (u32 *)buf);
-			else {
-				u32 tmp, ctrl = *(u32 *)buf;
-				/*
-				 * For an FLR case, the VC config may remain.
-				 * Preserve enable bit, restore the rest.
-				 */
-				pci_read_config_dword(dev, ctrl_pos, &tmp);
-				tmp &= PCI_VC_RES_CTRL_ENABLE;
-				tmp |= ctrl & ~PCI_VC_RES_CTRL_ENABLE;
-				pci_write_config_dword(dev, ctrl_pos, tmp);
-				/* Load port arbitration table if used */
-				if (ctrl & PCI_VC_RES_CTRL_ARB_SELECT)
-					pci_vc_load_port_arb_table(dev, pos, i);
-				/* Re-enable if needed */
-				if ((ctrl ^ tmp) & PCI_VC_RES_CTRL_ENABLE)
-					pci_vc_enable(dev, pos, i);
-			}
+			else
+				pci_vc_restore_res_ctrl(dev, pos, i,
+							*(u32 *)buf);
 			buf += 4;
 		}
 		len += 4;
-- 
2.56.0.455.g6c5a503b38-goog


