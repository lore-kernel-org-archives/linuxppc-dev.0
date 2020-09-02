Return-Path: <SRS0=iKE2=CL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D86C433E2
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Sep 2020 14:21:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5845720773
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Sep 2020 14:21:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5845720773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BhR2R0DzRzDqvn
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Sep 2020 00:21:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ip:192.40.192.88/32) smtp.mailfrom=kernel.crashing.org
 (client-ip=63.228.1.57; helo=gate.crashing.org;
 envelope-from=segher@kernel.crashing.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 4BhQvS0CkhzDqvw
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Sep 2020 00:15:31 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 082EEWYN031070;
 Wed, 2 Sep 2020 09:14:32 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id 082EEVOd031069;
 Wed, 2 Sep 2020 09:14:31 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Wed, 2 Sep 2020 09:14:31 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH 2/2] powerpc/vdso32: link vdso64 with linker
Message-ID: <20200902141431.GV28786@gate.crashing.org>
References: <20200901222523.1941988-1-ndesaulniers@google.com>
 <20200901222523.1941988-3-ndesaulniers@google.com>
 <b2066ccd-2b81-6032-08e3-41105b400f75@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2066ccd-2b81-6032-08e3-41105b400f75@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
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
Cc: Christophe Leroy <christophe.leroy@c-s.fr>,
 Joe Lawrence <joe.lawrence@redhat.com>, Kees Cook <keescook@chromium.org>,
 Fangrui Song <maskray@google.com>, Nick Desaulniers <ndesaulniers@google.com>,
 linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
 clang-built-linux@googlegroups.com, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi!

On Wed, Sep 02, 2020 at 06:46:45AM +0000, Christophe Leroy wrote:
> ld crashes:
> 
>   LD      arch/powerpc/kernel/vdso32/vdso32.so.dbg
> /bin/sh: line 1: 23780 Segmentation fault      (core dumped) 
> ppc-linux-ld -EB -m elf32ppc -shared -soname linux-vdso32.so.1 
> --eh-frame-hdr --orphan-handling=warn -T 
> arch/powerpc/kernel/vdso32/vdso32.lds 
> arch/powerpc/kernel/vdso32/sigtramp.o 
> arch/powerpc/kernel/vdso32/gettimeofday.o 
> arch/powerpc/kernel/vdso32/datapage.o 
> arch/powerpc/kernel/vdso32/cacheflush.o 
> arch/powerpc/kernel/vdso32/note.o arch/powerpc/kernel/vdso32/getcpu.o -o 
> arch/powerpc/kernel/vdso32/vdso32.so.dbg
> make[4]: *** [arch/powerpc/kernel/vdso32/vdso32.so.dbg] Error 139
> 
> 
> [root@localhost linux-powerpc]# ppc-linux-ld --version
> GNU ld (GNU Binutils) 2.26.20160125

[ Don't build as root :-P ]

Try with a newer ld?  If it still happens with current versions, please
open a bug report?  https://sourceware.org/bugzilla


Segher
