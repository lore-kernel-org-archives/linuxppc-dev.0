Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3A51F1A03C6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2015 21:01:36 +1100 (AEDT)
Message-ID: <1447754495.17316.98.camel@neuling.org>
Subject: Re: [PATCH 1/5] powerpc: Print MSR TM bits in oops message
From: Michael Neuling <mikey@neuling.org>
To: Michael Ellerman <mpe@ellerman.id.au>, benh@kernel.crashing.org
Cc: sam.bobroff@au1.ibm.com, linuxppc-dev@ozlabs.org, paulus@samba.org
Date: Tue, 17 Nov 2015 21:01:35 +1100
In-Reply-To: <1447666040.2191.3.camel@ellerman.id.au>
References: <1447390652-28355-1-git-send-email-mikey@neuling.org>
 <1447666040.2191.3.camel@ellerman.id.au>
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

On Mon, 2015-11-16 at 20:27 +1100, Michael Ellerman wrote:
> On Fri, 2015-11-13 at 15:57 +1100, Michael Neuling wrote:
>=20
> > Print the MSR TM bits in oops messages.  This appends them to the
> > end
> > like this:
> >  MSR: 8000000502823031 <SF,VEC,VSX,FP,ME,IR,DR,LE,TM[TE]>
> >=20
> > You get the TM[] only if at least one TM MSR bit is set.  Inside
> > the
> > TM[], E means Enabled (bit 32), S means Suspended (bit 33), and T
> > means Transactional (bit 34)
>=20
> Can you duplicate this into a comment in printtmbits() or on the bit
> definitions, so that I don't have to look up the commit to find the
> explanation.

Ok.

> > +#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> > +static struct regbit msr_tm_bits[] =3D {
> > +	{MSR_TS_T,	"T"},
> > +	{MSR_TS_S,	"S"},
> > +	{MSR_TM,	"E"},
> > +	{0,		NULL}
> > +};
> > +static void printtmbits(unsigned long val)
>=20
> I realise you followed the lead here with the naming, but can you
> call it
> print_tm_bits() please. MY EYES!

Ok, I've change the rest too -> print_msr_bits(), print_tm_bits(),
print_bits()

>=20
> > +{
> > +	if (val & (MSR_TM | MSR_TS_S | MSR_TS_T)) {
> > +		printk(",TM[");
> > +		printbits(val, msr_tm_bits, "");
> > +		printk("]");
>=20
> I suspect all these individual printks are going to behave badly if
> we have
> multiple cpus crashing simultaneously. But I won't make you fix that
> here. We
> should look at it sometime though.

Seems anton failed at this one a while back, and since I'm mortal I
might skip this one :-)

Mikey
