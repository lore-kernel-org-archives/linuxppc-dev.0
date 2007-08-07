Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp04.au.ibm.com (ausmtp04.au.ibm.com [202.81.18.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 50A2DDDF3A
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Aug 2007 14:13:06 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by ausmtp04.au.ibm.com (8.13.8/8.13.8) with ESMTP id l774G8WF267002
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Aug 2007 14:16:08 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.250.237])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l774Gbfk094394
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Aug 2007 14:16:37 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l774D3GR027323
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Aug 2007 14:13:04 +1000
Date: Tue, 7 Aug 2007 14:11:31 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/6] PowerPC 440EPx: Sequoia DTS
Message-ID: <20070807041131.GE13522@localhost.localdomain>
References: <20070730150648.GA5005@ru.mvista.com>
	<20070801020836.GB31391@localhost.localdomain>
	<20070802151513.12e9caf7@weaponx.rchland.ibm.com>
	<a9100305ca02c8609458c72edb99342c@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a9100305ca02c8609458c72edb99342c@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Aug 06, 2007 at 10:15:39PM +0200, Segher Boessenkool wrote:
> >>> +	UIC0: interrupt-controller0 {
> >>> +		compatible = "ibm,uic-440gp","ibm,uic";
> >>
> >> The first compatible entry should always be the precise model, so in
> >> this case "ibm,uic-440epx".  If it is (supposed to be) identical to
> >> the UIC in the 440GP, it can also have an "ibm,uic-440gp" entry, but
> >> since I believe all the UICs are supposed to operate the same, I think
> >> that's implicit in the "ibm,uic" entry.
> >
> > Most UICs are the same.  There are some oddball chips that either hide
> > particular registers because they are unused, or they change the
> > addressing stride.  I'm not sure that is a common enough case to worry
> > about now though.
> 
> You only need to worry about the oddball cases in the device
> trees for a device that uses one off those.
> 
> It is prudent to put the exact name of the device you're
> working with in there whenever possible, in case you later
> discover it has some quirks.  If that doesn't happen, the
> kernel can happily keep probing on the more generic name.

Right.  In that case I suggest the sequoia just specify:
	compatible = "ibm,uic-440epx", "ibm,uic";
Because we have no particular reason to think that the 440EPx version
of UIC is any more similar to the 440GP version of UIC than it is to
the "normal" UIC.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
