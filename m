Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CB3606D818
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 11:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vx5KxwKh
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJmwB27GYz2xN4;
	Tue, 03 Nov 2026 22:45:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793702990;
	cv=none; b=ghJjMoXeapGcsFz0ZDsvdrujfsi/IQkWO6W3qLB6eeF43lZDIrLP/sDggy3vH5b2PUmiZ4VwkBovfwc/FCOKQhiB93cGhMDb0rTrXFFlSMk7hMagOrOUeSwjJU8vwkT1K9lBhSnNgbQjJp/JRN5jhskZjeCS8PfJ20QHjZHxRum2RiZNvlB4/r2ZxtFzWN0whG6vERCXJBVgc0Gb9L9siUU+gNkiEMTahso699V5+32VeqDPt/HSEAwN6WaYnki1UzKcrEVschn9h+LTsblKrY1TVEOcVXXpRK+vQEYRTXhloe/vFsqZ3Mi3Z0G6nTJDScpKN6uNSxfY8C26t0KBYg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793702990; c=relaxed/relaxed;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aLNbo2khWLozj8zMK3uU5XcKo3MJJR381MMCzt7oFxdETJpmg9uNpWTpv0twNzhPaociYR8j9v34Yd9FD2eA2z21TIE/O+3AriE70rMQRRKz3E3bh+waGpV58wAPGm5W2l3PseO0BymolKVWLHL74hqcHpw5AkKYMTlDm+yWe3L1TR/XEMCIU2wPQMlGMkJDZKTLlC9DWmgTEco73+GBPL1FXkqlplNxlfepcaZvDsw/jQ0jLkMnWRGHRR6/uNSvCNeEhZoo+BJ4ZOB1VttgcWEuqj6Sy9NA5LKSVPfk/1tfnHEcQ4AsEnVOErZllQK4sICjhbisr28CI/3rHy+1Pw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vx5KxwKh; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=netdev-bot+sinfo@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vx5KxwKh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=netdev-bot+sinfo@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJlhD5cdzz2xH9
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 21:49:48 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1AC6842DD7;
	Tue,  3 Nov 2026 10:49:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62CC31F000C1;
	Tue,  3 Nov 2026 10:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793702987;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vx5KxwKh2n86yrd4SJOATo27TrL2RNNSe2jMDBKUQ1ldwm0tojhu+AqM48yRijjoG
	 /GTOYQLCgM0gQfLiZxW/3LZ0g7aeIltCuSYln7c773oyM1nzj3alyCSXIkjwBObwqV
	 kvAwwnohGpYGLaaolElrYpSu2oZO37WThxptmycO/iubNt4H3HrJTIm3265Pru9DJR
	 BDkJ1w8/4SMi802eqo3DFNp+BIi2gfGuT7DFvqs3rAsYBGbugHNgrVPhXbpZ0cz/zq
	 XlrVmFfl86S+MTkJJRzyk3naP6ja265j4c6EDm+fXviToYTbNNeXGIHfRneJV5uWe/
	 FjLmaoZhxXQOA==
From: netdev-bot+sinfo@kernel.org
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Zhao Qiang <qiang.zhao@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: wan: fsl_ucc_hdlc: release the net device on remove
Date: Tue, 03 Nov 2026 10:49:45 +0000
Message-ID: <179370298589.488859.8331776188055179026@kernel.org>
In-Reply-To: <20261103104237.1373675-1-vulab@iscas.ac.cn>
References: <20261103104237.1373675-1-vulab@iscas.ac.cn>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.

