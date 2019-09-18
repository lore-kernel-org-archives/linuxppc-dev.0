Return-Path: <SRS0=xS+q=XN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C63C4CEC4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Sep 2019 15:41:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2E04206C2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Sep 2019 15:41:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2E04206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=neo-zeon.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46YPNG0fntzF4cj
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Sep 2019 01:41:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=neo-zeon.de
 (client-ip=96.90.244.226; helo=neo-zeon.de; envelope-from=cam@neo-zeon.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=neo-zeon.de
Received: from neo-zeon.de (neo-zeon.de [96.90.244.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46YPK52dY0zF39S
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Sep 2019 01:38:48 +1000 (AEST)
Received: from [192.168.0.55] (ukyo.nerv.lan [192.168.0.55])
 (authenticated bits=0)
 by neo-zeon.de (8.15.2/8.15.2) with ESMTPSA id x8IFcfll047936
 (version=TLSv1.2 cipher=AES128-SHA bits=128 verify=NO);
 Wed, 18 Sep 2019 08:38:41 -0700 (PDT) (envelope-from cam@neo-zeon.de)
Subject: Re: [Bug 204789] New: Boot failure with more than 256G of memory
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>
References: <bug-204789-27@https.bugzilla.kernel.org/>
 <20190911073153.9df4d4618d7f99752cd18edd@linux-foundation.org>
 <875zlw7q5s.fsf@linux.ibm.com> <87zhj85lac.fsf@linux.ibm.com>
 <a18615a4-be8b-4df0-addb-7841567923f6@neo-zeon.de>
 <28de8cb6-3213-56aa-8ed6-fbdb109ab3df@linux.ibm.com>
 <e45ab4aa-202f-b98a-e9cf-8945ea9391a8@neo-zeon.de>
 <c5e52337-5ff1-79f0-8d36-baea0a105c58@linux.ibm.com>
From: Cameron Berkenpas <cam@neo-zeon.de>
Message-ID: <8562bd0e-f426-690e-7b3c-973390e208ce@neo-zeon.de>
Date: Wed, 18 Sep 2019 08:38:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c5e52337-5ff1-79f0-8d36-baea0a105c58@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
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
Cc: bugzilla-daemon@bugzilla.kernel.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hello,

Unfortunately, this patch set has made things quite a bit worse for me. 
Appending mem=256G doesn't fix it either. in all cases, the system at 
least gets past early boot and then I will probably get a panic and 
eventual reboot, or occasionally it just locks up entirely.

Here's my very first attempt at booting the kernel where I didn't even 
get a panic:
https://pastebin.com/a3TVZcVB

Here's another attempt where I get a panic:
https://pastebin.com/QsJjyC2v

Finally here's an attempt with mem=256G:
https://pastebin.com/swgLYie9

I don't know that these results are substantially different from each 
other, but perhaps there's something helpful.

Sometimes (but not in any of the above), the host gets to the point that 
systemd starts up, but ultimately it seems I got the same stacktrace.

At one point, I ended up with a CPU guarded out, but it was simple to 
recover.

-Cameron

On 9/17/19 8:15 PM, Aneesh Kumar K.V wrote:
> On 9/13/19 10:58 PM, Cameron Berkenpas wrote:
>> Running against the kernel I built against 0034d395f89d and the 
>> problem is still there.
>>
>> However, running against the kernel I built against the previous 
>> commit, a35a3c6f6065, and the system boots.
>>
>> This being due to 0034d395f89d confirmed.
>
>
> https://lore.kernel.org/linuxppc-dev/20190917145702.9214-1-aneesh.kumar@linux.ibm.com 
>
>
> This series should help you.
>
> -aneesh
>

