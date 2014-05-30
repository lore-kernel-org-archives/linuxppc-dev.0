Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 116FB1A06D4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 May 2014 19:10:47 +1000 (EST)
Message-ID: <1401441046.13479.2.camel@ale.ozlabs.ibm.com>
Subject: Re: powerpc/pseries: Use new defines when calling h_set_mode
From: Michael Neuling <mikey@neuling.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Fri, 30 May 2014 19:10:46 +1000
In-Reply-To: <1401440207.29324.10.camel@concordia>
References: <1401106626-13130-1-git-send-email-paulus@samba.org>
 <1401106626-13130-4-git-send-email-paulus@samba.org>
 <5385E620.5090703@suse.de> <1401342462.4116.4.camel@ale.ozlabs.ibm.com>
 <1401344549.4116.8.camel@ale.ozlabs.ibm.com>
 <BD1CF085-FEBC-4208-AD3F-C55DB002097F@suse.de>
 <1401349547.4116.19.camel@ale.ozlabs.ibm.com>
 <1401440207.29324.10.camel@concordia>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Alexander Graf <agraf@suse.de>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-05-30 at 18:56 +1000, Michael Ellerman wrote:
> On Thu, 2014-05-29 at 17:45 +1000, Michael Neuling wrote:
> > > > +/* Values for 2nd argument to H_SET_MODE */
> > > > +#define H_SET_MODE_RESOURCE_SET_CIABR        1
> > > > +#define H_SET_MODE_RESOURCE_SET_DAWR        2
> > > > +#define H_SET_MODE_RESOURCE_ADDR_TRANS_MODE    3
> > > > +#define H_SET_MODE_RESOURCE_LE            4
> > >=20
> > > Much better, but I think you want to make use of these in non-kvm cod=
e too,
> > > no? At least the LE one is definitely already implemented as call :)
> >=20
> > powerpc/pseries: Use new defines when calling h_set_mode
> >=20
> > Now that we define these in the KVM code, use these defines when we cal=
l
> > h_set_mode.  No functional change.
> >=20
> > Signed-off-by: Michael Neuling <mikey@neuling.org>
> > --
> > This depends on the KVM h_set_mode patches.
> >=20
> > diff --git a/arch/powerpc/include/asm/plpar_wrappers.h b/arch/powerpc/i=
nclude/asm/plpar_wrappers.h
> > index 12c32c5..67859ed 100644
> > --- a/arch/powerpc/include/asm/plpar_wrappers.h
> > +++ b/arch/powerpc/include/asm/plpar_wrappers.h
> > @@ -273,7 +273,7 @@ static inline long plpar_set_mode(unsigned long mfl=
ags, unsigned long resource,
> >  static inline long enable_reloc_on_exceptions(void)
> >  {
> >  	/* mflags =3D 3: Exceptions at 0xC000000000004000 */
> > -	return plpar_set_mode(3, 3, 0, 0);
> > +	return plpar_set_mode(3, H_SET_MODE_RESOURCE_ADDR_TRANS_MODE, 0, 0);
> >  }
>=20
> Which header are these coming from, and why aren't we including it? And i=
s it
> going to still build with CONFIG_KVM=3Dn?

=46rom include/asm/hvcall.h in the h_set_mode patch set I sent before.

And yes it compiles with CONFIG_KVM=3Dn fine.

Mikey
