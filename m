Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA35B606A31E
	for <linuxppc-dev@archiver.kernel.org>; Sat, 28 Nov 2026 04:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TibZhc1f
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jbyjN2fGGz2y7p;
	Sat, 28 Nov 2026 15:58:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=172.105.4.254 arc.chain=kernel.org
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795831058;
	cv=pass; b=a934wVWYuCcKIWQqOfFix+7cScnNGqyDVVYZNqU5UdW+gQ/Xkmyr70WFMMyN2zMZ3223no0bw4ft5bNdERp17vxpfrmF0KpPJTt7EFVPpzNRO5hnKCchonf68XwDDLtzPXLC/CCDuTMmq3mHuVs0WTXi6H7gAvBEayRRBDNYWf403Mp0+e23fIqAS6f+0CP+u4ulxcwM6N6ga2hl0exfcAuQqk37Yres3cMAk/D56O0ZCbH/A82thaxgBGe9FHx/likGDlQyCKDJEEPKf5dY6MdcvlS1tN7EYHfB0twa6LwvTo/MtsZaaS3ydCqpZJBZqTlT74FUUF+CoqFydQZ8tQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795831058; c=relaxed/relaxed;
	bh=bHxqvPh3ppNYFdCM4V5QvWKC2wpzaqk/bpoy4eBiOkA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XCHrR9GZhTsDLqKWehSRofToSh/vCMzX/FTbqJLdZxgefFnQoks6Tq1Isn9KlsKgllsZH0qAUcxIsFM4Q0ofyjPpkCOlv1XofS49ILVUhoHv7ayiYAzLBOLrDLeCbkchyIlHbBKVBxs/Z0wFkJ3eU8umGohblSgGE7uinbuUqsuKg/hZMQ06x1o5eMcBtG7eMRl8DH8pHj7V/qKLSWU1bHLPlQUlVOuSWnVo+Bw/xVpUX0JIr7Ot3lT59gc+LHi9Uwe80hAjC4EecY3av1CMCBvrjkbPq7V6/ceflUh/taHNx43HnotSkAJrYy2MS/zN7s8faCcVH+5bZbVdLRMzLA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TibZhc1f; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=devnull+akafelixab.gmail.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TibZhc1f;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=devnull+akafelixab.gmail.com@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jbthd5GL6z2xyh
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Nov 2026 12:57:37 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id EC49860416;
	Sat, 28 Nov 2026 01:57:34 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795831054;
	b=VdA74k43fIcKqtntVsKcHmiArm4yeT8zKEy3BNSiGuFG/9cigHNdh1lG/WHxmvuNXuu1
	 Sd4HI/fbY8NhUskCO9PwT5++JHc15pth0qIqWTjb+UWhbbqvKVXSwPccfWKOIzZnfRigv
	 R7bpcjLhXmysXbs1BPp5R9c12KpEDsoTV4nRYqaggZScA1gGH0c+vuGwVCQHzgFYPFstj
	 cmhuNB6j/oLzpGoi85LPoKp2CZ5L/a25KXrM5uVksPVIe3S3zWhz1ZLZtn5Rmy3siSUgZ
	 Rd4M9pXUSnB/mseOjgIdFwqg3Wv/RiVnyLGhk6hh4s/5JoBxCiCOoUispXGr4O5/Wdg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795831054;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=bHxqvPh3ppNYFdCM4V5QvWKC2wpzaqk/bpoy4eBiOkA=;
	b=CIMIZ0ab0Wcvms/uNLDeVSzRMyHcXePpeddjI9xV/3af5PvJNeJIais6/gQpxD+n+N6n
	 cJ2tmnQih8z9R9VcMR8pcIUzsU7yUWUQzReAjJ4ompmLy7fb5yejO0GFXXEVBpafN5TdC
	 nObXBzOnixdZdr3jbp/I2V5bD20zZPZ0F8rIccnEiflDNmjHD4hRiug9HtczW4TF6n4OZ
	 HeBDTUbGzeCp1eFj3kOXGDYvr0m62H4RhJypq+GOzL6TeN4lvXj7MtlGkhquIYckA28od
	 BGfY8qphCH7WN3R9lhnjwuRMMZynUQPdCsI229AtZQuZygstsia6Yqd4mB2YZWwmKjQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3D58E1F00893;
	Sat, 28 Nov 2026 01:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795831054;
	bh=bHxqvPh3ppNYFdCM4V5QvWKC2wpzaqk/bpoy4eBiOkA=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=TibZhc1fqM+TLNB8jF61TRaUBRkzq2pxWJZdDcbJFEezJVY6czG4kUvHE0nQ2K4R+
	 XTpc+qP2zDEQkwTdxuY3wnFV713HgxmMaT8wsNPlqwWGRGa0/GFgPThiBwc/af7/PJ
	 pxMb1nwAoTpa2KkZTbvKup7nMeaeHHtTTAUPt/w/0QFUOiDR6+6wMlkfqwzkj8E+X8
	 2wcjbAAOe0WtlybmpBK+FBKZzQjx9dNR2XDS77IIGs1dWx9w5ZfyeLco3fxGRnS16Y
	 CuX185n7yZP3fZ1rpVO53JthZWCFeA3vZCu0PkF5dT8rQjmpD3tZ9RlGK01ievMgoH
	 9UkX2bOBFjqXA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C4C9C4DF08;
	Sat, 28 Nov 2026 01:57:33 +0000 (UTC)
From: Felix Huang via B4 Relay <devnull+akafelixab.gmail.com@kernel.org>
Date: Fri, 27 Nov 2026 20:58:51 -0500
Subject: [PATCH] usb: phy: fsl-usb: use NULL instead of plain integer 0
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
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261127-fsl-usb-null-pointer-v1-1-1d10607f9f39@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0avIrB1I0qKlVykuHDvRkRAlY0pBv
 HtTXb7F/zsoJ2GFZ7VD4o+oLLHA1hUMUx9HRnkXgzOusda16DVgVsKYQ8B1kbhxQk9k7w/T9Dc
 yUNI1sZfvuX11lzXTzMP2f8Fx/AAoLyv+eAAAAA==
X-Change-ID: 20261127-fsl-usb-null-pointer-fbb14806a3b0
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 Felix Huang <akafelixab@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795831131; l=1057;
 i=akafelixab@gmail.com; s=20261128; h=from:subject:message-id;
 bh=F90+UAhf/qFwjlJxTZbrRIrGBJm8qNw2VciNz2TFR6I=;
 b=dq/U0Wmrsv/58/mA0pLYFqm6ys7ncWjOkCfRqzTVV8Txb6bluBYA5ekaFRD5GiaKD6V4ywLdq
 ANp9UlLeWzUAFIiUhqdxB7L2tlZm+sX3zVh3S1nB6g6UhG0Fk3jZQzE
X-Developer-Key: i=akafelixab@gmail.com; a=ed25519;
 pk=Axl3BM1UWa+m0/AWcEhRIdIk/WY9FnY4wZkyQn64uVY=
X-Endpoint-Received: by B4 Relay for akafelixab@gmail.com/20261128 with
 auth_id=1670
X-Original-From: Felix Huang <akafelixab@gmail.com>
Reply-To: akafelixab@gmail.com
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Felix Huang <akafelixab@gmail.com>

Fix the following sparse warning in fsl_otg_set_peripheral():

  drivers/usb/phy/phy-fsl-usb.c:618:31: warning: Using plain integer as NULL pointer

Assign NULL instead of 0 to the struct usb_gadget pointer otg->gadget.

Signed-off-by: Felix Huang <akafelixab@gmail.com>
---
 drivers/usb/phy/phy-fsl-usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/phy/phy-fsl-usb.c b/drivers/usb/phy/phy-fsl-usb.c
index 1986f7e9d..110b277aa 100644
--- a/drivers/usb/phy/phy-fsl-usb.c
+++ b/drivers/usb/phy/phy-fsl-usb.c
@@ -615,7 +615,7 @@ static int fsl_otg_set_peripheral(struct usb_otg *otg,
 		if (!otg->default_a)
 			otg->gadget->ops->vbus_draw(otg->gadget, 0);
 		usb_gadget_vbus_disconnect(otg->gadget);
-		otg->gadget = 0;
+		otg->gadget = NULL;
 		otg_dev->fsm.b_bus_req = 0;
 		otg_statemachine(&otg_dev->fsm);
 		return 0;

---
base-commit: f4585067150b85e33f60876149a6e742928da75e
change-id: 20261127-fsl-usb-null-pointer-fbb14806a3b0

Best regards,
--  
Felix Huang <akafelixab@gmail.com>



