Return-Path: <linuxppc-dev+bounces-28282-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 507C8C98338
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Sep 2026 14:11:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hsTyG39fpz30Nl;
	Sun, 27 Sep 2026 00:11:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=101.71.155.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790431878;
	cv=none; b=BFbrvK4pVuf/Py5SISLEicv1HuDxjxYTMjvH2rCwl7O5Q8HLZYzsAAdMw1hsP0lcGB3v4y1PiLhTdKcovy5xh3jijAATzrldqRadgvQVbFlFi2eLYfaPWKXjJGmvdc7TLugtoN8d55fzz7VReYmVpHUqaBq4aYCqrurp2W1C1hTzYGsEfnNXRmf35Xjsofx3QGhEVchZLojpLLqGpUtyN2wfCNOEETmn4nhWiLp4sQr+ElfZpJDvtv2by6cMYEByTYl4CLRjgnQsdiJ1Gm67i2bX43NogwXN48d7k/ppNiOrlmrcicVz1tL9zpp0eWg2ZglC9J0EwPQNaSs7RN2AvA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790431878; c=relaxed/relaxed;
	bh=tn+AKePJ/UjAryEvi5oaTWRovtAQRbYO7Jysf+KDOFs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fTHunY9tsvxMLxPBsj+r65v/QK9pqvsvIPpfiZiXNZPq9PRJdLfo5FZ/bUt/dE7c4NP1lvfxvSvnDIe/JsHQqNxG3p/8HvnMvChWgJ96VRQdalA6jXL7dyBjtXelJz1sFh893u4s23Y6hSDS6DNuyJncJQS6uJaA9D/LHRyqAhuQnkt69t+8QfLbl7dYY5HoSYLo7ZUlYCk0nabNQt1Rtht6qA8zHgntUWcKkOKKCVlqCfo5zv+yij9Ae8L9JMNkNNKwQVv3O/K+6KKSeuD4aj9FI+G+YzChcN3ZixV9J1XvNZDkAqjuN4yHqGyx33MpLg4fUtX/7kcV+ulk8WntQA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; dkim=pass (1024-bit key; unprotected) header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=nx2rAX/f; dkim-atps=neutral; spf=pass (client-ip=101.71.155.101; helo=mail-m155101.qiye.163.com; envelope-from=bolin.liu@seu.edu.cn; receiver=lists.ozlabs.org) smtp.mailfrom=seu.edu.cn
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=nx2rAX/f;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=seu.edu.cn (client-ip=101.71.155.101; helo=mail-m155101.qiye.163.com; envelope-from=bolin.liu@seu.edu.cn; receiver=lists.ozlabs.org)
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hsTyB40Lgz2yd7
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2026 00:10:59 +1000 (AEST)
Received: from seu.edu.cn (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4f321466a;
	Sat, 26 Sep 2026 22:10:12 +0800 (GMT+08:00)
From: Slavin Liu <bolin.liu@seu.edu.cn>
To: error27@gmail.com
Cc: shengjiu.wang@gmail.com,
	xiubo.lee@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	bolin.liu@seu.edu.cn
Subject: Re: [PATCH] ASoC: fsl_asrc: check the second front-end DMA channel
Date: Sat, 26 Sep 2026 22:10:11 +0800
Message-Id: <20260926141011.451552-1-bolin.liu@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <arfGajXmMUeew0fr@stanley.mountain>
References: <20260913125147.109920-1-bolin.liu@seu.edu.cn> <arfGajXmMUeew0fr@stanley.mountain>
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
X-HM-Tid: 0aa0de0d5af503a1kunm7bc9a132185a52
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZH0IfVkhCHUJIGE1PSE5MGlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0
	NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=nx2rAX/fYSaniaSuVhhX5H2iMYMQeNlAyPksRDdNVsEBeimgggPGhO8A8sDBPOXsOCk6JzAmbv6lOT/bjyhI+/A4IcMKEwAf1zZ8S7l/YpJeY9ccwaVHr5HRCq7ZENpkcB/FQ2UsXlEGbYK5CPMFLa72IWMAFnZirDrK/siPYjE=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=tn+AKePJ/UjAryEvi5oaTWRovtAQRbYO7Jysf+KDOFs=;
	h=date:mime-version:subject:message-id:from;

Hi Dan,

On Sat, Sep 26, 2026 at 04:19:38PM +0300, Dan Carpenter wrote:
> The ->get_dma_channel() function pointer returns error pointers not
> NULL.
>
>     sound/soc/fsl/fsl_asrc_dma.c:254 fsl_asrc_dma_hw_params()
>     warn: 'tmp_chan' is an error pointer or valid
>
> sound/soc/fsl/fsl_easrc.c | (struct fsl_asrc)->get_dma_channel | fsl_easrc_get_dma_channel | 1
> sound/soc/fsl/fsl_asrc.c | (struct fsl_asrc)->get_dma_channel | fsl_asrc_get_dma_channel | 1

Is this a false positive?: both implementations return
dma_request_slave_channel(), which is an inline wrapper converting the
ERR_PTR from dma_request_chan() to NULL before returning:

	static inline struct dma_chan * __deprecated
	dma_request_slave_channel(struct device *dev, const char *name)
	{
		struct dma_chan *ch = dma_request_chan(dev, name);

		return IS_ERR(ch) ? NULL : ch;
	}

So ->get_dma_channel() return NULL or a valid pointer.

The same function backs this up: the persistent Front-End channel a
few lines above comes from the same function pointer and is checked
with !pair->dma_chan[!dir], while the Back-End channel is requested
with dma_request_chan() directly and uses IS_ERR() -- the two check
styles in one function match the two APIs.

Best regards,
Slavin Liu

