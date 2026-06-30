Return-Path: <linuxppc-dev+bounces-23233-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 978C2C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2026 23:35:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqffP51Z9z2ySJ;
	Wed, 01 Jul 2026 09:35:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782862557;
	cv=none; b=PkgZqPSrgt4rcq+aGjXKFj8EcFZawmt+wIxCnnIYAXI2MKRKod9JpzQxdR6vzA4an82NMREG8HRszeFCkIVms9vr7iLcdmfI+WTdVyxtWQiOn1I53mpS/TxWP5UDz4gzqpik512opENbNJVI83eRIDnxTEbnUbh0ZKh7WkMVJYl6OCKQqVNciplR0Z7d/85D/OnROGi+cM+y3qCKYi6wqdPD7HzJpxiuNl2hROIa37bdxhLf8kYkfvU1aqGXGTgvOBlxF5Wvc0YgL/2agCCpHn2Av+DLrIjVm2PDDNS+7yO9gggzoX768qMHQ3jBNNoSYU3VdNZKo20IeZgLzDTZVw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782862557; c=relaxed/relaxed;
	bh=t/dDGecgQnyHBRD1CloI8qbKKQ9H/fQiDD0u9Ytdf0Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aG9mNZ5HikGUtc5afCd/OvyigH6NU1Hc1/1ffgCHsXn4V+VeHs2FuGmyKfKNtFwaIK/631THjVt8Fhlc7EwYjzNPg4dcc89Zx4poF+ekYHUsobgXf7QuaDnLQKvfs31YZCqQ7F8FPxKGhmLKjE3Dy3/0+OrWBN2yPo5yQZ27DxCFsOa3GTBBjjhNeYC0NQc3Ui65ciZfI5lO7UHc9dvwedEXLJMW/juONkFeCJiBFQPpmQC0jB0GxpAcQjQX34Sc3OE6vtBqGFdm1Fn4uu0yYJ8ghlewKbv0UFHKMZAP3Y2TaKbI32yOBoaxTO3MTK67PPZ1oJjjl5QcFxL0ll5szg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P+W++TEY; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=namhyung@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P+W++TEY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=namhyung@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqffN31kyz2yQL
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 09:35:56 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E6F616001D;
	Tue, 30 Jun 2026 23:35:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 439851F000E9;
	Tue, 30 Jun 2026 23:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782862553;
	bh=t/dDGecgQnyHBRD1CloI8qbKKQ9H/fQiDD0u9Ytdf0Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=P+W++TEYtBN0he+DRSsSh/pTdqhJpG/c4TEMUMlz4dsYxFz09eNlg8LJqkotJVUDp
	 VGP82pXyncBdOix2vcU8VXZ8JJajsF6QPfufBWcd8BB4lt3+xaUmtEdwljLtaW0RJW
	 eik3Gn99oW4kf8RJOp2ZVQrpfnThI/MjfAkRVium4nrLAO8LTij2qfG/WZQ0qNOYJy
	 ajmEsss41G/Vesr3b5QFj+Ux2PNQSe7rk4SjaI6V7GHVZSxCDwwpkSxMbxel89ntT8
	 j947RQBCigXW0BIGXxPIFYIGI4+TVDY3oSKBUtdbYj2RCAEml+N+dpiwUzGh6KRZZI
	 HJQcO7uTac6xw==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com, 
 mpetlan@redhat.com, tmricht@linux.ibm.com, maddy@linux.ibm.com, 
 irogers@google.com, Athira Rajeev <atrajeev@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 hbathini@linux.vnet.ibm.com, Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, 
 shivani@linux.ibm.com, venkat88@linux.ibm.com
In-Reply-To: <20260607140245.95706-1-atrajeev@linux.ibm.com>
References: <20260607140245.95706-1-atrajeev@linux.ibm.com>
Subject: Re: [PATCH V2] tools/perf/sched: Update process names of processes
 in zombie state for both -s and -S options
Message-Id: <178286255323.2863034.7654707778135452027.b4-ty@kernel.org>
Date: Tue, 30 Jun 2026 16:35:53 -0700
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Sun, 07 Jun 2026 19:32:45 +0530, Athira Rajeev wrote:
> In redhat perftool testsuite, observed fail for this test:
>     -- [ FAIL ] -- perf_sched :: test_timehist :: --with-summary (output regexp parsing)
> 
> This led to analysis of "perf sched timehist" summary options.
> 
>   # perf sched record -a -o ./perf.data -- sleep 0.1
>    This will record using perf sched record
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung



