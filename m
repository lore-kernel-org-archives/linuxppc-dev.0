Return-Path: <SRS0=OBm5=SH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDDFC4360F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 15:32:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 993CA21726
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 15:32:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 993CA21726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44bP2V4rkTzDqVR
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Apr 2019 02:32:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=jpoimboe@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44bP0g2yLlzDqLY
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Apr 2019 02:30:59 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D00553082AFD;
 Fri,  5 Apr 2019 15:30:56 +0000 (UTC)
Received: from treble (ovpn-123-87.rdu2.redhat.com [10.10.123.87])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CA39A60BFB;
 Fri,  5 Apr 2019 15:30:50 +0000 (UTC)
Date: Fri, 5 Apr 2019 10:30:48 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH RFC 2/5] x86/speculation: Add support for
 'cpu_spec_mitigations=' cmdline options
Message-ID: <20190405153048.knaizips2n27fwtx@treble>
References: <cover.1554396090.git.jpoimboe@redhat.com>
 <78c63cb08f36f55407f534d49cc2543079e44dbb.1554396090.git.jpoimboe@redhat.com>
 <20190405135712.GF23348@zn.tnic>
 <5ccc7515-33e6-b726-833e-9553ab0f4c6a@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5ccc7515-33e6-b726-833e-9553ab0f4c6a@infradead.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Fri, 05 Apr 2019 15:30:57 +0000 (UTC)
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
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Tyler Hicks <tyhicks@canonical.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Apr 05, 2019 at 08:18:09AM -0700, Randy Dunlap wrote:
> On 4/5/19 6:57 AM, Borislav Petkov wrote:
> > On Thu, Apr 04, 2019 at 11:44:12AM -0500, Josh Poimboeuf wrote:
> >> Configure x86 runtime CPU speculation bug mitigations in accordance with
> >> the 'cpu_spec_mitigations=' cmdline options.  This affects Meltdown,
> >> Spectre v2, Speculative Store Bypass, and L1TF.
> >>
> >> The default behavior is unchanged.
> >>
> >> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> >> ---
> >>  .../admin-guide/kernel-parameters.txt         | 15 +++++++++
> >>  arch/x86/include/asm/processor.h              |  1 +
> >>  arch/x86/kernel/cpu/bugs.c                    | 32 ++++++++++++++++---
> >>  arch/x86/kvm/vmx/vmx.c                        |  2 ++
> >>  arch/x86/mm/pti.c                             |  4 ++-
> >>  5 files changed, 49 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> >> index ac42e510bd6e..29dc03971630 100644
> >> --- a/Documentation/admin-guide/kernel-parameters.txt
> >> +++ b/Documentation/admin-guide/kernel-parameters.txt
> >> @@ -2552,6 +2552,11 @@
> >>  
> >>  			off
> >>  				Disable all speculative CPU mitigations.
> >> +				Equivalent to: nopti [x86]
> >> +					       nospectre_v2 [x86]
> >> +					       spectre_v2_user=off [x86]
> >> +					       spec_store_bypass_disable=off [x86]
> >> +					       l1tf=off [x86]
> >>  
> >>  			auto (default)
> >>  				Mitigate all speculative CPU vulnerabilities,
> >> @@ -2560,12 +2565,22 @@
> >>  				surprised by SMT getting disabled across kernel
> >>  				upgrades, or who have other ways of avoiding
> >>  				SMT-based attacks.
> >> +				Equivalent to: pti=auto [x86]
> >> +					       spectre_v2=auto [x86]
> >> +					       spectre_v2_user=auto [x86]
> >> +					       spec_store_bypass_disable=auto [x86]
> >> +					       l1tf=flush [x86]
> >>  
> >>  			auto,nosmt
> >>  				Mitigate all speculative CPU vulnerabilities,
> >>  				disabling SMT if needed.  This is for users who
> >>  				always want to be fully mitigated, even if it
> >>  				means losing SMT.
> >> +				Equivalent to: pti=auto [x86]
> >> +					       spectre_v2=auto [x86]
> >> +					       spectre_v2_user=auto [x86]
> >> +					       spec_store_bypass_disable=auto [x86]
> >> +					       l1tf=flush,nosmt [x86]
> >>  
> >>  	mminit_loglevel=
> >>  			[KNL] When CONFIG_DEBUG_MEMORY_INIT is set, this
> > 
> > Yap, those sets look ok.
> 
> nit:  s/x86/X86/g
> according to Documentation/admin-guide/kernel-parameters.rst

Ah, I didn't realize I was conforming to a standard.  I will update the
other arch strings as well.  Thanks.

-- 
Josh
