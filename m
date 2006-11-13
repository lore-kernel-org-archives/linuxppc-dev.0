Return-Path: <cel@us.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4609C67DD8
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Nov 2006 04:06:09 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kADH66DW031412
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Nov 2006 12:06:06 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kADH65vr338178
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Nov 2006 10:06:06 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kADH65Xg030930
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Nov 2006 10:06:05 -0700
Subject: Re: Help with an MMIO register read function
From: Carl Love <cel@us.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1163209606.4982.201.camel@localhost.localdomain>
References: <1163199434.30540.13.camel@dyn9047021226.beaverton.ibm.com>
	<200611110010.28788.arnd@arndb.de>
	<1163209606.4982.201.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 13 Nov 2006 09:06:04 -0800
Message-Id: <1163437564.30540.21.camel@dyn9047021226.beaverton.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ben:

Changing to the in_be64 function fixed the problem.  Thanks for you help
on this.  Using the dump function, we have been able to isolate the
problem with the RTAS call.  

             Carl Love


On Sat, 2006-11-11 at 12:46 +1100, Benjamin Herrenschmidt wrote:
> On Sat, 2006-11-11 at 00:10 +0100, Arnd Bergmann wrote:
> > On Friday 10 November 2006 23:57, Carl Love wrote:
> > > I expect the SBI values to be 0x2000000  not 0x200000000.  The L2 debug
> > > value should be 0x6 not 0x600000000000000.  It seems like the bits are
> > > there but shifted from where I would expect them to be.  Anyone have any
> > > thoughts as to what is wrong?
> > 
> > Hmm, maybe you confused the bit order in the specification? IBM
> > counts the MSB as bit 0, while everyone else counts the LSB as
> > bit 0.
> 
> I think in this case the problem is that he's using readq() which
> byteswaps.
> 
> Ben.
> 
> 
