Return-Path: <moilanen@austin.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E9356DDF07
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jun 2007 07:24:16 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l57LOD7f001041
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Jun 2007 17:24:13 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l57LOD8e528156
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Jun 2007 17:24:13 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l57LODKD007322
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Jun 2007 17:24:13 -0400
Subject: Re: [PATCH] Donate dedicated CPU cycles
From: Jake Moilanen <moilanen@austin.ibm.com>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18022.14166.83442.173369@cargo.ozlabs.ibm.com>
References: <1180638885.5756.11.camel@goblue>
	<18022.14166.83442.173369@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Thu, 07 Jun 2007 16:24:11 -0500
Message-Id: <1181251451.5835.10.camel@goblue>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-06-06 at 14:25 +1000, Paul Mackerras wrote:
> Jake Moilanen writes:
> 
> > A Power6 can give up CPU cycles on a dedicated CPU (as opposed to a
> > shared CPU) to other shared processors if the administrator asks for it
> > (via the HMC).
> > 
> > This patch enables that to work properly on P6.
> 
> Is this something that needs to be controlled from userland, e.g. by a
> sysctl or something in /sys?

The turning on of donating of dedicated CPU cycles is done via the HMC.
IHMO, it would be a bit redundant to do it in two places.

The reason why this is better than just shared processors is the
partitions w/ dedicated CPUs are guaranteed an actual processor, yet the
system is still able to increase the capacity of the shared CPU pool.

I have an updated patch come w/ a rename of the VPA field.

Jake
