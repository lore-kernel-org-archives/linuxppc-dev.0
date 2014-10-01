Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 03EAD1A1789
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Oct 2014 20:51:43 +1000 (EST)
Message-ID: <1412160702.19209.59.camel@ale.ozlabs.ibm.com>
Subject: Re: [PATCH v2 03/17] powerpc/cell: Make spu_flush_all_slbs() generic
From: Michael Neuling <mikey@neuling.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Wed, 01 Oct 2014 20:51:42 +1000
In-Reply-To: <20141001071330.E4262140174@ozlabs.org>
References: <20141001071330.E4262140174@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: cbe-oss-dev@lists.ozlabs.org, arnd@arndb.de, "Aneesh
 Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, greg@kroah.com,
 linux-kernel@vger.kernel.org, imunsie@au.ibm.com, linuxppc-dev@ozlabs.org,
 anton@samba.org, jk@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-10-01 at 17:13 +1000, Michael Ellerman wrote:
> On Tue, 2014-30-09 at 10:34:52 UTC, Michael Neuling wrote:
> > diff --git a/arch/powerpc/include/asm/copro.h b/arch/powerpc/include/as=
m/copro.h
> > index 2858108..f3d338f 100644
> > --- a/arch/powerpc/include/asm/copro.h
> > +++ b/arch/powerpc/include/asm/copro.h
> > @@ -15,4 +15,10 @@ int copro_handle_mm_fault(struct mm_struct *mm, unsi=
gned long ea,
> > =20
> >  int copro_data_segment(struct mm_struct *mm, u64 ea, u64 *esid, u64 *v=
sid);
> > =20
> > +
> > +#ifdef CONFIG_PPC_COPRO_BASE
> > +void copro_flush_all_slbs(struct mm_struct *mm);
> > +#else
> > +#define copro_flush_all_slbs(mm) do {} while(0)
>=20
> This can be a static inline, so it should be. That way you get type check=
ing on
> the argument for CONFIG_PPC_COPRO_BASE=3Dn.

OK, I'll update.

Mikey
