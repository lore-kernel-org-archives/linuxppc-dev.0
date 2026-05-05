Return-Path: <linuxppc-dev+bounces-20480-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E45FF8855
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2026 15:48:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g92xG0xjMz2xfB;
	Wed, 06 May 2026 01:48:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777996130;
	cv=none; b=RqGAUdvZkJlFU7nrIaLZ5Ybgf6QkWIld3BLLJoVCLHtspSP6AV1rtYKNigxFqdt+JIPnvSKdn0g/t8bkfZDO5jf93+u8YTTY1X/qbHDWhPsm3PdWjNjU/AhVK0K1qihYwo2ls7KwmOuWv4YgFZelFK2JBHN8JjEAIZNf6DdFA/ya7nYzUGhWUnMaNJ2Z7jWfzTThsx8GW0GK6J9X4YJfztR1KkRI8uYqdwo9LzLA3FQYJzMztRnYDTBqjNlzhJ233oMqe2RO1oC5ItYJ2E4MVUFuVFOo5l78ahr+/Kd/1mhYdDafSXCsHnvz+AJ0V2D1Qs6ODbvjClEtHPzij7ZNMA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777996130; c=relaxed/relaxed;
	bh=byyCvjBzlGvXGE/cI4UiJyJoZJ0yJl27r1CdKLIGL5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nxvX5Gkdu0uqmZo6LLuQ7H9IwP1XG+BwZmdYWfuVYWTrwM4fAV1gS2moLRi8xkugLqtMPMqw9lt9z3P2I3+Mq1dCvmIuoQPtQMdHoISKncxnOP+YwQFPUmoGM1EXZH0WqWHFnGPt2WMF6u139pSQbzpaL3XYONCOfLGho3XL2tuSrMZ+x38uyaYQM2MEo6RfdN4ayKvG3aBnXj/D2zzqUxjwSdzVpxASyCZxXQ4VcgH+D061qHwSoU7ryrCb1kR2j59/dXTYARPLSxi2sd3tR6yfcw10JrbIwuWriCl/oAjlrpzHDBwVT4pqV6WkG+pcV68TWlwLv6Amarg3uaBeFg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TP94/sBj; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TP94/sBj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g92x9527Wz2xMV
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 May 2026 01:48:45 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 4525441757;
	Tue,  5 May 2026 15:48:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF5DC2BCB4;
	Tue,  5 May 2026 15:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777996123;
	bh=sPt8QCw97y+bSuSf9ZbsQX4cPKPD+Mv6U7XrbNA+fN4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TP94/sBj8COsFYLwjYLqeHwcQ8YaduzVRj0kBcni2b/fUpciNk+tPpuUu2WJvTQQu
	 OZgz4V0ZTr0bp8hOFkm5gMTGmzvk7WXrBvKYdJSUmUChLpFHIF/+C/yRdzrGjC4fdY
	 UYJ0UdryMTMViMVcT+X0s7K4QPUWCYPQxF7Y3zq9x2i/9+40R1BIUcN+UAlXZFZ+BH
	 53Hn6vsUc4XrFJL+ALohHvki7Xl7VYZyswhtpfpQPnq6933oeFMwXgZOx4xNZ2TTWR
	 Ey7H5m+CNRfQiWmxuAUvHNQgKQgansY1eXkT9Tcy/36BmpbeTb4TuGvm/cFrbv5+Jo
	 L93oNSbskNfXA==
Message-ID: <669fbc9a-a243-43e8-8888-93bfb9d6ee12@kernel.org>
Date: Tue, 5 May 2026 17:48:32 +0200
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/6] objtool/powerpc: Add build-time fixup of alternate
 feature branch targets
To: Peter Zijlstra <peterz@infradead.org>,
 Sathvika Vasireddy <sv@linux.ibm.com>
Cc: nathan@kernel.org, nsc@kernel.org, maddy@linux.ibm.com,
 mpe@ellerman.id.au, npiggin@gmail.com, jpoimboe@kernel.org,
 ojeda@kernel.org, masahiroy@kernel.org, lossin@kernel.org,
 tamird@kernel.org, thomas.weissschuh@linutronix.de, rostedt@goodmis.org,
 ihor.solodrai@linux.dev, thuth@redhat.com, pmladek@suse.com,
 aliceryhl@google.com, elver@google.com, kees@kernel.org, legion@kernel.org,
 ardb@kernel.org, yuxuan.zuo@outlook.com, alexghiti@rivosinc.com,
 alexandre.chartre@oracle.com, bp@alien8.de, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20260505084628.17940-1-sv@linux.ibm.com>
 <20260505084628.17940-2-sv@linux.ibm.com>
 <20260505144539.GX3126523@noisy.programming.kicks-ass.net>
 <20260505144949.GO3102924@noisy.programming.kicks-ass.net>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260505144949.GO3102924@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 05/05/2026 à 16:49, Peter Zijlstra a écrit :
> On Tue, May 05, 2026 at 04:45:39PM +0200, Peter Zijlstra wrote:
>> On Tue, May 05, 2026 at 02:16:23PM +0530, Sathvika Vasireddy wrote:
>>>   	switch (opcode) {
>>> +	case 16:
>>
>> Like case 18 below, this wants a comment describing which instruction
>> this is; bclr ?

No, it is bc/bca/bcl/bcla, it is quite similar to type 18 which is 
b/ba/bl/bla, but that's a conditional branch to a 14-bit offset while 
type 18 is a non-conditional branch to a 24-bit offset (10 bits are the 
conditional in the bc, hence the reduced offset size).


> 
> Also, isn't that typically used for return, suggesting at least
> something should have INSN_RETURN on?
> 

bclr (which is the return INSN_RETURN) has type 19

By the way you can have a look at 
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/bfa8364da047d8610a09458a1cd924a0566aedbb.1736955567.git.christophe.leroy@csgroup.eu/

That patch has all the objtool decoding. By the way objtool is missing a 
INSN_CONDITIONAL_RETURN, also see 
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/537e5d8f181b1f1c2b8918f1aefa1dba3f972c03.1736955567.git.christophe.leroy@csgroup.eu/



>>> +		if (ins & 1)
>>> +			typ = INSN_OTHER;
>>> +		else
>>> +			typ = INSN_JUMP_CONDITIONAL;
>>> +		imm = ins & 0xfffc;
>>> +		if (imm & 0x8000)
>>> +			imm -= 0x10000;
>>> +		insn->immediate = imm | aa;
>>> +		break;
>>> +
>>>   	case 18: /* b[l][a] */
>>>   		if (ins == 0x48000005)	/* bl .+4 */
>>>   			typ = INSN_OTHER;


