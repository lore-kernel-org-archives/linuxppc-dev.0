Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp05.au.ibm.com (ausmtp05.au.ibm.com [202.81.18.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id ACEDDDDEA0
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Aug 2007 11:20:37 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by ausmtp05.au.ibm.com (8.13.8/8.13.8) with ESMTP id l7D1MdK74341806
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Aug 2007 11:22:39 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.250.244])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l7D1KZaE1581242
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Aug 2007 11:20:35 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7D1KZVn022970
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Aug 2007 11:20:35 +1000
Date: Sun, 12 Aug 2007 19:26:27 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: DTC 1.0.0 Release Coming?
Message-ID: <20070812092627.GB6803@localhost.localdomain>
References: <E1IE314-0000qF-5x@jdl.com>
	<20070726142739.GB18684@localhost.localdomain>
	<E1IE59h-0001tt-JE@jdl.com>
	<20070727013331.GB1561@localhost.localdomain>
	<20070806084813.5432ba91@weaponx.rchland.ibm.com>
	<20070810013001.GF17370@localhost.localdomain>
	<20070809203754.2e9192c5@zod.rchland.ibm.com>
	<20070810025944.GI17370@localhost.localdomain>
	<18109.2103.507694.281225@cargo.ozlabs.ibm.com>
	<46BD1272.9060107@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <46BD1272.9060107@am.sony.com>
Cc: linuxppc-dev@ozlabs.org, Jon Loeliger <jdl@jdl.com>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 10, 2007 at 06:35:46PM -0700, Geoff Levand wrote:
> Paul Mackerras wrote:
> > David Gibson writes:
> > 
> >> We decided that since a formal dtc release was imminent, it would be
> >> simpler to make dtc a new kernel build requirement, rather than
> >> integrate the substantial blob of dtc code into the kernel tree and
> >> then have to deal with the maintenance / synchronization issues
> >> between the in-kernel and upstream versions.
> > 
> > Um, what I thought we decided was to ship a pre-built .dtb for ps3
> > (once its dts settles down), and make dtc a kernel build requirement
> > only for embedded platforms.
> 
> We could also ship a generated .S file (dtc -O asm -o ps3-dt.S ps3.dts),
> which would be easier to maintain in the source tree than a binary file,
> then use something like this in the wrapper script:
>   
>   ${CROSS}gcc -c -o ${platform}-dt.o ${platform}-dt.S
>   ${CROSS}objcopy -O binary ${platform}-dt.o ${platform}.dtb
> 
> Untested, but it seems like it would work.

Yes, I'm aware of that option and am considering it.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
