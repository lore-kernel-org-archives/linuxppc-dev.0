Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 91AF02C0085
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2013 01:55:48 +1100 (EST)
Subject: Re: [PATCH 5/6] powerpc/fsl-booke: Add B4_QDS board support
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <E12D2F89F87F4A49B0320A4C2DE7E749144A98@039-SN2MPN1-011.039d.mgd.msft.net>
Date: Mon, 18 Mar 2013 09:56:00 -0500
Message-Id: <6F89A437-E585-4426-8DA9-36B2D85BF590@kernel.crashing.org>
References: <1363334109-21922-1-git-send-email-shaveta@freescale.com>
 <1363334109-21922-5-git-send-email-shaveta@freescale.com>
 <69F32D25-11C5-414D-A23A-AD25C9CCF9C6@kernel.crashing.org>
 <E12D2F89F87F4A49B0320A4C2DE7E749144A98@039-SN2MPN1-011.039d.mgd.msft.net>
To: Leekha Shaveta-B20052 <B20052@freescale.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 18, 2013, at 1:28 AM, Leekha Shaveta-B20052 wrote:

>=20
>=20
> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
> Sent: Friday, March 15, 2013 9:28 PM
> To: Leekha Shaveta-B20052
> Cc: linuxppc-dev@lists.ozlabs.org
> Subject: Re: [PATCH 5/6] powerpc/fsl-booke: Add B4_QDS board support
>=20
>=20
> On Mar 15, 2013, at 2:55 AM, Shaveta Leekha wrote:
>=20
>> - Add support for B4 board's personalities in board file  b4_qds.c, =
It=20
>> is common for B4 personalities B4860 and B4420QDS
>> - Add B4QDS support in Kconfig and Makefile
>=20
> Code also references a B4220, what about it?
> [SL] I have added the basic support for it in board file as it's one =
of the personality of
> B4, missed it in description. But device trees for this has not been =
created and tested.
> So what do you suggest here:
> Should I add it here in B4 board support or should I remove its =
references altogether?

What's the difference between B4220 and B4420 or B4860?

- k

>=20
>>=20
>> B4860QDS is a high-performance computing evaluation, development and=20=

>> test platform supporting the B4860 QorIQ Power Architecture =
processor,=20
>> with following major features:
>>=20
>>   - Four dual-threaded e6500 Power Architecture processors
>>     organized in one cluster-each core runs up to 1.8 GHz
>>   - Two DDR3/3L controllers for high-speed memory interface each
>>     runs at up to 1866.67 MHz
>>   - CoreNet fabric that fully supports coherency using MESI protocol
>>     between the e6500 cores, SC3900 FVP cores, memories and
>>     external interfaces.
>>   - Data Path Acceleration Architecture having FMAN, QMan, BMan, SEC =
5.3 and RMAN
>>   - Large internal cache memory with snooping and stashing =
capabilities
>>   - Sixteen 10-GHz SerDes lanes that serve:
>>       - Two SRIO interfaces. Each supports up to 4 lanes and
>>         a total of up to 8 lanes
>>       - Up to 8-lanes Common Public Radio Interface (CPRI) controller
>>         for glue-less antenna connection
>>       - Two 10-Gbit Ethernet controllers (10GEC)
>>       - Six 1G/2.5-Gbit Ethernet controllers for network =
communications
>>       - PCI Express controller
>>       - Debug (Aurora)
>>   - Various system peripherals
>>=20
>> B4420 is a reduced personality of B4860 with fewer core/clusters(both=20=

>> SC3900 and e6500), fewer DDR controllers, fewer serdes lanes, fewer =
SGMII interfaces and reduced target frequencies.
>>=20
>> Key differences between B4860 and B4420:
>> B4420 has:
>>   - Fewer e6500 cores:
>>       1 cluster with 2 e6500 cores
>>   - Fewer SC3900 cores/clusters:
>>       1 cluster with 2 SC3900 cores per cluster
>>   - Single DDRC
>>   - 2X 4 lane serdes
>>   - 3 SGMII interfaces
>>   - no sRIO
>>   - no 10G
>>=20
>> Signed-off-by: Shaveta Leekha <shaveta@freescale.com>
>> ---
>> arch/powerpc/platforms/85xx/Kconfig  |   16 +++++
>> arch/powerpc/platforms/85xx/Makefile |    1 +
>> arch/powerpc/platforms/85xx/b4_qds.c |  102=20
>> ++++++++++++++++++++++++++++++++++
>> 3 files changed, 119 insertions(+), 0 deletions(-) create mode 100644=20=

>> arch/powerpc/platforms/85xx/b4_qds.c
