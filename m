Return-Path: <SRS0=Akx6=S5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8FAC43219
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Apr 2019 13:15:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A836A208C2
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Apr 2019 13:15:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A836A208C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44rryS6BGqzDqY2
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Apr 2019 23:15:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=metux.net
 (client-ip=212.227.126.130; helo=mout.kundenserver.de;
 envelope-from=info@metux.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=metux.net
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44rrSj5p8dzDqHv
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Apr 2019 22:53:25 +1000 (AEST)
Received: from orion.localdomain ([77.2.90.210]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M2OEw-1hM22x2IWM-003z2b; Sat, 27 Apr 2019 14:52:33 +0200
From: "Enrico Weigelt, metux IT consult" <info@metux.net>
To: linux-kernel@vger.kernel.org
Subject: serial drivers polishing
Date: Sat, 27 Apr 2019 14:51:41 +0200
Message-Id: <1556369542-13247-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:KJDamy/sLPxVA6+e/xJ3QUvJO2vZRQRZ7H0KMjcX3Xau2yWekpn
 NpGyWcv0BdxhaW7aX7/vr2xwwxMEX+6774NoAKSIMs3MmeEZ+xYywOxnE2TTovvdXTrh2yJ
 RNeD0ze+njam53jHsvoBAF38TFF8FCMFOboXlpNsaf5RaLhhCCBqtkthfNYpeDWcM41q4C0
 CVkuapPP3KK3JkmPsaT5g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UgSrRnCWrUY=:7fJ0rhQipVcqjbOMouuuLX
 HpGMJ1r9jBZF63ISf/g4eJR7MR4pim7nBhig4Jl6mL9rhhjlxhwR2qh1N4i4VbbUFcAAJS4Ir
 3ehiLQX6cqWnF50zJ7z21t0eDxTtPggAbzQRa+2t5Cjiod8h5Wb5R4iORC6PmyUH6vKKXXUM+
 R9rHMmPwJ7xow24gQslekOboEkjLcPhRKBzHll9gB05PrKyGQOO6IpPuj6JsGixD3/SV3rmAI
 WRreW0Q86/xSc9xzAZ/s0Tg16UGmFtYYzADiDOPYcz3bsuoRYHOUzjkSUBY7pks4GDFdjYMMY
 J/JvztrHNATKtF+xcSdHOfYpteSdbEr/adF2EdyGRbxXQKt/TrGXW7mmq08GeH8Pf+Ddxxi57
 gX4f5PaLFHVVAJwJNkdrPkVeh2oB4ZHHOgB7VwynKoG66tYGIwGyrt4JIE1NQxJ6/CCNQokSN
 tV88raPuIGD29SSpSBLoPwxN2NaH59lI0OHOA+RLEySArhq2aDwIEO1siM+Ym55O0C23LpHF/
 hhfoTRUvhYjfKChKVcwQzaBKOc6JX3KasD/lLqJOlFd4rOiG+bk5N2aqTqu9WhMZGPdByTTNn
 dZijwtgoeZ/ESNSagGa5Wp6TuGjsZnfKLyqzZ9EJkEAL0lFMwoIHRDBYlKB3pdj5Z6vK9cpbZ
 wU/2h8/Ce7j4rFZJwmpQfbVxZ6ipvpbPepnAyc6fl580YIKcwbDd50N+z74IAAonMBK2/PlY6
 SM9MoLwOFEsiV5jP9jDXm+Fk2osf8+pzyh1JcQ==
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
Cc: lorenzo.pieralisi@arm.com, linux-ia64@vger.kernel.org,
 linux-serial@vger.kernel.org, andrew@aj.id.au, gregkh@linuxfoundation.org,
 sudeep.holla@arm.com, liviu.dudau@arm.com, linux-mips@vger.kernel.org,
 vz@mleia.com, linux@prisktech.co.nz, sparclinux@vger.kernel.org,
 khilman@baylibre.com, macro@linux-mips.org, slemieux.tyco@gmail.com,
 matthias.bgg@gmail.com, jacmet@sunsite.dk, linux-amlogic@lists.infradead.org,
 andriy.shevchenko@linux.intel.com, linuxppc-dev@lists.ozlabs.org,
 davem@davemloft.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hello folks,


here's another attempt of polishing the serial drivers:

* lots of minor cleanups to make checkpatch happier
  (eg. formatting, includes, inttypes, ...)

* use appropriate logging helpers instead of printk()

* consequent use of mapsize/mapbase fields:
  the basic idea is, all drivers should fill mapbase/mapbase fields at
  init time and later only use those fields, instead of hardcoded values
  (later on, we can add generic helpers for the map/unmap stuff, etc)

* untwisting serial8250_port_size() at all:
  move the iomem size probing to initialization time, move out some
  platform specific magic to corresponding platform code, etc.


Unfortunately, I don't have the actual hardware to really test all
the code, so please let me know if there's something broken in here.


have fun,

--mtx

