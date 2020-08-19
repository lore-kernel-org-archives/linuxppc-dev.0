Return-Path: <SRS0=nuQA=B5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116F5C433E1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Aug 2020 01:21:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F7C02075E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Aug 2020 01:21:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F7C02075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BWVPG5PJ5zDqsq
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Aug 2020 11:21:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=perches.com
 (client-ip=216.40.44.121; helo=smtprelay.hostedemail.com;
 envelope-from=joe@perches.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=perches.com
Received: from smtprelay.hostedemail.com (smtprelay0121.hostedemail.com
 [216.40.44.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BWVM64NcBzDqVb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2020 11:20:00 +1000 (AEST)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay07.hostedemail.com (Postfix) with ESMTP id A882B181D330D;
 Wed, 19 Aug 2020 01:19:56 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: wash41_4712ceb27023
X-Filterd-Recvd-Size: 2169
Received: from XPS-9350.home (unknown [47.151.133.149])
 (Authenticated sender: joe@perches.com)
 by omf13.hostedemail.com (Postfix) with ESMTPA;
 Wed, 19 Aug 2020 01:19:55 +0000 (UTC)
Message-ID: <3ca05f10dec479a70f6c33274ded8d4fab9c01ec.camel@perches.com>
Subject: Re: [PATCH v2 11/25] powerpc/signal: Refactor bad frame logging
From: Joe Perches <joe@perches.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael
 Ellerman <mpe@ellerman.id.au>
Date: Tue, 18 Aug 2020 18:19:54 -0700
In-Reply-To: <fa094445c119fc00315e1c13783b493346306c6a.1597770847.git.christophe.leroy@csgroup.eu>
References: <cover.1597770847.git.christophe.leroy@csgroup.eu>
 <fa094445c119fc00315e1c13783b493346306c6a.1597770847.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
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

On Tue, 2020-08-18 at 17:19 +0000, Christophe Leroy wrote:
> The logging of bad frame appears half a dozen of times
> and is pretty similar.
[]
> diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
[]
> @@ -355,3 +355,14 @@ static unsigned long get_tm_stackpointer(struct task_struct *tsk)
>  #endif
>  	return ret;
>  }
> +
> +static const char fm32[] = KERN_INFO "%s[%d]: bad frame in %s: %p nip %08lx lr %08lx\n";
> +static const char fm64[] = KERN_INFO "%s[%d]: bad frame in %s: %p nip %016lx lr %016lx\n";

Why not remove this and use it in place with
%08lx/%016x used as %px with a case to (void *)?

> +void signal_fault(struct task_struct *tsk, struct pt_regs *regs,
> +		  const char *where, void __user *ptr)
> +{
> +	if (show_unhandled_signals)
> +		printk_ratelimited(regs->msr & MSR_64BIT ? fm64 : fm32, tsk->comm,
> +				   task_pid_nr(tsk), where, ptr, regs->nip, regs->link);

	pr_info_ratelimited("%s[%d]: bad frame in %s: %p nip %016lx lr %016lx\n",
			    tsk->comm, task_pid_nr(tsk), where, ptr,
			    (void *)regs->nip, (void *)regs->link);


