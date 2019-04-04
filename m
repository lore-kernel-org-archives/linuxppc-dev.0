Return-Path: <SRS0=99u2=SG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68878C4360F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 16:47:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55BCE20693
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 16:47:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55BCE20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Zpl33l5RzDqGF
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 03:47:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=jpoimboe@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Zphn3wQgzDqF1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Apr 2019 03:45:09 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id ED709308793A;
 Thu,  4 Apr 2019 16:45:05 +0000 (UTC)
Received: from treble.redhat.com (ovpn-125-158.rdu2.redhat.com [10.10.125.158])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9EFE2608BB;
 Thu,  4 Apr 2019 16:44:58 +0000 (UTC)
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH RFC 0/5] cpu/speculation: Add 'cpu_spec_mitigations=' cmdline
 options
Date: Thu,  4 Apr 2019 11:44:10 -0500
Message-Id: <cover.1554396090.git.jpoimboe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Thu, 04 Apr 2019 16:45:06 +0000 (UTC)
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
Cc: Peter Zijlstra <peterz@infradead.org>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mackerras <paulus@samba.org>,
 "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
 Andrea Arcangeli <aarcange@redhat.com>, linux-s390@vger.kernel.org,
 x86@kernel.org, Will Deacon <will.deacon@arm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Waiman Long <longman@redhat.com>,
 linux-arch@vger.kernel.org, Jon Masters <jcm@redhat.com>,
 Jiri Kosina <jikos@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Tyler Hicks <tyhicks@canonical.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Keeping track of the number of mitigations for all the CPU speculation
bugs has become overwhelming for many users.  It's getting more and more
complicated to decide which mitigations are needed for a given
architecture.  Complicating matters is the fact that each arch tends to
it own custom way to mitigate the same vulnerability.

Most users fall into a few basic categories:

a) they want all CPU speculation mitigations off;

b) they want all reasonable mitigations on, with SMT enabled even if
   it's vulnerable; or

c) they want all reasonable mitigations on, with SMT disabled if
   vulnerable.

Define a set of curated, arch-independent options, each of which is an
aggregation of existing options:

- cpu_spec_mitigations=off: Disable all mitigations.

- cpu_spec_mitigations=auto: [default] Enable all the default
  mitigations, but leave SMT enabled, even if it's vulnerable.

- cpu_spec_mitigations=auto,nosmt: Enable all the default mitigations,
  disabling SMT if needed by a mitigation.


Josh Poimboeuf (5):
  cpu/speculation: Add 'cpu_spec_mitigations=' cmdline options
  x86/speculation: Add support for 'cpu_spec_mitigations=' cmdline
    options
  powerpc/speculation: Add support for 'cpu_spec_mitigations=' cmdline
    options
  s390/speculation: Add support for 'cpu_spec_mitigations=' cmdline
    options
  arm64/speculation: Add support for 'cpu_spec_mitigations=' cmdline
    options

 .../admin-guide/kernel-parameters.txt         | 42 +++++++++++++++++++
 arch/arm64/kernel/cpu_errata.c                |  4 ++
 arch/arm64/kernel/cpufeature.c                |  6 +++
 arch/powerpc/kernel/security.c                |  6 +--
 arch/powerpc/kernel/setup_64.c                |  2 +-
 arch/s390/kernel/nospec-branch.c              |  4 +-
 arch/x86/include/asm/processor.h              |  1 +
 arch/x86/kernel/cpu/bugs.c                    | 32 ++++++++++++--
 arch/x86/kvm/vmx/vmx.c                        |  2 +
 arch/x86/mm/pti.c                             |  4 +-
 include/linux/cpu.h                           |  8 ++++
 kernel/cpu.c                                  | 15 +++++++
 12 files changed, 116 insertions(+), 10 deletions(-)

-- 
2.17.2

