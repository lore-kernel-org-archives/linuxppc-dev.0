Return-Path: <linuxppc-dev+bounces-17961-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58EECEB104B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Mar 2026 10:42:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVVp86FT3z3cB5;
	Tue, 10 Mar 2026 21:42:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773139376;
	cv=none; b=fteJK0Ik5AVBcHBIu4LmG1wmblkO7/7l9UkgNRSalEVn+pd2hi7Rc6X2ECMuzdtHcHUKbBbiX74x9mNBqzYWDI5Y8a2KQRM8KlGfRKS3I8WOeFYK8PCJkYV7pj/tzbpREIIXmnV6ASjA0Mqcpe89DygSbopJTRuM8gSN2DitrBPv4+IxDospoxSjGTJgr8gTeRkGY9xiskZdJrHPA3nh9TA9QodRlKgUGxuwuUoPJ7gGEZk61xryY0isPOI9d6pVcFZNmAQAeyJl84kymeX+0ocw/eM4P4W1eq2/krw3LCzzkV8zWbZ7u4FmrqNgtgLDBK4XBCF3Tz8CXGVGRH0cEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773139376; c=relaxed/relaxed;
	bh=9FN+TSPz+ltUzp9VbceUI7lOzqSaL3v1qzAWOwuafhg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=W9iQ/cOOu8YB13qz0Mk33zrVWtY1BrNhRjh/IIqiKVIXY3ENaokecUT45yLoxCAgvCWTDaIXCD65JSpj+ebdmkXYVYkDhZnZItAmrLIut8NCy4rIY+xJU3EjYq0znzmY3sUEPfPhaXWI7+kEYiCEzWPE+cUWgEhg0L0Dc7E44/fFEztFVxaMo9SZbps2+QEEeyH0MIflsJEnckCfucz0nAjoHVfEvJYyUFot61KSixjLc+iSqnQLHboCGh4HnYvAcehSRRfEkXCj+tZXL8qg7yQj7s7fPK/Ggf2fp+PuDjjx0L0WoXxwDliltEIC6fWLho/EQ4BUypR8NZaKnuhrbw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=oMYZgNyO; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=vbabka@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=oMYZgNyO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=vbabka@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVVp82CDtz2yFY
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2026 21:42:56 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 16CAF600AE;
	Tue, 10 Mar 2026 10:42:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBAC8C19423;
	Tue, 10 Mar 2026 10:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773139373;
	bh=3m4rwlvUFZd/0jBCZKj1ip7fgfW/CYTB+r1GS0xW8Zg=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=oMYZgNyO6Nw0x10/mkbxLbNa3w2PDuEiOMmiGOmxmWdsAOPsFzktLpRkbixkawRet
	 tj5YdvGt4sREgy8o/poBYWzHo4fTpp++pr5X2UMGlzKyJcO8Kg96Ns1yjhKZcd7txE
	 5EvJ6fTGwznHjJt6UprwMhfYioMNPBGVGqIg552QXnbdj/17cl6RZWlu6qMSpQI5f3
	 fLdCzn89uMtWTne6Wzrz92K8HderdBAcLDYXaxhjU2rrPCC8xYXawirkfsEz2sAUxV
	 Bw96P6McCBiZSVtvb2iwX4n2pJqHd42GbNC+AhmVlZYV+E4WHOf2LHjNboUFKYdqJn
	 gzzi3dYFxAlaA==
Message-ID: <d987d8a2-07b5-477c-9ca1-23eb7947768d@kernel.org>
Date: Tue, 10 Mar 2026 11:42:47 +0100
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
From: Vlastimil Babka <vbabka@kernel.org>
Subject: Re: [PATCH v1 0/4] mm: move vma_(kernel|mmu)_pagesize() out of
 hugetlb.c
Content-Language: en-US
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: Pedro Falcato <pfalcato@suse.de>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Dan Williams <dan.j.williams@intel.com>
References: <20260306101600.57355-1-david@kernel.org>
 <4rzf46kw6hq3b5ivv7cvgyza4yfrvk2shrncytobabxef644nm@wzu2bw63co37>
 <371cf0f7-4b30-4d8c-99e7-ae0543f8be23@lucifer.local>
 <5eae6c52-c3f9-407e-8fb8-01a950b282bf@kernel.org>
 <9172a09f-f014-4a76-b813-8f0c79fbe2f4@lucifer.local>
 <19fdac31-0d2e-4662-b3a4-02555d8e4221@kernel.org>
In-Reply-To: <19fdac31-0d2e-4662-b3a4-02555d8e4221@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/9/26 16:07, David Hildenbrand (Arm) wrote:
> On 3/9/26 14:42, Lorenzo Stoakes (Oracle) wrote:
>> On Fri, Mar 06, 2026 at 02:12:50PM +0100, David Hildenbrand (Arm) wrote:
>>> On 3/6/26 12:19, Lorenzo Stoakes (Oracle) wrote:
>>>>
>>>> Yeah I noticed this also :>) Assumed it was a new way of doing things somehow?
>>>> :P
>>>
>>> "--cc-cover" is apparently not the git default on my new machine.
>>>
>>> "See, I CCed you, I totally did not try to sneak something in. Oh, I
>>> messed up my tooling, stupid me ...". :)
>> 
>> ;)
>> 
>> Wasn't aware of that option actually, handy!
> 
> On my old setup I had a script that would, in addition, also CC anybody
> CC'ed on individual patches on the cover letter. Was quite useful for
> larger series where you don't want to spam people with unrelated patches.

I had such a script too.

> Still have to set that back up.

But now "b4 send" does that for me automatically. And I don't need to do a
"git format-patch" beforehand. It also does the equivalent of "--cc-cover".

