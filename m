Return-Path: <linuxppc-dev+bounces-29079-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7114CA5FED
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Oct 2026 03:54:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j1Cfy6vfgz2ynZ;
	Fri, 09 Oct 2026 14:54:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791518090;
	cv=none; b=BVLDRCUopfCaW+FqzeEyy3Dt1x4PLVAcHXJ3Q/7URrwR7POKtA5cVxHOMHjlg12mN+LF0Ijvqe1IBSElPwqpmX7634aNsg+IoBUdVdhxFIElCWD4hQyXJfgVDTKh800uG1ouSvcfK/RCX7x8Ms4cfrxGjXFKgGgnivOHNJBw3xGbWCcokLek4VscoDhVMrXuMZ/Y4n64slgneacwA2a+6piL3+WxIJ3aYU/jIjClQjYPdCZE+5xUW4wAtkFGoHpVg85SpwCKvBgcGpEi7Jlr3+VwGGce57+l6pSm0D4UE1hIwk0/3V/yklGEV8wdHBzGaeD9QurFJ75J3fUaNUjvEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791518090; c=relaxed/relaxed;
	bh=L9Q/w/AHW6Mbd26Vlroy5oXg6u2XbVEnC7wQXSIZink=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Yb4QuH0g2zkbm76kpk/fseUXFpxGpq1jgtuliJQre2tsI+3SsoWywndP9DTwXd38p4xmX8e3ZZtODi2jxc29abLSuQmvzMTMHLM5mmsmn+kG1YTsUqt/VdodCZiZKfDkbN7KMqKLH/TlpWJoZLmsOiLCvaQsCNBfrLWQmQV1wSvTmR2JHFET1Zcdt7RfMmuR3JdGriPHQUE/Htdjd7nkvInL6l1Xozv7txm3iA15Rc/u/xhTA7aFYCu0OSCpBflVo1/PK96yHIorTiE7t4Hil0bkcE9WncGStxRvVS/ZRSANqfhG/zrQJNQ3b0JrU2mvPfQqHR65LpNUIwmFK6ErIg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass (client-ip=159.226.251.81; helo=cstnet.cn; envelope-from=vulab@iscas.ac.cn; receiver=lists.ozlabs.org) smtp.mailfrom=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=iscas.ac.cn (client-ip=159.226.251.81; helo=cstnet.cn; envelope-from=vulab@iscas.ac.cn; receiver=lists.ozlabs.org)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j1Cfx66mdz2yHD
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Oct 2026 14:54:48 +1100 (AEDT)
Received: from fc87d0ffb700.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAD3AUCCZchqZDgbCg--.2182S2;
	Fri, 09 Oct 2026 11:54:42 +0800 (CST)
From: Haotian Zhang <vulab@iscas.ac.cn>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Michael Bringmann <mwb@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/pseries: fix device_node leak in drc-info lookup error paths
Date: Fri,  9 Oct 2026 11:54:45 +0800
Message-Id: <20261009035445.3079660-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
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
X-CM-TRANSID:rQCowAD3AUCCZchqZDgbCg--.2182S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw18Cw43Jw15ArWDtr17Awb_yoW8Wr17pF
	4fGFZ7tF10kryIyryFyF1Uur429w43KrWFyw4jya4Skr45XryDXryqqr1Yqr18CrWfCas0
	qF4qga4vvanruaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUklb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4
	vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26F4j6r
	4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_
	Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI
	42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU5VxRPUUUU
	U==
X-Originating-IP: [36.110.52.2]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgQPA2rIYxAH6AAAsw

cpu_to_drc_index() and drc_index_to_cpu() acquire the /cpus device_node
with of_find_node_by_path() and then walk the ibm,drc-info property. When
an entry whose drc_type is not "CPU" is encountered, the code jumps to the
err label, which is *after* the err_of_node_put label, so of_node_put() is
skipped and the reference taken on the /cpus node is leaked on every such
exit.

Jump to err_of_node_put instead so the device_node reference is always
released.

Fixes: e83636ac3334 ("pseries/drc-info: Search DRC properties for CPU indexes")
Assisted-by: DeepSeek-V4.1-Flash
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
---
 arch/powerpc/platforms/pseries/pseries_energy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/pseries_energy.c b/arch/powerpc/platforms/pseries/pseries_energy.c
index fdaf85ecd39b..b3a1c34b3323 100644
--- a/arch/powerpc/platforms/pseries/pseries_energy.c
+++ b/arch/powerpc/platforms/pseries/pseries_energy.c
@@ -66,7 +66,7 @@ static u32 cpu_to_drc_index(int cpu)
 
 			of_read_drc_info_cell(&info, &value, &drc);
 			if (strncmp(drc.drc_type, "CPU", 3))
-				goto err;
+				goto err_of_node_put;
 
 			if (thread_index < drc.last_drc_index)
 				break;
@@ -135,7 +135,7 @@ static int drc_index_to_cpu(u32 drc_index)
 
 			of_read_drc_info_cell(&info, &value, &drc);
 			if (strncmp(drc.drc_type, "CPU", 3))
-				goto err;
+				goto err_of_node_put;
 
 			if (drc_index > drc.last_drc_index) {
 				cpu += drc.num_sequential_elems;
-- 
2.25.1


