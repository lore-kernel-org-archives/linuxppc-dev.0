Return-Path: <linuxppc-dev+bounces-16141-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EFFDC44500
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Jan 2026 10:49:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dxd995qdyz2ySb;
	Thu, 22 Jan 2026 21:49:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769078957;
	cv=none; b=jLY3cnPvN2ZhFsJ7McVsi8W83A6qHPxxIzzsQcLfDlRspqIzHj8c7FYlMJSOQndRtOuv7d2Dg9ks4s0G7UkHQZBu3oWyCTpzWl9sE5cSZVRaeDi8xQzxhecmbhAoH4Qgp2wMjwM5H/gP2SlS94i9OU+NTtwrkL6+B+439VDpkl5RIrJjR9YmRWJRqL9KYH0QAYrLOZqqE1gMUkV7CXTDnlax6eN/Wr9ql43rhHnQDzt8JRVOqg3MgjzdiKykHnfDyHdCVI+Q+jYqn+lkeN7N3t/91yWoEZ1bpqMyvJfEN+Nj+PbjOV094JEroBNqLuZo4ARnOTzVr9pLSvsITHyXWg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769078957; c=relaxed/relaxed;
	bh=RDNgypXJKzKaziR0xdy5j5Cl96ZZg0vzrmgy/aiqRl8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=bCkVqNVbjCjuvJr5RfNNe/2Swu8onH2euB09X/Lu5ldtV5i8DhaD+YnMr7ZoGzCYlERod8W5k68eWQ1W6QXDiJcnCkiGJ+nol7am5aZPD83koiZqphxVJK/VCfokW1F7iabt1Kc2ix9tKWU57d0uEqyruSb2+ocDUiLkYHi+QCyHkWT6AlAXzh837TZVMKMfZkkVW78n7iabbzZUaC8+D3Mk2t4NS1iPpaeou+x4Y/GzNHMmY1oh/2SkV9mHP5NJ/KdW3xLfouaZiAhVIVY3tVQlK1R49XKkgV+Nb+8h4KTwKm97XuDjGmsy6Q+xDvKcpZjPpftM5w3/X1fQZyS9sQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=sgw3bjbF; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=sgw3bjbF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dxd986NxKz2xS5
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jan 2026 21:49:16 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A328A600CB;
	Thu, 22 Jan 2026 10:49:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F565C19424;
	Thu, 22 Jan 2026 10:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769078954;
	bh=899+KQ+C/AkTUNVlsmhBnoYgZLqrkK6jNm34LzhoNKM=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=sgw3bjbF4+A2uz4fYgMk21kNejazmNux1LHEv+VBMyYrDq9lnU0+K4cPkrJhl2cum
	 eCm3R5DsbLP1VgZ+nbXUHq+rgVowHOls7zOk/M4am6e0Tx1rAbwgcr/fG4CDknlg+z
	 JXI0UvwFydzeRDhyE1sPZiWjjTvsApOJyd7DFFGKZGL2ENOSHquL0SsdX5rBYSr7gF
	 I+gFLvtwBKXfA9qbG+DPiklCfR02h8Yerzdqy/FYWHlAARzbfDfjs/giTqSYn1NjCM
	 fD2tsi9yoCAsxqN8f7a9sQV6NfjaVJfLo6EcYo8aRy3s88dNFlLEausclQgbDZW2UM
	 r8p1KredAYnrA==
Message-ID: <19755142-0f2a-4cdb-a746-50ff06e297a0@kernel.org>
Date: Thu, 22 Jan 2026 11:49:09 +0100
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
Subject: Re: [PATCH] powerpc/vdso: Provide clock_getres_time64()
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
Cc: "npiggin@gmail.com" <npiggin@gmail.com>, "luto@kernel.org"
 <luto@kernel.org>, "maddy@linux.ibm.com" <maddy@linux.ibm.com>,
 "tglx@kernel.org" <tglx@kernel.org>, "mpe@ellerman.id.au"
 <mpe@ellerman.id.au>, "vincenzo.frascino@arm.com"
 <vincenzo.frascino@arm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260114-vdso-powerpc-align-v1-1-acf09373d568@linutronix.de>
 <f45316f65a46da638b3c6aa69effd8980e6677b9.camel@siemens.com>
 <20260122104257-3124dc96-5916-4d25-bbce-9b868b30ee18@linutronix.de>
 <f0bee121-41cc-4162-8c02-2b279f54c11f@kernel.org>
Content-Language: fr-FR
In-Reply-To: <f0bee121-41cc-4162-8c02-2b279f54c11f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Again,

Le 22/01/2026 à 11:27, Christophe Leroy (CS GROUP) a écrit :
> Hi Thomas,
> 
> Le 22/01/2026 à 10:50, Thomas Weißschuh a écrit :
>> Hi Alexander,
>> Could you also share your configuration?
> 
> I've just been able to reproduce it with ppc64_defconfig + 
> CONFIG_CC_OPTIMIZE_FOR_SIZE
> 
>    VDSO32L arch/powerpc/kernel/vdso/vdso32.so.dbg
> arch/powerpc/kernel/vdso/vdso32.so.dbg: dynamic relocations are not 
> supported
> make[2]: *** [arch/powerpc/kernel/vdso/Makefile:79: arch/powerpc/kernel/ 
> vdso/vdso32.so.dbg] Error 1
> make[1]: *** [arch/powerpc/Makefile:388: vdso_prepare] Error 2
> make: *** [Makefile:248: __sub-make] Error 2
> 

Comes from here, a call to memset():

000007c0 <__c_kernel_clock_getres>:
  7c0:   94 21 ff d0     stwu    r1,-48(r1)
  7c4:   7c 08 02 a6     mflr    r0
  7c8:   bf a1 00 24     stmw    r29,36(r1)
  7cc:   7c 7e 1b 78     mr      r30,r3
  7d0:   7c bd 2b 78     mr      r29,r5
  7d4:   7c 9f 23 78     mr      r31,r4
  7d8:   38 a0 00 10     li      r5,16
  7dc:   90 01 00 34     stw     r0,52(r1)
  7e0:   38 80 00 00     li      r4,0
  7e4:   38 61 00 08     addi    r3,r1,8
  7e8:   48 00 00 01     bl      7e8 <__c_kernel_clock_getres+0x28>
                         7e8: R_PPC_REL24        memset
  7ec:   7f c4 f3 78     mr      r4,r30
  7f0:   7f a3 eb 78     mr      r3,r29
  7f4:   38 a1 00 08     addi    r5,r1,8
  7f8:   4b ff f8 09     bl      0 <__cvdso_clock_getres_common>
  7fc:   2c 03 00 00     cmpwi   r3,0
  800:   40 82 00 24     bne     824 <__c_kernel_clock_getres+0x64>
  804:   38 00 00 f7     li      r0,247
  808:   7f c3 f3 78     mr      r3,r30
  80c:   7f e4 fb 78     mr      r4,r31
  810:   44 00 00 02     sc
  814:   40 e3 00 08     bns+    81c <__c_kernel_clock_getres+0x5c>
  818:   7c 63 00 d0     neg     r3,r3
  81c:   39 61 00 30     addi    r11,r1,48
  820:   48 00 00 00     b       820 <__c_kernel_clock_getres+0x60>
                         820: R_PPC_REL24        _restgpr_29_x
  824:   2c 1f 00 00     cmpwi   r31,0
  828:   41 82 00 14     beq     83c <__c_kernel_clock_getres+0x7c>
  82c:   81 21 00 0c     lwz     r9,12(r1)
  830:   91 3f 00 00     stw     r9,0(r31)
  834:   81 21 00 14     lwz     r9,20(r1)
  838:   91 3f 00 04     stw     r9,4(r31)
  83c:   38 60 00 00     li      r3,0
  840:   4b ff ff dc     b       81c <__c_kernel_clock_getres+0x5c>


