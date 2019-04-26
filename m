Return-Path: <SRS0=ImKy=S4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4BEC43218
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 05:53:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AFA3206E0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 05:53:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AFA3206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=depni.sinp.msu.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44r3BW3L85zDqZL
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 15:53:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=depni.sinp.msu.ru
 (client-ip=213.131.7.21; helo=depni-mx.sinp.msu.ru;
 envelope-from=belyshev@depni.sinp.msu.ru; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=depni.sinp.msu.ru
X-Greylist: delayed 343 seconds by postgrey-1.36 at bilbo;
 Fri, 26 Apr 2019 15:00:24 AEST
Received: from depni-mx.sinp.msu.ru (depni-mx.sinp.msu.ru [213.131.7.21])
 by lists.ozlabs.org (Postfix) with ESMTP id 44r21P00fLzDqcv
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2019 15:00:24 +1000 (AEST)
Received: from spider (unknown [109.63.154.231])
 by depni-mx.sinp.msu.ru (Postfix) with ESMTPSA id 13A3D1BF404;
 Fri, 26 Apr 2019 07:56:30 +0300 (MSK)
From: Serge Belyshev <belyshev@depni.sinp.msu.ru>
To: Christophe Leroy <crhistophe.leroy@c-s.fr>
Subject: BUG: crash in __tlb_remove_page_size with STRICT_KERNEL_RWX on
 BOOK3S_32
Date: Fri, 26 Apr 2019 07:54:06 +0300
Message-ID: <87pnp9mknl.fsf@depni.sinp.msu.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Fri, 26 Apr 2019 15:51:58 +1000
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi! Commit 63b2bc61956 aka "powerpc/mm/32s: Use BATs for STRICT_KERNEL_RWX"
caused my old powerbook to crash under I/O.  After "dd if=/dev/hda of=/null"
the crash happens in seconds.  Reverting the commit helps, as well as
disabling STRICT_KERNEL_RWX.  Unfortunately, I was unable to capture the oops
via the usb serial console, as it stuck right after the first "BUG: Unable to
handle kernel data access at 0xe0c29000" message. Oops screenshot:
http://aargh.no-ip.org/oops.jpg
