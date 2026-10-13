Return-Path: <linuxppc-dev+bounces-29347-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DF5CCC6B0E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Oct 2026 06:15:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3kZz50xtz3bqh;
	Tue, 13 Oct 2026 17:15:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791855356;
	cv=none; b=FsfnJvmbT0CHW4amNdw9fr8hqttJEuHhK6a7zXU29aEqqwQ9rIaLxJEEuV4kR9VKucZ+JPGYi9wZN1Q3rFg5O85tdNUaChZ0bda6KCHAsCmT16jRXgH1/5Tgk6S7qCkmcW2d0XueKBr3iPQJIkyb0bOuVE0Cc3IRFgDw2QVEkqAx4WWFAEGGgX7A6c0FwwxUkTrU6/9ZPbBwErPlhRTkaf9ULLk39nAbhtdMCZvEgAsfJYQggNLzx0WtiR7re1E0vH//6Ow2LMggMg3M7M84BalLdqR0LV/esK2h4oALrMe8jIMvr7Q80shJQqdRlqQRe+rdMhCnM5EPvkxHBeT53w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791855356; c=relaxed/relaxed;
	bh=T9DPR+2n3dWm0xXe4jJx+wMjBkoYkR/+x3n7hyULjmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IOo0KnuSPAK7SHH2p7qOwTvo1TtbtDPoKCSxQ/WUXJQQaGiAX2kWg2fhfWW2fydgj9HOnivHkcpGzeNCs/slEtSs+INZWCeAn+wuzbLHBg02635T6AmCT9S78DYLsIlhJqhudW7H7TEalsun2p/ddavYLtaKyaWWXCto3hqcezSHURXD/TUVbwqM40b+/Qi6RXHcVhOtSsdCq01I5CpnhUDsgHf5JBieiF1kVs/G4tW/h9t11lQHnFH0NyxHq8Py29cjYZP0tOvxLx5PAprQkL1dqFOPghaUlc9UFSF79xnh50zz6+YaSNo2wGClaG2jjoXrjzASf9YAcFuSPH97/g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=timdoug.com; dkim=pass (2048-bit key; unprotected) header.d=timdoug.com header.i=@timdoug.com header.a=rsa-sha256 header.s=fm2 header.b=QRx/vrQj; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=kswQaqdR; dkim-atps=neutral; spf=pass (client-ip=103.168.172.156; helo=fhigh-a5-smtp.messagingengine.com; envelope-from=me@timdoug.com; receiver=lists.ozlabs.org) smtp.mailfrom=timdoug.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=timdoug.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=timdoug.com header.i=@timdoug.com header.a=rsa-sha256 header.s=fm2 header.b=QRx/vrQj;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=kswQaqdR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=timdoug.com (client-ip=103.168.172.156; helo=fhigh-a5-smtp.messagingengine.com; envelope-from=me@timdoug.com; receiver=lists.ozlabs.org)
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3cNp58rgz30DY
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 12:35:54 +1100 (AEDT)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 33E98140012C
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2026 21:35:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 12 Oct 2026 21:35:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=timdoug.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1791855352; x=
	1791941752; bh=T9DPR+2n3dWm0xXe4jJx+wMjBkoYkR/+x3n7hyULjmY=; b=Q
	Rx/vrQjGS4aIvL+6atXZ/EJgExF6J+Cpo76zfb03yrOM+60+6v7uArudhJ+H1QeJ
	xTZtgktnMh6WvThrLqhTXso1BF7bQHcoqmFpIwfeA2EYsEuL7UeNQG8VSuHLDkFj
	Vz13RXcyWWMIDw5qeqNVObJAl6bntLhuCADRyqXfBVKOPGF/8qa8W0lvAQ0LRAy3
	KHVhtmpcf56SgpG/0kUQAgp0iSpM3e6gKBNpnUdNEQATnr4+MMqqTPc5yGcT00IT
	ZXVlFVTe4vs255+MyjvnURFRbE/cIe8Yy5oxnLaROPr5Qu8WiZhI2hvEKzWHeXf5
	ibBIaLPHlUaY4YEZms93g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1791855352; x=1791941752; bh=T
	9DPR+2n3dWm0xXe4jJx+wMjBkoYkR/+x3n7hyULjmY=; b=kswQaqdR1CqvQNd/j
	DH3k9yIBZLtSSbmKqpxBQHajK++XFzKM/ugzlbHMR/rA31MdaSryaFu1GiuY42TQ
	aLBGFBMPEj+J/oFMadW+rwjaopWKzSHEAUVYcEN9kKgF6tds+hA3ze5y4sPCbb7H
	ZQMycuW3IBD85U7Ry5D7T3qDquIhOS7MMCjngongwHztRjjvvu4vpCgOGScgUajG
	VnZ9iATREWoQAri6WJrrsZ0PDIh2IK4ceVi9onA8KzGm1seB1UkNbRuHX5tFXxmB
	wognCfNqhPxY4KR5klcgGYtdNEcY4Wswk3ntTpP/dLmsugCNhHeQrQ+92CeiQSpg
	y3yrA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=timdoug.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791855352; d=timdoug.com;
	mf=PG1lQHRpbWRvdWcuY29tPg==;
	rt=PGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnPg==;
	s=fm2:rsa-sha256:kAcfha0biMhO9rP0oxaqEnk+oODqOMTs5QgCffEbfULb5dK
	5mk0ml+g0xWtGiSC8hzUmGPYGjxSRhAaRL3JF4f1bbDHjUX0WaXFYwONDpBx4Sca
	sZELyBrSbubDcCL+Sw/htEQp7V+BPiGnLGZOxQijDZ87kwWhNLh6/LPnUFTlKZtn
	9lWXyVF83VwvdiNCRyT+FpoluUNKwVi4XxmYEbQc2Bj3qALGUUlEa6SXxnljLp/w
	rZpdtW5fC9S3tyLUsP/quJwPGjJOzo14n8yfqzW3vFrL6wxlt6z4o5Tkwy9bwi2R
	Sb3jXBIyKjeU8b3SuUMGyTGKll9pwZ5o1Hc7ggQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:PrJ717gr86u/8jEwEDf0Kba/XI0ZzKRLKWY3qUAP+p4=:sFJ72AgPE1Tu7+0QasszMAieCLJI86cGxQyysbzgmZo=;
X-ME-Sender: <xms:94rNauaQUoD4JYgxey6jAGfgXwXq7ZwhbOJ7SD71hJhzS9MwxQr0Tg>
    <xme:94rNavrb1jt46q3lHthhH0uc8hRbTYWNliNU0GYLm4Z3Y4NwVBkcG5FPBxCw0S3n6
    ERSkWNzuV0fbDUE9wCCDS3f-6rqTKguZmjyMu2zS2p8zW9Jv34ksRY>
X-ME-Received: <xmr:94rNaiSJ5BEQlHH_nOhrcLzEtCQn_-o1x45EfkBPZNP6iXl6cJ8_gpplsQwy>
X-ME-Proxy-Cause: dmFkZTGNbHk6fXAkhTsvEfU2amaovOmEajQYoQOBQ1jMMVTp78asCsTJKEOp2KUEoCfFhn
    jYQALR5baaW2Zmb2DSGiJU/TnUm2SfI3WostCaGFlcqIuQLSHsZ9RdgXfBjYku/rYSwytg
    gG+1Aavqm07SB9Nn6UC7/pwAlSnVJ/PwqLx0Zmi8Ps17l4MBClYGyctPQiDIoTu2tkkI4I
    +6r+oLdSUUBoLun+FPRvQnzwVjLQxo28j78W4Y4bg5ruy1wHbYTNmkWF91Y2zTMHrsLkbj
    qi0arGzxtkYavMM9fPhINZUuIXe1wxSlfZK0MTfoZfYvKJ5SD5BpIp5OQ6fEuy6blOsuKw
    nW3eLSjF2BND2Vjd97g59nD2DKqYZQu+JlfKwLQE9lwE88zee9wSf4CNj8n9SzXihMKcpZ
    Zs4p6+rzdHsFXI7syolFYyNB5I91mkE9iGE9b2x16B2MmkCHxTb8By+z7HsxsTcQ9rW4x+
    416IK9L8AYd4buUMJu6+7LDzkBydq0YrPQCwv2Vdj6Cv6beKVo5eL5egddT1MitD2oxa6L
    6US4AknzJ8UIp+SokIdMhItMdbeJRTd9GzV0GWOvk15FOcu61RhAyrpm4kcpP48hL4X5Oo
    FflG0RpWyZK/HpbuK0AJwUxFkUlqg5WuyC8qypY8zrSBHuFCOWKh43VBacmg
X-ME-Proxy: <xmx:94rNajqPmY2ZSWPPxJfXqCyJ4D_fTjfL20eEeGabkwpZxUCeAInFiQ>
    <xmx:94rNas0yU2ZDS9Gfi176s1AAZ8sPdDTqo2UdfoTW6shA7C3aRNV-jg>
    <xmx:94rNai46Pqk-WOfb_rXbsFNnQs5-L-hxY3Lk0NqXWjSVg1pYHXFkzg>
    <xmx:94rNagRTfUbBCTDIEh2OT5ePTQzYybdIDgD3ySg7vRHrQWaLcdjjzg>
    <xmx:-IrNahQ6Ea3zrp06XyzDGRg_fYH7RaJg4fHN_GzfuQ9EmBgTChCaQ2yH>
Feedback-ID: i12bc4175:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Oct 2026 21:35:50 -0400 (EDT)
From: Tim Douglas <me@timdoug.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-serial@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	Tim Douglas <me@timdoug.com>
Subject: [PATCH 2/2] serial: pmac_zilog: report received breaks
Date: Mon, 12 Oct 2026 21:35:41 -0400
Message-ID: <20261013013541.4535-3-me@timdoug.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261013013541.4535-1-me@timdoug.com>
References: <20261013013541.4535-1-me@timdoug.com>
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

pmz_status_handle() sets PMACZILOG_FLAG_BREAK from RR0, and
pmz_receive_chars() clears it on the null character that ends the
break without marking that character, then tests BRK_ABRT in RR1,
where the SCC does not set it in asynchronous mode. Breaks therefore
arrive as plain NULs: brk is never counted and BRKINT, PARMRK and SysRq
never see them.

Set BRK_ABRT in r1 for that character, as sunzilog does.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Assisted-by: LLM
Signed-off-by: Tim Douglas <me@timdoug.com>
---
 drivers/tty/serial/pmac_zilog.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/pmac_zilog.c b/drivers/tty/serial/pmac_zilog.c
index f49d605..a612f1d 100644
--- a/drivers/tty/serial/pmac_zilog.c
+++ b/drivers/tty/serial/pmac_zilog.c
@@ -233,6 +233,7 @@ static bool pmz_receive_chars(struct uart_pmac_port *uap)
 		ch &= uap->parity_mask;
 		if (ch == 0 && uap->flags & PMACZILOG_FLAG_BREAK) {
 			uap->flags &= ~PMACZILOG_FLAG_BREAK;
+			r1 |= BRK_ABRT;
 		}
 
 #if defined(CONFIG_MAGIC_SYSRQ) && defined(CONFIG_SERIAL_CORE_CONSOLE)
-- 
2.54.0 (Apple Git-157)


