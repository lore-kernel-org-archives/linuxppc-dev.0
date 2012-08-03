Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D71312C0089
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Aug 2012 05:14:06 +1000 (EST)
Subject: Re: [PATCH 3/3 v3] powerpc/mpic: FSL MPIC error interrupt support.
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <501C0007.8070209@freescale.com>
Date: Fri, 3 Aug 2012 14:13:19 -0500
Message-Id: <8E113655-B8C1-4F77-82DD-4A8460553CCA@kernel.crashing.org>
References: <1343745764-3788-1-git-send-email-Varun.Sethi@freescale.com>
 <609EA81E-EC64-4539-B36B-E57525CE2492@kernel.crashing.org>
 <501C0007.8070209@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Cc: Bogdan Hamciuc <bogdan.hamciuc@freescale.com>,
 Varun Sethi <Varun.Sethi@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 3, 2012, at 11:44 AM, Scott Wood wrote:

> On 08/03/2012 08:19 AM, Kumar Gala wrote:
>>=20
>> On Jul 31, 2012, at 9:42 AM, Varun Sethi wrote:
>>> +	/* ioremap'ed base for error interrupt registers */
>>> +	u32 __iomem	*err_regs;
>>> +	/* error interrupt config */
>>> +	u32			err_int_config_done;
>>> +
>>=20
>> Is this really needed ?
>=20
> Probably a left over from when it was done on demand.
>=20
>>=20
>>> 	/* Protected sources */
>>> 	unsigned long		*protected;
>>>=20
>>> @@ -370,6 +381,8 @@ struct mpic
>>> #define MPIC_NO_RESET			0x00004000
>>> /* Freescale MPIC (compatible includes "fsl,mpic") */
>>> #define MPIC_FSL			0x00008000
>>> +/* Freescale MPIC supports EIMR (error interrupt mask register)*/
>>> +#define MPIC_FSL_HAS_EIMR		0x00010000
>>=20
>> Can't we use BRR for this?
>=20
> BRR is used, and this is set as a result.  Better than opencoding a =
BRR
> check a bunch of places...

I'm fine w/that, but didn't see where MPIC_FSL_HAS_EMIR was being set.. =
Just want to avoid the caller of mpic_alloc() having to pass it in.

- k=
