Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 61F83DE08B
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 00:23:39 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4TDLFDK002206
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 09:21:15 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4TENWOT535932
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 10:23:32 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4TENW2i002526
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 10:23:32 -0400
Subject: Re: Don't use HOSTCFLAGS in BOOTCFLAGS
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20070529053712.GE30266@localhost.localdomain>
References: <20070529053712.GE30266@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 29 May 2007 09:21:30 -0500
Message-Id: <1180448490.3360.52.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-05-29 at 15:37 +1000, David Gibson wrote:
> In the bootwrapper code for powerpc, we include HOSTCFLAGS into the
> BOOTCFLAGS used for buildinf the zImage wrapper code.  Since the
> wrapper code is not host code, this makes no sense.  This patch
> removes the use of HOSTCFLAGS here, instead including directly into
> BOOTCFLAGS those flags from the normal kernel CFLAGS which also make
> sense in the bootwrapper code.
> 
> In particular, this makes the bootwrapper use -msoft-float, preventing
> the compiler from generating floating point instructions.  Previously,
> under some circumstances the compiler could generate floating point
> instructions in the bootwrapper which would cause exceptions on
> embedded CPUS which don't have floating point support.

This is essentially the cleanup Paul asked me to do of my original
-msoft-float addition.  Matches the patch I have sitting locally that I
haven't gotten around to sending out yet.

> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
