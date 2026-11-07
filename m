Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E12606A32C
	for <linuxppc-dev@archiver.kernel.org>; Sat,  7 Nov 2026 16:39:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jMMFH1cFNz2xrC;
	Sun, 08 Nov 2026 03:38:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794069539;
	cv=none; b=KwP+M1Mdl1OJ+qOrSE8WWXYGtUr4wrYR7Z13r028EAdRDnTZ/R102G1U1c7oVizOo5upJ02aRnLdh3ROYOTd7UHGRh4jdGqYWMQuq4M49rw27pO7XvrWDMheLEybRYKZXA7XWWLojTQSkfi15bCVeoH/nydtbsWQCkmtTE1xSrQ7NO6iMt57AFgbD2UR9mJeHrir3ywO7f/ySKU2Y6JcK55LSJ3y5eJbTar5HWMWj4h96H3wW9QxwUDm7mM62UTvCt+a70dqQxsZulPEiLq+v7Lmuq8MYToDfn+SEWXkbTwtbreDZ8paVHV9lH0gspnyX7cpIySSJqS5TJlmWIxEgw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794069539; c=relaxed/relaxed;
	bh=lWUiedORJz9iuGG8xvWpfiLUfTiY46+2FOj+Hma4KIU=;
	h=From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=ZdmfdgJueFVVGLHDwZZ2YV6g/BS1h8krxGBuPxhOOn0P3YIHrnmeABkUG4ebVQF670fVEYchA40Q6WUIJryQ7meQzr4QbCgpQINNnoPbz9R3f76XGj+TVkIJ+tTQ8rzbl4LsQWHMe//8BJoV/D4lw/rToiGf6X0oKrjpUGiY3fa24QWxzt0VfW++f2ezU/NYq5L2nxq0nndQCF2WeFfWO5SzxY5aYyTFa/GI0fy7b11D0nhDxf5xTPIvLDmB9ZPv5sLrkhoOPDC3emNDNtMXHMgczUN940LXBe+DTyMFQxamN2ppSY104Q2Ia/Zc5ZZ52GKmSy45SajQvP6remt7Ng==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass (client-ip=159.226.251.81; helo=cstnet.cn; envelope-from=vulab@iscas.ac.cn; receiver=lists.ozlabs.org) smtp.mailfrom=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=iscas.ac.cn (client-ip=159.226.251.81; helo=cstnet.cn; envelope-from=vulab@iscas.ac.cn; receiver=lists.ozlabs.org)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jMMFG0SQhz2xjM
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Nov 2026 03:38:56 +1100 (AEDT)
Received: from [172.100.0.8] (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAB3hpccVO9qzfeBAA--.3936S2;
	Sun, 08 Nov 2026 00:38:52 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Mark Brown <broonie@kernel.org>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>,
 Fabio Estevam <festevam@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org,
 linux-sound@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 Nicolin Chen <nicoleotsuka@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>,
 Shengjiu Wang <shengjiu.wang@gmail.com>,
 Takashi Iwai <tiwai@suse.com>,
 vulab@iscas.ac.cn
Subject: Re: [PATCH] ASoC: fsl-asoc-card: Fix ASRC device leak in
 fsl_asoc_card_probe()
In-Reply-To: <1d80b89f-7b33-4036-a450-bf32c603a238@sirena.org.uk>
References: <20260917165430.2163372-1-vulab@iscas.ac.cn>
 <1d80b89f-7b33-4036-a450-bf32c603a238@sirena.org.uk>
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
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Sat, 07 Nov 2026 16:38:38 +0000
Message-ID: <20261107163838.271828-1-vulab@iscas.ac.cn>
X-CM-TRANSID:rQCowAB3hpccVO9qzfeBAA--.3936S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xw4rJr4kur47Kry3CF1DAwb_yoWfCrgEkw
	4vkFyjvr1xZFZ8Ww12gFWkZF9F9ayqgryrK348Wa4xuFy5AFyaq3Z3KFn2vw4Iqas8ZF1q
	qFyqq3yj9w129jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb-kFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
	wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
	vE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280
	aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4UJwAS0I0E0xvYzxvE52
	x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
	XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4
	x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AK
	xVWUtVW8ZwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r48ZrWUJr1UMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
	W8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbUPEDUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAMEA2rvPp4fAQAAsz
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Sep 17, 2026 at 11:33:55PM +0100, Mark Brown wrote:
> This doesn't apply against current code, please check and resend.

Sorry for the very late reply, and for the noise.

You are right, and it was not a conflict with another fix: the patch was
generated against a tree predating de27e0cadcce ("ASoC: fsl-asoc-card:
Move bound-component setup to late_probe"), which removed cpu_pdev and
the codec_dev[] array from fsl_asoc_card_probe().  The exit path the
patch was built on no longer exists.

The leak itself does: asrc_pdev, taken by of_find_device_by_node(), is
still never released.  I rebased the fix on current code and resent it
on Nov 4:

  https://lore.kernel.org/all/20261104024047.1508601-1-vulab@iscas.ac.cn/

It adds put_device(&asrc_pdev->dev) at asrc_fail, applies cleanly to
310ee4c282a1 (current sound for-next), and builds with arm64 defconfig.

Thanks,
Wentao


