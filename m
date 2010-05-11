Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: michael@ellerman.id.au
Subject: Re: [PATCH 2/2] powerpc,kexec: Speedup kexec hpte tear down
In-reply-to: <1273561463.9209.138.camel@concordia>
References: <20100511062826.E1C49D3340@localhost.localdomain>
	<1273561463.9209.138.camel@concordia>
Date: Wed, 12 May 2010 09:29:54 +1000
Message-ID: <30983.1273620594@neuling.org>
Cc: kexec@lists.infradead.org, Anton Blanchard <anton@samba.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



In message <1273561463.9209.138.camel@concordia> you wrote:
> 
> --=-S056dRzmrEHDBzKyyTOs
> Content-Type: text/plain; charset="UTF-8"
> Content-Transfer-Encoding: quoted-printable
> 
> On Tue, 2010-05-11 at 16:28 +1000, Michael Neuling wrote:
> > Currently for kexec the PTE tear down on 1TB segment systems normally
> > requires 3 hcalls for each PTE removal. On a machine with 32GB of
> > memory it can take around a minute to remove all the PTEs.
> >=20
> ..
> > -	/* TODO: Use bulk call */
> 
> ...
> > +	/* Read in batches of 4,
> > +	 * invalidate only valid entries not in the VRMA
> > +	 * hpte_count will be a multiple of 4
> > +         */
> > +	for (i =3D 0; i < hpte_count; i +=3D 4) {
> > +		lpar_rc =3D plpar_pte_read_4_raw(0, i, (void *)ptes);
> > +		if (lpar_rc !=3D H_SUCCESS)
> > +			continue;
> > +		for (j =3D 0; j < 4; j++){
> > +			if ((ptes[j].pteh & HPTE_V_VRMA_MASK) =3D=3D
> > +				HPTE_V_VRMA_MASK)
> > +				continue;
> > +			if (ptes[j].pteh & HPTE_V_VALID)
> > +				plpar_pte_remove_raw(0, i + j, 0,
> > +					&(ptes[j].pteh), &(ptes[j].ptel));
> >  		}
> 
> Have you tried using the bulk remove call, if none of the HPTEs are for
> the VRMA? Rumour was it was slower/the-same, but that may have been
> apocryphal.

No, I didn't try it.

I think the real solution is to ask FW for a new call to do it all for
us.

Mikey
