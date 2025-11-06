Return-Path: <linuxppc-dev+bounces-13836-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F64FCCFA03
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Nov 2025 09:50:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d2HVQ692Hz3bs7;
	Thu,  6 Nov 2025 20:50:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=93.17.235.10
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762422606;
	cv=none; b=O9OkanJGYn9/E5GA9aph8bOze6jw140HaQrEB+qMA98Ei3T3nE53b5OjYwtZtozwPPOQo2xhni/jCOKOR79PiFmluYv9/ZcJdOqZ8V6jL8JDn7kkgNchZ9EBMfj8dkrfD2e4EHNejzfznDzYaEZ0AqPYv9IVKuerM9judr4I2PlTTw9jsgROkRpL2rmF3nLPzDnQoa8TwcUE+wVReNShiKlgHpWhYND73gVFeLhxBK2AgQubniP7zgU83MRvPDAiT5OMkVeJSCy6Q9VzCZJ5IhZ3VStjUHp6bK46FAUiq14WSdVuGT+vtabFar6W8K4q57M+dCdQzymtSVAtyuJ/Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762422606; c=relaxed/relaxed;
	bh=T9jEnWqJtVc6s4Vus7Y15sM4YFkrw/UlX+6tCkSmaLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HphPN2d5hVxnBgtx6pRYFtIkiquR8gWtDjfEtCxMvr/Yti31bCEqgmH2y2id9aXlTpR8e31WRFxF5ZDTDGlzxRzgHRvObOLr5iBJfpifxkck167iC3Q4CxbxL6A7ReOXE8T85IMCI4NraN/4Q1JzdKyOSI6VnUiIC/64tc+ZjlB1xCt9gf3wKheDeSmWJd5F13JXFZ/PTy7TaqrDYmuivEnYR3tkoMkcO45jFaa5id4E8DFiaAPnq9gCPj+8dLJ0sGxBLv6dlYaK7ivJ9akav/gh01Jzp5RSnWQ6gjdS1F9BgXEZvPDGLWsbfVStzggOxjIZz191UcQd4KoyvwOKbQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass (client-ip=93.17.235.10; helo=pegase2.c-s.fr; envelope-from=christophe.leroy@csgroup.eu; receiver=lists.ozlabs.org) smtp.mailfrom=csgroup.eu
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr; envelope-from=christophe.leroy@csgroup.eu; receiver=lists.ozlabs.org)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d2HVP65ggz2xsq
	for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Nov 2025 20:50:04 +1100 (AEDT)
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4d2H1v58zTz9sSV;
	Thu,  6 Nov 2025 10:28:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kAhLEPwwxtXU; Thu,  6 Nov 2025 10:28:51 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4d2H1v4Sh9z9sSS;
	Thu,  6 Nov 2025 10:28:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 88B0E8B77B;
	Thu,  6 Nov 2025 10:28:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id pF7VBQ2TqCs8; Thu,  6 Nov 2025 10:28:51 +0100 (CET)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 2177C8B773;
	Thu,  6 Nov 2025 10:28:51 +0100 (CET)
Message-ID: <994bea8c-7b28-4aae-a6b3-e4f33731cb29@csgroup.eu>
Date: Thu, 6 Nov 2025 10:28:50 +0100
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
Subject: Re: [PATCH v4] powerpc: Use shared font data
To: Finn Thain <fthain@linux-m68k.org>, Stan Johnson <userm57@yahoo.com>,
 "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: mpe@ellerman.id.au, npiggin@gmail.com, sam@ravnborg.org,
 benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, rdunlap@infradead.org,
 Cedar Maxwell <cedarmaxwell@mac.com>,
 "maddy@linux.ibm.com" <maddy@linux.ibm.com>
References: <20230825142754.1487900-1-linux@treblig.org>
 <d81ddca8-c5ee-d583-d579-02b19ed95301@yahoo.com> <aQeQYNANzlTqJZdR@gallifrey>
 <20108eef-b7cf-3f23-264a-5d97021f9ffa@linux-m68k.org>
 <aQgJ95Y3pA-8GdbP@gallifrey>
 <3cc3d311-35b0-42f1-b20f-ed59391bb8e0@csgroup.eu>
 <ead4ef3f-9f8c-a98e-b48d-f052bc9492d0@linux-m68k.org>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <ead4ef3f-9f8c-a98e-b48d-f052bc9492d0@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 06/11/2025 à 05:11, Finn Thain a écrit :
> 
> On Wed, 5 Nov 2025, Christophe Leroy wrote:
> 
>> 1/ Either build font_sun8x16.o with -fPIC
>> ...
>>
>> 2/ Or add a PTRRELOC:
>> ...
> 
> Thanks for your help with this, Christophe.
> 
> I fixed up the whitespace problems and forwarded those patches to Stan,
> along with instructions for applying them. He tells me that patch 2 fixed
> the hang. Patch 1 did not.

Fine. Then let's use PTRRELOC.

Will you or David submit the patch ?

Thanks
Christophe

