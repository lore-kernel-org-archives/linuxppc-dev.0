Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound2-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 2B507DDE1E
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Aug 2007 11:35:53 +1000 (EST)
Message-ID: <46BD1272.9060107@am.sony.com>
Date: Fri, 10 Aug 2007 18:35:46 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: DTC 1.0.0 Release Coming?
References: <E1IDjSy-0003eC-T4@jdl.com>	<20070726030550.GA1149@localhost.localdomain>	<E1IE314-0000qF-5x@jdl.com>	<20070726142739.GB18684@localhost.localdomain>	<E1IE59h-0001tt-JE@jdl.com>	<20070727013331.GB1561@localhost.localdomain>	<20070806084813.5432ba91@weaponx.rchland.ibm.com>	<20070810013001.GF17370@localhost.localdomain>	<20070809203754.2e9192c5@zod.rchland.ibm.com>	<20070810025944.GI17370@localhost.localdomain>
	<18109.2103.507694.281225@cargo.ozlabs.ibm.com>
In-Reply-To: <18109.2103.507694.281225@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Jon Loeliger <jdl@jdl.com>,
	David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras wrote:
> David Gibson writes:
> 
>> We decided that since a formal dtc release was imminent, it would be
>> simpler to make dtc a new kernel build requirement, rather than
>> integrate the substantial blob of dtc code into the kernel tree and
>> then have to deal with the maintenance / synchronization issues
>> between the in-kernel and upstream versions.
> 
> Um, what I thought we decided was to ship a pre-built .dtb for ps3
> (once its dts settles down), and make dtc a kernel build requirement
> only for embedded platforms.

We could also ship a generated .S file (dtc -O asm -o ps3-dt.S ps3.dts),
which would be easier to maintain in the source tree than a binary file,
then use something like this in the wrapper script:
  
  ${CROSS}gcc -c -o ${platform}-dt.o ${platform}-dt.S
  ${CROSS}objcopy -O binary ${platform}-dt.o ${platform}.dtb

Untested, but it seems like it would work.

-Geoff
