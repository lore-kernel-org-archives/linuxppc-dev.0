Return-Path: <SRS0=r5zj=QF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D85C169C4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 21:12:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EDB320881
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 21:12:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EDB320881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43pzhb1ldXzDqSK
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 08:11:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=jpoimboe@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43pzfb5zjFzDqRJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jan 2019 08:10:15 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 51A35804F4;
 Tue, 29 Jan 2019 21:10:13 +0000 (UTC)
Received: from treble (ovpn-120-147.rdu2.redhat.com [10.10.120.147])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 20248BAA0;
 Tue, 29 Jan 2019 21:10:02 +0000 (UTC)
Date: Tue, 29 Jan 2019 15:10:01 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Joe Lawrence <joe.lawrence@redhat.com>
Subject: Re: [PATCH 0/4] powerpc/livepatch: reliable stack unwinder fixes
Message-ID: <20190129211001.fsmxhasid4mamlea@treble>
References: <20190122155724.27557-1-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190122155724.27557-1-joe.lawrence@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Tue, 29 Jan 2019 21:10:13 +0000 (UTC)
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
Cc: Nicolai Stange <nstange@suse.de>, linux-kernel@vger.kernel.org,
 Torsten Duwe <duwe@lst.de>, Jiri Kosina <jkosina@suse.cz>,
 live-patching@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jan 22, 2019 at 10:57:20AM -0500, Joe Lawrence wrote:
> This patchset fixes a false negative report (ie, unreliable) from the
> ppc64 reliable stack unwinder, discussed here [1] when it may
> inadvertently trip over a stale exception marker left on the stack.
> 
> The first two patches fix this bug.  Nicolai's change clears the marker
> from the stack when an exception is finished.  The next patch modifies
> the unwinder to only look for such on stack elements when the ABI
> guarantees that they will actually be initialized.
> 
> The final two patches consist of code cleanups that Nicolai and I
> spotted during the development of the fixes.
> 
> Testing included re-running the original test scenario (loading a
> livepatch module on ppc64le) on a 5.0.0-rc2 kernel as well as a RHEL-7
> backport.  I ran internal tests on the RHEL-7 backport and no new test
> failures were introduced.  I believe that Nicolai has done the same
> with respect to the first patch.
> 
> [1] https://lore.kernel.org/lkml/7f468285-b149-37e2-e782-c9e538b997a9@redhat.com/
> 
> Joe Lawrence (3):
>   powerpc/livepatch: relax reliable stack tracer checks for first-frame
>   powerpc/livepatch: small cleanups in save_stack_trace_tsk_reliable()
>   powerpc/livepatch: return -ERRNO values in
>     save_stack_trace_tsk_reliable()
> 
> Nicolai Stange (1):
>   powerpc/64s: Clear on-stack exception marker upon exception return
> 
>  arch/powerpc/Kconfig             |  2 +-
>  arch/powerpc/kernel/entry_64.S   |  7 +++
>  arch/powerpc/kernel/stacktrace.c | 74 +++++++++++++++++---------------
>  3 files changed, 47 insertions(+), 36 deletions(-)

Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh
