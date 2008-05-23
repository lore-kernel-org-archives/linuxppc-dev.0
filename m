Return-Path: <ashish.kalra@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8499FDDF16
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 18:53:50 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m4N8rhY1002410
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 01:53:44 -0700 (MST)
Received: from zin33exm20.fsl.freescale.net (zin33exm20.ap.freescale.net
	[10.232.192.5])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m4N8rgEx028120
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 03:53:43 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH] Add port multiplier (PMP) support in sata_fsl driver
Date: Fri, 23 May 2008 14:23:39 +0530
Message-ID: <2A6F278C5B66C4459AF4013E77A40CD3013F7741@zin33exm20.fsl.freescale.net>
In-Reply-To: <483520E9.2090201@gmail.com>
From: "Kalra Ashish" <ashish.kalra@freescale.com>
To: "Tejun Heo" <htejun@gmail.com>, "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, jgarzik@pobox.com,
	Kalra Ashish <ashish.kalra@freescale.com>, linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Tejun,

Thanks for your review comments. Please find my answers below :

>> Broke the sata_fsl.c driver in 2.6.26.  I know the following patch=20
>> fixes the issue, it clearly also adds port multipler support.  I'm
not=20
>> sure if you are willing to take that as part of 2.6.26 or not, but
the=20
>> current
>> 2.6.26 driver is broken.

> Would it be possible to break the patch into two pieces?  One to fix
the problem and the other to add PMP support?

Actually, the boot-time hang issue was caused due to my handling of
command completion interrupt and detecting=20
the queued commands being completed. I was not finding the correct
"active" link and hence causing command completion
interrupts not being ack'ed correctly and locking the machine as they
remain pending forever.

Now the fix I added works for both PMP and direct device attach cases,
and is actually part of the PMP patch because I
had changed command completion interrupt handling initially for PMP and
addition of links in the libata core,=20
and this initial change had introduced the bug which caused hangs in
direct device attach cases. Therefore, this fix was added
to my initial PMP patch. For the same reason, I would wish to keep this
as a single patch.=20

>> @@ -771,7 +803,8 @@ try_offline_again:
>>  		ata_port_printk(ap, KERN_WARNING,
>>  				"No Device OR PHYRDY change,Hstatus =3D
0x%x\n",
>>  				ioread32(hcr_base + HSTATUS));
>> -		goto err;
>> +		*class =3D ATA_DEV_NONE;
>> +		goto out;
>>  	}
>>=20
>>  	/*
>> @@ -783,7 +816,8 @@ try_offline_again:
>>=20
>>  	if ((temp & 0xFF) !=3D 0x18) {
>>  		ata_port_printk(ap, KERN_WARNING, "No Signature
Update\n");
>> -		goto err;
>> +		*class =3D ATA_DEV_NONE;
>> +		goto out;

> Is setting class to ATA_DEV_NONE necessary?  What happens if you drop
the above two chunks?

> Also, it looks to me that currently sata_fsl_softreset() does both
hard and soft resets.  Is it possible to split it into
sata_fsl_hardreset() and softreset()?

>>  		/*
>> -		 * We should consider this as non fatal error, and TF
must
>> -		 * be updated as done below.
>> +		 * Ignore serror in case of fatal errors as we always
want
>> +		 * to do a soft-reset of the FSL SATA controller.
Analyzing
>> +		 * serror may cause libata to schedule a hard-reset
action,
>> +		 * and hard-reset currently does not do controller
>> +		 * offline/online, causing command timeouts and leads to
an
>> +		 * un-recoverable state, hence make libATA ignore
>> +		 * autopsy in case of fatal errors.
>>  		 */
>>=20
>> -		err_mask |=3D AC_ERR_DEV;
>> -	}
>> +		ehi->flags |=3D ATA_EHI_NO_AUTOPSY;

> This is really fishy.  NO_AUTOPSY isn't for stuff like this and libata
EH as of the current #usptream and #upstream-fixes default to hardreset,
so it will hardreset no > matter what you do.

> What do you mean by hardreset does'nt do controller offline/online?
Is this PHY sequence in sata_fsl_softreset()?  I think what should be
done is...

> * Separate out PHY diddling from sata_fsl_softreset() into
sata_fsl_hardreset().

> * If sata_fsl_hardreset() alone doesn't leave the controller in usable
state.  Return -EAGAIN from it to request follow-up SRST on success.

Both of the above cases ( ATA_DEV_NONE & NO_AUTOPSY ) are basically
hacks because as you have mentioned, currently sata_fsl_softreset() does
both=20
PHY-reset and softreset handling. This split of sata_fsl_softreset() has
been on my list of things to do for some time, and I will work on it
next
week and send you an updated patch for review.

Thanks,
Ashish
