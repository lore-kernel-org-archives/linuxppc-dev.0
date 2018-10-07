Return-Path: <SRS0=LxjK=MT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499AAC65C1B
	for <linuxppc-dev@archiver.kernel.org>; Sun,  7 Oct 2018 16:45:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFBE22087C
	for <linuxppc-dev@archiver.kernel.org>; Sun,  7 Oct 2018 16:45:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFBE22087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Sq9q4KnyzF36g
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 03:45:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Sq7Q4szgzF36T
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Oct 2018 03:43:30 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42Sq7B4mM9z9ttBZ;
 Sun,  7 Oct 2018 18:43:18 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id imktGuLurmfq; Sun,  7 Oct 2018 18:43:18 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42Sq7B4Gfmz9ttBL;
 Sun,  7 Oct 2018 18:43:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id E6F188B780;
 Sun,  7 Oct 2018 18:43:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id Wi7ZNpDUfyuo; Sun,  7 Oct 2018 18:43:26 +0200 (CEST)
Received: from PO15451 (unknown [192.168.232.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 836608B74B;
 Sun,  7 Oct 2018 18:43:26 +0200 (CEST)
Subject: Re: [PATCH v5 1/9] book3s/64: avoid circular header inclusion in
 mmu-hash.h
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
References: <cover.1538687073.git.christophe.leroy@c-s.fr>
 <3ae99c06f76fc89de00b801a6e839952850c7abb.1538687074.git.christophe.leroy@c-s.fr>
 <8055896d-f1cd-3560-2f08-ab367270beae@c-s.fr>
 <87r2h3i6np.fsf@concordia.ellerman.id.au>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <0a699e95-1f07-2ab1-47c2-84d7bce1bdda@c-s.fr>
Date: Sun, 7 Oct 2018 18:43:26 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87r2h3i6np.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 06/10/2018 à 14:47, Michael Ellerman a écrit :
> Christophe LEROY <christophe.leroy@c-s.fr> writes:
> 
>> The serie has been successfully compiled tested at
>> http://kisskb.ellerman.id.au/kisskb/head/358723b36b126a381d827c82d04ee226321416b2/
> 
> I guess we need to turn on BPF_JIT in some configs :)
> 
> This works (builds), but not runtime tested:
> 
> diff --git a/arch/powerpc/net/bpf_jit32.h b/arch/powerpc/net/bpf_jit32.h
> index 6f4daacad296..dc50a8d4b3b9 100644
> --- a/arch/powerpc/net/bpf_jit32.h
> +++ b/arch/powerpc/net/bpf_jit32.h
> @@ -106,9 +106,8 @@ DECLARE_LOAD_FUNC(sk_load_byte_msh);
>   	} while (0)
>   #else
>   #define PPC_BPF_LOAD_CPU(r)     \
> -	do { BUILD_BUG_ON(FIELD_SIZEOF(struct thread_info, cpu) != 4);		\
> -		PPC_LHZ_OFFS(r, (1 & ~(THREAD_SIZE - 1)),			\
> -				offsetof(struct thread_info, cpu));		\
> +	do { BUILD_BUG_ON(FIELD_SIZEOF(struct task_struct, cpu) != 4);		\
> +		PPC_LHZ_OFFS(r, 2, offsetof(struct task_struct, cpu));		\
>   	} while(0)
>   #endif
>   #else
> 

Thanks, I'll take that.

Christophe
