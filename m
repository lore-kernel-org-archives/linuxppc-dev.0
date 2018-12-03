Return-Path: <SRS0=3K4h=OM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD72C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 23:01:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5398D2064A
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 23:01:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5398D2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4380qH3L6ZzDqSB
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 10:01:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=iogearbox.net
 (client-ip=213.133.104.62; helo=www62.your-server.de;
 envelope-from=daniel@iogearbox.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=iogearbox.net
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4380fj2WqjzDqkG
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2018 09:54:03 +1100 (AEDT)
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
 by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
 (Exim 4.89_1) (envelope-from <daniel@iogearbox.net>)
 id 1gTx6B-0004v7-1F; Mon, 03 Dec 2018 23:53:55 +0100
Received: from [178.197.248.17] (helo=linux.home)
 by sslproxy05.your-server.de with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <daniel@iogearbox.net>)
 id 1gTx6A-000Vwo-S6; Mon, 03 Dec 2018 23:53:54 +0100
Subject: Re: [PATCH bpf] bpf: powerpc64: optimize JIT passes for bpf function
 calls
To: Sandipan Das <sandipan@linux.ibm.com>
References: <20181203122104.6746-1-sandipan@linux.ibm.com>
 <0e55ce74-ea93-06cf-cc67-28708f978bc2@iogearbox.net>
 <03a23ff9-1337-74dc-74e5-c5132909f8be@linux.ibm.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <a80f6fd5-181b-01a5-a7a4-2e8f1911ffac@iogearbox.net>
Date: Mon, 3 Dec 2018 23:53:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <03a23ff9-1337-74dc-74e5-c5132909f8be@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25177/Mon Dec  3 23:21:05 2018)
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
Cc: naveen.n.rao@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, ast@kernel.org,
 netdev@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 12/03/2018 02:26 PM, Sandipan Das wrote:
> Hi Daniel,
> 
> On 03/12/18 6:18 PM, Daniel Borkmann wrote:
>>
>> Thanks for the patch, just to clarify, it's targeted at bpf-next and
>> not bpf, correct?
> 
> This patch is targeted at the bpf tree.

Ok, thanks for clarifying, applied to bpf!
