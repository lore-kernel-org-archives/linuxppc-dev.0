Return-Path: <linuxppc-dev+bounces-24823-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A81C531D0
	for <linuxppc-dev@archiver.kernel.org>; Sat, 25 Jul 2026 16:34:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h6r6t3VZ1z2xl5;
	Sun, 26 Jul 2026 02:34:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=212.227.15.18
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784997286;
	cv=none; b=SA9OHlt//uPsezeYymvArulqEwoVjlyhzn9jtbwofkb7HIQyl7x1An+GBiYtcDub4x6hgKxMcAQuA9X4SbfTGW46w+kgXdHeFjuQd8bFKcwNLg+KPJ5bpvic8JNyf09HaMUC2tOfCwlsPeS87x4u4oiDtuzp58ou/xNmX3jJ+2Rr7wtOh4HMmw7uyVQplmig15fMu8TF45ifnKeBHykTI0cnGuNkQBXHQoinUBUgUOr1KYXpS/b4tZhhm4Y3QLGPezhziOh7afyGsz4YLMeZxcajtH8sy48CTW3Qs53P1BZZnfLZTVn7R6gMqyDpPvOupsk/6Frv+uBniayV7GISnA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784997286; c=relaxed/relaxed;
	bh=yIatGR7BxVlsPtV5mXKcWjGLb6heraxX3D5hGyBKDu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kU/o0V9+/5EeLJ3DqYSQekdoNyWJGK8/55EZUCbcLmkCzC3tbDdWshqdOdUjarRVsrHxeHXJWHuEwdrovoFDohhaiML4z6NfNwXSFFQyDQmPuzdYPxruG8BPfNqdT2DiM82DFvxiA/Py21dj5pL7IW49hLlkvSmtcDwxa6ZOn/HCZwQisFtobs3YVFXzZh5ffoUi0Gk+xWLgFvmeZKmhI4XtXWyEUlQqT96Zh62NOH3FAaWAs0aakA0M+yB46s2pYT9FYxWIKR1aLfwayiEarILDmaI6tXOUiTLrKU9ZvRiXtbwbbj1XQP1DvalhUGwJlq3eznpyackQHp8FV1QCCQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=jIOvOCiu; dkim-atps=neutral; spf=pass (client-ip=212.227.15.18; helo=mout.gmx.net; envelope-from=deller@gmx.de; receiver=lists.ozlabs.org) smtp.mailfrom=gmx.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=jIOvOCiu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmx.de (client-ip=212.227.15.18; helo=mout.gmx.net; envelope-from=deller@gmx.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 399 seconds by postgrey-1.37 at boromir; Sun, 26 Jul 2026 02:34:42 AEST
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h6r6p6Mb6z2xLd
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Jul 2026 02:34:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1784997261; x=1785602061; i=deller@gmx.de;
	bh=yIatGR7BxVlsPtV5mXKcWjGLb6heraxX3D5hGyBKDu8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=jIOvOCiuPIvo8gH2XEcWDLZhZGKC9CobCS9sVouPhzrMilmehBJ+BpyGpcnHbhcG
	 obrjYnf32gFvXFuo+BdQ+rzJ4syRsgnDxZIAQZTpydB92MXukrQrPddFTR4oMPtux
	 2oGmGn5k/gdQMA/YwIn8X5XdBRdLTRp3YIbjGY4ud6gNx5K6e0esS7ZDOrJMYA9LS
	 3lzGm6y1lUkbyKMmX/Sbdp01VSvxFuFyDiio1bQxnT639gbs/YT2hb0Dsgzhp/ffM
	 32z8loquvOT0Wi4sZaa9DW/QAPCkYLwbnCT9TYIylzjdmVIZylBa2r1/Z0wsYcwtQ
	 Kj3r2kJQLbdGUXvMEw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M1Hdw-1wqQ6u0OJG-00GYk2; Sat, 25
 Jul 2026 18:27:42 +0200
Message-ID: <3e9dece8-4e86-4ce5-bd74-b3ec305f3003@gmx.de>
Date: Sat, 25 Jul 2026 18:27:36 +0200
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
Subject: Re: [PATCH 3/5] mm/parisc: constify ptep_get() argument
To: Usama Arif <usama.arif@linux.dev>, Pedro Falcato <pfalcato@suse.de>
Cc: Matthew Wilcox <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Kevin Brodsky <kevin.brodsky@arm.com>,
 Muhammad Usama Anjum <usama.anjum@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <20260724102017.141532-1-pfalcato@suse.de>
 <20260724102017.141532-4-pfalcato@suse.de>
 <0fd713a8-e4ab-4c07-b36e-79dd138b4a86@linux.dev>
 <amNzLXuwflIZFKtI@casper.infradead.org>
 <253f7ac0-205b-42f1-9fb5-d19eceb581b6@linux.dev>
 <amOEUZlp1BxYh6_t@pedro-suse>
 <fd239383-dcbe-4daf-b337-32facef07076@linux.dev>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <fd239383-dcbe-4daf-b337-32facef07076@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XvEnQPYweOvdRlakB++BxNs8G8wkp15F6t4WcV4lTCEzkxz2evz
 ulkt5g2+OsJwb46K3fnZ8xxVK6MsyDBPGxEQJ0HDIyVaA5TeSiThrvngIAkKYtyVFB0Fvk2
 DpSQ2vU++551bzQrR+zPKyZuOcJNUEELMpikxVjIql6ipjTMHaG8v32wGLqfGSBmCi1S2ru
 yhOQhpXQbYPQQY6vF4ptA==
UI-OutboundReport: notjunk:1;M01:P0:b/9irExKGiU=;uN0E6cNDN2dCKn2NSaanZuRVNPz
 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
 89SqOUpds=

On 7/24/26 17:48, Usama Arif wrote:
>=20
>=20
> On 24/07/2026 16:32, Pedro Falcato wrote:
>> On Fri, Jul 24, 2026 at 04:03:44PM +0100, Usama Arif wrote:
>>>
>>>
>>> On 24/07/2026 15:14, Matthew Wilcox wrote:
>>>> On Fri, Jul 24, 2026 at 02:36:59PM +0100, Usama Arif wrote:
>>>>>
>>>>>
>>>>> On 24/07/2026 11:20, Pedro Falcato wrote:
>>>>>> ptep_get() does not need write access to the PTE.
>>>>>>
>>>>>> Signed-off-by: Pedro Falcato <pfalcato@suse.de>
>>>>>> ---
>>>>>>   arch/parisc/include/asm/pgtable.h | 2 +-
>>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>> hmm I think you might break build bisectibility if
>>>>> you separate out the patches, you should squash patch 3 and 4,
>>>>> with patch 1.
>>>>
>>>> I don't see how this breaks bisectability.  Can you elaborate on what
>>>> you think would break?
>>>
>>> Patch 1 does:
>>>
>>> -static inline pte_t ptep_get_lockless(pte_t *ptep)
>>> +static inline pte_t ptep_get_lockless(const pte_t *ptep)
>>>   {
>>>   	return ptep_get(ptep);
>>>   }
>>>
>>>
>>> ptep_get() takes a non-const arg till patch 3 for example for parsic.
>>> I don't think you can pass a const variable to non const function arg?
>>>
>>> So parsic won't compile in patch 1 and 2, powerprc wont compile
>>> for patches 1, 2 and 3..
>>
>> Aha, yes, nice catch! I'll have to rethink that. Maybe squashing the pa=
tches
>> would be the cleanest way forward.
>>
>=20
> Yes, squashing is the simplest way forward.
>=20
>> FWIW, the vast majority of architectures aren't doing funny things on
>> ptep_get(). E.g PA-RISC, loongarch only define these so they can use it=
 in
>> their own asm/pgtable.h. I'd really like to delete these but I can't te=
ll
>> if they are *actually* required.
>>
>=20
> Ah maybe there is something in git history on why it was needed?
>=20
> If not, hopefully someone from the arch lists could clarify..
I tried to remove ptep_get() and ptep_test_and_clear_young() from
arch/parisc/include/asm/pgtable.h, but this then triggers compile errors:

  CC      arch/parisc/kernel/asm-offsets.s
In file included from /home/cvs/parisc/git-kernel/linus-linux-2.6/include/=
linux/mm.h:31,
                  from /home/cvs/parisc/git-kernel/linus-linux-2.6/include=
/linux/pid_namespace.h:7,
                  from /home/cvs/parisc/git-kernel/linus-linux-2.6/include=
/linux/ptrace.h:10,
                  from /home/cvs/parisc/git-kernel/linus-linux-2.6/arch/pa=
risc/kernel/asm-offsets.c:21:
/home/cvs/parisc/git-kernel/linus-linux-2.6/include/linux/pgtable.h: In fu=
nction =E2=80=98clear_young_dirty_ptes=E2=80=99:
/home/cvs/parisc/git-kernel/linus-linux-2.6/include/linux/pgtable.h:683:25=
: error: implicit declaration of function =E2=80=98ptep_test_and_clear_you=
ng=E2=80=99; did you mean =E2=80=98pmdp_test_and_clear_young=E2=80=99? [-W=
implicit-function-declaration]
   683 |                         ptep_test_and_clear_young(vma, addr, ptep=
);
       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
       |                         pmdp_test_and_clear_young

So, I think the answer is, that the local copy of ptep_get() is used in th=
e parisc implementation of
ptep_test_and_clear_young() function.

Switching to the default include/linux/pgtable.h seems not easy doable....

Helge

