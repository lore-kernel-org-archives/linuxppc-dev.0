Return-Path: <linas@austin.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B7C45DE470
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Jan 2007 09:53:16 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id l0QMrBQC016810
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 17:53:11 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l0QMrBha185512
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 17:53:11 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l0QMrBtx007888
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 17:53:11 -0500
Date: Fri, 26 Jan 2007 16:53:11 -0600
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] pSeries: EEH improperly enabled for some Power4 systems
Message-ID: <20070126225311.GD11220@austin.ibm.com>
References: <20070126205503.GA11220@austin.ibm.com>
	<17850.33057.686491.685870@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17850.33057.686491.685870@cargo.ozlabs.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Jan 27, 2007 at 09:30:57AM +1100, Paul Mackerras wrote:
> Linas Vepstas writes:
> 
> > It appears that EEH is improperly enabled for some Power4 systems.
> > On these systems, the ibm,set-eeh-option returns a value of success
> > even when EEH is not supported on the given node. Thus, an explicit
> > check for support is required.
> 
> What happens on the power4 systems when EEH is improperly enabled?
> 
> What systems has the patch been tested on?

Sorry, I should have said more from the get-go.

During boot, on power4, without this patch, one sees messages 
similar to:

EEH: event on unsupported device, rc=0 dn=/pci@400000000110/IBM,sp@1
EEH: event on unsupported device, rc=0 dn=/pci@400000000110/pci@2
EEH: event on unsupported device, rc=0 dn=/pci@400000000110/pci@2,2
etc.

The patch makes these go away.

Without this patch, EEH recovery does seem to work correctly for 
at least some devices (I tested ethernet e1000), but fails to 
recover others (the Emulex LightPulse LPFC, most notably). 
Off the top of my head, I don't remember why some devices are 
affected, but not others.

The PAPR indicates that the correct way to test for EEH is as 
done in this patch; its not clear to me if this was in the PAPR 
all along, or recently added; if it was there all along, its not
clear to me why this hadn't been fixed long ago. I suspect only
certain firmware levels are affected.

I've tested on one power4 and one power5; both have "old" 
firmware (firmware dating back to not long after product 
announce). It sure would be nice to test on more machines, huh? 
I don't know how to quickly test on a broad spectrum of machines.

If this makes you nervous, I suppose this patch can wait for
the 2.6.21 series.

--linas
