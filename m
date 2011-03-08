Return-Path: <nacc@us.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 592DEB7100
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Mar 2011 16:34:21 +1100 (EST)
Received: from d01dlp01.pok.ibm.com (d01dlp01.pok.ibm.com [9.56.224.56])
	by e3.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p285E76g014301
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Mar 2011 00:14:07 -0500
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id D22FD38C803B
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Mar 2011 00:34:14 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p285YGCZ376188
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Mar 2011 00:34:16 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p285YGnL016265
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Mar 2011 02:34:16 -0300
Date: Mon, 7 Mar 2011 21:34:13 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: disable MSI using new interface if possible
Message-ID: <20110308053413.GA26971@us.ibm.com>
References: <1299200729.3630.52.camel@concordia>
	<1299202862-10682-1-git-send-email-nacc@us.ibm.com>
	<1299207684.3630.76.camel@concordia>
	<20110304072444.GA2080@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110304072444.GA2080@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org, miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03.03.2011 [23:24:44 -0800], Nishanth Aravamudan wrote:
> On 04.03.2011 [14:01:24 +1100], Michael Ellerman wrote:
> > On Thu, 2011-03-03 at 17:41 -0800, Nishanth Aravamudan wrote:
> > > On 04.03.2011 [12:05:29 +1100], Michael Ellerman wrote:
> > > > On Thu, 2011-03-03 at 11:39 -0800, Nishanth Aravamudan wrote:
> > > > > On upcoming hardware, we have a PCI adapter with two functions, one of
> > > > > which uses MSI and the other uses MSI-X. This adapter, when MSI is
> > > > > disabled using the "old" firmware interface (RTAS_CHANGE_FN), still
> > > > > signals an MSI-X interrupt and triggers an EEH. We are working with the
> > > > > vendor to ensure that the hardware is not at fault, but if we use the
> > > > > "new" interface (RTAS_CHANGE_MSI_FN) to disable MSI, we also
> > > > > automatically disable MSI-X and the adapter does not appear to signal
> > > > > any stray MSI-X interrupt.
> > > > 
> > > > It seems this could also be a firmware bug, have we heard anything from
> > > > them? PAPR explicitly says that RTAS_CHANGE_FN (function=1) should
> > > > disable MSI _and_ MSI-X (R1???7.3.10.5.1???1).
> > > 
> > > We're tracking that down too. I think the fact that the interrupt is
> > > coming in is a hardware bug in this particular adapter.
> > > 
> > > I'm looking at PAPR again and I see what might be a contradiction:
> > > 
> > > 7.3.10.5.1: "To removing all MSIs, set the Requested Number of
> > > Interrupts to zero."
> > > 
> > > Table 71: "Function ... 1: Request to set to a new number of MSI or
> > > MSI-X (platform choice) interrupts (including set to 0)"
> > > 
> > > It seems like the Table claims that using RTAS_CHANGE_FN with 0, could
> > > change only MSI or MSI-X and still be not a bug?
> > 
> > Yeah I guess you could read it that way, though I think that would be a
> > bug.
> > 
> > The idea is that it chooses for you whether it uses MSI or MSI-X. So the
> > only sane semantic is that when deconfiguring it deconfigures either,
> > ie. both, kinds.
> 
> I agree with you that is how it should be :) I'm asking the firmware
> folks to make sure I'm not misunderstanding the underlying issue.

It would appear that if a device does support both MSI and MSI-X and the
old (non-explicit) interface is used, only one of MSI or MSI-X is
guaranteed to be disabled, with preference given to MSI. Now, it turns
out that there is also a firmware dragon here (because this particular
device is misbehaving), but we can also fix it by using the new
interface, which shouldn't cause any harm, given the fallback.

> > Looking closer at your patch, now I don't understand :)
> > 
> > +       /*
> > +        * disabling MSI with the explicit interface also disables MSI-X
> > +        */
> > +       if (rtas_change_msi(pdn, RTAS_CHANGE_MSI_FN, 0) != 0) {
> > 
> > 
> > So we first disable using function 3, which should:
> > 
> >         3: Request to set to a new number of MSI interrupts (including set to 0)
> > 
> > Which does not mention MSI-X at all, implying it has no effect on them.
> > Which contradicts what you see, and the comment in the code?
> 
> Thanks for the thorough review!
> 
> Per PAPR 2.4 from Power.org, look at the page before that table, page
> 169:
> 
> "Specifying Function 3 (MSI) also disables MSI-X for the specified IOA
> function, and likewise specifying Function 4 (MSI-X) disables MSI for
> the IOA function....Specifying the Requested Number of Interrupts to
> zero for either Function 3 or 4 removes all MSI & MSI-X interrupts from
> the IOA function."
> 
> So I'm relying on this aspect of PAPR being enforced by the firmware,
> which I think it is in my testing.

Given all that, do I have your Ack? :)

Thanks,
Nish

-- 
Nishanth Aravamudan <nacc@us.ibm.com>
IBM Linux Technology Center
