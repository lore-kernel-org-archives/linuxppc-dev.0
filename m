Return-Path: <linuxppc-dev+bounces-28407-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9578DCA5FA2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Sep 2026 13:06:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hthQm6Wdcz2yMK;
	Mon, 28 Sep 2026 23:06:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:203:375::56"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790585564;
	cv=none; b=SvUEouc+CTOH/bzoooqfSj8oej+SUyWseWzBcfLW+YvTJFmxP45W10y82HfX4+6Wij2ZVwxjFCZc0/Llf15qQZ3vQVZuE9PP2KCpCeINfGSty7apKXAGl0A2h0ec2yJz/qrWveLtBKoWSyeBkgz2Cia9o3b0t0c+gsOb3AWeDpwUAuW9ETjW1CWcMFVtpMN1YZgTLZgSUPstA9o727Dd+zAX21ijR8ZaS9QOmvaSSIsdKloxi3j4Yadjd6ZELVyZF7C1wh/7pbIRF5GfIJzq5DNZgOGviVIjLHttGHMTj33SHjaKEas/bMeJdGyANmoHLbCjlgcJE1FrRHteLac5WA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790585564; c=relaxed/relaxed;
	bh=IRppXMJnpSyXUWhx7h9fDk7loXcgNTjvSS2BT0oKFKU=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=GeJSbpdhENntymMg+/ONfJEpyK7x9aKPwzDUKPB2PxtdlnlsHPCySm/VkWeyv5btc39Dpov3H5cxPLRSs4tGbwabA73wCM9jY22LvUmLcMUqb9QDHEYviBmNYLUTtp5qcxtjoJyfASmJFCT5wA4S5kKvSdiTVeqditLfChbNDVtJEYJBst4QkrlYGaps83Ei4oA4/CT9y2vkRmcJ4+Qed7Hs18zuMpI9NpmOJ1dsaEh/BhHMMBrS8lZJWr9uLwEm9cNmbxlS7G9djPjzYowasykzoU7EkKxWVTl627sHYEhgHgQOVYUhxn5a6ZvpYma03pY9QFGEdQ3DgnvoKjBI+Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=GBaWqE9r; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:203:375::56; helo=mta1.migadu.com; envelope-from=florent.revest@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=GBaWqE9r;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:203:375::56; helo=mta1.migadu.com; envelope-from=florent.revest@linux.dev; receiver=lists.ozlabs.org)
X-Greylist: delayed 79 seconds by postgrey-1.37 at boromir; Mon, 28 Sep 2026 18:52:40 AEST
Received: from mta1.migadu.com (out-86.mta1.migadu.com [IPv6:2001:41d0:203:375::56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4htZnh3BCLz30V6
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 18:52:40 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=09WBzyqcOHBSt5hLHqAwbTciP1G0S+c8iry/IFi/HlI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790585541; v=1; x=1791190341;
 b=GBaWqE9rjXleje9mmHCP+jkF7++JJqEznaH1Oqa09dFjPxg+EdrJXdzaAap1ozCXKg3k7y9M
 v2Dbt40b0dGhVJU90W8wfzZRie+wI+3bchwIi4iIS/RpGP89GQPHImCIw2TQt9hW7gcKCy/cWMV
 d2ZS8gBW3nIpf2GmRvwMNNGE=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id dcca5a333ecbdbdc;
	Mon, 28 Sep 2026 08:50:58 +0000
X-Mizu-Trace-ID: dcca5a333ecbdbdc
X-Migadu-Flow: FLOW_OUT
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
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Sep 2026 08:50:55 +0000
Message-Id: <DLQTKIGNXKLS.1E0Y9RS93S82N@linux.dev>
From: "Florent Revest" <florent.revest@linux.dev>
To: <bot+bpf-ci@kernel.org>, <bpf@vger.kernel.org>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <andrii@kernel.org>
Cc: <martin.lau@linux.dev>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <song@kernel.org>, <yonghong.song@linux.dev>, <jolsa@kernel.org>,
 <kpsingh@kernel.org>, <john.fastabend@gmail.com>, <leon.hwang@linux.dev>,
 <zirajs7@gmail.com>, <rhkrqnwk98@gmail.com>, <puranjay@kernel.org>,
 <xukuohai@huaweicloud.com>, <iii@linux.ibm.com>, <hbathini@linux.ibm.com>,
 <chleroy@kernel.org>, <naveen@kernel.org>, <bjorn@kernel.org>,
 <pulehui@huawei.com>, <yangtiezhu@loongson.cn>, <hengqi.chen@gmail.com>,
 <linux-kernel@vger.kernel.org>, <aou@eecs.berkeley.edu>,
 <agordeev@linux.ibm.com>, <alex@ghiti.fr>, <bp@alien8.de>,
 <catalin.marinas@arm.com>, <borntraeger@linux.ibm.com>,
 <dave.hansen@linux.intel.com>, <emil@etsalapatis.com>, <hca@linux.ibm.com>,
 <hpa@zytor.com>, <chenhuacai@kernel.org>, <ihor.solodrai@linux.dev>,
 <mingo@redhat.com>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kselftest@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-riscv@lists.infradead.org>, <linux-s390@vger.kernel.org>,
 <loongarch@lists.linux.dev>, <maddy@linux.ibm.com>, <mark.rutland@arm.com>,
 <mpe@ellerman.id.au>, <npiggin@g>
Subject: Re: [PATCH bpf v5 1/3] bpf: Wait for an RCU tasks grace period
 before freeing trampoline progs
X-Mailer: aerc 0.17.0
References: <20260926135605.1217928-2-florent.revest@linux.dev>
 <9d932a22ca908da9378ea281633ddb749453911ac6ae7a27a09e376f9ad02ff7@mail.kernel.org>
In-Reply-To: <9d932a22ca908da9378ea281633ddb749453911ac6ae7a27a09e376f9ad02ff7@mail.kernel.org>

On Sun Sep 27, 2026 at 8:41 PM UTC,  wrote:
> > bpf: Wait for an RCU tasks grace period before freeing trampoline progs
> >
> > When a prog is detached from a trampoline, it is freed after an RCU
> > grace period, or an RCU tasks trace one if it is sleepable. This covers
> > the tasks that are running the prog, since the prog's enter helper take=
s
> > the matching read lock before the prog is called. On a preemptible
> > kernel, it doesn't cover a task that was preempted in the trampoline
> > just before the enter helper. That task holds no lock yet, and it calls
> > the prog after it was freed:
> >
> >   BUG: KASAN: vmalloc-out-of-bounds in __bpf_prog_enter_recur+0x3a5/0x3=
f0
> >   Read of size 8 at addr ffffc90000055040 by task candidate/110
> >   CPU: 1 UID: 0 PID: 110 Comm: candidate Not tainted 7.3.0-rc2-00014-g1=
5071f2a1263-dirty #2 PREEMPT(full)
> >   Call Trace:
> >    <TASK>
> >    __bpf_prog_enter_recur+0x3a5/0x3f0
> >    bpf_trampoline_6442509193+0x37/0xf1
> >    __x64_sys_futex+0x9/0x410
> >    do_syscall_64+0xb0/0x530
> >    ...
> >
> > Wait for an RCU tasks grace period before the existing one when freeing
> > a prog that was linked to a trampoline. An RCU tasks grace period only
> > ends once the tasks that were preempted have run again, and
> > bpf_tramp_image_put() already relies on it to free the image. It doesn'=
t
> > wait for tasks that sleep in the trampoline, the next commit takes care
> > of those.
> >
> > Only progs that were linked to a trampoline can be called this way, so
> > bpf_trampoline_add_prog() marks them and other progs are still freed as
> > before.
> >
> > Fixes: e21aa341785c ("bpf: Fix fexit trampoline.")
>
> Is this the right Fixes: target?
>
> The race being closed here (a task preempted inside the trampoline image
> before __bpf_prog_enter*() takes its RCU read lock, while the prog is fre=
ed
> after only a regular RCU or RCU tasks trace grace period) appears to pred=
ate
> e21aa341785c.
>
> In fec56f5890d9 ("bpf: Introduce BPF trampoline") bpf_trampoline_update()
> switched images with no tasks RCU wait, and __bpf_prog_put_noref() freed =
the
> prog with a plain call_rcu(&prog->aux->rcu, __bpf_prog_put_rcu).
>
> Just before e21aa341785c, the synchronize_rcu_mult(call_rcu_tasks,
> call_rcu_tasks_trace) in bpf_trampoline_update() ran before
> arch_prepare_bpf_trampoline() rather than after the new image was install=
ed,
> and the total =3D=3D 0 unregister_fentry() path had no wait at all, so a =
task
> preempted in the old image could already reach a freed prog.
>
> Would Fixes: fec56f5890d9 ("bpf: Introduce BPF trampoline") be more
> accurate, so that stable trees without e21aa341785c also pick this up? Th=
e
> follow-up 49ca60187380 in this series uses the same tag.

Yeah, that seems right. It shouldn't make much of a difference for stable
because both have been introduced in the same 5.10.y. I can either switch t=
his
if there's a v6 or a maintainer can change when applying.

