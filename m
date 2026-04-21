Return-Path: <linuxppc-dev+bounces-19887-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53195F8FA6A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2026 12:14:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0Lrs6WJYz2ySW;
	Tue, 21 Apr 2026 22:14:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:e0a:1040:9780:49:5ff:fe41:d261"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776773693;
	cv=none; b=CwA563LQVcPvE99DbEfLuT06t5WUVvj/47rKqEZgu1EtR37ATxPXPEtMG34qncC3EAW48mqA1RAfXwbxNjAP6AddXUdLcDE9GEMAiVrhnzWdFs0U0WKmYpL739RnFq+Gk47NaxJ8NHTgk8zB7PRNpWgIMKFexJe28SossEm5AXF4n56NB6yTk7oIXgsLvLqOcUC122czleszqWz6LLZeJqvcJtjt2jKWhjDY/+RhIcEkLtzfYoqjQ3sCAUKJnnNuDdOzQIPADnKI/pmZqwk9lUcR+eiA4iGarMVqRbFyXoodyhE2WZLxULqOGvc1yM54eKJYSPV16JbmLBFHlTq2Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776773693; c=relaxed/relaxed;
	bh=EkozveozFgVRE0sJBT+yD7vRAphS/u6LHod1BdHztv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wkgk/13lkhBWNHltegF5Jufr3NDcMfWFBjuMUDdBXaYMxdwLb5Er9C5bPeJEuPOTFK0b4pJKRU5jYuo38B7E4qju8gd3Y4j0DLfUqtCGmuAxqfXayGM0TSpAt7HgqWSzrih8vFUgAQ6sNMmvW2gznoh/CLoFkSLbPWTXIN8EZwTj4pp8huNZ4am6HtYvbvLs72Kuc2yrRGUyMIz90k3EvYChg16ayECQRVPxFPMOqFdeWavLHl0pbEeQm8KmgQwuTpaGP4xbfAQwwwv0GEeDm1cvVjt5AL7lzcnc3bc0pVld336C6SKE1FrSo+S/hq+3MdEy4rSkQyosXQ1cuey7OQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr; spf=pass (client-ip=2a01:e0a:1040:9780:49:5ff:fe41:d261; helo=luna.linkmauve.fr; envelope-from=linkmauve@linkmauve.fr; receiver=lists.ozlabs.org) smtp.mailfrom=linkmauve.fr
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linkmauve.fr (client-ip=2a01:e0a:1040:9780:49:5ff:fe41:d261; helo=luna.linkmauve.fr; envelope-from=linkmauve@linkmauve.fr; receiver=lists.ozlabs.org)
X-Greylist: delayed 6476 seconds by postgrey-1.37 at boromir; Tue, 21 Apr 2026 22:14:53 AEST
Received: from luna.linkmauve.fr (unknown [IPv6:2a01:e0a:1040:9780:49:5ff:fe41:d261])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0Lrs0nrhz2yvR
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2026 22:14:53 +1000 (AEST)
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
	id C8035F40862; Tue, 21 Apr 2026 14:14:40 +0200 (CEST)
From: Link Mauve <linkmauve@linkmauve.fr>
To: linuxppc-dev@lists.ozlabs.org
Cc: Link Mauve <linkmauve@linkmauve.fr>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Juergen Gross <jgross@suse.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Geoff Levand <geoff@infradead.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	Anatolij Gustschin <agust@denx.de>,
	=?UTF-8?q?Breno=20Leit=C3=A3o?= <leitao@debian.org>,
	Nayna Jain <nayna@linux.ibm.com>,
	Paulo Flabiano Smorigo <pfsmorigo@gmail.com>,
	Eric Biggers <ebiggers@kernel.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Thomas Huth <thuth@redhat.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	David Hildenbrand <david@kernel.org>,
	Alistair Popple <apopple@nvidia.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Donet Tom <donettom@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Will Deacon <will@kernel.org>,
	"Lorenzo Stoakes (Oracle)" <ljs@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	Nam Cao <namcao@linutronix.de>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Srikar Dronamraju <srikar@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Jiri Bohac <jbohac@suse.cz>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Kees Cook <kees@kernel.org>,
	Stephen Rothwell <sfr@cab.auug.org.au>,
	Xichao Zhao <zhao.xichao@vivo.com>,
	Gautam Menghani <gautam@linux.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Li Chen <chenl311@chinatelecom.cn>,
	Aboorva Devarajan <aboorvad@linux.ibm.com>,
	Petr Mladek <pmladek@suse.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	"Nysal Jan K.A." <nysal@linux.ibm.com>,
	Aditya Gupta <adityag@linux.ibm.com>,
	Sayali Patil <sayalip@linux.ibm.com>,
	Rohan McLure <rmclure@linux.ibm.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Donnellan <andrew+kernel@donnellan.id.au>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Athira Rajeev <atrajeev@linux.ibm.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Chen Ni <nichen@iscas.ac.cn>,
	Haren Myneni <haren@linux.ibm.com>,
	Jonathan Greental <yonatan02greental@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	"Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
	Gaurav Batra <gbatra@linux.ibm.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	=?UTF-8?q?Adrian=20Barna=C5=9B?= <abarnas@google.com>,
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
	Thierry Reding <treding@nvidia.com>,
	Yury Norov <ynorov@nvidia.com>,
	"Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
	Ruben Wauters <rubenru09@aol.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	x86@kernel.org
Subject: [PATCH 1/2] powerpc: Add a typos.toml file
Date: Tue, 21 Apr 2026 14:14:13 +0200
Message-ID: <20260421121420.26079-2-linkmauve@linkmauve.fr>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421121420.26079-1-linkmauve@linkmauve.fr>
References: <20260421121420.26079-1-linkmauve@linkmauve.fr>
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

This file is used by the typos tool[1] to determine which words to fix,
which ones not to fix, and what the target word should be.

[1] https://github.com/crate-ci/typos

Signed-off-by: Link Mauve <linkmauve@linkmauve.fr>
---
 arch/powerpc/typos.toml | 109 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)
 create mode 100644 arch/powerpc/typos.toml

diff --git a/arch/powerpc/typos.toml b/arch/powerpc/typos.toml
new file mode 100644
index 000000000000..5c42fd2adf56
--- /dev/null
+++ b/arch/powerpc/typos.toml
@@ -0,0 +1,109 @@
+[default.extend-words]
+# All of these duplicated words tell typos not to touch them.
+# They are case-insensitive but keep the case when fixed.
+aack = "aack"
+aer = "aer"
+ahd = "ahd"
+alo = "alo"
+als = "als"
+aout = "aout"
+ba = "ba"
+buid = "buid"
+clen = "clen"
+cmo = "cmo"
+cpy = "cpy"
+daa = "daa"
+datas = "datas"
+decie = "decie"
+defin = "defin"
+divde = "divde"
+edn = "edn"
+emac = "emac"
+evn = "evn"
+extint = "extint"
+filp = "filp"
+firsr = "firsr"
+fram = "fram"
+fre = "fre"
+fpr = "fpr"
+hypen = "hypen"
+ihs = "ihs"
+indx = "indx"
+intack = "intack"
+iput = "iput"
+ist = "ist"
+iy = "iy"
+millenium = "millenium"
+mmaped = "mmaped"
+mminimal = "mminimal"
+mport = "mport"
+msis = "msis"
+nam = "nam"
+nax = "nax"
+nd = "nd"
+nin = "nin"
+nto = "nto"
+onl = "onl"
+ot = "ot"
+outout = "outout"
+parm = "parm"
+parms = "parms"
+performa = "performa"
+pevents = "pevents"
+piar = "piar"
+pn = "pn"
+ptd = "ptd"
+recal = "recal"
+rela = "rela"
+rto = "rto"
+ser = "ser"
+shw = "shw"
+shs = "shs"
+sie = "sie"
+siz = "siz"
+slq = "slq"
+sxl = "sxl"
+synopsys = "synopsys"
+systemes = "systemes"
+tbe = "tbe"
+tge = "tge"
+thr = "thr"
+thre = "thre"
+tne = "tne"
+tpe = "tpe"
+tpos = "tpos"
+tre = "tre"
+trun = "trun"
+tou = "tou"
+ue = "ue"
+unline = "unline"
+uupdate = "uupdate"
+vas = "vas"
+vor = "vor"
+wil = "wil"
+
+# These words are for typos which had two or more known fixes.
+addresse = "address"
+allowe = "allow"
+arbitrer = "arbiter"
+colose = "color"
+concatination = "concatenation"
+contants = "constants"
+contigious = "contiguous"
+defferent = "different"
+fime = "fixme"
+fo = "for"
+fom = "from"
+formt = "format"
+matrics = "metrics"
+mmaping = "mmapping"
+multipler = "multiplier"
+ony = "only"
+partions = "partitions"
+partioning = "partitioning"
+pathes = "paths"
+sensure = "ensure"
+tranditional = "traditional"
+verisions = "versions"
+wether = "whether"
+wll = "will"
-- 
2.54.0


