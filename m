Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2F0CFDDDDB
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 13:14:50 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l1G2Ejtn007979
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 21:14:45 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l1G2EjvH300996
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 21:14:45 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l1G2Ejpe014406
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 21:14:45 -0500
Date: Thu, 15 Feb 2007 20:19:56 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <dwg@au1.ibm.com>
Subject: Re: [0/16] Preliminary Ebony (440GP) support for arch/powerpc
Message-ID: <20070216021956.GA1038@crusty.rchland.ibm.com>
References: <20070213060904.GA6214@localhost.localdomain>
	<1171381565.4003.48.camel@zod.rchland.ibm.com>
	<1171469183.4003.96.camel@zod.rchland.ibm.com>
	<20070214231204.GB16279@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070214231204.GB16279@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 15, 2007 at 10:12:04AM +1100, David Gibson wrote:
> > I still have this issue, just haven't had a chance to figure out why
> > yet.  Likely because the openbios code is leaving garbage somewhere.
> 
> More likely simply because openbios just puts different things in the
> registers on entry, and we're assuming it uses the same method OF
> does.  Need to fix the entry path, and get rid of the hardcoded a1 and
> a2 junk.

I looked a the openbios code this morning.  For all intents and purposes
the values it pases in r3 and r4 to the zImage wrapper really are
garbage.  However, you're right in that we need to fix the boot wrapper
to not assume all firmwares will follow similar conventions for the entry
path.

Is there a compat property or something similar that could be defined in
the DTS that the wrapper could look at to determine what to expect?

josh
