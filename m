Return-Path: <SRS0=ildu=RZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E36C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 14:24:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A1FC218D3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 14:24:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A1FC218D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.ee
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44QmBm6kpDzDqSy
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Mar 2019 01:24:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.ee
 (client-ip=193.40.6.72; helo=mx2.cyber.ee; envelope-from=mroos@linux.ee;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ee
Received: from mx2.cyber.ee (mx2.cyber.ee [193.40.6.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Qm7d4180zDqS4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Mar 2019 01:22:01 +1100 (AEDT)
Subject: Re: powerpc32 boot crash in 5.1-rc1
To: LEROY Christophe <christophe.leroy@c-s.fr>
References: <20190321221632.Horde.sUFPCFV5Nrk0KQFVNqmMjw2@messagerie.si.c-s.fr>
From: Meelis Roos <mroos@linux.ee>
Message-ID: <6c3bfa43-4b11-ab27-fcc6-3732ccbed304@linux.ee>
Date: Fri, 22 Mar 2019 16:21:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190321221632.Horde.sUFPCFV5Nrk0KQFVNqmMjw2@messagerie.si.c-s.fr>
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

>> While 5.0.0 worked fine on my PowerMac G4, 5.0 + git (unknown rev as of Mar 13), 5.0.0-11520-gf261c4e and todays git all fail to boot.
>>
>> The problem seems to be in page fault handler in load_elf_binary() of init process.
> 
> The patch at https://patchwork.ozlabs.org/patch/1053385/ should fix it

Tested it - yes, it fixes the boot.

-- 
Meelis Roos <mroos@linux.ee>
