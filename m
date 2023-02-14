Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB5DC61DA4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Feb 2023 18:30:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PGVBq5zQjz3cgT
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Feb 2023 05:30:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hpBfb/N7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=jpoimboe@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hpBfb/N7;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PGV9r1nHHz3c34
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2023 05:29:52 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 07D97617B3;
	Tue, 14 Feb 2023 18:29:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8614C433EF;
	Tue, 14 Feb 2023 18:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1676399389;
	bh=oQROITW1uKecfEo2cGdUy6SKWCigHCuMd3wvoPcK/Ko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hpBfb/N7GqHlXo7xtxu5LoZyyUht86rqLf73Z3PeLujJU6jGBfG4Crx1t8FD0bkFr
	 cpbiPz0/QDlZfYRI4h2P3lLrmD5Z/xbGq7cs4Ut0xjuJi4YzSzkvOMMKpBtebTlCtL
	 l4e1AgnghjvPjyVVks0KpZOXqFcPu3BTc7mr5i2f6zK8LRTHRiYvESRTTFIvkhp+LF
	 VuUuwaRBMKyTuPkTeqMUDJ4+UTzBxdWeQgQAGNmVm18KuHS/90CWYpvajdj9AOJsed
	 2UAZeIOgM0zNiULRxmya9V9eCoG8CCRRUJHb21auhUA9pbURPxp8PbGI4vjFY9YHnJ
	 dx0ZQ0blYHc8A==
Date: Tue, 14 Feb 2023 10:29:46 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 00/24] cpu,sched: Mark arch_cpu_idle_dead() __noreturn
Message-ID: <20230214182946.x64fakiyfrjumuy2@treble>
References: <cover.1676358308.git.jpoimboe@kernel.org>
 <a48ebe98-82b5-8f7b-8327-4e60bdb231c8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a48ebe98-82b5-8f7b-8327-4e60bdb231c8@linaro.org>
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
Cc: juri.lelli@redhat.com, dalias@libc.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, peterz@infradead.org, catalin.marinas@arm.com, dave.hansen@linux.intel.com, x86@kernel.org, jiaxun.yang@flygoat.com, linux-mips@vger.kernel.org, bsegall@google.com, jcmvbkbc@gmail.com, guoren@kernel.org, hpa@zytor.com, sparclinux@vger.kernel.org, kernel@xen0n.name, will@kernel.org, vschneid@redhat.com, f.fainelli@gmail.com, vincent.guittot@linaro.org, ysato@users.sourceforge.jp, chenhuacai@kernel.org, linux@armlinux.org.uk, linux-csky@vger.kernel.org, mingo@redhat.com, bcm-kernel-feedback-list@broadcom.com, mgorman@suse.de, mattst88@gmail.com, linux-xtensa@linux-xtensa.org, paulmck@kernel.org, richard.henderson@linaro.org, npiggin@gmail.com, ink@jurassic.park.msu.ru, rostedt@goodmis.org, loongarch@lists.linux.dev, tglx@linutronix.de, dietmar.eggemann@arm.com, linux-arm-kernel@lists.infradead.org, jgross@suse.com, chris@zankel.net, tsbogend@alpha.franken.de, bristot@redhat.com, linux-kern
 el@vger.kernel.org, linux-alpha@vger.kernel.org, bp@alien8.de, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Feb 14, 2023 at 10:25:50AM +0100, Philippe Mathieu-Daudé wrote:
> On 14/2/23 08:05, Josh Poimboeuf wrote:
> > v2:
> > - make arch_call_rest_init() and rest_init() __noreturn
> > - make objtool 'global_returns' work for weak functions
> > - rebase on tip/objtool/core with dependencies merged in (mingo)
> > - add acks
> > 
> > v1.1:
> > - add __noreturn to all arch_cpu_idle_dead() implementations (mpe)
> 
> Possible similar candidates: panic_smp_self_stop, nmi_panic_self_stop
> and kexec.

Agreed.  Any volunteers?

-- 
Josh
