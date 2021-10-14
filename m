Return-Path: <SRS0=Ntje=PC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FAFC433F5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Oct 2021 08:34:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E80160EE5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Oct 2021 08:34:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4E80160EE5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HVN3z5qWGz2yPP
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Oct 2021 19:34:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HVN3V0jHfz2xr1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Oct 2021 19:33:55 +1100 (AEDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4HVN3N1VLcz9sSK;
 Thu, 14 Oct 2021 10:33:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MLltOqoChzB3; Thu, 14 Oct 2021 10:33:52 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4HVN3M5L7mz9sSL;
 Thu, 14 Oct 2021 10:33:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id A01868B788;
 Thu, 14 Oct 2021 10:33:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id evMA27PZM4fu; Thu, 14 Oct 2021 10:33:51 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.231])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 74C418B763;
 Thu, 14 Oct 2021 10:33:50 +0200 (CEST)
Subject: Re: [RESEND PATCH v4 0/8] bpf powerpc: Add BPF_PROBE_MEM support in
 powerpc JIT compiler
To: David Laight <David.Laight@ACULAB.COM>,
 'Hari Bathini' <hbathini@linux.ibm.com>,
 "naveen.n.rao@linux.ibm.com" <naveen.n.rao@linux.ibm.com>,
 "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "ast@kernel.org"
 <ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>
References: <20211012123056.485795-1-hbathini@linux.ibm.com>
 <8091e1294ad343a88aa399417ff91aee@AcuMS.aculab.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <61bc0e8e-8ab9-f837-1b44-1e193567fff7@csgroup.eu>
Date: Thu, 14 Oct 2021 10:33:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <8091e1294ad343a88aa399417ff91aee@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
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
Cc: "songliubraving@fb.com" <songliubraving@fb.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
 "andrii@kernel.org" <andrii@kernel.org>,
 "kpsingh@kernel.org" <kpsingh@kernel.org>,
 "paulus@samba.org" <paulus@samba.org>, "yhs@fb.com" <yhs@fb.com>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kafai@fb.com" <kafai@fb.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 14/10/2021 à 10:15, David Laight a écrit :
> From: Hari Bathini
>> Sent: 12 October 2021 13:31
>>
>> Patch #1 & #2 are simple cleanup patches. Patch #3 refactors JIT
>> compiler code with the aim to simplify adding BPF_PROBE_MEM support.
>> Patch #4 introduces PPC_RAW_BRANCH() macro instead of open coding
>> branch instruction. Patch #5 & #7 add BPF_PROBE_MEM support for PPC64
>> & PPC32 JIT compilers respectively. Patch #6 & #8 handle bad userspace
>> pointers for PPC64 & PPC32 cases respectively.
> 
> I thought that BPF was only allowed to do fairly restricted
> memory accesses - so WTF does it need a BPF_PROBE_MEM instruction?
> 


Looks like it's been added by commit 2a02759ef5f8 ("bpf: Add support for 
BTF pointers to interpreter")

They say in the log:

     Pointer to BTF object is a pointer to kernel object or NULL.
     The memory access in the interpreter has to be done via 
probe_kernel_read
     to avoid page faults.
