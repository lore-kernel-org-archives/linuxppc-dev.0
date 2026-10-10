Return-Path: <linuxppc-dev+bounces-29182-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38BAACA9EBE
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Oct 2026 16:03:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j27nm1nxpz2yqT;
	Sun, 11 Oct 2026 03:03:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=85.215.255.50 arc.chain=strato.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791648236;
	cv=pass; b=Dd96a5bYwBzrHnwrMaEEUQs3nDvXdVQFn5LxToYMRM0NRdEY5sJf7oCzbX0GzP0Wx2N9ywYAYxTF17CAfaZ2G9Hj+rqmvX+uTm3oIYf2VKU27zTya02Cy7XCiqquvR5G1jisJfWP3P++qah3fj1MWcmBHaZf2bnhgSrdJxX/wrdMTw69QIp9ab3QDCqw/8zg7gy0hwE3fzMrpGtJ8AbJsN5+fkXIDL05V3T8+/6Co4gDE4V4HDCty7lgrDhxnHTgGGJgtUEVHzryi1l7b4AQM1fnLVN4Lij+HjZrqxlDNRfHRfRsKw3cMYVID99SMWTU5XXiJXD9q4p+OhXwwwvBOw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791648236; c=relaxed/relaxed;
	bh=8Dn09naFX34dB8eLy8oKRKU9r7nHmJhKKpa22bIqJYs=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=o0skq26HB/nI0Xj6bcswl/PmdlNUqQ6UUmtoW3zQmFtwq/v54zmILip6euhew3puZ1dZubGWH5VkFjEI/WSLiW7fXGlPbdc6qqcDrFm4v2HJWtqOCRNvD7qurhG0CPg22yVRj++nq4HA6vbgoAch4ITZu5hEx5KORqdncGNiXGBRJVO/Nb5nAZseeb5yACuujJiJLXtsMPRbosnNb9Dr33/x3aZe1F1y+59b6uE7JNlOVS+ON2c4msNbr3HljrPZU6PZ1VmXdQQaowSIAUoSNL8xC/NJkr3Ed+hUYVJmrRXYCRydWIToYKG+v2jqVyPqS2bdaCzqKTIlHyTl09/yHQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=Frpi7HjM; dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=BC3njdNb; dkim-atps=neutral; spf=pass (client-ip=85.215.255.50; helo=mo4-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org) smtp.helo=mo4-p01-ob.smtp.rzone.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=Frpi7HjM;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=BC3njdNb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=mo4-p01-ob.smtp.rzone.de (client-ip=85.215.255.50; helo=mo4-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j27ng2Rrgz2xnQ
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Oct 2026 03:03:48 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791648181; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=I0/tEQDH63gdnc/RHpijRQd2irgTXY2u5sdn4FaZWi/Bi4YDfmZLyu56EbJ7FxZtx1
    va4juYfqzke8sMoTl90NpHsyNJDxVfIXGnla/UHcFo04dpRPuzjMON9SSR/BvMIs8B2Q
    CaXljBwhyBFNfRVBcLM/OMoTTIUUuAzRjCeHAJPNXHijNEQ6zUqe5DPu2bPAUGc2Vakk
    v3rpGp/3qSuU0G3dcJ82LtMmcx70noyjCNFVF3gZ/ET6jrJlp7qvbTkJnyGePET7rJSO
    /5emxJnzcEv5xX9emf1uXN7nnO7qeFGXfR7DD7CtNj18pEUHon0z5xbNGsVfJrudtsZq
    ISVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1791648181;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=8Dn09naFX34dB8eLy8oKRKU9r7nHmJhKKpa22bIqJYs=;
    b=sAFroKuwVFLrJxOCGSLp+vyADD55tBJTELb6jXK46xgCxZnAjbm5/eOilaIWJ+nSJk
    dS86GiZA4Zl/XWt4hfg2QNAd2WitIpL1DMCiaWm+x7ifOzxnfbNlQa93HSxV7aFtgYta
    jJkiofONFNbQIogG2p8vhAQS+GLGhckBm3aYIkd1Zm+XLsUfGYog4T1tDKKyq+4KUori
    BzICd6VGFJ9xEMyXfZ+sSObHWPpjzIn9GLYuNkzxfyV0Us4ujZF4L57E+vlUvIqtz6Jn
    u0UY4uW6yypZAXs/rnalyiq70DFQVA6FdWsSpzC0sowD8NFfbEdrk50RRsnkV92peyh2
    VqQw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1791648181;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=8Dn09naFX34dB8eLy8oKRKU9r7nHmJhKKpa22bIqJYs=;
    b=Frpi7HjM00W/fu4y5Vj5szP9PeuCe3/CewrtwPBJZ9FdD/RMnImDivVPF6FzwIxa3a
    Ve4kSmUrWUG3Q+Yhv9Gr5SMiqJqz8U2F/OqoKsGST76Rw6y4Y1VaElX6obs8YKxF3TL2
    GtPdkVeRHS9aLbtYODUXdNatzLU0MdK9ppBmL2GAzaxGv25PozTtv+2dfMONchzOqRq2
    y0+0cllknQtsv9rpDbpBtfM3niYOgvFFJii4FgB2/loleIOhqFcNuWiOWFtvn81E0RLq
    LQ2UIuEfv1DQkMRNo2KGMpSRHUumZtMnykV+agf/bty0cOg7OsLmXFSKBLZA0b8Lq6RG
    JVMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1791648181;
    s=strato-dkim-0003; d=xenosoft.de;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=8Dn09naFX34dB8eLy8oKRKU9r7nHmJhKKpa22bIqJYs=;
    b=BC3njdNbFvBiKxTqU7OxtDyrx9RW8QnUoDN4SmmDObwTIEO9owv2/fYnDvRjuhB9VQ
    /pQsIWyb0XOWzkRXDQCw==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr4thIFiqT9BURIC+m7Xc="
Received: from void-ppc.a-eon.tld
    by smtp.strato.de (RZmta 55.6.2 DYNA|AUTH)
    with ESMTPSA id e0463b29AG30iMc
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 10 Oct 2026 18:03:00 +0200 (CEST)
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
Message-ID: <0a1c01c3-d50b-90eb-6736-16628ed18099@xenosoft.de>
Date: Sat, 10 Oct 2026 18:02:59 +0200
X-Mailer: BrassMonkey/34.3.2.1
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
In-Reply-To: <aoFPwEi0iQRSmmSu@rli9-mobl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/16/2026 07:50 AM, Philip Li wrote:
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
When will the patch be integrated into the kernel? Would it be possible 
to integrate the patch into kernel 7.4?
Yesterday I adapted the patch for the stable long-term kernel 6.12.

Link to the patch for the kernel 6.12: 
https://raw.githubusercontent.com/chzigotzky/kernels/refs/heads/6_12/patches/X1000/pas_pci_init_v6.patch

-- Christian

-- 
Sent with BrassMonkey 34.3.2.1 (https://github.com/chzigotzky/Web-Browsers-and-Suites-for-Linux-PPC/releases/tag/BrassMonkey_34.3.2.1)


