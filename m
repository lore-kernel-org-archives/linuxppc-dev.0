Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7913D1A0163
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 13:38:43 +1000 (AEST)
Message-ID: <1437017923.28475.4.camel@ellerman.id.au>
Subject: Re: [RFC PATCH 09/12] powerpc/kernel: Add SIG_SYS support for
 compat tasks
From: Michael Ellerman <mpe@ellerman.id.au>
To: Kees Cook <keescook@chromium.org>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>, LKML
 <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>, Will
 Drewry <wad@chromium.org>, strosake@linux.vnet.ibm.com,
 bogdan.purcareata@freescale.com
Date: Thu, 16 Jul 2015 13:38:43 +1000
In-Reply-To: <CAGXu5jKX2OsQz0by52ZahiFXn89u4YQ8WHNv7b1XkpL0W+yW_w@mail.gmail.com>
References: <1436945834-26660-1-git-send-email-mpe@ellerman.id.au>
 <1436945834-26660-9-git-send-email-mpe@ellerman.id.au>
 <CAGXu5jKX2OsQz0by52ZahiFXn89u4YQ8WHNv7b1XkpL0W+yW_w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-07-15 at 08:12 -0700, Kees Cook wrote:
> On Wed, Jul 15, 2015 at 12:37 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> > diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> > index c5abe7fd7590..b2374c131340 100644
> > --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> > +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> > @@ -645,6 +645,10 @@ static struct siginfo TRAP_info;
> >  static volatile int TRAP_nr;
> >  static void TRAP_action(int nr, siginfo_t *info, void *void_context)
> >  {
> > +       fprintf(stderr, "in TRAP_action\n");
> > +       fprintf(stderr, "info->si_call_addr %p\n", info->si_call_addr);
> > +       fprintf(stderr, "info->si_syscall %u\n", info->si_syscall);
> > +       fprintf(stderr, "info->si_arch %u\n", info->si_arch);
> >         memcpy(&TRAP_info, info, sizeof(TRAP_info));
> >         TRAP_nr = nr;
> >  }
> 
> This chunk looks like left-over debugging?

Urgh yep, that's ugly. Thanks for noticing.

Will remove before merging :)

cheers
