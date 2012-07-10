Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4568B2C007F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2012 11:47:12 +1000 (EST)
Subject: Re: [PATCH 3/3 v2] powerpc/mpic: FSL MPIC error interrupt support.
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4FFB3D88.6030106@freescale.com>
Date: Mon, 9 Jul 2012 20:47:14 -0500
Message-Id: <22EF3A64-2185-4078-B7B9-00E00D32604A@kernel.crashing.org>
References: <1341823643-15737-1-git-send-email-Varun.Sethi@freescale.com>
 <62D13F27-5E39-450E-953D-102DCA32AA9D@kernel.crashing.org>
 <4FFB3D88.6030106@freescale.com>
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


On Jul 9, 2012, at 3:22 PM, Scott Wood wrote:

> On 07/09/2012 02:03 PM, Kumar Gala wrote:
>>=20
>> On Jul 9, 2012, at 3:47 AM, Varun Sethi wrote:
>>=20
>>> +int mpic_err_int_init(struct mpic *mpic, irq_hw_number_t irqnum)
>>> +{
>>=20
>> Why can't we do this during mpic_init() time?
>=20
> Are you willing to hardcode that IRQ 16 is the error interrupt, =
without
> waiting to see an intspec?

I'm torn, but the bit of code in mpic_host_xlate that calls =
mpic_err_int_init() is just ugly.

We could consider it similar to how we assume IPIs.

>>> +	ret =3D request_irq(virq, fsl_error_int_handler, IRQF_NO_THREAD,
>>> +		    "mpic-error-int", mpic);
>>=20
>> Hmm, should we be using irq_set_chained_handler() instead of =
request_irq
>=20
> As I said last time, "that's how Varun initially did it and I asked =
him
> to change it, because it gets a lot trickier to get things right, and =
I
> didn't see what it was buying us."  That original patch had locking
> problems as a result.
>=20
> Using the chained handler mechanism puts the responsibility on us to =
do
> a lot of the generic stuff that's already perfectly well implemented =
in
> generic code.  We're implementing a cascade, not a new flow.

Makes sense.

- k=
