Return-Path: <linuxppc-dev+bounces-11718-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36185CA1002
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Sep 2025 10:20:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cHb8k5sfTz2xnM;
	Thu,  4 Sep 2025 20:20:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=93.17.235.10
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756981238;
	cv=none; b=JRSqlnCI9cDic5VpOnc5yo7s9C/ZiYNdxYXKqEW3D0mb3z1rosTb+JGcji51CFHNbk3QYo38jSodb2vpdwKqWsl3VS69hayzsF8gmmFJnPPWL0Zk2bXHMQxx9/mkeujDEskMvmMVWCrq4ijKZr3yz/Ho4pQD5iW5VTdEqyd95zbKYyt/tHvj/yc9VxuF0z6o1aoC32dR/Tn/haB70eilG7pHTOE/sTmdKtwn9FSWygX9kKMTfHAfAYKacwZ3uc4NrMS8lT2MhqFFWj3akk0NFNEP1ZrNvt3+UPOVF7Dy3bCUakoe1t1on2tx/C0xuDiLcV74mj3moBsdKMNj6+99ng==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756981238; c=relaxed/relaxed;
	bh=oBgey+SXKxNwN0UFSl6NzJUItsG701jt62B5comsJAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mAXs6I4+StriPjQA6PkcbQjGyuIGR4oSMev5PFoPO1pvKJtMHNFlAUubvWTWy5fDP5mTIOo1YLXjE910/6h2ygIqqxxFoF0gfNKJFiER7jHn5UtO/x7QG8Kv/I706uZGqG10F1k0k27QmQQdfiyKWIsB3Su2NCJUlRc+YINfJtM17Xt8ojfAfUPeBbjS9E5jE+yuNJSw3WxbhRyd9NKCNq2o21jV9Xm7ueBqBb93tY9pWAfeXsxyR71XA2YVQDL9gl/UFwxmwl2U4s8SxWXdbdMPLgfIMii8L+sU21kSFcZGwJIKztcJzrxzESV8zBQaxqvjQawCunBhcvzVqVjIog==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass (client-ip=93.17.235.10; helo=pegase2.c-s.fr; envelope-from=christophe.leroy@csgroup.eu; receiver=lists.ozlabs.org) smtp.mailfrom=csgroup.eu
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr; envelope-from=christophe.leroy@csgroup.eu; receiver=lists.ozlabs.org)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cHb8h67Msz2xd6
	for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Sep 2025 20:20:36 +1000 (AEST)
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cHY2x2Nj3z9sSC;
	Thu,  4 Sep 2025 10:45:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RbpVFRObFkEX; Thu,  4 Sep 2025 10:45:29 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cHY2x1gzZz9sRy;
	Thu,  4 Sep 2025 10:45:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 25A068B764;
	Thu,  4 Sep 2025 10:45:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id ZZ6PRxhQp6oY; Thu,  4 Sep 2025 10:45:29 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id F25AF8B763;
	Thu,  4 Sep 2025 10:45:28 +0200 (CEST)
Message-ID: <e042d4ca-c66b-49ec-8572-442ab697c430@csgroup.eu>
Date: Thu, 4 Sep 2025 10:45:28 +0200
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
Subject: Re: Kernel v6.17-rc4 with STATIC_CALL_SELFTEST=y enabled fails to
 boot at early stage (PowerMac G4 DP)
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
 Erhard Furtner <erhard_f@mailbox.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Cc: Andrew Donnellan <ajd@linux.ibm.com>
References: <342b4120-911c-4723-82ec-d8c9b03a8aef@mailbox.org>
 <98dbafee-aad3-439b-9efb-76f80c6668fd@csgroup.eu>
 <ca440403-0108-4703-bf07-bc3ac7e3d108@linux.ibm.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <ca440403-0108-4703-bf07-bc3ac7e3d108@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 04/09/2025 à 10:40, Madhavan Srinivasan a écrit :
> 
> 
> On 9/4/25 1:01 PM, Christophe Leroy wrote:
>> Hi Erhard,
>>
>> Le 04/09/2025 à 00:44, Erhard Furtner a écrit :
>>> Greetings!
>>>
>>> In a conversation with Andrew about his page table check code for PowerPC he found out there seems to be a general problem of the code patching code on ppc:
>>>
>>>   > I note that STATIC_CALL_SELFTEST seems to fail, which could be but isn't
>>>   > necessarily related.
>>>
>>>   > Specifically, it looks like code patching fails if the instruction being patched
>>>   > is in an __init function, and in this case, that occurs due to
>>>   > page_table_check_pte_clear() being inlined into ptep_clear(), which is in turn
>>>   > inlined into pte_clear_tests() in debug_vm_pgtable.c which is marked __init.
>>>   > Very curious!
>>>
>>> Indeed, when I enable STATIC_CALL_SELFTEST=y on my G4 the kernel fails to boot at an early stage, the OpenFirmware console showing only:
>>>
>>> done
>>> found display   : /pci@f0000000/ATY,AlteracParent@10/ATY,Alterac_B@1, opening...
>>>
>>> Without STATIC_CALL_SELFTEST the kernel boots just fine.
>>>
>>> Kernel .config attached.
>>
>> With your .config, on QEMU I get the following. I will investigate.
>>
>> [    0.000000] Kernel panic - not syncing: arch_static_call_transform: patching failed func_a+0x0/0x10 at 0x0
>> [    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.17.0-rc4-PMacG4+ #1628 PREEMPTLAZY
>> [    0.000000] Hardware name: PowerMac3,1 7400 0xc0209 PowerMac
>> [    0.000000] Call Trace:
> 
> I am using qemu with -M mac99 and it boots
> 
> Hardware name: PowerMac3,1 7400 0xc0209 PowerMac
> printk: legacy bootconsole [udbg0] enabled
> -----------------------------------------------------
> phys_mem_size     = 0x8000000
> dcache_bsize      = 0x20
> 
> I am missing something here. Digging some more


Did you use the .config provided by Erhard ?

Christophe


