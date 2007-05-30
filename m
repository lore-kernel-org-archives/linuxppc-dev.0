Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp04.au.ibm.com (ausmtp04.au.ibm.com [202.81.18.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 97715DE04B
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 11:37:45 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by ausmtp04.au.ibm.com (8.13.8/8.13.8) with ESMTP id l4U1wJjt275544
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 11:58:21 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.250.244])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4U1f3dx168994
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 11:41:05 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4U1bVjZ001956
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 11:37:31 +1000
Date: Wed, 30 May 2007 11:26:09 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Fix problems with Holly's DT representation of ethernet PHYs
Message-ID: <20070530012609.GA21955@localhost.localdomain>
References: <20070529060541.GG30266@localhost.localdomain>
	<c7c131c3a7fdf7727d9ea1e40775017a@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c7c131c3a7fdf7727d9ea1e40775017a@kernel.crashing.org>
Cc: Alexandre Bounine <Alexandre.Bounine@tundra.com>,
	Paul Mackerras <paulus@samba.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 29, 2007 at 08:43:38AM +0200, Segher Boessenkool wrote:
> > +		MDIO: mdio@6000 {
> >  			device_type = "mdio";
> > -			compatible = "tsi-ethernet";
> > +			compatible = "tsi-mdio";
> 
> Hrm, did I miss this before?  A more exact "compatible"
> property would be better ("tsi109-mdio" "tsi108-mdio" or
> something like that).

Hrm, yeah.  I thought about that, but left it as tsi-mdio to match the
other rather non-specific compatible properties ("tsi-ethernet",
"tsi-brige", "tsi-i2c" and so forth).

But I guess I'd better fix that too.  Next version of the patch fixes
a whole bunch of places to use tsi108/tsi109 compatible properties.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
