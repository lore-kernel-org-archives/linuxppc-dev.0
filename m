Return-Path: <bergner@vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e9.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8C49ADDFC7
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Mar 2009 06:05:45 +1100 (EST)
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e9.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n23IvSvY027285
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Mar 2009 13:57:28 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n23J5GA02301996
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Mar 2009 14:05:16 -0500
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n23J5FFo019276
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Mar 2009 12:05:15 -0700
Subject: Re: powerpc allnoconfig
From: Peter Bergner <bergner@vnet.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20090303085614.07f8aa27.akpm@linux-foundation.org>
References: <20090302171948.d1e2aa00.akpm@linux-foundation.org>
	<12051.1236047470@neuling.org>
	<20090302184049.27a73395.akpm@linux-foundation.org>
	<20090303135203.b36312a0.sfr@canb.auug.org.au>
	<20090302185514.2cc73512.akpm@linux-foundation.org>
	<20090303141905.52dbf9b1.sfr@canb.auug.org.au>
	<20090302200809.26b5d5bb.akpm@linux-foundation.org>
	<alpine.LRH.2.00.0903031109190.31985@vixen.sonytel.be>
	<20090303085614.07f8aa27.akpm@linux-foundation.org>
Content-Type: text/plain
Date: Tue, 03 Mar 2009 13:05:31 -0600
Message-Id: <1236107131.6800.55.camel@otta>
Mime-Version: 1.0
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Michael Neuling <mikey@neuling.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2009-03-03 at 08:56 -0800, Andrew Morton wrote:
> On Tue, 3 Mar 2009 11:14:04 +0100 (CET) Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:
> 
> > > > let us know if that works :-)
> > > 
> > > didn't.  Oh well.
> > 
> > Does allnoconfig work if you force the compiler to be 32-bit, like
> > 
> >     make CC="powerpc64-unknown-linux-gnu-gcc -m32"
> 
> Nope:
> 
> scripts/mod/empty.c:1: error: -m64 requires a PowerPC64 cpu

To build a biarch compiler that defaults to 32-bit, try adding the
option --with-cpu=default32 to your GCC configure options.  You also
shouldn't need --enable-targets=all.  We haven't used that option
for ages when building powerpc64-linux enabled GCCs.

Peter
