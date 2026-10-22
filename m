Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58DE606A319
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Oct 2026 16:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=igDPq65G;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=z52wK+qT
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j9XFT18wvz2y7W;
	Fri, 23 Oct 2026 03:50:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=81.169.146.169 arc.chain=strato.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792687805;
	cv=pass; b=nl2CQJUaeDxJn6p7UzCAiaCpyuc93SRD08WqPGfA4tmNqVYW54Cl/zv9kA80VBtKN0EqRZJdNQnO31tlHlKusDsgyNOJIeZXd3aWs/Vmu+AiBxu9aVtVRddSAv6SbpEHFatd4PXBDLYGuNsFawKsmyvLkvc4HfwU7y2hzI7QtnxtyTw3MrgXhkYyZGvXfLRslekO/To4hvDjFlKp2od7w9jaL1fceDwKvah8FQhUt8QkaLUvts5Axs+Z2Krrl/U2z7VdptjKNbGI8eJ/N0Wv+fMr7t1aNMm1foT0nVhm9zEPm9o7PQ6QK03mIZE5g30UwiSt0p1eFMAc6/16kQF/Gg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792687805; c=relaxed/relaxed;
	bh=c9UuZNrtT9j3BmRS2G0fSk+x18niOMWM7XsMCgG28vk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=OEJAmQ6b0/i5UF0EiQuqh4BKN/telUvTPHL5gB7edLsGPqGhfMfcynltt3fRZ6YwSZpZ6B2v1R5wcd8TSB0FYuTkrdqMIzssQ9jIxXEApEeNMsYYUox/tBV1z83sKy9xxjRudt75Z0gho3mioGpHmjYKJPgIl74lgAb/fAhVmzDZkUPWTpMe1kr5Xfqt7xtThc1FrP/wS46gmkUqxmqUnJsxQblhyaA+HwLY+bp/tN8lo1chtSZHwsTQ38Kgi+yviXj4X8cugnOGaiY5P1tT70zCgzanJTD09+IxHfN2f2RGkss0aNUoqNbEHL9wVvcKIhHEqk9yrtAmTa2celDmgw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=igDPq65G; dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=z52wK+qT; dkim-atps=neutral; spf=pass (client-ip=81.169.146.169; helo=mo4-p02-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org) smtp.helo=mo4-p02-ob.smtp.rzone.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=igDPq65G;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=z52wK+qT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=mo4-p02-ob.smtp.rzone.de (client-ip=81.169.146.169; helo=mo4-p02-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org)
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j9XFN6K3rz2xKx
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2026 03:49:59 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792687766; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=bgvjnoE5/u/B6zWjKIKwHSbWLwFKSHpsIjgnRILwqNAOEjtT7VJxIYjlQ2iH+Drzdw
    UgwwyCSNqS23El37iJjfCOGGxob53z5i4JagxCo25i3M2ZI6nCcBcTqQH6fPZWSon+kr
    2uKIImRfutLMoMCKGWYAeDlxgG2IhE8YX7cJGqjZR3CKJ8MMFgS+U6EWiyXW/a/s1xm6
    HPcATaVE1E57O/6OkDxwzSxFkHy93koAI4GtKtmd9ONdPvQh+XP/ii67TIP1YGvY+wkQ
    3JIPRCHcZErS04hzaLLqh2GEVNKSGnDmGmri94WV0DvTrbdAOgObQNUHHo75ExD+oBv3
    i9uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792687766;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=c9UuZNrtT9j3BmRS2G0fSk+x18niOMWM7XsMCgG28vk=;
    b=KCdlwYjvNnegP8f5gWcbjh0z/HtNdHy0kXTm+vWysn0rqV9j1FM1rWGfKQBo31PqQ9
    UAPs7dVPgvD63UUpgr4YSB5McYD+oRnRmBGm9RRhPbJSMzkhpCyaaELliYXJC7ZgCS2b
    I/NXrUogYeLOCw43xhtQY3reoq68UxROv34+oLljIok4dFwgPDoCpniJelupIdwUY8R9
    Q3/BDwVt8q6VLscY0DNYJ0uAiNYM19+AiiTbMuH/s7d5MW/qNqpQe7+GxM/No9xfvlZI
    HRlucOZ7JKReqD53eQiaz2YaoP547OiwFXhOE5yUNvrpDBtBsfNlLTd+uUNJ+piuwumh
    b6Bw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792687766;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=c9UuZNrtT9j3BmRS2G0fSk+x18niOMWM7XsMCgG28vk=;
    b=igDPq65GiY2KB7hMRFvtg+dkeM+CXZwlVuohKOLeR00oh6yOpE/EcXOhp2lmAjE0pV
    ooJIEdWRfWWr7AveyNQlyUf5nKumoOlgW4Q+yhFp0TtlPQG5PVADYYp6whJkCpbT0vfX
    FNrMIYIQdSrsxmYcVPiopNuk3koUT6mxzRq+5d0rowYNXoUltpQqAdYK93OqN0m1qdfU
    kDmRjAR5lvO5w9j+jMtdeDlsXTLFMfhOUZrxkxjgraUMNrg3Mxrhfv0WWlqjeeDIivda
    B4LjIcRR9ZcX/I4eLZQxsoWgh4035Ot/F8ru1J3IraNFmaNTcoqHIa7FyXtEQnhaMPnv
    hk2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792687766;
    s=strato-dkim-0003; d=xenosoft.de;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=c9UuZNrtT9j3BmRS2G0fSk+x18niOMWM7XsMCgG28vk=;
    b=z52wK+qT5NOnKK45L+07BrB3LBDIX4ykBvT/OQNFcRnayROqiKoeC9uvmJIp9oXufA
    xgCjBUBBpscFHHPDrtBw==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr4thIFiqT9BURIS+l7Bng"
Received: from void-ppc.a-eon.tld
    by smtp.strato.de (RZmta 55.6.3 DYNA|AUTH)
    with ESMTPSA id e825d929MGnQXf5
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 22 Oct 2026 18:49:26 +0200 (CEST)
Subject: Re: [PATCH] Connecting the SB600's i8259 controller rather in
 pasemi's pci.c than in pasemi's setup.c.
To: Philip Li <philip.li@intel.com>
Cc: kernel test robot <lkp@intel.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 "(open list:LINUX FOR POWERPC \\(32-BIT AND 64-BIT\\))"
 <linuxppc-dev@lists.ozlabs.org>, linux-kernel@vger.kernel.org,
 oe-kbuild-all@lists.linux.dev, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 Darren Stevens <darren@stevens-zone.net>,
 Damien Stewart <hypexed@yahoo.com.au>, Christian Zigotzky <info@xenosoft.de>
References: <20260701125941.906-2-chzigotzky@xenosoft.de>
 <202608142355.4AeDorvg-lkp@intel.com>
 <5ad17e60-7c02-2cd9-7cad-0c14896b8f3d@xenosoft.de>
 <aoFPwEi0iQRSmmSu@rli9-mobl>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Organization: A-EON Open Source
Message-ID: <9baed4e5-2bc2-c3f9-9a27-24f7ec8dcbd9@xenosoft.de>
Date: Thu, 22 Oct 2026 18:49:25 +0200
X-Mailer: BrassMonkey/35.0.2
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aoFPwEi0iQRSmmSu@rli9-mobl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 16/08/26 07:50, Philip Li wrote:
> On Sat, Aug 15, 2026 at 11:56:56AM +0200, Christian Zigotzky wrote:
>> On 14/08/26 17:42, kernel test robot wrote:
>>> Hi Christian,
>>>
>>> kernel test robot noticed the following build warnings:
>>>
>>> [auto build test WARNING on powerpc/next]
>>> [also build test WARNING on powerpc/fixes linus/master v7.2-rc7
>> next-20260813]
>>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>>> And when submitting patch, we suggest to use '--base' as documented in
>>> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>>>
>>> url: https://github.com/intel-lab-lkp/linux/commits/Christian-Zigotzky/Connecting-the-SB600-s-i8259-controller-rather-in-pasemi-s-pci-c-than-in-pasemi-s-setup-c/20260813-054214
>>>
>>> All warnings (new ones prefixed by >>):
>>>
>>>>> arch/powerpc/platforms/pasemi/setup.c:217:6: warning: no previous
>> prototype for function 'nemo_init_IRQ' [-Wmissing-prototypes]
>>
>> This is the old patch.
> Sorry about this meaningless report, we will improve the bot to check
> new patches to avoid such report.
>
>> Here is the new patch with pasemi.h: https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20260801043458.12500-1-chzigotzky@xenosoft.de/
>>
>> Thanks
>>
>>
>>
>>
Hi All,

is it possible to add this patch to the kernel 7.4 too?

Thanks,
Christian

-- 
Sent with BrassMonkey 35.0.2 (https://github.com/chzigotzky/Web-Browsers-and-Suites-for-Linux-PPC/releases/tag/BrassMonkey_35.0.2)


