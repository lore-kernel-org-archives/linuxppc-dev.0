Return-Path: <SRS0=r5zj=QF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4603AC169C4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 23:52:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81A8920881
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 23:52:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81A8920881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43q3FT2YxYzDqS8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 10:52:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=jikos@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43q3Ch4rPPzDqRr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jan 2019 10:50:36 +1100 (AEDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id C00A8AE4B;
 Tue, 29 Jan 2019 23:50:33 +0000 (UTC)
Date: Wed, 30 Jan 2019 00:50:32 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Joe Lawrence <joe.lawrence@redhat.com>
Subject: Re: [PATCH 0/4] powerpc/livepatch: reliable stack unwinder fixes
In-Reply-To: <20190122155724.27557-1-joe.lawrence@redhat.com>
Message-ID: <nycvar.YFH.7.76.1901300049470.6626@cbobk.fhfr.pm>
References: <20190122155724.27557-1-joe.lawrence@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
 Torsten Duwe <duwe@lst.de>, Josh Poimboeuf <jpoimboe@redhat.com>,
 live-patching@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 22 Jan 2019, Joe Lawrence wrote:

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

Michael, are you fine with this going through LP tree, or do you plan to 
take it through yours?

Thanks,

-- 
Jiri Kosina
SUSE Labs

