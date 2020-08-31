Return-Path: <SRS0=+nHh=CJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40319C433E6
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2020 09:17:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED5ED2073A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2020 09:17:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED5ED2073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Bg4NG1RYyzDqSr
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2020 19:17:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=msuchanek@suse.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=suse.de
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Bg4L81YJgzDqR1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2020 19:15:28 +1000 (AEST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 92D03B6B3;
 Mon, 31 Aug 2020 09:15:59 +0000 (UTC)
Date: Mon, 31 Aug 2020 11:15:23 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: KVM on POWER8 host lock up since 10d91611f426 ("powerpc/64s:
 Reimplement book3s idle code in C")
Message-ID: <20200831091523.GC29521@kitsune.suse.cz>
References: <20200830201145.GA29521@kitsune.suse.cz>
 <1598835313.5688ngko4f.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1598835313.5688ngko4f.astroid@bobo.none>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: ro@suse.de, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Aug 31, 2020 at 11:14:18AM +1000, Nicholas Piggin wrote:
> Excerpts from Michal Suchánek's message of August 31, 2020 6:11 am:
> > Hello,
> > 
> > on POWER8 KVM hosts lock up since commit 10d91611f426 ("powerpc/64s:
> > Reimplement book3s idle code in C").
> > 
> > The symptom is host locking up completely after some hours of KVM
> > workload with messages like
> > 
> > 2020-08-30T10:51:31+00:00 obs-power8-01 kernel: KVM: couldn't grab cpu 47
> > 2020-08-30T10:51:31+00:00 obs-power8-01 kernel: KVM: couldn't grab cpu 71
> > 2020-08-30T10:51:31+00:00 obs-power8-01 kernel: KVM: couldn't grab cpu 47
> > 2020-08-30T10:51:31+00:00 obs-power8-01 kernel: KVM: couldn't grab cpu 71
> > 2020-08-30T10:51:31+00:00 obs-power8-01 kernel: KVM: couldn't grab cpu 47
> > 
> > printed before the host locks up.
> > 
> > The machines run sandboxed builds which is a mixed workload resulting in
> > IO/single core/mutiple core load over time and there are periods of no
> > activity and no VMS runnig as well. The VMs are shortlived so VM
> > setup/terdown is somewhat excercised as well.
> > 
> > POWER9 with the new guest entry fast path does not seem to be affected.
> > 
> > Reverted the patch and the followup idle fixes on top of 5.2.14 and
> > re-applied commit a3f3072db6ca ("powerpc/powernv/idle: Restore IAMR
> > after idle") which gives same idle code as 5.1.16 and the kernel seems
> > stable.
> > 
> > Config is attached.
> > 
> > I cannot easily revert this commit, especially if I want to use the same
> > kernel on POWER8 and POWER9 - many of the POWER9 fixes are applicable
> > only to the new idle code.
> > 
> > Any idea what can be the problem?
> 
> So hwthread_state is never getting back to to HWTHREAD_IN_IDLE on
> those threads. I wonder what they are doing. POWER8 doesn't have a good
> NMI IPI and I don't know if it supports pdbg dumping registers from the
> BMC unfortunately.
It may be possible to set up fadump with a later kernel version that
supports it on powernv and dump the whole kernel.

Thanks

Michal
