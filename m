Return-Path: <tim.martin@viasat.com>
Received: from VCAEXCH02.hq.corp.viasat.com (kestrel.viasat.com
	[199.106.52.139]) by ozlabs.org (Postfix) with ESMTP id 79940679FD
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Jul 2006 07:30:59 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: caches on Virtex 4
Date: Wed, 26 Jul 2006 14:18:53 -0700
Message-ID: <821B2170E9E7F04FA38DF7EC21DE487105D3A443@VCAEXCH01.hq.corp.viasat.com>
From: "Martin, Tim" <tim.martin@viasat.com>
To: "heiguga" <heiguga@gmx.net>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Robert,

There are several registers/etc that affect the caches on the Virtex4
PPC core.

Step 1 - Make sure your FPGA is configured to have caches in the memory
regions you're interested in caching.  Your FPGA designer should have
done this in the EDK (check options in the MHS file).

Step 2 - Make sure the individual cache regions are enabled.  Look at
the Xilinx standalone BSP to see how this works, or read the processor
manual.  E.g. xcache_l.c (a Xilinx standalone BSP file) in
XCache_EnableDCache modifies SGR, DCWR, and DCCR SPRs.
Xcache_EnableICache modifies SGR and ICCR SPRs.

Step 3- Make sure the cache configuration register (CCR0) is configured
correctly.

By default, I'm pretty sure you only need to worry about Step 1, as I
thought Step2 and 3 were handled by the kernel early in the boot process
and/or u-boot.

> -----Original Message-----
> From: linuxppc-embedded-bounces+tmartin=3Dviasat.com@ozlabs.org=20
> [mailto:linuxppc-embedded-bounces+tmartin=3Dviasat.com@ozlabs.or
> g] On Behalf Of heiguga
> Sent: Wednesday, July 26, 2006 10:59 AM
> To: linuxppc-embedded@ozlabs.org
> Subject: caches on Virtex 4
>=20
> Hi!
>=20
> I am working on an ml403 board (virtex4 with ppc core). I am=20
> sucessfully using Linux 2.4 and 2.6.
> I have done a few performance tests with networking, applications...
>=20
> How can i ensure, that the caches are turned on? (is there a special
> Register?)
> Where are the caches turned on?
>=20
> nice greetings
> Robert
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
