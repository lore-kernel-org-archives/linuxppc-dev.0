Return-Path: <B40534@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0249.outbound.messaging.microsoft.com [213.199.154.249])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 11C502C00D2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jul 2013 15:27:32 +1000 (EST)
From: Wang Dongsheng-B40534 <B40534@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>, "benh@kernel.crashing.org"
 <benh@kernel.crashing.org>
Subject: RE: [RFC 1/2] fsl/pm: combined the idle(PH&PW) state
Date: Tue, 30 Jul 2013 05:27:22 +0000
Message-ID: <ABB05CD9C9F68C46A5CEDC7F15439259FEF0ED@039-SN2MPN1-021.039d.mgd.msft.net>
References: <1373444876-7783-1-git-send-email-dongsheng.wang@freescale.com>
 <1375118509.30721.42@snotra>
In-Reply-To: <1375118509.30721.42@snotra>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Li Yang-R58472 <r58472@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Zhao Chenhui-B35336 <B35336@freescale.com>
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
> Sent: Tuesday, July 30, 2013 1:22 AM
> To: Wang Dongsheng-B40534
> Cc: benh@kernel.crashing.org; galak@kernel.crashing.org; Zhao Chenhui-
> B35336; Li Yang-R58472; Wang Dongsheng-B40534
> Subject: Re: [RFC 1/2] fsl/pm: combined the idle(PH&PW) state
>=20
> On 07/10/2013 03:27:55 AM, Dongsheng Wang wrote:
> > From: Wang Dongsheng <dongsheng.wang@freescale.com>
> >
> > move wait instructions from idle_e500.S to idle_book3e.S
> >
> > idle_e500.S: rename e500_idle to e500_idle_ph.
>=20
> What does _ph mean?
>=20
> If this is a reference to the new PHnn/PWnn terminology used on e6500, I
> don't see how that's relevant to this file, which isn't used on e6500.
> Or if you do plan to use this on e6500, why?
>=20
ph10/ph15 means doze/nap on freescale e500 family processors. On the IBM
platform does not "ph" concept.

Yes, "ph" maybe that's not a good idea. We should keep e500_idle.
On e500 processor, there is doze/nap, but e500mc/e5500/e6500 is using "wait=
".

I want to move "wait" from idle_e500.S into idle_book3e.S, but "book3e" mea=
ns
64bit mode... Now 32bit using idle_e500, 64bit using idle_book3e, and the i=
dle method
does not distinguish according to the platform, only in accordance with the=
 CPU
running mode(32bit/64bit) to distinguish.

So did you have any idea about this? Or another way as follows,

We do not touch idle_e500.S and idle_e6500.S, add fsl_cpuidle_wait() into "=
machdep.h"

arch/powerpc/include/asm/machdep.h
/* Wait for Interrupt */
static inline void fsl_cpuidle_wait(void)
{
#ifdef CONFIG_PPC64
        book3e_idle();
#else
        e500_idle();
#endif
}
