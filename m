Return-Path: <SRS0=vnEJ=O5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26ACEC43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 12:54:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96B6D2084A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 12:54:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96B6D2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43LBXp4HtGzDqxZ
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 23:54:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43LBV6538yzDqSc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Dec 2018 23:51:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43LBV61B8Lz9s8r;
 Thu, 20 Dec 2018 23:51:58 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] selftests/powerpc: New TM signal self test
In-Reply-To: <1543411413-23863-1-git-send-email-leitao@debian.org>
References: <1542828069-29100-1-git-send-email-leitao@debian.org>
 <1543411413-23863-1-git-send-email-leitao@debian.org>
Date: Thu, 20 Dec 2018 23:51:56 +1100
Message-ID: <875zvoqs2b.fsf@concordia.ellerman.id.au>
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
Cc: Breno Leitao <leitao@debian.org>, mikey@neuling.org,
 gromero@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Breno Leitao <leitao@debian.org> writes:

> A new self test that forces MSR[TS] to be set without calling any TM
> instruction. This test also tries to cause a page fault at a signal
> handler, exactly between MSR[TS] set and tm_recheckpoint(), forcing
> thread->texasr to be rewritten with TEXASR[FS] = 0, which will cause a BUG
> when tm_recheckpoint() is called.
>
> This test is not deterministic since it is hard to guarantee that the page
> access will cause a page fault. Tests have shown that the bug could be
> exposed with few interactions in a buggy kernel. This test is configured to
> loop 5000x, having a good chance to hit the kernel issue in just one run.
> This self test takes less than two seconds to run.
>
> This test uses set/getcontext because the kernel will recheckpoint
> zeroed structures, causing the test to segfault, which is undesired because
> the test needs to rerun, so, there is a signal handler for SIGSEGV which
> will restart the test.

Hi Breno,

Thanks for the test, some of these TM tests are getting pretty advanced! :)

Unfortunately it doesn't build in a few configurations.

On Ubuntu 18.10 built with powerpc-linux-gnu-gcc I get:

  tm-signal-force-msr.c: In function 'trap_signal_handler':
  tm-signal-force-msr.c:42:19: error: 'union uc_regs_ptr' has no member named 'gp_regs'; did you mean 'uc_regs'?
    ucp->uc_mcontext.gp_regs[PT_MSR] |= MSR_TS_S;
                     ^~~~~~~
                     uc_regs
  tm-signal-force-msr.c:17:29: error: left shift count >= width of type [-Werror=shift-count-overflow]
   #define __MASK(X)       (1UL<<(X))
                               ^~
  tm-signal-force-msr.c:20:25: note: in expansion of macro '__MASK'
   #define MSR_TS_S        __MASK(MSR_TS_S_LG) /* Transaction Suspended */
                           ^~~~~~
  tm-signal-force-msr.c:42:38: note: in expansion of macro 'MSR_TS_S'
    ucp->uc_mcontext.gp_regs[PT_MSR] |= MSR_TS_S;
                                        ^~~~~~~~

And using powerpc64le-linux-gnu-gcc I get:

  In file included from /usr/powerpc64le-linux-gnu/include/string.h:494,
                   from tm-signal-force-msr.c:10:
  In function 'memcpy',
      inlined from 'trap_signal_handler' at tm-signal-force-msr.c:39:2:
  /usr/powerpc64le-linux-gnu/include/bits/string_fortified.h:34:10: error: '__builtin_memcpy' accessing 1272 bytes at offsets 8 and 168 overlaps 1112 bytes at offset 168 [-Werror=restrict]
     return __builtin___memcpy_chk (__dest, __src, __len, __bos0 (__dest));
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

cheers
