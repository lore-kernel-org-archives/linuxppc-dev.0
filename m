Return-Path: <SRS0=VpUd=ZH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954FCC432C3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Nov 2019 21:04:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BE5E20723
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Nov 2019 21:04:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BE5E20723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47F9p802hmzF7ht
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Nov 2019 08:04:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=srs0=+1k2=zh=goodmis.org=rostedt@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=goodmis.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47F9lv3wPpzF4nC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Nov 2019 08:02:35 +1100 (AEDT)
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com
 [66.24.58.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 03D3220723;
 Fri, 15 Nov 2019 21:02:31 +0000 (UTC)
Date: Fri, 15 Nov 2019 16:02:30 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Qian Cai <cai@lca.pw>
Subject: Re: powerpc ftrace broken due to "manual merge of the ftrace tree
 with the arm64 tree"
Message-ID: <20191115160230.78871d8f@gandalf.local.home>
In-Reply-To: <1573849732.5937.136.camel@lca.pw>
References: <1573849732.5937.136.camel@lca.pw>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 15 Nov 2019 15:28:52 -0500
Qian Cai <cai@lca.pw> wrote:

> # echo function >/sys/kernel/debug/tracing/current_tracer
>=20
> It hangs forever with today's linux-next on powerpc. Reverted the conflic=
t fix
> [1] as below fixes the issue.
>=20
> [1] https://lore.kernel.org/linux-next/20191115135357.10386fac@canb.auug.=
org.au/

What's your config file.

And can you test the two conflicting commits to see which one caused
your error?

Test this commit please: b83b43ffc6e4b514ca034a0fbdee01322e2f7022

And see if the issue is with that one, and not with the one without it.

-- Steve


>=20
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-
> generic/vmlinux.lds.h
> index 7d0d03a03d4d..a92222f79b53 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -136,29 +136,20 @@
> =C2=A0#endif
> =C2=A0
> =C2=A0#ifdef CONFIG_FTRACE_MCOUNT_RECORD
> -/*
> - * The ftrace call sites are logged to a section whose name depends on t=
he
> - * compiler option used. A given kernel image will only use one, AKA
> - * FTRACE_CALLSITE_SECTION. We capture all of them here to avoid header
> - * dependencies for FTRACE_CALLSITE_SECTION's definition.
> - */
> -/*
> - * Need to also make ftrace_graph_stub point to ftrace_stub
> - * so that the same stub location may have different protocols
> - * and not mess up with C verifiers.
> - */
> -#define MCOUNT_REC()	. =3D ALIGN(8);				\
> +#ifdef CC_USING_PATCHABLE_FUNCTION_ENTRY
> +#define MCOUNT_REC()	. =3D ALIGN(8)				\
> =C2=A0			__start_mcount_loc =3D .;			\
> -			KEEP(*(__mcount_loc))			\
> =C2=A0			KEEP(*(__patchable_function_entries))	\
> =C2=A0			__stop_mcount_loc =3D .;			\
> =C2=A0			ftrace_graph_stub =3D ftrace_stub;
> =C2=A0#else
> -# ifdef CONFIG_FUNCTION_TRACER
> -#=C2=A0=C2=A0define MCOUNT_REC()	ftrace_graph_stub =3D ftrace_stub;
> -# else
> -#=C2=A0=C2=A0define MCOUNT_REC()
> -# endif
> +#define MCOUNT_REC()	. =3D ALIGN(8);				\
> +			__start_mcount_loc =3D .;			\
> +			KEEP(*(__mcount_loc))			\
> +			__stop_mcount_loc =3D .;
> +#endif
> +#else
> +#define MCOUNT_REC()
> =C2=A0#endif
> =C2=A0
> =C2=A0#ifdef CONFIG_TRACE_BRANCH_PROFILING

