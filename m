Return-Path: <linuxppc-dev+bounces-20199-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13585FF8867
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Apr 2026 23:31:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g4KZF335Lz2xYw;
	Tue, 28 Apr 2026 09:31:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777304646;
	cv=none; b=NLFFA/FWgRwKsyZD5qPSj755980rwK5QPADVO3KSSsD/JSCIM7xm7ZrJE+a0qZAfq/wgOzKgzkwNtgY8s5Ft0tkuRX+5kniOR1yOvK6gEHfLoEVeXUdAYB3naj+6f8gEW5XnsKu/x5t+3FPP6JdFB5y0YsEdSoUtn6kyFXC+THW8CegAUXnopAxopc1e8EkWwUEQXRAJrQDFNxQlNf1T4WG7vKUSVHeSxLJZ/tSLuYWxZgoxhRc8gnMaGzWozczFpwjcYCRReqiw0NnXAFxKtptxOnxyX5hSGOaE/26BCqfGUswj4DihWy+6KdrokGB3Mf5x5CDIWQJsVxEVF4Xn6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777304646; c=relaxed/relaxed;
	bh=R3VvLzU7Vkt+NIodPaRJoxQXwkmwFuDEX0x8xQpIwHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kAviEI6d1NCPo7du2W0cXg54vgu9umBbStKZ8jE/GsU7y2x9kbpZoy/l1pPznntoTEB8gzBfJ/hMy00M507Q1yZaN02grNmZ5h/GckA5yxrJ7XQh9f2dJqcZyb5obbar08Z0Z6HzeWn1djMmllEKbbegWcdxxojfiHp3kXfEvf48cqa8s6m+TgoLQh2QSjOJbkozZtfLTREQ/qRoiGmnaU+XkuxjfB7rEgMEM41bxi0qH81BXNbwl6uOWYX0iIDzOO41a0gpH+e5L9jOPWFh6zuR5ZtEvWS1xkZpxEZn0BAd6yAiP1JMAUByD5q/Fhzh8xlm28X8LEcNmAdmr+GooQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=B9yTiIM8; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=boqun@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=B9yTiIM8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=boqun@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g47CT42XZz2xcD
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2026 01:44:05 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 7C0A260139;
	Mon, 27 Apr 2026 15:44:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB20EC4AF0C;
	Mon, 27 Apr 2026 15:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777304642;
	bh=Y0m4lfVka5tIgD8TebgzyuHkC9SbM/oEcDxBQLbgk48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B9yTiIM819kfF4AqtE3Ts8cxL1uUeddFTUfpkn1Tg3/p51P5v+KP8Rbw/Ijny72u4
	 kd4iJpYck74XIq8bVOelJ49GL6Ec50j5Gjb9iJO9vtXfeHKwr3NIt0XBhJ0BsTuUGk
	 WS16gQ/ahwfZyttd0i1dqvbt2myBNg5nUtMBWSlJiUYdxBXB5OJLgabgbAVRxCT6BG
	 s7bWMcx5TDjScDJqGPil+/Tn0BeHulcS/d2pBRmm/Bd5pAnQMC5tdtAVVvMfLCjXiL
	 s1RZdAOmWi6dD8295iTb5uv/7DCAM+Uw9Q3QOqrQ4hYvD9sOFmlflvc6TL7zcyCvkx
	 u06DljfpNZn4w==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id EC70AF40075;
	Mon, 27 Apr 2026 11:44:00 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 27 Apr 2026 11:44:00 -0400
X-ME-Sender: <xms:QITvac-l_EHI-ECjsKgtiKMWuKRS13h2-xjfvROIW9vnGVzMFvuLcg>
    <xme:QITvaXyU06JGnq-E6Z7-Ttmzqtj92r3aHJuv_jPn770vd8yoJz5jq_gowS7AjGmIv
    WNFGSLuwNSc8hNiUxZuxmLnzXM0935ma3caGKHSxknzPOgX1NIpdQo>
X-ME-Received: <xmr:QITvacp46zHbDRfaO_VjOl62TcdrzKUkujt5a_ykvqwZ6xXOxQZaJvsS8JmiCVSwFK8inCTU3heaNYtxM1TKyj4EdLB-JEz7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejledtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtudenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    eiffevjeegvdefhfeiveejjeeihfehgfejtdfhueegheehvdehveelieelkedutdenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhn
    rghlihhthidqudeijedtleekgeejuddqudejjeekheehhedvqdgsohhquhhnpeepkhgvrh
    hnvghlrdhorhhgsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepledpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepshgrmhhirheslhhinhhugidrihgsmhdrtghomh
    dprhgtphhtthhopehprghulhhmtghksehkvghrnhgvlhdrohhrghdprhgtphhtthhopegs
    ohhquhhnrdhfvghnghesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvg
    hrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtjheskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigphhptgdquggvvheslhhishhtshdrohiilhgrsghsrdhorhhg
    pdhrtghpthhtohepshhshhgvghguvgeslhhinhhugidrihgsmhdrtghomhdprhgtphhtth
    hopegsohhquhhnsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:QITvaYphAi8BuLB7nuuWYSUE1F20CYjQxz_PCnWK6V6bX7-Ter5pvw>
    <xmx:QITvacDsnVJv5L35cYuiWeeE5OH_-E2e0eA3ImfuYc4NAhvf47j5IA>
    <xmx:QITvaWteZJOrR4miG1MzHPWOa0fR-41lqp48i09eEv3S_lUtBWiuzA>
    <xmx:QITvabIXr0wb6IyYmG0cWfGaoINODwVA7IVouYz3aGlzUbYWk4a06Q>
    <xmx:QITvadaIZ4w-XzwpW_01paghiofamfqbq9OIG9ifmrqITsiRdFijsXEh>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Apr 2026 11:44:00 -0400 (EDT)
Date: Mon, 27 Apr 2026 08:43:59 -0700
From: Boqun Feng <boqun@kernel.org>
To: Samir M <samir@linux.ibm.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
	RCU <rcu@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
	Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: Re: [mainline][BUG] Observed Workqueue lockups on offline CPUs.
Message-ID: <ae-EP1BpXgnEWCt4@tardis.local>
References: <97a7d011-d573-4754-9e5d-68b562c64089@linux.ibm.com>
 <688280dc-78a2-4796-9eaf-e1c058836012@linux.ibm.com>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <688280dc-78a2-4796-9eaf-e1c058836012@linux.ibm.com>

On Mon, Apr 27, 2026 at 05:00:10PM +0530, Samir M wrote:
> 

Hi Samir,

> On 27/04/26 3:32 pm, Samir M wrote:
> > Hi Paul,
> > 
> > I've been testing the latest upstream kernel on a PowerPC system and
> > encountered workqueue lockup issues that I've bisected to commit
> > 61bbcfb50514 ("srcu: Push srcu_node allocation to GP when
> > non-preemptible").
> > After booting, I'm seeing workqueue lockup warnings for CPUs 81-96,
> > which are offline on my system. The workqueues remain stuck for over 237
> > seconds:
> > 
> > [  243.309302][    C0] BUG: workqueue lockup - pool cpus=81 node=0
> > flags=0x4 nice=0 stuck for 237s!
> > [  243.309311][    C0] BUG: workqueue lockup - pool cpus=82 node=0
> > flags=0x4 nice=0 stuck for 237s!
> > [  243.309318][    C0] BUG: workqueue lockup - pool cpus=83 node=0
> > flags=0x4 nice=0 stuck for 237s!
> > [  243.309326][    C0] BUG: workqueue lockup - pool cpus=84 node=0
> > flags=0x4 nice=0 stuck for 237s!
> > [  243.309333][    C0] BUG: workqueue lockup - pool cpus=85 node=0
> > flags=0x4 nice=0 stuck for 237s!
> > [  243.309341][    C0] BUG: workqueue lockup - pool cpus=86 node=0
> > flags=0x4 nice=0 stuck for 237s!
> > [  243.309348][    C0] BUG: workqueue lockup - pool cpus=87 node=0
> > flags=0x4 nice=0 stuck for 237s!
> > [  243.309355][    C0] BUG: workqueue lockup - pool cpus=88 node=0
> > flags=0x4 nice=0 stuck for 237s!
> > [  243.309363][    C0] BUG: workqueue lockup - pool cpus=89 node=0
> > flags=0x4 nice=0 stuck for 237s!
> > [  243.309370][    C0] BUG: workqueue lockup - pool cpus=90 node=0
> > flags=0x4 nice=0 stuck for 237s!
> > [  243.309377][    C0] BUG: workqueue lockup - pool cpus=91 node=0
> > flags=0x4 nice=0 stuck for 237s!
> > [  243.309384][    C0] BUG: workqueue lockup - pool cpus=92 node=0
> > flags=0x4 nice=0 stuck for 237s!
> > [  243.309392][    C0] BUG: workqueue lockup - pool cpus=93 node=0
> > flags=0x4 nice=0 stuck for 237s!
> > [  243.309399][    C0] BUG: workqueue lockup - pool cpus=94 node=0
> > flags=0x4 nice=0 stuck for 237s!
> > [  243.309406][    C0] BUG: workqueue lockup - pool cpus=95 node=0
> > flags=0x4 nice=0 stuck for 237s!
> > [  243.309413][    C0] BUG: workqueue lockup - pool cpus=96 node=0
> > flags=0x4 nice=0 stuck for 237s!
> > 
> > Git bisect identified this as the first bad commit:
> > 
> > commit 61bbcfb50514a8a94e035a7349697a3790ab4783
> > Author: Paul E. McKenney <paulmck@kernel.org>
> > Date:   Fri Mar 20 20:29:20 2026 -0700
> > 
> >     srcu: Push srcu_node allocation to GP when non-preemptible
> > 
> >     When the srcutree.convert_to_big and srcutree.big_cpu_lim kernel boot
> >     parameters specify initialization-time allocation of the srcu_node
> >     tree for statically allocated srcu_struct structures (for example, in
> >     DEFINE_SRCU() at build time instead of init_srcu_struct() at
> > runtime),
> >     init_srcu_struct_nodes() will attempt to dynamically allocate this
> > tree
> >     at the first run-time update-side use of this srcu_struct structure,
> >     but while holding a raw spinlock. Because the memory allocator can
> >     acquire non-raw spinlocks, this can result in lockdep splats.
> > 
> >     This commit therefore uses the same SRCU_SIZE_ALLOC trick that is
> > used
> >     when the first run-time update-side use of this srcu_struct structure
> >     happens before srcu_init() is called. The actual allocation then
> > takes
> >     place from workqueue context at the ends of upcoming SRCU grace
> > periods.
> > 
> >     [boqun: Adjust the sha1 of the Fixes tag]
> > 
> >     Fixes: 175b45ed343a ("srcu: Use raw spinlocks so call_srcu() can be
> > used under preempt_disable()")
> >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> >     Signed-off-by: Boqun Feng <boqun@kernel.org>
> > 
> >  kernel/rcu/srcutree.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > Reverting this commit resolves the issue.
> > 
> > The problem appears to be that the workqueue is attempting to execute on
> > offline CPUs. The commit moves SRCU node allocation to workqueue context
> > to avoid lockdep issues with memory allocation under raw spinlocks,
> > which makes sense. However, it seems the workqueue scheduling doesn't
> > properly account for CPU online/offline state in this code path.
> > 
> > My test environment:
> > - Architecture: PowerPC
> > - Kernel version: Latest upstream (7.1-rc1)
> > - CPUs 81-96 are offline at boot time
> > 
> > I suspect the issue might be related to:
> > 1. Workqueue not checking CPU online status before scheduling SRCU
> > allocation work
> > 2. Missing CPU hotplug awareness in the new workqueue-based allocation
> > path
> > 3. Possible race condition with CPU hotplug events
> > 
> > Would it make sense to use queue_work_on() with explicit online CPU
> > selection, or add CPU hotplug handlers for this workqueue? I'm not
> > deeply familiar with the workqueue internals, so I might be missing
> > something.
> > Please let me know if you need any additional details or if you'd like
> > me to test any patches.
> > 
> > If you happen to fix the above issue, then please add below tag.
> > Reported-by: Samir M <samir@linux.ibm.com>
> > 
> > 
> > Thanks,
> > Samir
> 
> Hi Paul,
> 
> 
> I worked on fixing the issue and introduced the changes below. With these
> updates, I no longer observe any workqueue lockup messages for offline CPUs.
> Could you please review the changes and share your feedback?
> 
> The commit 61bbcfb50514 ("srcu: Push srcu_node allocation to GP when
> non-preemptible") introduced workqueue lockups on systems with offline
> CPUs. The issue occurs because srcu_queue_delayed_work_on() calls
> queue_work_on() with sdp->cpu, which may be offline, causing the
> workqueue to spin indefinitely on that CPU.
> 
> This patch fixes the issue by checking if the target CPU is online
> before queuing work on it. If the CPU is offline, we fall back to
> using queue_work() which will schedule the work on any available
> online CPU.
> 
> Fixes: 61bbcfb50514 ("srcu: Push srcu_node allocation to GP when
> non-preemptible")
> 
> Signed-off-by: Samir <samir@linux.ibm.com>

Thanks for the patch, but I wonder: have you checked this email thread:

	https://lore.kernel.org/rcu/ttd89ul@ub.hpns/	

Paul had a fix [1], and TJ had a "fix" [2] on workqueue side.

In general I think we discovered that as long as a CPU has been onlined
once, it's OK to queue the work on that CPU (which may be offlined) even
with our TJ's patch (whether we should do that is a different problem
;-)). Please do check whether Paul's fix works for your case, thanks!

[1]: https://lore.kernel.org/rcu/ed1fa6cd-7343-4ca3-8b9d-d699ca496f83@paulmck-laptop/
[2]: https://lore.kernel.org/rcu/adlHKowvhn8AGXCc@slm.duckdns.org/

Regards,
Boqun

> ---
>  kernel/rcu/srcutree.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 0d01cd8c4b4a..55a90dd4a030 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -869,10 +869,15 @@ static void srcu_delay_timer(struct timer_list *t)
>  static void srcu_queue_delayed_work_on(struct srcu_data *sdp,
>  unsigned long delay)
>  {
> -       if (!delay) {
> +       if (!delay && cpu_online(sdp->cpu)) {
>                 queue_work_on(sdp->cpu, rcu_gp_wq, &sdp->work);
>                 return;
> +       } else if (!delay) {
> +               /* CPU is offline, queue on any available CPU */
> +               queue_work(rcu_gp_wq, &sdp->work);
> +               return;
> +       }
> 
>         timer_reduce(&sdp->delay_work, jiffies + delay);
>  }
> --
> 
> 
> Thanks,
> Samir

