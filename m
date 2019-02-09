Return-Path: <SRS0=dqXl=QQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01E5C282C4
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Feb 2019 23:23:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57CB221919
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Feb 2019 23:23:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57CB221919
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stevens-zone.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43xp4z22nZzDqTX
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 Feb 2019 10:23:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=stevens-zone.net
 (client-ip=212.227.17.10; helo=mout.kundenserver.de;
 envelope-from=darren@stevens-zone.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=stevens-zone.net
X-Greylist: delayed 311 seconds by postgrey-1.36 at bilbo;
 Sun, 10 Feb 2019 10:21:49 AEDT
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43xp3K5QHQzDqMB
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Feb 2019 10:21:49 +1100 (AEDT)
Received: from mintppc.lan ([80.189.87.237]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.179]) with ESMTPA (Nemesis) id
 1MNLZc-1gTlRu3uhe-00Ong2; Sun, 10 Feb 2019 00:16:29 +0100
From: Darren Stevens <darren@stevens-zone.net>
To: linuxppc-dev@lists.ozlabs.org,
	oss@buserror.net
Date: Sat, 09 Feb 2019 23:14:34 +0000 (GMT)
Message-ID: <4d531fb86c6.a2619d3@auth.smtp.1and1.co.uk>
User-Agent: YAM/2.9p1 (AmigaOS4; PPC; rv:20140418r7798)
Subject: [PATCH] powerpc/85xx:  Add Cyrus board power-off and reset nodes
MIME-Version: 1.0
Content-Type: text/plain
X-Provags-ID: V03:K1:+oc10Ns1Z9OOv7QRHhv/BV0WMxeatlQOBD7PsJsS8uzVZHJgUhr
 24Emoil8dr2AyPFQ8I4+lxRQiPYeHK2S1KEIIISgd6bC/sP1tYcPbkCD+V1ao3YqHFGy7TM
 5445MXaLpB9PDqGGgqDJS7l68g0leEUpdfjNRkEkjQdNBXwa+j5ZQK/tLrvFZs63O1rWf23
 PYTsGYAUKxszKE5UzwTyA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:y0G1tIThgJU=:s3o4yqpvBZ/qkLlhVMmoGz
 2MjcyfGwS/87lnqgWxWleqLcqXwH4Ncxh8e0HRZ8gRUqUkBiBhTkX8R96i+g1iB/a5pdMUSsv
 n9eWhkbmEK1iP9aw60vo0V7xyLFYqvCaBM8+4WYbcwvOjq4CTe0zl6H6WDHjfD9OLwtfPpvS7
 OHEV/+YbSkZYLYL+ZeTXsUPtcLMEl5W2+sjjGYDDZ9RcTrMR4hJhhg92Jl0PZJ7hQWptqri3y
 rFYuLDlt4qwp2fCkk4ASwOtu29JOFXXyTYJ2+zLFIHUmfkRjIyBJvnEs+IZnXCuZFeB0Dh7CR
 I7iLtaieLOZuH83Flx/zV/Mv3QEED6EmnJqZnu5/Jh9lZ54DR5QlR72Ts0q6iiFwozHmt3W6j
 +rDAh0HtFKESAgBBPX5uQJloBrM79fJiFYTc1Jd7VyXssn7yLrGuZ8kXODpVjDphE4YLt2L7z
 actxMG+SDuwprOJXfCA9Ew5yWRU6ICz1A7lOYIESGwNl07KV2JDU+agKG58xKf3+SGzjdgPye
 QSgGmfr9HQENi5nx8DN2RCmd0ZOelQplzI1WLZxr//bHEKrKc9k0DaQQdAqpurIY1n8UksJw9
 3q2ilRvYZ9MRpSjNGskl4pex6OosOtbRwN/mFGnRkp4z8UfHwq8/Vs3N5i2cQY9RWuzP4yIIZ
 2wRxiK2zSV/3faEp6lGe1xuxzVPuKOFsNOjEpARb16HOOVGhhhAsC5KjSNwpZZPXyDJEameec
 chh8nIifP3wR+4YA6EBqEkGRSDsKB/0TwOhtp24O0JbO6H40H9z7M7wZ8M0=
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
Cc: Christian Zigotzky <chzigotzky@xenosoft.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The Cyrus board from Varisys has power-off and reset functions attached
to gpio pins. Add the required device-tree bindings.

Signed-off-by: Darren Stevens <darren@stevens-zone.net>

---

diff --git a/arch/powerpc/boot/dts/fsl/cyrus_p5020.dts b/arch/powerpc/boot/dts/fsl/cyrus_p5020.dts
index c603390..15e8440 100644
--- a/arch/powerpc/boot/dts/fsl/cyrus_p5020.dts
+++ b/arch/powerpc/boot/dts/fsl/cyrus_p5020.dts
@@ -71,6 +71,17 @@
                reg = <0x6f>;
            };
        };
+
+       gpio-poweroff {
+           compatible = "gpio-poweroff";
+           gpios = <&gpio0 3 1>;
+       };
+
+       gpio-restart {
+           compatible = "gpio-restart";
+           gpios = <&gpio0 2 1>;
+       };
+
    };
 
    rio: rapidio@ffe0c0000 {

