Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 413912BEA0
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 Nov 2004 01:58:18 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Date: Tue, 16 Nov 2004 08:58:10 -0600
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B06DBBD@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: <morten.banzon@axxessit.no>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: MPC82xx -- DPRAM1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Check the drivers/serial/cpm_uart stuff.
In older kernels (before the uart move, ie 2.6.7) the start of dpram was
taken by the initial SCC/SMC driver for initial console output before
the full CPM drivers were initialized. The addresses were hardcoded
because the driver was initialized before the dpalloc functions were
initailized.

There might be some left over from that. Look for anything getting set
to cpm2_immr->im_dprambase[0]


> -----Original Message-----
> From: linuxppc-embedded-bounces@ozlabs.org=20
> [mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of=20
> morten.banzon@axxessit.no
> Sent: Tuesday, November 16, 2004 05:17
> To: Mark Chambers
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: MPC82xx -- DPRAM1
>=20
>=20
> I am not sure if I understand you. The CPM must have been=20
> told somehow=20
> that there is something for its peripherals in this=20
> particular region of=20
> the dpram1 or no ? I wild guess could be that the bootloader=20
> (in this case=20
> u-boot) has configured this area of dpram1 behind the back of=20
> the kernel.=20
> I assume that is not the case. Would not that be rather ugly ?
> =20
> The mcc driver I am trying to get running on linux-2.6.9 is a=20
> driver I=20
> wrote for pSos a few years ago, and it is running fine on=20
> that platform. Therefore, I am sure that there is nothing i=20
> the processor or the cpm that=20
> prevents me from putting mcc related parameters at offset zero in the=20
> dpram1.
> I am still trying to figure out what piece of code in the=20
> kernel that I=20
> have to manipulate to get this driver working.=20
>=20
> Thanks for any advise,
> Morten
