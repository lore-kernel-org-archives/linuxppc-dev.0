Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287EE606EEA4
	for <linuxppc-dev@archiver.kernel.org>; Sat,  7 Nov 2026 16:39:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jMMFL0g39z2yGT;
	Sun, 08 Nov 2026 03:39:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794069542;
	cv=none; b=iSClwZxEBls3y9iSWTYmMRJ9N+LUExnw5LaZR8aIdqi5zcYqKOEFWDb9GQ6EfPpZXP3xfxqBWwaK91ihf2E/JcVVOjnJe01i4PpSoy528xtxdw2jIf/SWYYPrR6dsYKIaRBYISFsCYWOPKL+Xg1WtX7nQbXZJn0P3wL6VYFNXZ4Tsx8W7GcfiSFi201lVSs0v4MrftBRXYvrzCzZ/IuY3U5vUSYQib14b7AKwq2pFWn21JjlxBHVaYwIkeJ8qpCBf52Zff9BC5+YbmyFsYo/HICeN50Ku4Evji2+WJZAUfqfRyoS/S7Zoi45/fMJPFF0i0kkPru41N7Uu7iiE1NPWw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794069542; c=relaxed/relaxed;
	bh=40kuihcjhTlj1aLdgEnB45MZzzZ6zfuouT8zXvlNzdI=;
	h=From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=ArI1eNeG/SnNc86LGB930aPBkp8FYHbrD7MtbEsZlWD1x1YDviG/sKeu6ef8Uht30dY+v5rCv07soWhQV7zIPXhUjIHSe/dZln3qQQu4d9iD/LFKthWZUUaUswi4+FNpDIbCD5wEYWWJWcw8Nrd24CU2q8i02IlGCOv44w3FpHPN7eHQhAU3FCWa0qQEVIrxdIHYONMzECdIHIUA+/ngdQphmpDfHUJFd4gq9mLIstZMyH8+gs786fa+HsOJUUjxRqyhrzgPagNez0Ccz2XeFmfyQyNbrgN955cTeS7Vv7xrk7LCnk3tW5Wvv2OH2i3xRqDXDp43XfwdRX5Z8XRjtw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass (client-ip=159.226.251.81; helo=cstnet.cn; envelope-from=vulab@iscas.ac.cn; receiver=lists.ozlabs.org) smtp.mailfrom=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=iscas.ac.cn (client-ip=159.226.251.81; helo=cstnet.cn; envelope-from=vulab@iscas.ac.cn; receiver=lists.ozlabs.org)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jMMFK1SwQz2xjM
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Nov 2026 03:39:01 +1100 (AEDT)
Received: from [172.100.0.8] (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAAXJpcfVO9qL_iBAA--.3844S2;
	Sun, 08 Nov 2026 00:38:55 +0800 (CST)
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
Subject: Re: [PATCH] ASoC: fsl-asoc-card: Fix codec device leak in
 fsl_asoc_card_probe()
In-Reply-To: <1ff14ab8-fa35-45c3-abcc-1075a848be2d@sirena.org.uk>
References: <20260917165654.2163461-1-vulab@iscas.ac.cn>
 <1ff14ab8-fa35-45c3-abcc-1075a848be2d@sirena.org.uk>
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
Message-ID: <20261107163838.271829-1-vulab@iscas.ac.cn>
X-CM-TRANSID:rQCowAAXJpcfVO9qL_iBAA--.3844S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gw4kAw1fuF13Aw1kXF48tFb_yoW3uFg_ua
	93Cryjqw1UZF4UWr43GF1SyF12gFWjqw1kGwnYgFWxXryrAF12g3ZYgwn7Aw1xX395ZrnF
	kr1DZ3yY9wnF9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb-AFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
	wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
	vE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280
	aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c
	8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_
	WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
	ACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8GFyrJr1UJwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
	s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
	0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUDOz3UUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAIEA2rvPp4fAgABsw
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Sep 17, 2026 at 11:29:53PM +0100, Mark Brown wrote:
> This doesn't apply against current code, please check and resend.

Sorry for the very late reply, and for the noise.

You are right, and after rebasing I found that the patch is not just
stale: de27e0cadcce ("ASoC: fsl-asoc-card: Move bound-component setup
to late_probe") removed the codec_dev[] lookups from probe().  Codec
components are now resolved in late_probe() through the bound rtd, and
no codec device reference is taken there, so the leak this patch
addressed no longer exists in current code.

I am dropping this patch rather than resending a no-op change.

The ASRC half of the same series is still valid and was rebased and
resent on Nov 4:

  https://lore.kernel.org/all/20261104024047.1508601-1-vulab@iscas.ac.cn/

Thanks,
Wentao


