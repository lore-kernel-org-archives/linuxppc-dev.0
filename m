Return-Path: <SRS0=FZqe=NR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA8EFC32789
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 18:34:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55EAE20827
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 18:34:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55EAE20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42qJ9M6nvgzF3FL
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 05:34:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=fweimer@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42qJ7Q0312zF26K
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Nov 2018 05:32:33 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B37BA308FB8C;
 Tue,  6 Nov 2018 18:32:30 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-116-235.ams2.redhat.com
 [10.36.116.235])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 365C71042557;
 Tue,  6 Nov 2018 18:32:29 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Breno Leitao <leitao@debian.org>
Subject: Re: [RFC PATCH v2 00/14] New TM Model
References: <1541508028-31865-1-git-send-email-leitao@debian.org>
Date: Tue, 06 Nov 2018 19:32:25 +0100
In-Reply-To: <1541508028-31865-1-git-send-email-leitao@debian.org> (Breno
 Leitao's message of "Tue, 6 Nov 2018 10:40:14 -0200")
Message-ID: <87zhumkqfa.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Tue, 06 Nov 2018 18:32:30 +0000 (UTC)
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
Cc: mikey@neuling.org, ldufour@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, cyrilbur@gmail.com, gromero@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

* Breno Leitao:

> This  patchset for the hardware transactional memory (TM) subsystem
> aims to avoid spending a lot of time on TM suspended mode in kernel
> space.  It basically changes where the reclaim/recheckpoint will be
> executed.

I assumed that we want to abort on every system call these days?

We have this commit in glibc:

commit f0458cf4f9ff3d870c43b624e6dccaaf657d5e83
Author: Adhemerval Zanella <adhemerval.zanella@linaro.org>
Date:   Mon Aug 27 09:42:50 2018 -0300

    powerpc: Only enable TLE with PPC_FEATURE2_HTM_NOSC
    
    Linux from 3.9 through 4.2 does not abort HTM transaction on syscalls,
    instead it suspend and resume it when leaving the kernel.  The
    side-effects of the syscall will always remain visible, even if the
    transaction is aborted.  This is an issue when transaction is used along
    with futex syscall, on pthread_cond_wait for instance, where the futex
    call might succeed but the transaction is rolled back leading the
    pthread_cond object in an inconsistent state.
    
    Glibc used to prevent it by always aborting a transaction before issuing
    a syscall.  Linux 4.2 also decided to abort active transaction in
    syscalls which makes the glibc workaround superfluous.  Worse, glibc
    transaction abortion leads to a performance issue on recent kernels
    where the HTM state is saved/restore lazily (v4.9).  By aborting a
    transaction on every syscalls, regardless whether a transaction has being
    initiated before, GLIBS makes the kernel always save/restore HTM state
    (it can not even lazily disable it after a certain number of syscall
    iterations).
    
    Because of this shortcoming, Transactional Lock Elision is just enabled
    when it has been explicitly set (either by tunables of by a configure
    switch) and if kernel aborts HTM transactions on syscalls
    (PPC_FEATURE2_HTM_NOSC).  It is reported that using simple benchmark [1],
    the context-switch is about 5% faster by not issuing a tabort in every
    syscall in newer kernels.

I wonder how the new TM model interacts with the assumption we currently
have in glibc.

Thanks,
Florian
