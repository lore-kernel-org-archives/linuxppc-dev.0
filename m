Return-Path: <SRS0=eeko=PU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4AABC43387
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Jan 2019 16:28:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35DF62084E
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Jan 2019 16:28:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35DF62084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43cQCr0dLzzDqDS
	for <linuxppc-dev@archiver.kernel.org>; Sun, 13 Jan 2019 03:28:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmx.net
 (client-ip=212.227.17.21; helo=mout.gmx.net;
 envelope-from=j.neuschaefer@gmx.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=gmx.net
X-Greylist: delayed 330 seconds by postgrey-1.36 at bilbo;
 Sun, 13 Jan 2019 03:27:28 AEDT
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43cQB86pZszDqCF
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Jan 2019 03:27:28 +1100 (AEDT)
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lusmr-1hQrxH3aUb-0101Mb; Sat, 12
 Jan 2019 17:21:34 +0100
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/2] powerpc: wii.dts: GPIO interrupt and button support
Date: Sat, 12 Jan 2019 17:21:22 +0100
Message-Id: <20190112162124.3341-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:NvSI0Cn9AkS944gBf8AO4c2SIPinsXmyo1eQWzZU5kvzefHaxLa
 TbSLldJGLjkVAvigiWClgZRNcwwtP0+RAzeXQlMa9s8S/i1MylnKghvWYCP6hMh/7ZZtO7Q
 7IkF3TIyO4OJdKqSMeqpPZQRS91MlbZwHy4ejqbQaq/sKvkutDB/Kd1C2TjVDQm08Q7kouG
 3Ya53DmxFA9u6KfZMCg1g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nJFY3hkbaFI=:gQp/+XPnOmm9NiCj6vuBIS
 9y144ptedV6vgS4T+OBtEVXuEQ02xLkdupVF5MzCAEBP6RaR0N/qC88tLHFsxxknYtPmiM5qy
 ELEKj6lYbfWrJCRnxCOU+kFZy1AQUEaAWO5xpngLS4R9AZDEe232KfIOJ3COoirs0jibpv3R0
 AArt5JimDKA8k4aKSi9r05ddfAyZg6tQXPiAow91L+8DLqKuNNBtCKGkWBjTi1voHMBW+djWL
 C8WSO8nBVHzg86KoZDCZXHdAmOgnPOq4qqupAWtk93mcRU0Nr1aEgRQcg4hCM0RSMgKKh0ShN
 ykkHeuXpajhKjHCiQKD6KBz4sef1pLlfieTjDODgOX4EhEe0HVb9VkSQfvUU1PW51ZFMJNXIt
 AzyvTB6MC61P1CQyGLGCt8fxOpspLKCm1SAfVE5c8NfXBzI/wFxQDTAdOiewtpfHRWSX4/Rh6
 YTxQqssPuODsoXxbocxk2ynAs/rmS7/2bXrYxp51gpzp89wnbnPE9pEDH0LgokEFuFlUspsrY
 a/EK3CT3zeKVUiwUBypNCbaClJzD8di+IQ7CzOaAfd7W8R+csjjxV8p9b9C6EqHWCXvqDcKDS
 D5PLSJn4wUq0G1ZWZ1J+iXZdZ9RRI17TbJMKnxTQT5C15JUyLzMkFdoRuFwfSWurVWGy2sT9u
 dKI/wc8lECMGd6Qx0G26n284Ttn7cFhgTl09SXn+6DuXY/07JClQAz7H3HqFNPuQ9b4FnUZM3
 VhB/ucQMgCcUqeZeNtBHEPFe8KijDsGgfC/zzplU9yWMNhpJopezm6ZU7so9oePPsA9Jyi4r9
 W6xm9tmseC7qsNgQyi0HeJY+FyfIOfZ5m2gd9UzcEI1NUFORrrdoSAHZgyPDheQeS9YMemTie
 2IPgeb9d7tQkQ/zSm/v2tg5byEEoppS4hzHSse/8x+WUoQCZqEkd0CtzrFhmpwMINx9zZ5K1n
 uY903NxOFMQ==
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 Rob Herring <robh+dt@kernel.org>, Paul Mackerras <paulus@samba.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This patchset adds the necessary bits to wii.dts to enable interrupt
support in the GPIO controller, and defines two GPIO-based buttons,
the POWER button and the EJECT button.

I will send another patchset which will implement interrupt support in
the GPIO driver (gpio-hlwd.c).

Jonathan Neuschäfer (2):
  powerpc: wii.dts: Add interrupt-related properties to GPIO node
  powerpc: wii.dts: Add GPIO keys

 arch/powerpc/boot/dts/wii.dts | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

-- 
2.20.1

