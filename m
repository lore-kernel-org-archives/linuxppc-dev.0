Return-Path: <nacc@us.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 23F28B70BA
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  4 Mar 2011 18:25:01 +1100 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e32.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p247ER5K006421
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Mar 2011 00:14:27 -0700
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p247OwYv109520
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Mar 2011 00:24:58 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p247OwwT029358
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Mar 2011 00:24:58 -0700
Date: Thu, 3 Mar 2011 23:24:44 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: disable MSI using new interface if possible
Message-ID: <20110304072444.GA2080@us.ibm.com>
References: <1299200729.3630.52.camel@concordia>
	<1299202862-10682-1-git-send-email-nacc@us.ibm.com>
	<1299207684.3630.76.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1299207684.3630.76.camel@concordia>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04.03.2011 [14:01:24 +1100], Michael Ellerman wrote:
> On Thu, 2011-03-03 at 17:41 -0800, Nishanth Aravamudan wrote:
> > On 04.03.2011 [12:05:29 +1100], Michael Ellerman wrote:
> > > On Thu, 2011-03-03 at 11:39 -0800, Nishanth Aravamudan wrote:
> > > > On upcoming hardware, we have a PCI adapter with two functions, one of
> > > > which uses MSI and the other uses MSI-X. This adapter, when MSI is
> > > > disabled using the "old" firmware interface (RTAS_CHANGE_FN), still
> > > > signals an MSI-X interrupt and triggers an EEH. We are working with the
> > > > vendor to ensure that the hardware is not at fault, but if we use the
> > > > "new" interface (RTAS_CHANGE_MSI_FN) to disable MSI, we also
> > > > automatically disable MSI-X and the adapter does not appear to signal
> > > > any stray MSI-X interrupt.
> > > 
> > > It seems this could also be a firmware bug, have we heard anything from
> > > them? PAPR explicitly says that RTAS_CHANGE_FN (function=1) should
> > > disable MSI _and_ MSI-X (R1???7.3.10.5.1???1).
> > 
> > We're tracking that down too. I think the fact that the interrupt is
> > coming in is a hardware bug in this particular adapter.
> > 
> > I'm looking at PAPR again and I see what might be a contradiction:
> > 
> > 7.3.10.5.1: "To removing all MSIs, set the Requested Number of
> > Interrupts to zero."
> > 
> > Table 71: "Function ... 1: Request to set to a new number of MSI or
> > MSI-X (platform choice) interrupts (including set to 0)"
> > 
> > It seems like the Table claims that using RTAS_CHANGE_FN with 0, could
> > change only MSI or MSI-X and still be not a bug?
> 
> Yeah I guess you could read it that way, though I think that would be a
> bug.
> 
> The idea is that it chooses for you whether it uses MSI or MSI-X. So the
> only sane semantic is that when deconfiguring it deconfigures either,
> ie. both, kinds.

I agree with you that is how it should be :) I'm asking the firmware
folks to make sure I'm not misunderstanding the underlying issue.

> Looking closer at your patch, now I don't understand :)
> 
> +       /*
> +        * disabling MSI with the explicit interface also disables MSI-X
> +        */
> +       if (rtas_change_msi(pdn, RTAS_CHANGE_MSI_FN, 0) != 0) {
> 
> 
> So we first disable using function 3, which should:
> 
>         3: Request to set to a new number of MSI interrupts (including set to 0)
> 
> Which does not mention MSI-X at all, implying it has no effect on them.
> Which contradicts what you see, and the comment in the code?

Thanks for the thorough review!

Per PAPR 2.4 from Power.org, look at the page before that table, page
169:

"Specifying Function 3 (MSI) also disables MSI-X for the specified IOA
function, and likewise specifying Function 4 (MSI-X) disables MSI for
the IOA function....Specifying the Requested Number of Interrupts to
zero for either Function 3 or 4 removes all MSI & MSI-X interrupts from
the IOA function."

So I'm relying on this aspect of PAPR being enforced by the firmware,
which I think it is in my testing.

Thanks,
Nish
