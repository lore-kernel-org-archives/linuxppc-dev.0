Return-Path: <SRS0=4/q6=6I=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E95BC54FD0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2020 22:37:04 +0000 (UTC)
Received: from lists.ozlabs.org (unknown [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71A3A2074F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2020 22:37:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71A3A2074F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stevens-zone.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4988DX59sszDr6y
	for <linuxppc-dev@archiver.kernel.org>; Sat, 25 Apr 2020 08:37:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=stevens-zone.net (client-ip=212.227.126.130;
 helo=mout.kundenserver.de; envelope-from=darren@stevens-zone.net;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=stevens-zone.net
X-Greylist: delayed 321 seconds by postgrey-1.36 at bilbo;
 Sat, 25 Apr 2020 08:35:14 AEST
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4988BV4V4VzDr6d
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2020 08:35:14 +1000 (AEST)
Received: from Cyrus.lan ([80.189.87.161]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.163]) with ESMTPA (Nemesis) id
 1MIyiY-1jlHZZ34UE-00KSAw; Sat, 25 Apr 2020 00:29:39 +0200
Date: Fri, 24 Apr 2020 23:29:38 +0100
From: Darren Stevens <darren@stevens-zone.net>
To: madalin.bacur@nxp.com, netdev@vger.kernel.org
Subject: [RFC PATCH dpss_eth] Don't initialise ports with no PHY
Message-ID: <20200424232938.1a85d353@Cyrus.lan>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; powerpc-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:/BZt50zNv9G906G9ocwyBjQ0Zm7jz6707yp6I7hCFQP0H2xPe50
 i+WqNCC/IMSdkxn1rB/MXN+DmFqzerlaKe/T+aYwQ6+g6QQVg8COQdAcKpKy5jq2PbVM5eD
 AHTcNBhNf4LxJ8woGO1scFAK3AbPL6g2FgNuV1CF7HVl6pyesjyO1bDu/TlVV8tKL3gQnYC
 0AJnUzPNZ9QCNFJsaMfWQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jS2sCBhkfVI=:QdzCKiXrKUybkwPXCT4KnS
 svWeyb2Jvxf+5SnNugIrvOCErdH6SMHuOwoXtm+Z6LImE6uJHiMk34Wd5mKZkz2H5EonMpCZE
 3YRZDBhv3zykiaGHBbAEaKRW0tlNBrpJcmKw4i4s7OlD5xjDvIEyuVVX8MfDFLOhbyTMaUeeN
 wQcdD1DJUeNYlulMf0lDAXL1dXJc1TY8yzq56eBQ8o2f0DxyyJMwUwbmhYBiTNaMAw9JXMK5b
 BCiayKIJ21+yTkkhEKJFKBoSFtVMoItfoBG74bfUdY3PjPJ/v5O7Dgzb+De9zzzTub16Vgc8K
 N1taSfwFBqEM7SpLuxvOyw4v0PJ9CVondN1Zb2F+Dmic6cTafwzmHgQMDd+dTpsu67OC2ctpV
 K1k4oaaT0x91XQkNs3xI+IEVEwhTzRESpWT+J7q8p2yveIAiRVJ5tE3WefrKKBZvg2SoVH9s8
 p/x9juviJFKVVv1vtmmGsxW23zJldaVG7x5fIqTtzy1Ub0lrBs4pzPnpiiMguGBPB4yrbY+9Z
 v5q39h5ZRV0qLuJzC+8PJCpiaugfly4WitS6PD0GJxQprV25AW/1wf0zkHmciWyEhmW93ouGB
 EZTsfDJf8J4s5JpHrFO5SMy3YcVD6s9jBMYJnol1N3zDavX+GpHYigCWCXL0LkLtSiXOQ8peL
 V6o4J8AQUDW5ZHkvD+xOERtMIV58Jd6KFcDfgJdMMGEDvmLipx6BMg4IDh3AGm7hKgLGWNImo
 DFR6BdYNNo81P13a5eblaRnMcgSL3ctZjDI83EHbDRTZL9H6HsDJkMupSNRhGN7Zum0NizOde
 FbRqHmB90vcl9sFvWg5qMjuqzA8PrxEX+LadOV5NGBBXQ/r3B5FX3tnOgTbYnqw/vwoBYNV
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
Cc: oss@buserror.net, linuxppc-dev@lists.ozlabs.org, chzigotzky@xenosoft.de
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Since cbb961ca271e ("Use random MAC address when none is given")
Varisys Cyrus P5020 boards have been listing 5 ethernet ports instead of
the 2 the board has.This is because we were preventing the adding of the
unused ports by not suppling them a MAC address, which this patch now
supplies.

Prevent them from appearing in the net devices list by checking for a
'status="disabled"' entry during probe and skipping the port if we find
it. 

Signed-off-by: Darren Stevens <Darren@stevens-zone.net>

---

 drivers/net/ethernet/freescale/fman/mac.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/freescale/fman/mac.c b/drivers/net/ethernet/freescale/fman/mac.c
index 43427c5..c9ed411 100644
--- a/drivers/net/ethernet/freescale/fman/mac.c
+++ b/drivers/net/ethernet/freescale/fman/mac.c
@@ -606,6 +606,7 @@ static int mac_probe(struct platform_device *_of_dev)
 	struct resource		 res;
 	struct mac_priv_s	*priv;
 	const u8		*mac_addr;
+	const char 		*prop;
 	u32			 val;
 	u8			fman_id;
 	phy_interface_t          phy_if;
@@ -628,6 +629,16 @@ static int mac_probe(struct platform_device *_of_dev)
 	mac_dev->priv = priv;
 	priv->dev = dev;
 
+	/* check for disabled devices and skip them, as now a missing
+	 * MAC address will be replaced with a Random one rather than
+	 * disabling the port
+	 */
+	prop = of_get_property(mac_node, "status", NULL);
+	if (prop && !strncmp(prop, "disabled", 8) {
+		err = -ENODEV;
+		goto _return
+	}
+
 	if (of_device_is_compatible(mac_node, "fsl,fman-dtsec")) {
 		setup_dtsec(mac_dev);
 		priv->internal_phy_node = of_parse_phandle(mac_node,
