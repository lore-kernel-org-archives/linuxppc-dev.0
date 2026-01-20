Return-Path: <linuxppc-dev+bounces-16072-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F16BD2ECE9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Jan 2026 14:28:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dwV7D0nyyz3c5c;
	Wed, 21 Jan 2026 01:28:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768919320;
	cv=none; b=V6KxOIVB/+mXa6sebxhGdNQeOJOyDIJEy7QZiJGV5wIS4BXJC72LP969ZkaLV7GdKbtaaEg/CRp/T4XKL3U0PIFsmOMrALtyTIHZuQtU5aw5VzWU3U+qfSNB7jETTAJZAKAKhNsxqePdi39Lr8W1NR+LfuOkHGD/0zc+JwU8UuYg6EppfHyF91AJRuRL7xutC7fh7Bx1IqMlyGJUUymS7LIK8hYg/+cKFe9/UOVc3XNW/CXCnvLfo+yRW2P1iCKblhmNlG/5JOkDxZVCXUuT+OMz2OkPtIl8E4/Gf6rKaY9ixRIo+ChjgmKTeSGDlAQVaf9hHpZ2xznCt2/YAE3vKA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768919320; c=relaxed/relaxed;
	bh=+Lguxp45Sf7JjnDUGuCBY/lTM/RSA32E8lpcuumw7Qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ChPAInhiiJtMAMz2s/rrIPORBi22SWjh7CNk5apK9PsFuv0nXz1uwVOs7MpN5YW5HdcKBZJVYjQZQaDWSKa936+D9wmA1Ns6M2D8IaftIEL1H0j11QXzyyEOj1gxkJAu+xBoN88WERShXJkuzfyJ/F7BH2X+1Z9/c/8zNEfLJkAfMKNwyyg4FNTO692Y0qVEXEiutomh4c07XI83ig7rnAgyh4rRVjusOgusTdvY0vSRGodPVcabpswZEOsEa1HJAhRK0bMjuaWOZhIsDvU37VXpfYG3FpBg1etOHsQHg+YGOmAdXbAm4az3mtx4esxUrfasKMocL//tLmMNq0e2RA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Fn4JA8d1; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=frederic@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Fn4JA8d1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=frederic@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dwV7B4F6pz3c55
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jan 2026 01:28:38 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 5B97344024;
	Tue, 20 Jan 2026 14:28:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D304CC19423;
	Tue, 20 Jan 2026 14:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768919316;
	bh=OtwTnDpvDtbMBHvqPMZewcBZYEUS5NfRqaxfbB7joZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fn4JA8d1pUoK5IYDAD/REmgz3XFxvQ+4EMUiivOVIwX0mBUNuj1YudA6H2j/KP2js
	 1u7RZ3bveDlNfpGQfj5OGzCZJjpb35llivcWTSd1DS9XVszq78JeigVaaDJt30fVNe
	 m8EiHvICvqta/R6tBqkwUokrutW8CSVjFsCTw82ts94PN7Wb23kyOBNOizq+Fel7E3
	 RpxysRXLhJfosaVgI0e4cwNxSR+D+4cuGZXBmV9O3xQa+5Ik08YXEiNzb0UdVRDW//
	 xY4ofNxvVqahQAvNh0AywkWtlNbS4RWT6M+8pUp5n0ah3jDMHxD4+LYjUSU0SYsqyP
	 4vxzGPayTPZrQ==
Date: Tue, 20 Jan 2026 15:28:30 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ben Segall <bsegall@google.com>, Boqun Feng <boqun.feng@gmail.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Heiko Carstens <hca@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mel Gorman <mgorman@suse.de>, Michael Ellerman <mpe@ellerman.id.au>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Xin Zhao <jackzxcui1989@163.com>, linux-pm@vger.kernel.org,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 07/15] cpufreq: ondemand: Simplify idle cputime
 granularity test
Message-ID: <aW-RDkr-KQ5pkFAX@localhost.localdomain>
References: <20260116145208.87445-1-frederic@kernel.org>
 <20260116145208.87445-8-frederic@kernel.org>
 <CAJZ5v0hn81J_0N0Hy6QYtc3655w-9hDqVgWWY1BVhW=DT56Deg@mail.gmail.com>
 <aW6rAjJ5hz5BYuAR@pavilion.home>
 <CAJZ5v0gfT1A9OtEzeyp0MJ7JmrPJXF0PWL-8dSdtJXp4pAE8fA@mail.gmail.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gfT1A9OtEzeyp0MJ7JmrPJXF0PWL-8dSdtJXp4pAE8fA@mail.gmail.com>

Le Tue, Jan 20, 2026 at 01:32:50PM +0100, Rafael J. Wysocki a écrit :
> On Mon, Jan 19, 2026 at 11:07 PM Frederic Weisbecker
> <frederic@kernel.org> wrote:
> >
> > Le Mon, Jan 19, 2026 at 01:30:07PM +0100, Rafael J. Wysocki a écrit :
> > > On Fri, Jan 16, 2026 at 3:53 PM Frederic Weisbecker <frederic@kernel.org> wrote:
> > > >
> > > > cpufreq calls get_cpu_idle_time_us() just to know if idle cputime
> > > > accounting has a nanoseconds granularity.
> > > >
> > > > Use the appropriate indicator instead to make that deduction.
> > > >
> > > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > >
> > > Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
> > >
> > > or please let me know if you want me to take this patch.
> >
> > The patch is standalone but the rest of the patchset depends on it.
> > Now I don't target this patchset for v6.20-rc1.
> >
> > So if you manage to sneak this patch in for v6.20-rc1, it works because
> > I'll rebase on -rc1. Otherwise I'll need to keep it to avoid breaking
> > some code assumptions.
> >
> > What do you think?
> 
> It can go into -rc1.

Very nice, thanks for taking it!


-- 
Frederic Weisbecker
SUSE Labs

