Return-Path: <linas@austin.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1CA18DDEFD
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 02:00:32 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l33G1Dee028914
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Apr 2007 12:01:13 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l33G0SLs125128
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Apr 2007 12:00:28 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l33G0ROn027828
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Apr 2007 12:00:27 -0400
Date: Tue, 3 Apr 2007 11:00:26 -0500
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [PATCH 1/19] PCI: rpaphp: Cleanup flow of control for
	rpaphp_add_slot
Message-ID: <20070403160026.GL4922@austin.ibm.com>
References: <20070403002629.GI4922@austin.ibm.com>
	<20070403003346.3D32D3A65C@topology.austin.ibm.com>
	<20070403142828.GK8423@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070403142828.GK8423@localdomain>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	linux-pci@atrey.karlin.mff.cuni.cz, Greg KH <gregkh@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 03, 2007 at 09:28:28AM -0500, Nathan Lynch wrote:
> Linas Vepstas wrote:
> > 
> > Cleanup the flow of control for rpaphp_add_slot(), so as to
> > make it easier to read. The ext patch will fix a bug in this 
> > same code. 
> 
> This:
> 
> > +	if (!dn || strcmp(dn->name, "pci"))
> > +		return 0;
> 
> is not equivalent to the code it's replacing:
> 
> > -	if (dn->name != 0 && strcmp(dn->name, "pci") == 0) {
> 
> With your version we'll oops if dn->name is NULL.

oops, thanks, I'll fix that.

--linas
