Return-Path: <SRS0=6Fot=JI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AA3C433ED
	for <linuxppc-dev@archiver.kernel.org>; Sun, 11 Apr 2021 11:09:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99A1561008
	for <linuxppc-dev@archiver.kernel.org>; Sun, 11 Apr 2021 11:09:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99A1561008
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FJ8Jv642jz3bpZ
	for <linuxppc-dev@archiver.kernel.org>; Sun, 11 Apr 2021 21:09:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=molgen.mpg.de (client-ip=141.14.17.11; helo=mx1.molgen.mpg.de;
 envelope-from=pmenzel@molgen.mpg.de; receiver=<UNKNOWN>)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FJ8JZ0gXcz301C
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Apr 2021 21:09:15 +1000 (AEST)
Received: from [192.168.178.35] (unknown [94.134.88.216])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 13BF5206473C4;
 Sun, 11 Apr 2021 13:09:08 +0200 (CEST)
To: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Sandipan Das <sandipan@linux.ibm.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: sysctl: setting key "net.core.bpf_jit_enable": Invalid argument
Message-ID: <412d88b2-fa9a-149e-6f6e-3cfbce9edef0@molgen.mpg.de>
Date: Sun, 11 Apr 2021 13:09:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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
Cc: it+linux-bpf@molgen.mpg.de, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Dear Linux folks,


Related to * [CVE-2021-29154] Linux kernel incorrect computation of 
branch displacements in BPF JIT compiler can be abused to execute 
arbitrary code in Kernel mode* [1], on the POWER8 system IBM S822LC with 
self-built Linux 5.12.0-rc5+, I am unable to disable `bpf_jit_enable`.

     $ /sbin/sysctl net.core.bpf_jit_enable
     net.core.bpf_jit_enable = 1
     $ sudo /sbin/sysctl -w net.core.bpf_jit_enable=0
     sysctl: setting key "net.core.bpf_jit_enable": Invalid argument

It works on an x86 with Debian sid/unstable and Linux 5.10.26-1.


Kind regards,

Paul


[1]: https://seclists.org/oss-sec/2021/q2/12
