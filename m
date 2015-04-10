Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B3FBF1A0415
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 13:03:54 +1000 (AEST)
Message-ID: <1428635033.1554.49.camel@neuling.org>
Subject: Re: [V6,1/9] elf: Add new powerpc specifc core note sections
From: Michael Neuling <mikey@neuling.org>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Fri, 10 Apr 2015 13:03:53 +1000
In-Reply-To: <55267595.9030202@linux.vnet.ibm.com>
References: <20141203052204.9DA8F1400DD@ozlabs.org>
 <547EB253.5050307@linux.vnet.ibm.com> <548578A8.5020901@linux.vnet.ibm.com>
 <54947C64.4030206@linux.vnet.ibm.com> <54A50094.5070902@linux.vnet.ibm.com>
 <1421883597.30744.3.camel@neuling.org>
 <OFC6CFC348.C619B89D-ONC1257DD5.0056279B-C1257DD5.00577002@de.ibm.com>
 <1421963049.30744.23.camel@neuling.org>
 <1422419289.9646.20.camel@neuling.org>
 <OFE5516C3F.3C4884DE-ONC1257DE4.004E7852-C1257DE4.00514232@de.ibm.com>
 <1424667110.16027.6.camel@neuling.org>
 <OF5DE08D4B.0B79C501-ONC1257E0C.0044F80B-C1257E0C.0046DC8F@de.ibm.com>
 <1426718702.4866.2.camel@neuling.org> <1426719027.4866.4.camel@neuling.org>
 <550FEC36.8080803@linux.vnet.ibm.com>
 <OF91038A37.65C405E5-ONC1257E21.0061938F-C1257E21.00620A03@de.ibm.com>
 <1428534695.4682.18.camel@neuling.org>
 <55267595.9030202@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: james.hogan@imgtec.com, avagin@openvz.org, Paul.Clothier@imgtec.com,
 linuxppc-dev@ozlabs.org, peterz@infradead.org, palves@redhat.com,
 davem@davemloft.net, shuahkh@osg.samsung.com, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, dhowells@redhat.com,
 Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, kirjanov@gmail.com,
 oleg@redhat.com, davej@redhat.com, tglx@linutronix.de,
 sukadev@linux.vnet.ibm.com,
 Edjunior Barbosa Machado <emachado@linux.vnet.ibm.com>,
 sam.bobroff@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-04-09 at 18:20 +0530, Anshuman Khandual wrote:
> On 04/09/2015 04:41 AM, Michael Neuling wrote:
> > On Wed, 2015-04-08 at 19:50 +0200, Ulrich Weigand wrote:
> >> Anshuman Khandual <khandual@linux.vnet.ibm.com> wrote on 23.03.2015
> >> 11:34:30:
> >>
> >>>> With that in mind, do we have a way to set the top 32bits of the MSR
> >>>> (which contain the TM bits) when ptracing 32 bit processes?  I can't
> >>>> find anything like that in this patch set.
> >>>
> >>> No, we dont have that yet. When ptracing in 32-bit mode the MSR value
> >>> which can be viewed or set from the user space through PTRACE_GETREGS
> >>> PTRACE_SETREGS call is it's lower 32 bits only. Either we can club
> >>> the upper 32 bits of MSR as part of one of the ELF core notes we are
> >>> adding in the patch series or we can create one more separate ELF cor=
e
> >>> note for that purpose. Let me know your opinion on this.
> >>
> >> I'm not sure I understand this.  I thought we had the following:
> >>
> >> - If the process calling ptrace is itself 64-bit (which is how GDB is
> >>   built on all current Linux distributions), then PTRACE_GETREGS etc.
> >>   will *always* operate on 64-bit register sets, even if the target
> >>   process is 32-bit.
> >>
> >> - If the process calling ptrace is 32-bit, then PTRACE_GETREGS will
> >>   operate on 32-bit register sets.   However, there is a separate
> >>   PTRACE_GETREGS64 / PTRACE_SETREGS64 call that will also provide
> >>   the opportunity to operate on the full 64-bit register set.  Both
> >>   apply independently of whether the target process is 32-bit or
> >>   64-bit.
> >>
> >> Is this not correct?
> >=20
> > I think you're correct.  We should be right.  I'd forgotten about the
> > GET/SETREGS64 interfaces.
>=20
> In that case, is the patch series complete and okay ? Is there any thing
> else we need to verify other than waiting for the GDB test results which
> Edjunior has been working on. But I am not aware of the status on the GDB
> test development front.

I think we are good.

Mikey

>=20
> Edjunior,
>=20
> Do you have any updates ?
>=20
> Regards
> Anshuman
>=20
>=20
