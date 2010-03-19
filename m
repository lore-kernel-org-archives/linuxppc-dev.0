Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3CE04B7080
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Mar 2010 02:15:44 +1100 (EST)
Subject: Re: [PATCH] powerpc/fsl: Add multiple MSI bank support
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1268968014.30747.136.camel@concordia>
Date: Fri, 19 Mar 2010 10:15:29 -0500
Message-Id: <03F1ACA1-0A02-4FD6-9FE6-AD44E0EFFD0F@kernel.crashing.org>
References: <1268923993-26689-1-git-send-email-galak@kernel.crashing.org>
	<1268968014.30747.136.camel@concordia>
To: michael@ellerman.id.au
Cc: Lan Chunhe-B25806 <B25806@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 18, 2010, at 10:06 PM, Michael Ellerman wrote:

> On Thu, 2010-03-18 at 09:53 -0500, Kumar Gala wrote:
>> From: Lan Chunhe-B25806 <B25806@freescale.com>
>>=20
>> Freescale QorIQ P4080 has three MSI banks and the original code
>> can not work well. This patch adds multiple MSI banks support for
>> Freescale processor.
>>=20
>> Signed-off-by: Lan Chunhe-B25806 <b25806@freescale.com>
>> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
>=20
>> @@ -146,9 +149,13 @@ static int fsl_setup_msi_irqs(struct pci_dev =
*pdev, int nvec, int type)
>> 	unsigned int virq;
>> 	struct msi_desc *entry;
>> 	struct msi_msg msg;
>> -	struct fsl_msi *msi_data =3D fsl_msi;
>> +	struct fsl_msi *msi_data;
>>=20
>> 	list_for_each_entry(entry, &pdev->msi_list, list) {
>> +		if (entry->irq =3D=3D NO_IRQ)
>> +			continue;
>=20
> This looks wrong, entry->irq should always be 0 here because it was =
just
> kzalloc'ed - you should only be doing this check in teardown.
>=20
>> -	WARN_ON(ppc_md.setup_msi_irqs);
>> -	ppc_md.setup_msi_irqs =3D fsl_setup_msi_irqs;
>> -	ppc_md.teardown_msi_irqs =3D fsl_teardown_msi_irqs;
>> -	ppc_md.msi_check_device =3D fsl_msi_check_device;
>> +	/* The multiple setting ppc_md.setup_msi_irqs will not harm =
things */
>> +	if (!ppc_md.setup_msi_irqs) {
>> +		ppc_md.setup_msi_irqs =3D fsl_setup_msi_irqs;
>> +		ppc_md.teardown_msi_irqs =3D fsl_teardown_msi_irqs;
>> +		ppc_md.msi_check_device =3D fsl_msi_check_device;
>> +	} else if (ppc_md.setup_msi_irqs !=3D fsl_setup_msi_irqs) {
>> +		dev_err(&dev->dev, "Different MSI driver already =
installed!\n");
>> +		err =3D -EBUSY; /* or some other error code */
>> +		goto error_out;
>> +	}
>=20
> I liked it the way it was, because having two competing MSI backends
> means something's probably not going to work. But it's your driver so
> whatever you like.

The previous WARN_ON() is problematic when we have multiple (of the same =
type) MSI blocks.  The check was intended to do exactly what you are =
suggesting.  If you think its doing something else let us know.

- k=
