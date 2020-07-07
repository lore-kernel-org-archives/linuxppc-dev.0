Return-Path: <SRS0=AwiL=AS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F62C433DF
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2020 13:30:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE7B220672
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2020 13:30:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE7B220672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sguazz.it
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B1Nbd5Rr1zDqv1
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2020 23:30:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=centrum.lixper.it (client-ip=46.4.16.148; helo=centrum.lixper.it;
 envelope-from=srs0=ts6c=as=sguazz.it=giuseppe@centrum.lixper.it;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=sguazz.it
X-Greylist: delayed 1749 seconds by postgrey-1.36 at bilbo;
 Tue, 07 Jul 2020 23:28:01 AEST
Received: from centrum.lixper.it (centrum.lixper.it [46.4.16.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B1NXx4vvkzDqMm
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jul 2020 23:28:01 +1000 (AEST)
Received: from net-130-25-222-52.cust.vodafonedsl.it ([130.25.222.52]
 helo=uefi)
 by centrum.lixper.it with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.84_2) (envelope-from <giuseppe@sguazz.it>)
 id 1jsnBQ-0000bd-IE
 for linuxppc-dev@lists.ozlabs.org; Tue, 07 Jul 2020 14:58:48 +0200
Message-ID: <89e412a76350b28f791bb8a2b6f9647a034f6fc8.camel@sguazz.it>
Subject: kernel since 5.6 do not boot anymore on Apple PowerBook
From: Giuseppe Sacco <giuseppe@sguazz.it>
To: linuxppc-dev@lists.ozlabs.org
Date: Tue, 07 Jul 2020 14:58:43 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-GeoIP: IT
X-SRS: Sender address rewritten from <giuseppe@sguazz.it> to
 <SRS0=Ts6C=AS=sguazz.it=giuseppe@centrum.lixper.it> by centrum.lixper.it.
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hello,
I am testing linux on a quite old hardware, an Apple PowerBook G4
"Titanium IV". I used to run Debian on this machine, so I upgraded the
old operating system to the latest software and found that new kernels
do not boot.
I rebuilt natively (on the powerbook) a few kernels and found that
5.4.50 still works fine, while 5.6.19 and 5.7.7 stop after printing:

pmac32_cpufreq: registering PowerMac CPU frequency driver
pmac32_cpufreq: Low: 667 MHz, High: 867 Mhz, Boot: 667 MHz

no more output is printed. I waited 5 minutes and then powered off the
machine using the power button. Rebooting with old kernel works.

So, I am looking for help. How may I better investigate the problem?
How may I crossbuild the kernel on a faster machine (amd64) in order to
try git-bisect without waiting ages?

Thank you,
Giuseppe

