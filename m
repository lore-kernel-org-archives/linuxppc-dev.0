Return-Path: <stevewin@us.ibm.com>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D15ABDDE01
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Mar 2007 10:15:00 +1100 (EST)
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by pokfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	l2DHiT2d015001
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 13:44:30 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l2DHdT9c026370
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 13:39:29 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l2DHdS3F048004
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 11:39:28 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l2DHdRrb029619
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 11:39:28 -0600
To: benh@kernel.crashing.org
MIME-Version: 1.0
Subject: Fw: [PATCH 2/15] Automatically lmb_reserve() initrd
Message-ID: <OF526C2D02.381593EB-ON8725729D.005FC841-8525729D.0060FE86@us.ibm.com>
From: Stephen Winiecki <stevewin@us.ibm.com>
Date: Tue, 13 Mar 2007 13:43:00 -0400
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@ozlabs.org, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 03/12/2007 
05:25:32 PM:

> 
> > It might be helpful if some kind of message was surfaced if the 
> > initrd-start/end properties didn't exist in the dt, esp. since it may 
not 
> > be well known initially as a dts definition requirement/option (voice 
of 
> > experience :)).  In general I think surfacing messages for any 
properties 
> > which are detected as not existing and which might be normally 
expected 
> > would be a good thing as people get familiar with defining dts files 
and 
> > specifying properties for their platforms. 
> 
> Well.. initrd is totally optional...
> 

I understand - I guess I am just thinking of the case where someone didn't 
define the property because they were not aware of it - esp in this case 
where the existence of the property name is all that is required for the 
value to be filled in properly by the init code.  Instead of just setting 
the start/end to 0 - maybe include a message something like (even if 
debug) "No initird-start/end property found - setting to 0" - just a minor 
example.  The larger point also being that defining dts files and 
properties may be a new thing for many people with the new support - might 
be helpful to surface missing properties when appropriate (I'm not 
condoning mass amounts of messages for everything). 
