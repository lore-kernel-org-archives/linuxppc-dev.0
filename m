Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp04.au.ibm.com (ausmtp04.au.ibm.com [202.81.18.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 27598DDE45
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 11:28:30 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by ausmtp04.au.ibm.com (8.13.8/8.13.8) with ESMTP id l4F1mQrm327318
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 11:48:26 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.250.243])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4F1Vx9Y168064
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 11:31:59 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4F1SRsD029434
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 11:28:27 +1000
Date: Tue, 15 May 2007 11:26:29 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/3] Initial AMCC Bamboo support
Message-ID: <20070515012629.GC565@localhost.localdomain>
References: <1179154608.3420.21.camel@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1179154608.3420.21.camel@zod.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 14, 2007 at 09:56:48AM -0500, Josh Boyer wrote:
> Hi All,
> 
> The following patches add the initial AMCC Bamboo eval board support.  
> 
> The support for peripheral devices at the moment is rather limited as
> the board is quite complicated in it's muxing of I/O lines.  Until the
> bootwrapper can figure out how to setup the EBC peripherals based on the
> dip switch settings, the DTS will lack any EBC devices.

Ick.  Can you describe roughly the setup here?  It might be that the
simplest approach is to include all options in the DTS, and delete
ones that aren't selected from the bootwrapper.

I have a patch which might help here, which fills in the ebc's
'ranges' property based on the contents of the EBC bridge registers.
I'm using it as part of the code necessary to get the right address
for the Ebony flash depending on DIP switch settings.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
