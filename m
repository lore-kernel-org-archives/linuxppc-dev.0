Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rQ2xQ5r7wzDqNj
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jun 2016 08:22:34 +1000 (AEST)
Message-ID: <1465424554.17932.14.camel@neuling.org>
Subject: Re: [PATCH v5 08/11] powerpc/powernv: Add platform support for stop
 instruction
From: Michael Neuling <mikey@neuling.org>
To: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>, benh@au1.ibm.com,
 mpe@ellerman.id.au
Cc: ego@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Thu, 09 Jun 2016 08:22:34 +1000
In-Reply-To: <57584F60.7010504@linux.vnet.ibm.com>
References: <1464871141-11568-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1464871141-11568-9-git-send-email-shreyas@linux.vnet.ibm.com>
 <1465165718.4274.20.camel@au1.ibm.com>
 <57584F60.7010504@linux.vnet.ibm.com>
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

On Wed, 2016-06-08 at 22:31 +0530, Shreyas B Prabhu wrote:
> Hi Ben,
>=20
> Sorry for the delayed response.
>=20
> On 06/06/2016 03:58 AM, Benjamin Herrenschmidt wrote:
> >=20
> > On Thu, 2016-06-02 at 07:38 -0500, Shreyas B. Prabhu wrote:
> > >=20
> > > @@ -61,8 +72,13 @@ save_sprs_to_stack:
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* Note all regi=
ster i.e per-core, per-subcore or per-thread
> > > is saved
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* here since an=
y thread in the core might wake up first
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*/
> > > +BEGIN_FTR_SECTION
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mfspr=C2=A0=C2=A0=C2=A0r3,=
SPRN_PTCR
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0std=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0r3,_PTCR(r1)
> > > +FTR_SECTION_ELSE
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mfspr=C2=A0=C2=A0=C2=
=A0r3,SPRN_SDR1
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0std=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0r3,_SDR1(r1)
> > > +ALT_FTR_SECTION_END_IFSET(CPU_FTR_ARCH_300)
> > This is the only new SPR we care about in P9 ?
> >=20
> After reviewing ISA again, I've identified LMRR, LMSER and ASDR also
> need to be restored. I've fixed this in v6.

LMRR and LMSER are used the load monitored patch set. =C2=A0There they will=
 get
restored when we context switch back to userspace. =C2=A0It probably doesn'=
t
hurt that much but you don't need to restore them here.=C2=A0

They are not used in the kernel.

It escapes me what ASDR is right now.

Mikey
