Return-Path: <SRS0=k2O5=MV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23789C64EAD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 10:57:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A0A42064E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 10:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yqc/dF8N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A0A42064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42TvLw2RqHzF3BG
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 21:57:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Yqc/dF8N";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Yqc/dF8N"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42TvJ00Xc0zF38q
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Oct 2018 21:54:39 +1100 (AEDT)
Received: by mail-pg1-x542.google.com with SMTP id y18-v6so641724pge.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Oct 2018 03:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6uHAiEZ/VNBNmc1syn3PfOTCnnrtxC24MfWBCzSHuzQ=;
 b=Yqc/dF8NcmERqeVmdsbeTK53lG8eqEft/t7CGli3vMBFT80LpTeIjSSH7ZJZXl+3Y5
 x8UDOVZ6uoowb1ftEB+nSp+xZVmYBpfsCgIQzGCGEcwQqOaBqjX3eu443Ujt38d6SJPO
 O33Yl6URbal49N3EnoYWWKXxcVT2D1wZH9h/vhJgfgaEEljHcLup/vD2bYK2X+H3NHwy
 opSQY8HLvt1r1jCuTPY597nTPizin3NfkLCgS6BcBkpLcJkVrVBaQPCY3MniAz0dbCKC
 r7EUPRoOGFKBWxW3f6wxcPPTy1ygDC/nG/7O9z8FKzAOaAq4i9YkYm5ZaNGpu8FGMzKS
 7TPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6uHAiEZ/VNBNmc1syn3PfOTCnnrtxC24MfWBCzSHuzQ=;
 b=eL7xCFk0Ai9tVjSFGbuHJeebs1C9KdA81rwpKdurW+5KIESsfF0NrY46qoXJvUQyiM
 S38NDwJtCz8hc6gsHcb+k9PRtgmHC4TdgjQjw1DqD/ghN/1rjlGu5T4b63YA955HDqj2
 rW2ahADpQsvyE86Ye/zuqLnEMNIEqmykiV3wWgUp86MNcBLslyFFV1nDdhJ4q1aZE5AT
 RmNM+rHRcNcthE47FbL9D55jmzvCM3WIJ9jnaRKjPgrW46iLoWn0di6qjM7bx/ksGBxv
 T5NIC2ToP+EUY8H0S7KrlRjQBUaWjc+HDuO2w32E6yv+LhwQ4hlU7kQoRlGuzfeApy9K
 w6EA==
X-Gm-Message-State: ABuFfogb9X2fAl2eId+qxUCo0vit7Ren+0JqlRYj2Z2VEysRKLOn9n+D
 gjloFTlAIPXgdX0uj/8ieZ0=
X-Google-Smtp-Source: ACcGV60vbKRdtkJQplU2pabYcx3WyEoUqCTqFr6oCmA0DNjzl5hgQtngoCz4vwBFbRI6WwOK1HIXaQ==
X-Received: by 2002:a63:6746:: with SMTP id
 b67-v6mr25328762pgc.310.1539082477834; 
 Tue, 09 Oct 2018 03:54:37 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (60-240-121-136.tpgi.com.au.
 [60.240.121.136])
 by smtp.gmail.com with ESMTPSA id l83-v6sm51243749pfi.172.2018.10.09.03.54.34
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 09 Oct 2018 03:54:37 -0700 (PDT)
Date: Tue, 9 Oct 2018 20:54:30 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v6 0/9] powerpc: Switch to CONFIG_THREAD_INFO_IN_TASK
Message-ID: <20181009205430.351134eb@roar.ozlabs.ibm.com>
In-Reply-To: <df8575fba80d19e6e58c16266350e9980c432ae1.camel@kernel.crashing.org>
References: <cover.1538954166.git.christophe.leroy@c-s.fr>
 <df8575fba80d19e6e58c16266350e9980c432ae1.camel@kernel.crashing.org>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 08 Oct 2018 20:59:56 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Mon, 2018-10-08 at 09:16 +0000, Christophe Leroy wrote:
> > The purpose of this serie is to activate CONFIG_THREAD_INFO_IN_TASK which
> > moves the thread_info into task_struct.  
> 
> We need to make sure we don't have code that assumes that we don't take
> faults on TI access.
> 
> On ppc64, the stack SLB entries are bolted, which means the TI is too.
> 
> We might have code that assumes that we don't get SLB faults when
> accessing TI. If not, we're fine but that needs a close look.

Oh, we do. I think the entry side might be okay, but on exit we have
at least one (in syscall and interrupt exit both):

        /*
         * Disable interrupts so current_thread_info()->flags can't change,
         * and so that we don't get interrupted after loading SRR0/1.
         */
#ifdef CONFIG_PPC_BOOK3E
        wrteei  0
#else
        /*
         * For performance reasons we clear RI the same time that we
         * clear EE. We only need to clear RI just before we restore r13
         * below, but batching it with EE saves us one expensive mtmsrd call.
         * We have to be careful to restore RI if we branch anywhere from
         * here (eg syscall_exit_work).
         */
        li      r11,0
        mtmsrd  r11,1
#endif /* CONFIG_PPC_BOOK3E */

        ld      r9,TI_FLAGS(r12)

So taking an SLB there will cause an unrecoverable.

I think we can probably get rid of that optimization for now. I've found
for non-trivial syscalls it's often a loss if FP was used. I have a
couple of different options I'm working on to get rid of the mtmsrd
entirely we can go with instead (but I don't think those have to come
before Christophe's patch).

Thanks,
Nick
