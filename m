Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C24C433F5
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Jan 2022 10:20:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JVfPQ5SwGz3cDy
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Jan 2022 21:20:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=iogearbox.net (client-ip=213.133.104.62;
 helo=www62.your-server.de; envelope-from=daniel@iogearbox.net;
 receiver=<UNKNOWN>)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JVfNs6Xclz30L9
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Jan 2022 21:20:12 +1100 (AEDT)
Received: from sslproxy02.your-server.de ([78.47.166.47])
 by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.92.3) (envelope-from <daniel@iogearbox.net>)
 id 1n5mLp-000CWp-Jl; Fri, 07 Jan 2022 11:20:01 +0100
Received: from [85.1.206.226] (helo=linux.home)
 by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <daniel@iogearbox.net>)
 id 1n5mLp-000HOu-9F; Fri, 07 Jan 2022 11:20:01 +0100
Subject: Re: [PATCH 00/13] powerpc/bpf: Some fixes and updates
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>
References: <cover.1641468127.git.naveen.n.rao@linux.vnet.ibm.com>
 <f4f3437d-084f-0858-8795-76e4a0fa5627@iogearbox.net>
 <1641540707.ewk8tpqmvl.naveen@linux.ibm.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <4893ddd3-f0ef-003b-3445-57ce5dc1b065@iogearbox.net>
Date: Fri, 7 Jan 2022 11:20:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1641540707.ewk8tpqmvl.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.3/26415/Fri Jan  7 10:26:59 2022)
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
Cc: ykaliuta@redhat.com, johan.almbladh@anyfinetworks.com,
 Jiri Olsa <jolsa@redhat.com>, song@kernel.org, bpf@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Hari Bathini <hbathini@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 1/7/22 8:36 AM, Naveen N. Rao wrote:
> Daniel Borkmann wrote:
>> On 1/6/22 12:45 PM, Naveen N. Rao wrote:
>>> A set of fixes and updates to powerpc BPF JIT:
>>> - Patches 1-3 fix issues with the existing powerpc JIT and are tagged
>>>    for -stable.
>>> - Patch 4 fixes a build issue with bpf selftests on powerpc.
>>> - Patches 5-9 handle some corner cases and make some small improvements.
>>> - Patches 10-13 optimize how function calls are handled in ppc64.
>>>
>>> Patches 7 and 8 were previously posted, and while patch 7 has no
>>> changes, patch 8 has been reworked to handle BPF_EXIT differently.
>>
>> Is the plan to route these via ppc trees? Fwiw, patch 1 and 4 look generic
>> and in general good to me, we could also take these two via bpf-next tree
>> given outside of arch/powerpc/? Whichever works best.
> 
> Yes, I would like to route this through the powerpc tree. Though patches 1 and 4 are generic, they primarily affect powerpc and I do not see conflicting changes in bpf-next. Request you to please ack those patches so that Michael can take it through the powerpc tree.

Ok, works for me. I presume this will end up in the upcoming merge window
anyway, so not too long time until we can sync these back to bpf/bpf-next
trees then.

Thanks!
Daniel
