Return-Path: <SRS0=wZlq=MS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215ACC65C30
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 12:24:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCEA1206B2
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 12:24:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCEA1206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42S5RD2gyKzF3cY
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 22:24:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42S5Mb5JkvzF3bx
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Oct 2018 22:21:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42S5Mb0Zxjz9s1x;
 Sat,  6 Oct 2018 22:21:31 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v4 0/9] powerpc: Switch to CONFIG_THREAD_INFO_IN_TASK
In-Reply-To: <cover.1538541946.git.christophe.leroy@c-s.fr>
References: <cover.1538541946.git.christophe.leroy@c-s.fr>
Date: Sat, 06 Oct 2018 22:21:30 +1000
Message-ID: <871s93jmet.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> The purpose of this serie is to activate CONFIG_THREAD_INFO_IN_TASK which
> moves the thread_info into task_struct.
>
> Moving thread_info into task_struct has the following advantages:
> - It protects thread_info from corruption in the case of stack
> overflows.
> - Its address is harder to determine if stack addresses are
> leaked, making a number of attacks more difficult.

We need to fixup bpf_jit32.h:

#ifdef CONFIG_SMP
#ifdef CONFIG_PPC64
#define PPC_BPF_LOAD_CPU(r)		\
	do { BUILD_BUG_ON(FIELD_SIZEOF(struct paca_struct, paca_index) != 2);	\
		PPC_LHZ_OFFS(r, 13, offsetof(struct paca_struct, paca_index));	\
	} while (0)
#else
#define PPC_BPF_LOAD_CPU(r)     \
	do { BUILD_BUG_ON(FIELD_SIZEOF(struct thread_info, cpu) != 4);		\
		PPC_LHZ_OFFS(r, (1 & ~(THREAD_SIZE - 1)),			\
				offsetof(struct thread_info, cpu));		\
	} while(0)
#endif
#else
#define PPC_BPF_LOAD_CPU(r) do { PPC_LI(r, 0); } while(0)
#endif


cheers
