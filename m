Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2057E1A0163
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 13:41:20 +1000 (AEST)
Message-ID: <1437018079.28475.5.camel@ellerman.id.au>
Subject: Re: [RFC PATCH 11/12] selftests/seccomp: Make seccomp tests work on
 big endian
From: Michael Ellerman <mpe@ellerman.id.au>
To: Kees Cook <keescook@chromium.org>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>, LKML
 <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>, Will
 Drewry <wad@chromium.org>, strosake@linux.vnet.ibm.com,
 bogdan.purcareata@freescale.com
Date: Thu, 16 Jul 2015 13:41:19 +1000
In-Reply-To: <CAGXu5j+CNxPSzA83UJDEdr_0G14qqX4yNdhr5+2YrisE8O6eeg@mail.gmail.com>
References: <1436945834-26660-1-git-send-email-mpe@ellerman.id.au>
 <1436945834-26660-11-git-send-email-mpe@ellerman.id.au>
 <CAGXu5j+CNxPSzA83UJDEdr_0G14qqX4yNdhr5+2YrisE8O6eeg@mail.gmail.com>
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

On Wed, 2015-07-15 at 08:16 -0700, Kees Cook wrote:
> On Wed, Jul 15, 2015 at 12:37 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> > diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> > index b2374c131340..51adb9afb511 100644
> > --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> > +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> > @@ -82,7 +82,13 @@ struct seccomp_data {
> >  };
> >  #endif
> >
> > +#if __BYTE_ORDER == __LITTLE_ENDIAN
> >  #define syscall_arg(_n) (offsetof(struct seccomp_data, args[_n]))
> > +#elif __BYTE_ORDER == __BIG_ENDIAN
> > +#define syscall_arg(_n) (offsetof(struct seccomp_data, args[_n]) + sizeof(__u32))
> > +#else
> > +#error "wut?"
> > +#endif
> 
> Ah-ha! Yes, thanks. Could you change the #error to something that
> describes the particular (impossible) failure condition? "wut? Unknown
> __BYTE_ORDER?!". Not a huge deal, but I always like verbose errors. :)
> Especially for "impossible" situations. :)

Yeah sorry that was a "quick hack" which got promoted into an actual patch.

Fixed to use your message.

cheers
