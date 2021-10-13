Return-Path: <SRS0=X2ql=PB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1399AC433F5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Oct 2021 02:28:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25F3060F92
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Oct 2021 02:28:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 25F3060F92
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HTc0L3TcQz2ygC
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Oct 2021 13:28:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=srs0=7yos=pb=goodmis.org=rostedt@kernel.org; receiver=<UNKNOWN>)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HTbzp2CS1z2xKY
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Oct 2021 13:28:06 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 17A2560F11;
 Wed, 13 Oct 2021 02:28:00 +0000 (UTC)
Date: Tue, 12 Oct 2021 22:27:58 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Subject: Re: [PATCH 1/2] ftrace: disable preemption on the testing of recursion
Message-ID: <20211012222758.1a029157@oasis.local.home>
In-Reply-To: <74090798-7d93-0713-982c-6f0247118d20@linux.alibaba.com>
References: <8c7de46d-9869-aa5e-2bb9-5dbc2eda395e@linux.alibaba.com>
 <a8756482-024c-c858-b3d1-1ffa9a5eb3f7@linux.alibaba.com>
 <alpine.LSU.2.21.2110121421260.3394@pobox.suse.cz>
 <74090798-7d93-0713-982c-6f0247118d20@linux.alibaba.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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
Cc: "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Guo Ren <guoren@kernel.org>, Jisheng Zhang <jszhang@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, live-patching@vger.kernel.org,
 linux-riscv@lists.infradead.org, Miroslav Benes <mbenes@suse.cz>,
 Paul Mackerras <paulus@samba.org>, Joe Lawrence <joe.lawrence@redhat.com>,
 Helge Deller <deller@gmx.de>, x86@kernel.org, linux-csky@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Petr Mladek <pmladek@suse.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Jiri Kosina <jikos@kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>, Borislav Petkov <bp@alien8.de>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Colin Ian King <colin.king@canonical.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 13 Oct 2021 09:50:17 +0800
=E7=8E=8B=E8=B4=87 <yun.wang@linux.alibaba.com> wrote:

> >> -	preempt_enable_notrace();
> >>  	ftrace_test_recursion_unlock(bit);
> >>  } =20
> >=20
> > I don't like this change much. We have preempt_disable there not becaus=
e=20
> > of ftrace_test_recursion, but because of RCU. ftrace_test_recursion was=
=20
> > added later. Yes, it would work with the change, but it would also hide=
=20
> > things which should not be hidden in my opinion. =20
>=20
> Not very sure about the backgroup stories, but just found this in
> 'Documentation/trace/ftrace-uses.rst':
>=20
>   Note, on success,
>   ftrace_test_recursion_trylock() will disable preemption, and the
>   ftrace_test_recursion_unlock() will enable it again (if it was previous=
ly
>   enabled).

Right that part is to be fixed by what you are adding here.

The point that Miroslav is complaining about is that the preemption
disabling is special in this case, and not just from the recursion
point of view, which is why the comment is still required.

-- Steve


>=20
> Seems like this lock pair was supposed to take care the preemtion itself?
