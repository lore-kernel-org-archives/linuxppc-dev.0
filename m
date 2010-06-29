Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2F29AB6EEC
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jun 2010 11:02:26 +1000 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp04.au.ibm.com (8.14.4/8.13.1) with ESMTP id o5T0w84J018314
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jun 2010 10:58:08 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o5T12N1N1630442
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jun 2010 11:02:23 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o5T12MxC011040
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jun 2010 11:02:23 +1000
Content-Type: text/plain; charset=UTF-8
Subject: Re: [PATCH 39/40] trace syscalls: Clean confusing {s, r,
	}name and fix ABI breakage
From: Ian Munsie <imunsie@au1.ibm.com>
To: Jason Baron <jbaron@redhat.com>
In-reply-to: <20100623180353.GB2680@redhat.com>
References: <1277287401-28571-1-git-send-email-imunsie@au1.ibm.com>
	<1277287401-28571-40-git-send-email-imunsie@au1.ibm.com>
	<20100623180353.GB2680@redhat.com>
Date: Tue, 29 Jun 2010 11:02:01 +1000
Message-Id: <1277770197-sup-4485@au1.ibm.com>
Cc: Jesper Nilsson <jesper.nilsson@axis.com>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Christoph Hellwig <hch@lst.de>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>, Ingo Molnar <mingo@redhat.com>,
	Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from Jason Baron's message of Thu Jun 24 04:03:54 +1000 2010:
> overall this patch is a major improvement! My question though is
> about the naming of the compat syscalls in the context of events. I
> believe this patch differeniates compat syscall event names as:
> "sys32_enter_sname", and "compat_sys_enter_sname". I agree that we keep that
> distinction for purposes of defining the actual syscall function. However,
> we had discuessed previously about keeping the event name the same for
> all compat syscalls. ie they are all called "compat_sys_sname" or some
> such. Reason being you could just do "compat_*" to match all compat
> events.


Sorry for the delay in replying - I've been pretty busy with other work
over the last few days.

I can certainly change that to name them all compat_sys to be more
consistent. In terms of activating all of them at once that can still be
done fairly easily since they are in their own compat_sys category with
something like "perf record -e 'compat_syscalls:*' ..." or "echo 1 >
/sys/kernel/debug/tracing/events/compat_syscalls/enable".

Ideally I would actually like to consolidate these events with the
ordinary syscall events and just print out compat=0|1 as part of their
output.

Since many of the native syscalls are used as compat syscalls as well I
think that would make a whole lot more sense - at the moment to catch
all syscalls from a compat process both the compat and native syscalls
would need to be activated.

It would also have the benefit of removing any arch specific naming from
userspace, which would make things a lot nicer.

Cheers,
-Ian
