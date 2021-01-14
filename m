Return-Path: <SRS0=IYgH=GR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABBAC433DB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Jan 2021 12:44:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B67BE221E2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Jan 2021 12:44:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B67BE221E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DGkXg3RhSzDrqP
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Jan 2021 23:44:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=msuchanek@suse.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=suse.de
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DGkRy0mhxzDqv9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jan 2021 23:40:29 +1100 (AEDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id D3100B80A;
 Thu, 14 Jan 2021 12:40:24 +0000 (UTC)
Date: Thu, 14 Jan 2021 13:40:23 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: KVM on POWER8 host lock up since 10d91611f426 ("powerpc/64s:
 Reimplement book3s idle code in C")
Message-ID: <20210114124023.GL6564@kitsune.suse.cz>
References: <20200830201145.GA29521@kitsune.suse.cz>
 <1598835313.5688ngko4f.astroid@bobo.none>
 <20200831091523.GC29521@kitsune.suse.cz>
 <87y2lv1430.fsf@mpe.ellerman.id.au>
 <1599484062.vgmycu6q5i.astroid@bobo.none>
 <20201016201410.GH29778@kitsune.suse.cz>
 <1603066878.gtbyofrzyo.astroid@bobo.none>
 <1603082970.5545yt7raj.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1603082970.5545yt7raj.astroid@bobo.none>
User-Agent: Mutt/1.11.3 (2019-02-01)
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
Cc: ro@suse.de, linuxppc-dev@lists.ozlabs.org,
 Hari Bathini <hbathini@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Oct 19, 2020 at 02:50:51PM +1000, Nicholas Piggin wrote:
> Excerpts from Nicholas Piggin's message of October 19, 2020 11:00 am:
> > Excerpts from Michal Suchánek's message of October 17, 2020 6:14 am:
> >> On Mon, Sep 07, 2020 at 11:13:47PM +1000, Nicholas Piggin wrote:
> >>> Excerpts from Michael Ellerman's message of August 31, 2020 8:50 pm:
> >>> > Michal Suchánek <msuchanek@suse.de> writes:
> >>> >> On Mon, Aug 31, 2020 at 11:14:18AM +1000, Nicholas Piggin wrote:
> >>> >>> Excerpts from Michal Suchánek's message of August 31, 2020 6:11 am:
> >>> >>> > Hello,
> >>> >>> > 
> >>> >>> > on POWER8 KVM hosts lock up since commit 10d91611f426 ("powerpc/64s:
> >>> >>> > Reimplement book3s idle code in C").
> >>> >>> > 
> >>> >>> > The symptom is host locking up completely after some hours of KVM
> >>> >>> > workload with messages like
> >>> >>> > 
> >>> >>> > 2020-08-30T10:51:31+00:00 obs-power8-01 kernel: KVM: couldn't grab cpu 47
> >>> >>> > 2020-08-30T10:51:31+00:00 obs-power8-01 kernel: KVM: couldn't grab cpu 71
> >>> >>> > 2020-08-30T10:51:31+00:00 obs-power8-01 kernel: KVM: couldn't grab cpu 47
> >>> >>> > 2020-08-30T10:51:31+00:00 obs-power8-01 kernel: KVM: couldn't grab cpu 71
> >>> >>> > 2020-08-30T10:51:31+00:00 obs-power8-01 kernel: KVM: couldn't grab cpu 47
> >>> >>> > 
> >>> >>> > printed before the host locks up.
> >>> >>> > 
> >>> >>> > The machines run sandboxed builds which is a mixed workload resulting in
> >>> >>> > IO/single core/mutiple core load over time and there are periods of no
> >>> >>> > activity and no VMS runnig as well. The VMs are shortlived so VM
> >>> >>> > setup/terdown is somewhat excercised as well.
> >>> >>> > 
> >>> >>> > POWER9 with the new guest entry fast path does not seem to be affected.
> >>> >>> > 
> >>> >>> > Reverted the patch and the followup idle fixes on top of 5.2.14 and
> >>> >>> > re-applied commit a3f3072db6ca ("powerpc/powernv/idle: Restore IAMR
> >>> >>> > after idle") which gives same idle code as 5.1.16 and the kernel seems
> >>> >>> > stable.
> >>> >>> > 
> >>> >>> > Config is attached.
> >>> >>> > 
> >>> >>> > I cannot easily revert this commit, especially if I want to use the same
> >>> >>> > kernel on POWER8 and POWER9 - many of the POWER9 fixes are applicable
> >>> >>> > only to the new idle code.
> >>> >>> > 
> >>> >>> > Any idea what can be the problem?
> >>> >>> 
> >>> >>> So hwthread_state is never getting back to to HWTHREAD_IN_IDLE on
> >>> >>> those threads. I wonder what they are doing. POWER8 doesn't have a good
> >>> >>> NMI IPI and I don't know if it supports pdbg dumping registers from the
> >>> >>> BMC unfortunately.
> >>> >>
> >>> >> It may be possible to set up fadump with a later kernel version that
> >>> >> supports it on powernv and dump the whole kernel.
> >>> > 
> >>> > Your firmware won't support it AFAIK.
> >>> > 
> >>> > You could try kdump, but if we have CPUs stuck in KVM then there's a
> >>> > good chance it won't work :/
> >>> 
> >>> I haven't had any luck yet reproducing this still. Testing with sub 
> >>> cores of various different combinations, etc. I'll keep trying though.
> >> 
> >> Hello,
> >> 
> >> I tried running some KVM guests to simulate the workload and what I get
> >> is guests failing to start with a rcu stall. Tried both 5.3 and 5.9
> >> kernel and qemu 4.2.1 and 5.1.0
> >> 
> >> To start some guests I run
> >> 
> >> for i in $(seq 0 9) ; do /opt/qemu/bin/qemu-system-ppc64 -m 2048 -accel kvm -smp 8 -kernel /boot/vmlinux -initrd /boot/initrd -nodefaults -nographic -serial mon:telnet::444$i,server,wait & done
> >> 
> >> To simulate some workload I run
> >> 
> >> xz -zc9T0 < /dev/zero > /dev/null &
> >> while true; do
> >>     killall -STOP xz; sleep 1; killall -CONT xz; sleep 1;
> >> done &
> >> 
> >> on the host and add a job that executes this to the ramdisk. However, most
> >> guests never get to the point where the job is executed.
> >> 
> >> Any idea what might be the problem?
> > 
> > I would say try without pv queued spin locks (but if the same thing is 
> > happening with 5.3 then it must be something else I guess). 
> > 
> > I'll try to test a similar setup on a POWER8 here.
> 
> Couldn't reproduce the guest hang, they seem to run fine even with 
> queued spinlocks. Might have a different .config.
> 
> I might have got a lockup in the host (although different symptoms than 
> the original report). I'll look into that a bit further.

Hello,

any progress on this?

I considered reinstating the old assembly code for POWER[78] but even
the way it's called has changed slightly.

Thanks

Michal
