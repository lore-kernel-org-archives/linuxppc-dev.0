Return-Path: <SRS0=DRoX=MN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16205C43143
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 23:10:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F259206B2
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 23:10:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F259206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42PJ0T3zLqzDrM8
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 09:10:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=windriver.com
 (client-ip=147.11.1.11; helo=mail.windriver.com;
 envelope-from=jason.wessel@windriver.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=windriver.com
X-Greylist: delayed 11309 seconds by postgrey-1.36 at bilbo;
 Tue, 02 Oct 2018 09:04:37 AEST
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42PHsx6XfGzF3DK
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2018 09:04:37 +1000 (AEST)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
 by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id w91JtxFO013023
 (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
 Mon, 1 Oct 2018 12:55:59 -0700 (PDT)
Received: from [172.25.59.211] (172.25.59.211) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.408.0; Mon, 1 Oct 2018
 12:55:58 -0700
Subject: Re: [PATCH] kdb: print real address of pointers instead of hashed
 addresses
To: Christophe Leroy <christophe.leroy@c-s.fr>, Daniel Thompson
 <daniel.thompson@linaro.org>
References: <e5f8f6e3e5a5595be08127eefae8025ebbb691cc.1538068025.git.christophe.leroy@c-s.fr>
From: Jason Wessel <jason.wessel@windriver.com>
Message-ID: <ed907623-d636-0d18-95b0-33249c3d88cf@windriver.com>
Date: Mon, 1 Oct 2018 14:55:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <e5f8f6e3e5a5595be08127eefae8025ebbb691cc.1538068025.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset="utf-8"; format=flowed
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 09/27/2018 12:17 PM, Christophe Leroy wrote:
> Since commit ad67b74d2469 ("printk: hash addresses printed with %p"),
> all pointers printed with %p are printed with hashed addresses
> instead of real addresses in order to avoid leaking addresses in
> dmesg and syslog. But this applies to kdb too, with is unfortunate:
> 
>      Entering kdb (current=0x(ptrval), pid 329) due to Keyboard Entry
>      kdb> ps
>      15 sleeping system daemon (state M) processes suppressed,
>      use 'ps A' to see all.
>      Task Addr       Pid   Parent [*] cpu State Thread     Command
>      0x(ptrval)      329      328  1    0   R  0x(ptrval) *sh
> 
>      0x(ptrval)        1        0  0    0   S  0x(ptrval)  init
>      0x(ptrval)        3        2  0    0   D  0x(ptrval)  rcu_gp
>      0x(ptrval)        4        2  0    0   D  0x(ptrval)  rcu_par_gp
>      0x(ptrval)        5        2  0    0   D  0x(ptrval)  kworker/0:0
>      0x(ptrval)        6        2  0    0   D  0x(ptrval)  kworker/0:0H
>      0x(ptrval)        7        2  0    0   D  0x(ptrval)  kworker/u2:0
>      0x(ptrval)        8        2  0    0   D  0x(ptrval)  mm_percpu_wq
>      0x(ptrval)       10        2  0    0   D  0x(ptrval)  rcu_preempt
> 
> The whole purpose of kdb is to debug, and for debugging real addresses
> need to be known. In addition, data displayed by kdb doesn't go into
> dmesg.
> 

I completely agree.  This is added to the merge queue.

Cheers,
Jason.
