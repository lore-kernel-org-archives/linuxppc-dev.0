Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C41C02C0086
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2012 21:46:11 +1000 (EST)
Subject: Re: [PATCH 3/3 v2] powerpc/mpic: FSL MPIC error interrupt support.
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <C5ECD7A89D1DC44195F34B25E172658D139C36@039-SN2MPN1-013.039d.mgd.msft.net>
Date: Tue, 10 Jul 2012 06:46:06 -0500
Message-Id: <932AD066-0042-447E-BF5A-5BE0F212F4D7@kernel.crashing.org>
References: <1341823643-15737-1-git-send-email-Varun.Sethi@freescale.com>
 <62D13F27-5E39-450E-953D-102DCA32AA9D@kernel.crashing.org>
 <4FFB3D88.6030106@freescale.com>
 <22EF3A64-2185-4078-B7B9-00E00D32604A@kernel.crashing.org>
 <C5ECD7A89D1DC44195F34B25E172658D139C36@039-SN2MPN1-013.039d.mgd.msft.net>
To: Sethi Varun-B16395 <B16395@freescale.com>
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Hamciuc Bogdan-BHAMCIU1 <bhamciu1@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 10, 2012, at 4:39 AM, Sethi Varun-B16395 wrote:

>=20
>=20
>> -----Original Message-----
>> From: Kumar Gala [mailto:galak@kernel.crashing.org]
>> Sent: Tuesday, July 10, 2012 7:17 AM
>> To: Wood Scott-B07421
>> Cc: Sethi Varun-B16395; Hamciuc Bogdan-BHAMCIU1; linuxppc-
>> dev@lists.ozlabs.org
>> Subject: Re: [PATCH 3/3 v2] powerpc/mpic: FSL MPIC error interrupt
>> support.
>>=20
>>=20
>> On Jul 9, 2012, at 3:22 PM, Scott Wood wrote:
>>=20
>>> On 07/09/2012 02:03 PM, Kumar Gala wrote:
>>>>=20
>>>> On Jul 9, 2012, at 3:47 AM, Varun Sethi wrote:
>>>>=20
>>>>> +int mpic_err_int_init(struct mpic *mpic, irq_hw_number_t irqnum) =
{
>>>>=20
>>>> Why can't we do this during mpic_init() time?
>>>=20
>>> Are you willing to hardcode that IRQ 16 is the error interrupt,
>>> without waiting to see an intspec?
>>=20
>> I'm torn, but the bit of code in mpic_host_xlate that calls
>> mpic_err_int_init() is just ugly.
>>=20
>> We could consider it similar to how we assume IPIs.
> [Sethi Varun-B16395] I don't understand this point.
>=20
> -Varun

Just that we don't parse the .dts to get the IPI interrupts.  They are =
just assumed as part of being OpenPIC.  So, I was suggesting if you set =
the MPIC_FSL_HAS_EIMR flag, we just assume the IRQ #, rather than =
parsing the .dts.

- k
