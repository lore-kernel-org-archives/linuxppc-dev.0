Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40q1tG0pTTzF0Tj
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2018 11:49:42 +1000 (AEST)
Message-ID: <7ea12ca168a0fd27b4904265912c85f8bb7fd81b.camel@neuling.org>
Subject: Re: [PATCH 2/2] powerpc/ptrace: Fix setting 512B aligned
 breakpoints with PTRACE_SET_DEBUGREG
From: Michael Neuling <mikey@neuling.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Edjunior Barbosa Machado
 <emachado@linux.vnet.ibm.com>, Pedro Franco de Carvalho
 <pedromfc@linux.vnet.ibm.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
Date: Mon, 21 May 2018 11:49:41 +1000
In-Reply-To: <87po1txgu9.fsf@concordia.ellerman.id.au>
References: <20180517053715.24011-1-mikey@neuling.org>
 <20180517053715.24011-2-mikey@neuling.org>
 <87po1txgu9.fsf@concordia.ellerman.id.au>
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

On Fri, 2018-05-18 at 22:56 +1000, Michael Ellerman wrote:
> Michael Neuling <mikey@neuling.org> writes:
> > In this change:
> >   e2a800beac powerpc/hw_brk: Fix off by one error when validating DAWR
> > region end
> >=20
> > We fixed setting the DAWR end point to its max value via
> > PPC_PTRACE_SETHWDEBUG. Unfortunately we broke PTRACE_SET_DEBUGREG when
> > setting a 512 byte aligned breakpoint.
> >=20
> > PTRACE_SET_DEBUGREG currently sets the length of the breakpoint to
> > zero (memset() in hw_breakpoint_init()).  This worked with
> > arch_validate_hwbkpt_settings() before the above patch was applied but
> > is now broken if the breakpoint is 512byte aligned.
> >=20
> > This sets the length of the breakpoint to 8 bytes when using
> > PTRACE_SET_DEBUGREG.
> >=20
> > Signed-off-by: Michael Neuling <mikey@neuling.org>
> > Cc: stable@vger.kernel.org # 3.10+
>=20
> If this is "fixing" e2a800beac then I think v3.11 is right for the
> stable tag?
>=20
> $ git describe --contains --long e2a800beaca1
> v3.11-rc1~94^2~4

You're right. I think read the output of gitk incorrectly.

Thanks.
Mikey
