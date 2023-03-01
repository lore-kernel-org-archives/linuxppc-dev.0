Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D4D0C678D4
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Mar 2023 04:10:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PRyLb0sncz3cfW
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Mar 2023 15:10:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=traphandler.com (client-ip=46.105.34.251; helo=smtpout1.mo528.mail-out.ovh.net; envelope-from=jjhiblot@traphandler.com; receiver=<UNKNOWN>)
Received: from smtpout1.mo528.mail-out.ovh.net (smtpout1.mo528.mail-out.ovh.net [46.105.34.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PRqXN3gPsz3bhD
	for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Mar 2023 10:03:16 +1100 (AEDT)
Received: from pro2.mail.ovh.net (unknown [10.109.156.120])
	by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 5F9F121955;
	Wed,  1 Mar 2023 18:53:00 +0000 (UTC)
Received: from localhost.localdomain (88.161.25.233) by DAG1EX1.emp2.local
 (172.16.2.1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 1 Mar
 2023 19:52:58 +0100
From: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
To: <saravanak@google.com>, <clement.leger@bootlin.com>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, Russell King
	<linux@armlinux.org.uk>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas
 Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
	<zajec5@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas
 Gleixner <tglx@linutronix.de>, Claudiu Beznea <claudiu.beznea@microchip.com>,
	Marc Zyngier <maz@kernel.org>, <afaerber@suse.de>, Manivannan Sadhasivam
	<mani@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
	<paul.walmsley@sifive.com>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
	<jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Rob Herring
	<robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Bjorn Helgaas
	<bhelgaas@google.com>, Nishanth Menon <nm@ti.com>, <ssantosh@kernel.org>,
	<mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>,
	<thierry.reding@gmail.com>, <jonathanh@nvidia.com>
Subject: [PATCH 1/3] of: irq: make callers of of_irq_parse_raw() release the device node
Date: Wed, 1 Mar 2023 19:52:07 +0100
Message-ID: <20230301185209.274134-2-jjhiblot@traphandler.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230301185209.274134-1-jjhiblot@traphandler.com>
References: <20230301185209.274134-1-jjhiblot@traphandler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [88.161.25.233]
X-ClientProxiedBy: DAG3EX2.emp2.local (172.16.2.22) To DAG1EX1.emp2.local
 (172.16.2.1)
X-Ovh-Tracer-Id: 11460535152125229436
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrudelhedguddutdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgtghisehtkeertdertddtnecuhfhrohhmpeflvggrnhdqlfgrtghquhgvshcujfhisghlohhtuceojhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmqeenucggtffrrghtthgvrhhnpeduteevleevvefggfdvueffffejhfehheeuiedtgedtjeeghfehueduudegfeefueenucfkphepuddvjedrtddrtddruddpkeekrdduiedurddvhedrvdeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehjjhhhihgslhhothesthhrrghphhgrnhgulhgvrhdrtghomheqpdhnsggprhgtphhtthhopedupdhrtghpthhtohepshgrrhgrvhgrnhgrkhesghhoohhglhgvrdgtohhmpdhnmhesthhirdgtohhmpdhsshgrnhhtohhshheskhgvrhhnvghlrdhorhhgpdhmrghthhhirghsrdhnhihmrghnsehinhhtvghlrdgtohhmpdhgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdpthhhihgvrhhrhidrrhgvughinhhgsehgmhgrihhlrdgtohhmpdhjohhnrghthhgrnhhhsehnvhhiughirgdrtghomhdplhhinhhugi
 dqrhgvnhgvshgrshdqshhotgesvhhgvghrrdhkvghrnhgvlhdrohhrghdplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdplhhinhhugihpphgtqdguvghvsehlihhsthhsrdhoiihlrggsshdrohhrghdplhhinhhugidqfihirhgvlhgvshhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhlihhnuhigqdgrtghtihhonhhssehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhlihhnuhigqdhrihhstghvsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhlihhnuhigqdhsuhhngihisehlihhsthhsrdhlihhnuhigrdguvghvpdguvghvihgtvghtrhgvvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdplhhinhhugidquhhssgesvhhgvghrrdhkvghrnhgvlhdrohhrghdpsghhvghlghgrrghssehgohhoghhlvgdrtghomhdpfhhrohifrghnugdrlhhishhtsehgmhgrihhlrdgtohhmpdhrohgshhdoughtsehkvghrnhgvlhdrohhrghdpshgrmhhuvghlsehshhholhhlrghnugdrohhrghdptghlvghmvghnthdrlhgvghgvrhessghoohhtlhhinhdrtghomhdpghgvvghrthdorhgvnhgvshgrshesghhlihguvghrrdgsvgdpmhgrghhnuhhsrdgurghmmhesghhmrghilhdrtghomhdplhhinhhugiesrghrmhhlihhnuhigrdh
 orhhgrdhukhdpmhhpvgesvghllhgvrhhmrghnrdhiugdrrghupdhnphhighhgihhnsehgmhgrihhlrdgtohhmpdgthhhrihhsthhophhhvgdrlhgvrhhohiestghsghhrohhuphdrvghupdiirghjvggtheesghhmrghilhdrtghomhdplhhinhhugidqthgvghhrrgesvhhgvghrrdhkvghrnhgvlhdrohhrghdpuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdptghlrghuughiuhdrsggviihnvggrsehmihgtrhhotghhihhprdgtohhmpdhmrgiisehkvghrnhgvlhdrohhrghdprghfrggvrhgsvghrsehsuhhsvgdruggvpdhmrghniheskhgvrhhnvghlrdhorhhgpdhprghlmhgvrhesuggrsggsvghlthdrtghomhdpphgruhhlrdifrghlmhhslhgvhiesshhifhhivhgvrdgtohhmpdifvghnshestghsihgvrdhorhhgpdhjvghrnhgvjhdrshhkrhgrsggvtgesghhmrghilhdrtghomhdpthhglhigsehlihhnuhhtrhhonhhigidruggvpdfovfetjfhoshhtpehmohehvdekpdhmohguvgepshhmthhpohhuth
X-Mailman-Approved-At: Thu, 02 Mar 2023 15:09:14 +1100
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
Cc: devicetree@vger.kernel.org, Jean-Jacques Hiblot <jjhiblot@traphandler.com>, linux-actions@lists.infradead.org, linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org, linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

of_irq_parse_raw() does a get() on the device node returned in out_irq->np.
Callers of of_irq_parse_raw() must do a put() when they are done with it.

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
---
 arch/powerpc/platforms/fsl_uli1575.c | 1 +
 drivers/bcma/main.c                  | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/fsl_uli1575.c b/arch/powerpc/platforms/fsl_uli1575.c
index 84afae7a25617..ba104f6474bc8 100644
--- a/arch/powerpc/platforms/fsl_uli1575.c
+++ b/arch/powerpc/platforms/fsl_uli1575.c
@@ -334,6 +334,7 @@ static void hpcd_final_uli5288(struct pci_dev *dev)
 	laddr[1] = laddr[2] = 0;
 	of_irq_parse_raw(laddr, &oirq);
 	dev->irq = irq_create_of_mapping(&oirq);
+	of_node_put(oirq.np);
 }
 
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x1575, hpcd_quirk_uli1575);
diff --git a/drivers/bcma/main.c b/drivers/bcma/main.c
index 0a8469e0b13ad..11219dd79d327 100644
--- a/drivers/bcma/main.c
+++ b/drivers/bcma/main.c
@@ -193,7 +193,10 @@ static unsigned int bcma_of_get_irq(struct device *parent,
 		return 0;
 	}
 
-	return irq_create_of_mapping(&out_irq);
+	ret = irq_create_of_mapping(&out_irq);
+	of_node_put(out_irq.np);
+
+	return ret;
 }
 
 static void bcma_of_fill_device(struct device *parent,
-- 
2.25.1

