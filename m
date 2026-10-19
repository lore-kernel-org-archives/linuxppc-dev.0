Return-Path: <linuxppc-dev+bounces-29704-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF83FCCF2DE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Oct 2026 13:41:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j7cCm4Vfpz2yfD;
	Tue, 20 Oct 2026 00:41:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=154.81.10.69
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792404671;
	cv=none; b=mtmo8MNJ8c4cFXD3Vg0C6gkvrtu0IK0calSwaVxpX7ilqZsHtD0n0eX03+ylhlAUcE1A+S0Hdy/tfFwcydhIrp4uJA6ShliD7lZO8oKigfLo57qNAp9OmV+AoS7MY2/2GHp6e6yV72WCC17+uZYTx0p5IyNrNYy8uVBQ4YAftlDntmKqxBlwcvockPsY7C/PcNsxVDsEAuNJcBDu3dXu+JOK9BjQ3KR3C/FWYBjXIDPjuYaImHkU2q6bmPZQmwB/Ob3LoEt1WhqT5Co4/rTsRWoTNn26PB41x69n3r5LvcpZxFouzMREoCWo0LafvR9o809lkv9XeNO2z2UX0ew08g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792404671; c=relaxed/relaxed;
	bh=P5ZOGYNyg8L4aWfSSNCbwWmwvGqHOzjsLvZxi1qWtsQ=;
	h=Content-Type:Message-ID:To:Cc:Subject:MIME-Version:From:Date; b=SiI9d6ieIkzGv15MGV3yfVFSyHThm6y56ovHg1GwWsJRX1IfWgjNN2sWcTeMb8BxuOt3UqliYSWSzxq8SnHAeERU4nfh2HQ0wvNOaXQOk6qKpsPsa6EiFFntwhhvNz2q5geeFoZSNoTrcG4LIIkvR10ZN1fD6vBBah4UY8co1/1Z4TQF9WXC9CTkBQkPsNxyMaue/E1drcFRkjiCZ0H+o8ynt2xx4CN6/Up35TvYwUGOxbCJfX96EJ2lnYNJbxR/AEsQL0BXM01jSDF5I+xTqN8MU1TmBMZgJTgXTjgNpNrshIW8eH+6dAjZxOpxrynXG4L3Qs1hy1arLLRiKjyu2A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=hdu.edu.cn; dkim=pass (1024-bit key; unprotected) header.d=hdu.edu.cn header.i=@hdu.edu.cn header.a=rsa-sha256 header.s=default header.b=k0Qyk3oV; dkim-atps=neutral; spf=pass (client-ip=154.81.10.69; helo=mail-m1069.netease.com; envelope-from=lixiao0@hdu.edu.cn; receiver=lists.ozlabs.org) smtp.mailfrom=hdu.edu.cn
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=hdu.edu.cn
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=hdu.edu.cn header.i=@hdu.edu.cn header.a=rsa-sha256 header.s=default header.b=k0Qyk3oV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=hdu.edu.cn (client-ip=154.81.10.69; helo=mail-m1069.netease.com; envelope-from=lixiao0@hdu.edu.cn; receiver=lists.ozlabs.org)
X-Greylist: delayed 304 seconds by postgrey-1.37 at boromir; Mon, 19 Oct 2026 21:11:07 AEDT
Received: from mail-m1069.netease.com (mail-m1069.netease.com [154.81.10.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j7WXW2ChHz2yfH
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2026 21:11:06 +1100 (AEDT)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AEMA9QCuLOMl3el2RGWf44oE.1.1792404355168.Hmail.252270051@hdu.edu.cn>
To: linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: jirislaby@kernel.org, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org
Subject: =?UTF-8?B?dHR5OiBodmM6IHBvc3NpYmxlIHVzZS1hZnRlci1mcmVlIGluIHJlc2l6ZSB3b3JrIGR1cmluZyBodmNfcmVtb3ZlKCk=?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com web
X-Originating-IP: 183.157.177.89
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
Received: from 252270051@hdu.edu.cn( [183.157.177.89] ) by ajax-webmail ( [127.0.0.1] ) ; Mon, 19 Oct 2026 18:05:55 +0800 (GMT+08:00)
From: LI xiao <lixiao0@hdu.edu.cn>
Date: Mon, 19 Oct 2026 18:05:55 +0800 (GMT+08:00)
X-HM-Tid: 0aa153977f1fd458kusy54270f56bd31
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaGUseVk1DGUNKQ08fHk0ZH1YVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlKQ0hVSk5MVUpMTFVDQllXWRYaDxIVHRRZQVlLVUtVS1
	VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=k0Qyk3oVsTrpeNVuKRQr2fS4IJnAzD50uPkztkH0qmMGQP1VEmw6oY6yfNmzOUtxYS8IIOJVQM86Yzw0UFr4Y40vqi5HnhJoEpDwNhGU401hC8HUHFnaWZ0KgnLqAg59V7LGQZXoh5+vrcGdMxXQfiFQbBO0y55q2XXpee1S0NU=; s=default; c=relaxed/relaxed; d=hdu.edu.cn; v=1;
	bh=P5ZOGYNyg8L4aWfSSNCbwWmwvGqHOzjsLvZxi1qWtsQ=;
	h=date:mime-version:subject:message-id:from;

SGksCgpJIGZvdW5kIGEgcG9zc2libGUgdXNlLWFmdGVyLWZyZWUgaW52b2x2aW5nIHRoZSBIVkMg
cmVzaXplIHdvcmsuCgpBIHF1ZXVlZCBodmNfc2V0X3dpbnN6KCkgY2FuIGFjY2VzcyBocCBhZnRl
ciBodmNfcmVtb3ZlKCkgZHJvcHMgdGhlIGZpbmFsIHR0eV9wb3J0IHJlZmVyZW5jZSBhbmQgaHZj
X3BvcnRfZGVzdHJ1Y3QoKSBmcmVlcyB0aGUgY29udGFpbmluZyBodmNfc3RydWN0LgoKSSByZXBy
b2R1Y2VkIHRoaXMgb24gTGludXggbWFpbmxpbmUgY29tbWl0IGMwM2MxYTE0NTA3ZGZhZjhiODU2
YzI2MDhmOWFjMjE2MDIxZmMyMjIsIHVzaW5nIGEgS0FTQU4tZW5hYmxlZCB4ODZfNjQga2VybmVs
IGluIGEgMi12Q1BVIFFFTVUgZ3Vlc3QuCgpUaGUgcmVwcm9kdWNlciBpcyBhbiBvdXQtb2YtdHJl
ZSB0ZXN0IG1vZHVsZSB3aG9zZSByZW1vdmFsIHRocmVhZCBjYWxscyBodmNfcmVtb3ZlKCkgY29u
Y3VycmVudGx5IHdpdGggYSBxdWV1ZWQgaHZjX3Jlc2l6ZSgpIG9wZXJhdGlvbi4gS0FTQU4gcmVw
b3J0cyB0aGF0IHRoZSBxdWV1ZWQgaHZjX3NldF93aW5zeigpIHdvcmsgYWNjZXNzZXMgdGhlIGZy
ZWVkIEhWQyBvYmplY3QuIFRoaXMgcmVwcm9kdWNlcyB0aGUgSFZDIEFQSS1sZXZlbCBsaWZldGlt
ZSBpc3N1ZSwgYnV0IGRvZXMgbm90IHlldCBleGVyY2lzZSB0aGUgZnVsbCB2aXJ0aW8tY29uc29s
ZSBob3QtdW5wbHVnIHBhdGguCgpSZWxldmFudCBLQVNBTiByZXBvcnQ6CgpCVUc6IEtBU0FOOiBz
bGFiLXVzZS1hZnRlci1mcmVlIGluIHR0eV9wb3J0X3R0eV9nZXQrMHhhOC8weGIwClJlYWQgb2Yg
c2l6ZSA4IGF0IGFkZHIgZmYxMTAwMDAwYTU1YTQ4OCBieSB0YXNrIGt3b3JrZXIvMDowLzkKV29y
a3F1ZXVlOiBldmVudHMgaHZjX3NldF93aW5zegpDYWxsIFRyYWNlOgp0dHlfcG9ydF90dHlfZ2V0
KzB4YTgvMHhiMApodmNfc2V0X3dpbnN6KzB4NmUvMHgxMTAKcHJvY2Vzc19vbmVfd29yaysweDY4
Yy8weDExODAKd29ya2VyX3RocmVhZCsweDRiNy8weGIzMAoKQWxsb2NhdGVkIGJ5IHRhc2sgNjQ6
Cl9fa21hbGxvY19ub3Byb2YrMHgxY2QvMHg0YTAKaHZjX2FsbG9jKzB4MmUxLzB4YTIwCmh2Y19s
aWZldGltZV9yZXByb19pbml0KzB4NjAvMHhmZjAgW2h2Y19saWZldGltZV9yZXByb10KCkZyZWVk
IGJ5IHRhc2sgNjY6CmtmcmVlKzB4MTI3LzB4M2IwCmh2Y19yZW1vdmUrMHhlYS8weDE1MApyZW1v
dmVfaHZjX3BvcnQrMHgxYy8weDQwIFtodmNfbGlmZXRpbWVfcmVwcm9dCgpUaGUgcmVwcm9kdWNl
ciBhbHNvIGNhcHR1cmVkIHRoZSBmb2xsb3dpbmcgd29yay1xdWV1ZWluZyBzdGFjazoKCl9fcXVl
dWVfd29yaysweDcwZC8weDExZjAKcXVldWVfd29ya19vbisweDU5LzB4NjAKaHZjX2xpZmV0aW1l
X3JlcHJvX2luaXQrMHgxMGQvMHhmZjAgW2h2Y19saWZldGltZV9yZXByb10KCktBU0FOIGFsc28g
cmVwb3J0ZWQgYSB3cml0ZSB0byB0aGUgc2FtZSBmcmVlZCBvYmplY3Qgd2hpbGUgdGhlIGNhbGxi
YWNrIHdhcyBleGVjdXRpbmc6CgpCVUc6IEtBU0FOOiBzbGFiLXVzZS1hZnRlci1mcmVlIGluCl9y
YXdfc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSsweDY2LzB4ODAKV3JpdGUgb2Ygc2l6ZSAxIGF0IGFk
ZHIgZmYxMTAwMDAwYTU1YTRhOCBieSB0YXNrIGt3b3JrZXIvMDowLzkKV29ya3F1ZXVlOiBldmVu
dHMgaHZjX3NldF93aW5zegpDYWxsIFRyYWNlOgpfcmF3X3NwaW5fdW5sb2NrX2lycXJlc3RvcmUr
MHg2Ni8weDgwCnR0eV9wb3J0X3R0eV9nZXQrMHg3Ny8weGIwCmh2Y19zZXRfd2luc3orMHg2ZS8w
eDExMApwcm9jZXNzX29uZV93b3JrKzB4NjhjLzB4MTE4MAp3b3JrZXJfdGhyZWFkKzB4NGI3LzB4
YjMwCgpUaGUgb2JqZWN0IHdhcyBhbGxvY2F0ZWQgZnJvbSBrbWFsbG9jLTUxMiwgYW5kIHRoZSBy
ZXBvcnRlZCByZWFkIHdhcyAxMzYgYnl0ZXMgaW50byB0aGUgZnJlZWQgNTEyLWJ5dGUgcmVnaW9u
LgoKVGhlIHJlcHJvZHVjZXIgcmVxdWlyZXMgcm9vdCBwcml2aWxlZ2VzIHRvIGxvYWQgaXRzIG91
dC1vZi10cmVlIG1vZHVsZSwgd2hpY2ggdGFpbnRzIHRoZSBrZXJuZWwuCgpDb3VsZCB5b3UgY29u
ZmlybSB3aGV0aGVyIHRoaXMgaXMgYSB2YWxpZCBidWc/CgpUaGFua3MsCkxJIFhpYW8=

