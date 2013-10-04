Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-ee0-x22d.google.com (mail-ee0-x22d.google.com
 [IPv6:2a00:1450:4013:c00::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B46212C009A
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Oct 2013 03:35:49 +1000 (EST)
Received: by mail-ee0-f45.google.com with SMTP id c50so1972316eek.18
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Oct 2013 10:35:43 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Fri, 4 Oct 2013 19:35:40 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH v3 net-next] fix unsafe set_memory_rw from softirq
Message-ID: <20131004173540.GB15689@gmail.com>
References: <1380853446-30537-1-git-send-email-ast@plumgrid.com>
 <20131004075133.GA12313@gmail.com>
 <CANn89iKkbR0_HaofvC_OVvqRv_Hqj3rATx-Z_4xXeusOasa56g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CANn89iKkbR0_HaofvC_OVvqRv_Hqj3rATx-Z_4xXeusOasa56g@mail.gmail.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux@vger.kernel.org, Nicolas Dichtel <nicolas.dichtel@6wind.com>,
 Alexei Starovoitov <ast@plumgrid.com>, linux-s390@vger.kernel.org,
 Russell King <linux@arm.linux.org.uk>, x86@kernel.org,
 James Morris <jmorris@namei.org>, Ingo Molnar <mingo@redhat.com>,
 Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Xi Wang <xi.wang@gmail.com>,
 Matt Evans <matt@ozlabs.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, Stelian Nirlu <steliannirlu@gmail.com>,
 Nicolas Schichan <nschichan@freebox.fr>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev <netdev@vger.kernel.org>,
 linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Mircea Gherzan <mgherzan@gmail.com>, Daniel Borkmann <dborkman@redhat.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
 linuxppc-dev@lists.ozlabs.org, Patrick McHardy <kaber@trash.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Eric Dumazet <edumazet@google.com> wrote:

> 1)
> >
> > I took a brief look at arch/x86/net/bpf_jit_comp.c while reviewing this
> > patch.
> >
> > You need to split up bpf_jit_compile(), it's an obscenely large, ~600
> > lines long function. We don't do that in modern, maintainable kernel code.
> >
> > 2)
> >
> > This 128 bytes extra padding:
> >
> >         /* Most of BPF filters are really small,
> >          * but if some of them fill a page, allow at least
> >          * 128 extra bytes to insert a random section of int3
> >          */
> >         sz = round_up(proglen + sizeof(*header) + 128, PAGE_SIZE);
> >
> > why is it done? It's not clear to me from the comment.
> >
> 
> commit 314beb9bcabfd6b4542ccbced2402af2c6f6142a
> Author: Eric Dumazet <edumazet@google.com>
> Date:   Fri May 17 16:37:03 2013 +0000
> 
>     x86: bpf_jit_comp: secure bpf jit against spraying attacks
> 
>     hpa bringed into my attention some security related issues
>     with BPF JIT on x86.
> 
>     This patch makes sure the bpf generated code is marked read only,
>     as other kernel text sections.
> 
>     It also splits the unused space (we vmalloc() and only use a fraction of
>     the page) in two parts, so that the generated bpf code not starts at a
>     known offset in the page, but a pseudo random one.

Thanks for the explanation - that makes sense.

	Ingo
