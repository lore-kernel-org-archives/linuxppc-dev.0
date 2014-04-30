Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/3] Add new ptrace request macros on PowerPC
In-reply-to: <535F997B.3000500@linux.vnet.ibm.com>
References: <1396422144-11032-1-git-send-email-khandual@linux.vnet.ibm.com>
 <533BD922.4070009@linux.vnet.ibm.com> <535F4E10.2020300@linux.vnet.ibm.com>
 <CAEjGV6yi5YY95tM-HY4akN4BGXGn4chA8_sCaqvWx3HPSu2V3w@mail.gmail.com>
 <535F5BDE.2030309@linux.vnet.ibm.com>
 <CAEjGV6y8MRiCfRBtWjNfrwKMccROEAJw2rPVc_u+r=tAo2EcHQ@mail.gmail.com>
 <535F997B.3000500@linux.vnet.ibm.com>
Date: Wed, 30 Apr 2014 10:29:05 +1000
Message-ID: <20730.1398817745@ale.ozlabs.ibm.com>
Cc: Linux PPC dev <linuxppc-dev@ozlabs.org>, linux-kernel@vger.kernel.org,
 avagin@openvz.org, roland@redhat.com, oleg@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anshuman Khandual <khandual@linux.vnet.ibm.com> wrote:

> On 04/29/2014 01:52 PM, Michael Neuling wrote:
> > That's not what that patch does. It shouldn't make any user visible changes
> > to DSCR or PPR.
> 
> It may not when it runs uninterrupted but after the tracee process has
> stopped, thread.dscr reflects the default DSCR value as mentioned
> before. This can be proved by changing the "dscr_default" value in
> arch/powerpc/sysfs.c file.

The intention with DSCR is that if the user changes the DSCR, the kernel
should always save/restore it.  If you are seeing something else, then
that is a bug.  Anton has a test case for this here:

  http://ozlabs.org/~anton/junkcode/dscr_explicit_test.c

If that is failing, then there is a bug that we need to fix.

The PPR is the same, except that the kernel can change it over a
syscall.

> > Over syscall PPR and DSCR may change.

Sorry, this should be only PPR.  DSCR shouldn't change over a syscall,
at least that's the intention.

> > Depending on your test case, that may
> > be your problem.
> 
> I would guess when the tracee process stops for ptrace analysis, tm_reclaim or
> tm_recheckpoint path might be crossed which is causing this dscr_default value
> to go into thread_struct.

That shouldn't happen.  If that's happening, it's a bug.

Mikey
