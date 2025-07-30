Return-Path: <linuxppc-dev+bounces-10467-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C1AC87FCB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jul 2025 15:20:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bsbWT3Nbdz3bm7;
	Thu, 31 Jul 2025 01:20:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=93.17.236.30
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753888837;
	cv=none; b=e2vvpc1ELI0eV2+5pleG9JM/zme/kcWxAnB/vrKqeiunBVGQrocaiLVy10H1v24pU3pNgXLeByCJrGoP111WfDjLkucOCV9m3jGsierE2n+KwBI6eNjEonLzt1X9kqyqk7YpoLDvB5PDYlg+PwhHROlZS4VpbXzShwSToWhA9unqzUgUr36yROd2fNDymxBNPGcVEd7zwwChp4kiW8L1E5b2t8Cy9mIgeJZ44YuOb3CbwMPYDu//JfkAY/7jHA9dTmzFTk3OuZ93WkLTfOc3JJAFEqJYFNL2G/z6aMTYHswK5k+15JcdofJoT6en1x61IVMjyPXn0zMkQWVUD55RNw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753888837; c=relaxed/relaxed;
	bh=eRRAgdX8JbLQtHGgAl40TW5ZpMol7yVqAYnv35H4ysc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eHR3lKdR9TEIvdXJmVP0OguH0qQxuyhjG7KKp7lua2je5OoVWQM6mkzwwMQApkrmuEknmQ2hsSVjT1rzb35n0jzwk8jvvNvztg6Bgf8F6C/ehpEJtmRfYvQ8GMTTNRXFg1yiL5m/t9yLayPG/C5Y7mTi1JyjUVRFf1qWtOYQTSKYQQr/I3a0E4GrA0gJI81ToAasAx8/oXUkj/KQTh1JR8COT6lXp4cg8E2JNaiPc4pT82beJ+qUGt27IeKfBm6frNSXYT9dEQVJZfv+m2r6FYxP+TJ/CNw4ptE2YGcEawCXIaF6mFACfoQ/SQn9jVhcBthzar7zBsfWL+lHJ05QpA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass (client-ip=93.17.236.30; helo=pegase1.c-s.fr; envelope-from=christophe.leroy@csgroup.eu; receiver=lists.ozlabs.org) smtp.mailfrom=csgroup.eu
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr; envelope-from=christophe.leroy@csgroup.eu; receiver=lists.ozlabs.org)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bsbWS3Kv9z3bm3
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jul 2025 01:20:36 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4bsZPW0HHCz9snk;
	Wed, 30 Jul 2025 16:30:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xsGl8q2AKTJb; Wed, 30 Jul 2025 16:30:22 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4bsZPH0JDCz9sps;
	Wed, 30 Jul 2025 16:30:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 042698B76E;
	Wed, 30 Jul 2025 16:30:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id jj0F2l6esWm3; Wed, 30 Jul 2025 16:30:10 +0200 (CEST)
Received: from [10.25.207.160] (unknown [10.25.207.160])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id CBF298B763;
	Wed, 30 Jul 2025 16:30:10 +0200 (CEST)
Message-ID: <f10f6457-1a19-47cf-86d1-eb787badd6dd@csgroup.eu>
Date: Wed, 30 Jul 2025 16:30:10 +0200
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
Subject: Re: linux-next: build warning after merge of the jc_docs tree
To: Jonathan Corbet <corbet@lwn.net>, Stephen Rothwell
 <sfr@canb.auug.org.au>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Randy Dunlap <rdunlap@infradead.org>
Cc: PowerPC <linuxppc-dev@lists.ozlabs.org>,
 Vishal Parmar <vishistriker@gmail.com>,
 Brigham Campbell <me@brighamcampbell.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20250730102931.6334022c@canb.auug.org.au>
 <87cy9hx272.fsf@trenco.lwn.net>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <87cy9hx272.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 30/07/2025 à 15:01, Jonathan Corbet a écrit :
> Stephen Rothwell <sfr@canb.auug.org.au> writes:
> 
>> Hi all,
>>
>> After merging the jc_docs tree, today's linux-next build (htmldocs)
>> produced this warning:
>>
>> Documentation/arch/powerpc/index.rst:7: WARNING: duplicated entry found in toctree: arch/powerpc/htm
>>
>> Introduced by commit
>>
>>    c361f76da696 ("docs: powerpc: Add htm.rst to table of contents")
>>
>> interacting with commit
>>
>>    19122a7c28ed ("docs: powerpc: add htm.rst to toctree")
>>
>> from the powerpc tree.
> 
> Did that just get added there?  I've had that fix since early June...I'd
> rather not drop it (and have to redo my 6.17 pull request) now if
> possible...
> 

There was a ping from Randy about it recently so that Maddy added it the 
powerpc tree, see 
https://lore.kernel.org/all/5ac25ceb-023d-409d-8e7e-014d010c5028@infradead.org/

Christophe

