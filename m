Return-Path: <SRS0=DN5o=RY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15947C10F0D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 20:27:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B97E02183E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 20:27:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B97E02183E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.ee
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44QJHs4x1XzDqSc
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 07:27:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.ee
 (client-ip=193.40.6.72; helo=mx2.cyber.ee; envelope-from=mroos@linux.ee;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ee
Received: from mx2.cyber.ee (mx2.cyber.ee [193.40.6.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44QJFF6q9XzDqSJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2019 07:25:21 +1100 (AEDT)
Subject: powerpc32 boot crash in 5.1-rc1
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <91966c00-b09f-7e07-89cb-04ac208d5dc1@linux.ee>
From: Meelis Roos <mroos@linux.ee>
Message-ID: <67399e37-6c8b-7172-09ed-be9e1bf4429c@linux.ee>
Date: Thu, 21 Mar 2019 22:25:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <91966c00-b09f-7e07-89cb-04ac208d5dc1@linux.ee>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: et-EE
Content-Transfer-Encoding: 7bit
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

While 5.0.0 worked fine on my PowerMac G4, 5.0 + git (unknown rev as of Mar 13),
5.0.0-11520-gf261c4e and todays git all fail to boot.

The problem seems to be in page fault handler in load_elf_binary() of init process.

Two different screenshots are at http://kodu.ut.ee/~mroos/powerpc-boot-hang-1.jpg and
http://kodu.ut.ee/~mroos/powerpc-boot-hang-1.jpg .

-- 
Meelis Roos <mroos@linux.ee>
