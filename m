Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 75229B6FA1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2012 04:46:50 +1100 (EST)
Subject: Re: [PATCH] powerpc/srio: Fix the compile errors when building with
 64bit
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1330957222.23420.136.camel@10.ap.freescale.net>
Date: Tue, 6 Mar 2012 11:46:20 -0600
Message-Id: <B946A444-73EC-4A70-AA7E-31FAF31FFF13@kernel.crashing.org>
References: <1330672127-22172-1-git-send-email-Gang.Liu@freescale.com>
 <6BFCD6C7-7675-4A99-9C4C-4E86FA5642A4@kernel.crashing.org>
 <1330957222.23420.136.camel@10.ap.freescale.net>
To: Liu Gang <Gang.Liu@freescale.com>
Cc: r58472@freescale.com, Paul Gortmaker <paul.gortmaker@windriver.com>,
 linux-kernel@vger.kernel.org, r61911@freescale.com, Alexandre.Bounine@idt.com,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 Shaohui Xie <Shaohui.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 5, 2012, at 8:20 AM, Liu Gang wrote:

> Hi, Kumar,
>=20
> On Fri, 2012-03-02 at 09:11 -0600, Kumar Gala wrote:
>>> diff --git a/arch/powerpc/sysdev/fsl_rmu.c =
b/arch/powerpc/sysdev/fsl_rmu.c
>>> index 1548578..468011e 100644
>>> --- a/arch/powerpc/sysdev/fsl_rmu.c
>>> +++ b/arch/powerpc/sysdev/fsl_rmu.c
>>> @@ -311,8 +311,8 @@ fsl_rio_dbell_handler(int irq, void =
*dev_instance)
>>>=20
>>> 	/* XXX Need to check/dispatch until queue empty */
>>> 	if (dsr & DOORBELL_DSR_DIQI) {
>>> -		u32 dmsg =3D
>>> -			(u32) fsl_dbell->dbell_ring.virt +
>>> +		unsigned long dmsg =3D
>>> +			(unsigned long) fsl_dbell->dbell_ring.virt +
>>> 			(in_be32(&fsl_dbell->dbell_regs->dqdpar) & =
0xfff);

How about a struct instead:

struct rmu_dmsg {
	u16	dummy;
	u16	tid;
	u16	sid;
	u16	info;
};

	struct rmu_dmsg *dmsg =3D fsl_dbell->dbell_ring.virt + =
(in_be32(&fsl_dbell->dbell_regs->dqdpar) & 0xfff);

Than you can git rid of the DBELL_* macros.


- k
