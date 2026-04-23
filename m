Return-Path: <linuxppc-dev+bounces-20025-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57DF5FDEE28
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Apr 2026 22:51:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g1rtW5Y5yz2xlr;
	Fri, 24 Apr 2026 08:51:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.226.251.25
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776984691;
	cv=none; b=PfYIoYFEfFcWikxlNQhFf6DMr3mzmM7/vGJ38yV3vOiD8BsDAHy+OcaIhkEGv5T9qFbPNUjYI9Cw0mPjxJ/wyntJ2FBcBhWX/VEufT86jNL3eBkVbpck+pH7a8eQE3RJxys4bqZy5cgBtvUxkLgqiEfhRwkGuPmVf5VTTgHLoeNsIGRqldgo/M8Ag1+9G4jP22UFgg+vibTzJlMHBrEWuI0GbJXjVeGzwPnJCpLoo20PpH5mMTMECFB5dKP/gz4NTUmNJJCKLl0XAn67UXTlrrvXpBrvuiAgwiN4XPc0XUuJ1LIkEDhgCrM4Ez0ddv15ryIec5cfNukWEZlaadzDVA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776984691; c=relaxed/relaxed;
	bh=cstw2BMbxrEvaVG/y7xDTp3UHW4BHf5rDqiywYFqsxo=;
	h=From:Date:Message-ID:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K/NzEECuBJVheoNSjFnOTSBvvwMrBiWiTwc/3MaBlhFVHb89X8fw+/83KnJ1X4aDVWWGgHE7VSGvfU3Ts1MGp9JWSpbesdoZa1m1nsZcZSOLnJ7W05BFb0Stb7RUng85O9dLzycUTpcjT3eYY5YxPiEyM1o2XFt4x4IwhsLMHimB9qkHg1tkG53jTmzzi+yKCe6AZqX50zL298foaZw4qYI+YjR/TQLo8dOQkp6VA7cCBcya876dcq/d7e4xpSjbFXzySRK4HkT3y4Azqq61KfRavihNqI8jx/5fqewESzoChF7YWXcx4KA4NYplzHN1ALLjz8GC7Ops/nvaT8jmTg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass (client-ip=159.226.251.25; helo=cstnet.cn; envelope-from=pengpeng@iscas.ac.cn; receiver=lists.ozlabs.org) smtp.mailfrom=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=iscas.ac.cn (client-ip=159.226.251.25; helo=cstnet.cn; envelope-from=pengpeng@iscas.ac.cn; receiver=lists.ozlabs.org)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g1rtV43Qdz2xfR
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2026 08:51:30 +1000 (AEST)
Received: from 08-fadump-drop.eml (unknown [111.196.245.116])
	by APP-05 (Coremail) with SMTP id zQCowAAXrA9roupp1IlsDg--.1662S2;
	Fri, 24 Apr 2026 06:51:23 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
Date: Fri, 24 Apr 2026 06:51:23 +0800
Message-ID: <20260424070108.1-fadump-drop-pengpeng@iscas.ac.cn>
To: Sourabh Jain <sourabhjain@linux.ibm.com>, Christophe Leroy <chleroy@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Hari Bathini <hbathini@linux.ibm.com>, Jiri Bohac <jbohac@suse.cz>, Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, pengpeng@iscas.ac.cn
Subject: Re: [PATCH] powerpc/fadump: reject empty bootargs_append writes
In-Reply-To: <20260417073907.4985-1-pengpeng@iscas.ac.cn>
References: <20260417073907.4985-1-pengpeng@iscas.ac.cn>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAXrA9roupp1IlsDg--.1662S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYP7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z2
	80aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
	w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMc
	vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l
	FIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4c8EcI0Ec7CjxVAaw2AFwI
	0_Jw0_GFyl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
	CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbKsjUUUUUU==
X-Originating-IP: [111.196.245.116]
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

Hi Sourabh, Christophe,

Thanks for checking this.

I rechecked the current sysfs write path and I no longer think this
patch is valid. sysfs_kf_write() returns 0 before calling ->store() when
count is 0, so I do not have a path that reaches bootargs_append_store()
with count == 0.

Also, if such a path did exist, returning 0 would be the right behavior
for an empty write, not -EINVAL.

I'll drop this patch.

Thanks,
Pengpeng



