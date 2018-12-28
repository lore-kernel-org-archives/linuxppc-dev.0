Return-Path: <SRS0=XWqB=PF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73126C43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Dec 2018 22:13:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FB2F20861
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Dec 2018 22:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j77Vi22F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FB2F20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43RLZj2gkdzDq9d
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Dec 2018 09:13:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j77Vi22F";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com;
 envelope-from=groeck7@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="j77Vi22F"; 
 dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43RLWw37NVzDqD1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Dec 2018 09:11:23 +1100 (AEDT)
Received: by mail-pg1-x544.google.com with SMTP id s198so10528683pgs.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Dec 2018 14:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=XAUtO9EOHccUgdDJX1ToyhisP+OQnbGmwmcwb3RDvAY=;
 b=j77Vi22F0G7doLL5rmeK3tDLjxLG24MdgLGGdXxiPYEaY2a5qEp1GQyq5zH9rLBERo
 a0Tt7fXmfDilX7utPVisym6xFAxYGbWQ0QPfq9gKhLNWnkZuSGomCZVxU4RcK9Dysd0C
 2QWJZVyta/jq1IL60a+CwnlUq9Z4BQdSZhryXv7rR1Z3EnzZ6insqlwnPv2PGRBfy8zL
 oH9FBgCizBf0+gDwXHaWPOQR9qsOEqTcKUFt8SLVWeK+dSjc+j+kA2DNy2ANYWMpyZDj
 zzTbso2T9fsE+xG852w2AoZ82lVEb4rVt7Fl6h4J6CN5GwTHB8+rqCehmxWuQhIsw2jS
 qtEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=XAUtO9EOHccUgdDJX1ToyhisP+OQnbGmwmcwb3RDvAY=;
 b=MKHAZu2lDkJmAS5sSkZQUQWri0NTBr557SSFiJOr4ocDcFR68sSYoX4V1L1/Y7Kl0c
 Z401PcccDMn3CjSKbAzZ67eIy4QpwjOa8C2+h8nmLL76xb4oh1wdmdR8cO4LyaVJQCwW
 FirvbucuX8zk6LnjL32CKhoWzAcJG1De2m1hPpR+VAnxJWQgTj8ePg0LLPa1AfcsPVer
 1dnEWQ+m66xRKllJBnG1vM56EIqnMlmIyQiXdp1vprNJl5FU8K75WX+zUpuSmgm3lfmS
 XOI1lljiNNfELiAxdc7T3Tex1fYYJY3i4VX5GZH21ThDE3h23efemb8ItwheJmfhVKbq
 uM4Q==
X-Gm-Message-State: AA+aEWbk7GQF6XQHUEOobM+Hch256tI/eHp+7nM9Fou4FeDn/9B+FNnw
 9OLSZ588MYO+veGUp9Y4LBg=
X-Google-Smtp-Source: AFSGD/WYprIjiMO7lP8QMz+2smp1ZgzFt84/0F1i8mF/53RbRh4K7ZRsOL5nm+8Ha5z5yh9qPI2mmw==
X-Received: by 2002:a62:8949:: with SMTP id v70mr29045113pfd.85.1546035081091; 
 Fri, 28 Dec 2018 14:11:21 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id w184sm47245680pgd.34.2018.12.28.14.11.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 28 Dec 2018 14:11:19 -0800 (PST)
Date: Fri, 28 Dec 2018 14:11:18 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Scott Wood <oss@buserror.net>
Subject: Re: Runtime warnings in powerpc code
Message-ID: <20181228221118.GA12038@roeck-us.net>
References: <20181227190542.GA29444@roeck-us.net>
 <859893153097012cf1a6efd1457e56c79a8ce5ce.camel@buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <859893153097012cf1a6efd1457e56c79a8ce5ce.camel@buserror.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Scott,

On Thu, Dec 27, 2018 at 07:31:33PM -0600, Scott Wood wrote:
> On Thu, 2018-12-27 at 11:05 -0800, Guenter Roeck wrote:
> > ---
> > CONFIG_DEBUG_ATOMIC_SLEEP
> > 
> > ------------[ cut here ]------------
> > do not call blocking ops when !TASK_RUNNING; state=2 set at [<(ptrval)>]
> > prepare_to_wait+0x54/0xe4
> > WARNING: CPU: 0 PID: 1 at kernel/sched/core.c:6099 __might_sleep+0x94/0x9c
> > Modules linked in:
> > CPU: 0 PID: 1 Comm: init Not tainted 4.20.0-yocto-standard+ #1
> > NIP:  c00667a0 LR: c00667a0 CTR: 00000000
> > REGS: cf8df8c0 TRAP: 0700   Not tainted  (4.20.0-yocto-standard+)
> > MSR:  00029032 <EE,ME,IR,DR,RI>  CR: 28888822  XER: 20000000
> > 
> > GPR00: c00667a0 cf8df970 cf8e0000 00000062 c0af15c8 00000007 fa1ae97e
> > 757148e2 
> > GPR08: cf8de000 00000000 00000000 00000000 1f386000 00000000 00000000
> > cfd83c8c 
> > GPR16: 00000004 00000004 00000004 00000000 0000060c 0000000a cf8dfdb8
> > cf267804 
> > GPR24: cf8dfd78 cf8dfd68 cfa88a20 cec70830 00000001 00000000 000001d3
> > c0b444cc 
> > NIP [c00667a0] __might_sleep+0x94/0x9c
> > LR [c00667a0] __might_sleep+0x94/0x9c
> > Call Trace:
> > [cf8df970] [c00667a0] __might_sleep+0x94/0x9c (unreliable)
> > [cf8df990] [c05beddc] do_ide_request+0x48/0x6bc
> > [cf8dfa10] [c0492bcc] __blk_run_queue+0x80/0x10c
> > [cf8dfa20] [c049a938] blk_flush_plug_list+0x23c/0x258
> > [cf8dfa60] [c006b888] io_schedule_prepare+0x44/0x5c
> > [cf8dfa70] [c006b8c0] io_schedule+0x20/0x48
> > [cf8dfa80] [c095e1ac] bit_wait_io+0x24/0x74
> > [cf8dfa90] [c095dd94] __wait_on_bit+0xac/0x104
> > [cf8dfab0] [c095de74] out_of_line_wait_on_bit+0x88/0x98
> > [cf8dfae0] [c0229094] bh_submit_read+0xf8/0x104
> > [cf8dfaf0] [c028b9a8] ext4_get_branch+0xdc/0x168
> > [cf8dfb20] [c028c7fc] ext4_ind_map_blocks+0x2b0/0xc08
> > [cf8dfc30] [c029551c] ext4_map_blocks+0x2e0/0x65c
> > [cf8dfc80] [c02b8c84] ext4_mpage_readpages+0x5e8/0x97c
> > [cf8dfd60] [c016c3cc] read_pages+0x60/0x1a0
> > [cf8dfdb0] [c016c6e8] __do_page_cache_readahead+0x1dc/0x208
> > [cf8dfe10] [c0159768] filemap_fault+0x418/0x834
> > [cf8dfe50] [c02a00fc] ext4_filemap_fault+0x40/0x64
> > [cf8dfe60] [c0198d0c] __do_fault+0x34/0xb8
> > [cf8dfe70] [c019e264] handle_mm_fault+0xc44/0xf88
> > [cf8dfef0] [c001a218] __do_page_fault+0x158/0x7b4
> > [cf8dff40] [c00143b4] handle_page_fault+0x14/0x40
> > --- interrupt: 301 at 0xb7904a70
> >     LR = 0xb78ef0c8
> > Instruction dump:
> > 7fe3fb78 bba10014 7c0803a6 38210020 4bfffd20 808a0000 3c60c0b0 39400001 
> > 7cc53378 3863a558 99490001 4bfd03bd <0fe00000> 4bffffc0 7c0802a6 90010004 
> > irq event stamp: 126702
> > hardirqs last  enabled at (126701): [<c0091a74>] console_unlock+0x434/0x5d0
> > hardirqs last disabled at (126702): [<c00140b4>] reenable_mmu+0x30/0x88
> > softirqs last  enabled at (126552): [<c0964614>] __do_softirq+0x42c/0x4a0
> > softirqs last disabled at (126529): [<c003cda4>] irq_exit+0x104/0x108
> > ---[ end trace 4f6c84b7815474d9 ]---
> 
> This doesn't look PPC-specific, but rather IDE-specific.  Here's a similar one
> on x86:
> https://lkml.org/lkml/2016/12/12/596
> 
I wasn't sure, since I don't see the problem anywhere else.

Anyway, I'll disable the debug option in my tests if CONFIG_IDE is enabled.

> > ---
> > #if defined(CONFIG_PROVE_LOCKING) && defined(CONFIG_DEBUG_LOCKDEP) && \
> >     defined(CONFIG_TRACE_IRQFLAGS)
> > 
> > ------------[ cut here ]------------
> > DEBUG_LOCKS_WARN_ON(!current->hardirqs_enabled)
> > WARNING: CPU: 0 PID: 1 at kernel/locking/lockdep.c:3762
> 
> http://patchwork.ozlabs.org/patch/1016541/ should fix this.  It should also
> only be showing up on 32-bit, not all platforms.
> 
Looks like it. Unfortunately the patch does not apply to mainline.
I'll monitor its progress. And, yes, I should have been more
specific - both problem are only seen with ppc32 tests.

Thanks,
Guenter
