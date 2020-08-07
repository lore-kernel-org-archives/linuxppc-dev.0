Return-Path: <SRS0=mIln=BR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22263C433DF
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2020 14:53:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CC8A22CA1
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2020 14:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="WcOsVmOV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CC8A22CA1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BNSyt3XvtzDqvD
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Aug 2020 00:53:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.helo=mo4-p00-ob.smtp.rzone.de (client-ip=81.169.146.163;
 helo=mo4-p00-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256
 header.s=strato-dkim-0002 header.b=WcOsVmOV; 
 dkim-atps=neutral
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de
 [81.169.146.163])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BNSsN18yTzDqHV
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Aug 2020 00:48:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1596811697;
 s=strato-dkim-0002; d=xenosoft.de;
 h=Date:Message-ID:Subject:From:To:X-RZG-CLASS-ID:X-RZG-AUTH:From:
 Subject:Sender;
 bh=etPxG83tkMXiJ/hnA1T72V+lMvSf2k090VPDeSw1U3I=;
 b=WcOsVmOVSkRsdAvy/k0CN0SUFrJ5er5BvOFvs2dn40pzHj8cVINRdAld6e9adZXrTl
 /IvE0na37KeXveo1on6Cj8v49n3kn1j1D4kjjN+RHNCNz6CRGlDQlqVwOeOq0WEBwl2y
 jNwmUPHOlwsOBZbz8fBlDLnWYIJENWXkzjRo7+kMt0U2XMl7G6Mpgp0TbEhAK7SJT4e9
 akBlJ4vj8iiM2xsbx2ei6YyjxAjhjSolmVO/lNn0SbAPEhQT78CdSRM1LCu6OAi/35F+
 K22uWUXKhVne93yfAUl86tQ4YJcwHXwtzDutJa9Y5bfRm1ezH6/qBdP1u8lt5iCEiYxe
 K8JA==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5DdBJSrwuuqxvPhSI1Vi9hdbute3wuvmUTfEdg9AyQ=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:89c0:ebfc:15f9:f3ba:c3bc:6875]
 by smtp.strato.de (RZmta 46.10.5 AUTH)
 with ESMTPSA id 60686ew77EjEQ1K
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Fri, 7 Aug 2020 16:45:14 +0200 (CEST)
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, keescook@chromium.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "R.T.Dickinson" <rtd2@xtra.co.nz>, Darren Stevens <darren@stevens-zone.net>,
 mad skateman <madskateman@gmail.com>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: [Latest Git kernel/Linux-next kernel] Xorg doesn't start after the
 seccomp updates v5.9-rc1
Message-ID: <67cd9693-10bc-5aa5-0898-ff2ac1f9c725@xenosoft.de>
Date: Fri, 7 Aug 2020 16:45:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
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

Xorg doesn't start with the latest Git kernel anymore on some Linux 
distributions after the seccomp updates v5.9-rc1 [1]. For example on 
Fienix (Debian Sid PowerPC 32-bit) and on ubuntu MATE 16.04.6 (PowerPC 
32-bit). I tested these distributions on the A-EON AmigaOne X1000 [2], 
A-EON AmigaOne X5000 [3], and in a virtual e5500 QEMU machine with a 
virtio_gpu.

Error messages:

systemd-journald[2238]: Failed to send WATCHDOG-1 notification message: 
Connection refused
systemd-journald[2238]: Failed to send WATCHDOG-1 notification message: 
Transport endpoint is not connected
systemd-journald[2238]: Failed to send WATCHDOG-1 notification message: 
Transport endpoint is not connected
systemd-journald[2238]: Failed to send WATCHDOG-1 notification message: 
Transport endpoint is not connected
systemd-journald[2238]: Failed to send WATCHDOG-1 notification message: 
Transport endpoint is not connected
systemd-journald[2238]: Failed to send WATCHDOG-1 notification message: 
Transport endpoint is not connected

---

But Xorg works on Ubuntu 10.04.4 (PowerPC 32-bit), openSUSE Tumbleweed 
20190722 PPC64 and on Fedora 27 PPC64 with the latest Git kernel.

I bisected today [4].

Result: net/scm: Regularize compat handling of scm_detach_fds() 
(c0029de50982c1fb215330a5f9d433cec0cfd8cc) [5] is the first bad commit.

This commit has been merged with the seccomp updates v5.9-rc1 on 
2020-08-04 14:11:08 -0700 [1]. Since these updates, Xorg doesn't start 
anymore on some Linux distributions.

Unfortunately I wasn't able to revert the first bad commit. The first 
bad commit depends on many other commits, which unfortunately I don't 
know. I tried to remove the modifications of the files from the first 
bad commit but without any success. There are just too many dependencies.

Additionally I compiled a linux-next kernel because of the issue with 
the lastest Git kernel. Unfortunately this kernel doesn't boot. It can't 
initialize the graphics card.

Could you please test Xorg with the latest Git kernel on some Linux 
distributions?

Thanks,
Christian


[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9ecc6ea491f0c0531ad81ef9466284df260b2227
[2] https://en.wikipedia.org/wiki/AmigaOne_X1000
[3] http://wiki.amiga.org/index.php?title=X5000
[4] https://forum.hyperion-entertainment.com/viewtopic.php?p=51317#p51317
[5] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c0029de50982c1fb215330a5f9d433cec0cfd8cc


