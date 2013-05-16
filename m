Return-Path: <R65777@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4C8952C012D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 May 2013 03:02:41 +1000 (EST)
From: Bhushan Bharat-R65777 <R65777@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH 2/2 v2] powerpc: restore dbcr0 on user space exit
Date: Thu, 16 May 2013 17:03:00 +0000
Message-ID: <6A3DF150A5B70D4F9B66A25E3F7C888D0701D79B@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1368682472-4268-3-git-send-email-Bharat.Bhushan@freescale.com>
 (from r65777@freescale.com on Thu May 16 00:34:32 2013)
 <1368723257.8202.43@snotra>
In-Reply-To: <1368723257.8202.43@snotra>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Yang James-RA8135 <RA8135@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Yoder Stuart-B08248 <B08248@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Thursday, May 16, 2013 10:24 PM
> To: Bhushan Bharat-R65777
> Cc: galak@kernel.crashing.org; benh@kernel.crashing.org; linuxppc-
> dev@lists.ozlabs.org; Yoder Stuart-B08248; Yang James-RA8135; Bhushan Bha=
rat-
> R65777
> Subject: Re: [PATCH 2/2 v2] powerpc: restore dbcr0 on user space exit
>=20
> On 05/16/2013 12:34:32 AM, Bharat Bhushan wrote:
> > On BookE (Branch taken + Single Step) is as same as Branch Taken on
> > BookS and in Linux we simulate BookS behavior for BookE as well.
> > When doing so, in Branch taken handling we want to set DBCR0_IC but we
> > update the current->thread->dbcr0 and not DBCR0.
> >
> > Now on 64bit the current->thread.dbcr0 (and other debug registers) is
> > synchronized ONLY on context switch flow. But after handling Branch
> > taken in debug exception if we return back to user space without
> > context switch then single stepping change (DBCR0_ICMP) does not get
> > written in h/w DBCR0 and Instruction Complete exception does not
> > happen.
> >
> > This fixes using ptrace reliably on BookE-PowerPC
> >
> > Signed-off-by: Bharat Bhushan <bharat.bhushan@freescale.com>
> > ---
> > v1->v2
> >  - Subject line was not having 2/2
> >
> >  arch/powerpc/kernel/asm-offsets.c |    1 +
> >  arch/powerpc/kernel/entry_64.S    |   24 ++++++++++++++++++++----
> >  2 files changed, 21 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/powerpc/kernel/asm-offsets.c
> > b/arch/powerpc/kernel/asm-offsets.c
> > index b51a97c..1e2f450 100644
> > --- a/arch/powerpc/kernel/asm-offsets.c
> > +++ b/arch/powerpc/kernel/asm-offsets.c
> > @@ -103,6 +103,7 @@ int main(void)
> >  #endif /* CONFIG_VSX */
> >  #ifdef CONFIG_PPC64
> >  	DEFINE(KSP_VSID, offsetof(struct thread_struct, ksp_vsid));
> > +	DEFINE(THREAD_DBCR0, offsetof(struct thread_struct, dbcr0));
> >  #else /* CONFIG_PPC64 */
> >  	DEFINE(PGDIR, offsetof(struct thread_struct, pgdir));  #if
> > defined(CONFIG_4xx) || defined(CONFIG_BOOKE) diff --git
> > a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> > index 794889b..561630d 100644
> > --- a/arch/powerpc/kernel/entry_64.S
> > +++ b/arch/powerpc/kernel/entry_64.S
> > @@ -614,7 +614,9 @@ _GLOBAL(ret_from_except_lite)
> >  	 * from the interrupt.
> >  	 */
> >  #ifdef CONFIG_PPC_BOOK3E
> > +	ld	r3,PACACURRENT(r13)
> >  	wrteei	0
> > +	lwz	r10,(THREAD+THREAD_DBCR0)(r3)
>=20
> I know I asked you to move these earlier, but this is probably too early.=
..
> wrteei has synchronization, so it will probably have to wait until the ld
> completes, defeating the purpose of moving it earlier.
>=20
> Ideal would probably be to load PACACURRENT immediately after _MSR(r1), a=
nd load
> DBCR0 just after "beq resume_kernel".

ok

>=20
> Or, move DBCR0 to therad_info as I suggested internally.

If no one have objection on moving dbcr0 to thread_info then I am happy to =
do that.

>=20
> Regardless of what you do, could you run a basic syscall benchmark (e.g. =
from
> lmbench) before and after the patch?

Sure.

-Bharat
>=20
> -Scott
