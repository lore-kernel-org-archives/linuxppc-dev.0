Return-Path: <SRS0=3VWP=OF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEDAC43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 14:49:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53BAB20817
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 14:49:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53BAB20817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 433VDc0qglzDqY0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 01:49:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=embeddedor.com
 (client-ip=192.185.47.206; helo=gateway22.websitewelcome.com;
 envelope-from=gustavo@embeddedor.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=embeddedor.com
X-Greylist: delayed 1278 seconds by postgrey-1.36 at bilbo;
 Tue, 27 Nov 2018 01:47:14 AEDT
Received: from gateway22.websitewelcome.com (gateway22.websitewelcome.com
 [192.185.47.206])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 433VBB6NTlzDqW2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Nov 2018 01:47:14 +1100 (AEDT)
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
 by gateway22.websitewelcome.com (Postfix) with ESMTP id 1DC95788B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2018 08:25:53 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22]) by cmsmtp with SMTP
 id RHphgX8uxSjJARHphguuwQ; Mon, 26 Nov 2018 08:25:53 -0600
X-Authority-Reason: nr=8
Received: from [189.250.78.127] (port=48484 helo=[192.168.43.131])
 by gator4166.hostgator.com with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.91)
 (envelope-from <gustavo@embeddedor.com>)
 id 1gRHpg-000gKx-H8; Mon, 26 Nov 2018 08:25:52 -0600
Subject: Re: New linux-next KCFLAGS
To: Stephen Rothwell <sfr@canb.auug.org.au>, Kees Cook <keescook@google.com>
References: <CAGXu5jL9WDRVCzPP0V2cvFHWfwAfd74kBNX9O+0frFkD26ti1Q@mail.gmail.com>
 <20181126084841.13679afd@canb.auug.org.au>
 <CAGXu5jL38a1Tx_LW9_j0sEHwLFGpuX-r2Y7dJq32eoED8BFrhw@mail.gmail.com>
 <20181126174926.65889a69@canb.auug.org.au>
 <20181127010035.1385b60b@canb.auug.org.au>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <fa07361e-67eb-1299-bb81-da5a920a315d@embeddedor.com>
Date: Mon, 26 Nov 2018 08:25:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181127010035.1385b60b@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - lists.ozlabs.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.78.127
X-Source-L: No
X-Exim-ID: 1gRHpg-000gKx-H8
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.43.131]) [189.250.78.127]:48484
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
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
Cc: PowerPC <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 11/26/18 8:00 AM, Stephen Rothwell wrote:
> Hi all,
> 
> On Mon, 26 Nov 2018 17:49:26 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> On Sun, 25 Nov 2018 21:46:20 -0800 Kees Cook <keescook@google.com> wrote:
>>>
>>> Excellent! (Though, wait, does this mean everyone _else_ will see this
>>> too? I'm worried that will be way too noisy...)
>>
>> Ah, yes, you may be right.  everyone will see them :-(
>>
>> I may have to figure out another way to do this for tomorrow.
> 
> OK, starting tomorrow (later today), I have just added
> -Wimplicit-fallthrough to KCFLAGS in my build scripts.
> 

Awesome!

Thank you, Stephen. :)
--
Gustavo
