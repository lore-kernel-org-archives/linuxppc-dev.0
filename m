Return-Path: <SRS0=OgF1=RR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DE7C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 22:38:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A3DF2184C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 22:38:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A3DF2184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44L3Wl0sG9zDq7h
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 09:38:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=metux.net
 (client-ip=217.72.192.75; helo=mout.kundenserver.de;
 envelope-from=info@metux.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=metux.net
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44L3SD2slZzDqNG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 09:35:07 +1100 (AEDT)
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MkprN-1gcgkx0B6F-00mMZ9; Thu, 14 Mar 2019 23:34:32 +0100
From: "Enrico Weigelt, metux IT consult" <info@metux.net>
To: linux-kernel@vger.kernel.org
Subject: serial driver cleanups v2
Date: Thu, 14 Mar 2019 23:33:30 +0100
Message-Id: <1552602855-26086-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:90tVeR9OdExxrSMvPUryTzfPCWjO8NamvaYvMWrJ8sQIo2vkZEM
 WLfgLJ9+jnh45Nf7Rjk9Tl4let5oIzu8P51lsevr4kOSsznnoLWWfQMnWxa3mARd8SuRsii
 BK8WPgu6oeerNXMtTkzb8jp1TSgOmpU7uIED+Hd1FY/kAVTztF3wNFRAjZG841vMctQZ19Z
 NU+pfZA+a457drDVUdIlg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CkT95SOkLIk=:XQtGzRuMeTpqtd+Vvcx9sW
 2qSnUPEWCO8ddfUL5eO8e1KDKYrpveInu88Sp48xoZfKPYM8tUPqrJPiyZASoyIXAFSmSpgeM
 BesEw7d2yj9hWe3/VhZAAp6oUKNekUvxm7RqoV5b3yim1yNo3yG5Qx9DShS5d91Sf48Jzf7qS
 LT+85wtn0iyIkjDidz9lLqco18b0rW8rjiBNV/6iYf1r9tl0KAOGbqwFEmQDYKqJWqL3W/hCS
 R9uPF0dYkWxkuhhWuFthZTbu6J8QrRN1hnHVYmItReql2WWPRFFI4NL9ihgAcGW0DD2yjVZUs
 VELFRgSgbh0mkfmjgNvGabhNgg02jKDusV/1CRiviaeZsmM7cmujZ0nMIWHb6+9qubho1s+T+
 Spt4e+fk+NggtbsKU9qkL6T8MQPH6bZc5ghHCz9bDHakEB93J/wZonWhZkG0A+moPEpvG+lwD
 7lSXxiV36sqUSI6s0NbyQVarzKRxwQmzRAnu4KQsW2c4UlL1sW3ZhLeBSzUBHRzrdCN3SkMBf
 gfqQJfEirx3CakxKDwtyoiDerq04m8flE3GIjnxBGTTLZIgX/fz5F48imtkb87R6KBuGvVAsw
 XOpXPnGxcrao0jIADgOnjqWLjDMk9rb97iXFeU/Fii+6uAGNbwLJCkTHqpIYR5gfAzh7c6vuP
 DiIIyU9v45qnCKmCE+W/ltm3BjyUxpXPnjN9kcX1fcJzinrmouP7FkvI6iC6Mh13sm48y5Na5
 4E9ts9008+/7hUxpRaxm0wK73N+dn09Zm0G+Wg==
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
Cc: linux-arm-msm@vger.kernel.org, yamada.masahiro@socionext.com,
 macro@linux-mips.org, jacmet@sunsite.dk, festevam@gmail.com,
 stefan.wahren@i2se.com, f.fainelli@gmail.com,
 bcm-kernel-feedback-list@broadcom.com, linux-imx@nxp.com,
 linux-serial@vger.kernel.org, u.kleine-koenig@pengutronix.de,
 andy.gross@linaro.org, tklauser@distanz.ch, david.brown@linaro.org,
 rjui@broadcom.com, s.hauer@pengutronix.de, slemieux.tyco@gmail.com,
 linuxppc-dev@lists.ozlabs.org, vz@mleia.com, matthias.bgg@gmail.com,
 andriy.shevchenko@linux.intel.com, baohua@kernel.org, sbranden@broadcom.com,
 eric@anholt.net, richard.genoud@gmail.com, gregkh@linuxfoundation.org,
 kernel@pengutronix.de, shawnguo@kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hello folks,


here's v2 of my serial cleanups queue - part I:

essentially using helpers to code more compact and switching to
devm_*() functions for mmio management.

Part II will be about moving the mmio range from mapbase and
mapsize (which are used quite inconsistently) to a struct resource
and using helpers for that. But this one isn't finished yet.
(if somebody likes to have a look at it, I can send it, too)


happy hacking


--mtx



