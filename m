Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 751A8B6F8F
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Apr 2011 00:04:09 +1100 (EST)
Subject: Re: [PATCH] edac/mpc85xx: Limit setting/clearing of HID1[RFXE] to
	e500v1/v2 cores
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20110331224208.GA30426@us.ibm.com>
Date: Fri, 1 Apr 2011 08:03:56 -0500
Message-Id: <94F1D25E-6F38-42E5-A097-C4AB23E58D78@kernel.crashing.org>
References: <1301610194-29971-1-git-send-email-galak@kernel.crashing.org>
	<20110331224208.GA30426@us.ibm.com>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: linuxppc-dev@ozlabs.org, bluesmoke-devel@lists.sourceforge.net,
	dougthompson@xmission.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 31, 2011, at 5:42 PM, Nishanth Aravamudan wrote:

> On 31.03.2011 [17:23:14 -0500], Kumar Gala wrote:
>> Only the e500v1/v2 cores have HID1[RXFE] so we should attempt to set =
or
>> clear this register bit on them.  Otherwise we get crashes like:
>=20
> <snip>
>=20
>> diff --git a/drivers/edac/mpc85xx_edac.c =
b/drivers/edac/mpc85xx_edac.c
>> index b123bb3..5aef2ed 100644
>> --- a/drivers/edac/mpc85xx_edac.c
>> +++ b/drivers/edac/mpc85xx_edac.c
>=20
> <snip>
>=20
>> @@ -1209,10 +1215,15 @@ static void __exit =
mpc85xx_mc_restore_hid1(void *data)
>> static void __exit mpc85xx_mc_exit(void)
>> {
>> #ifdef CONFIG_FSL_SOC_BOOKE
>> -	on_each_cpu(mpc85xx_mc_restore_hid1, NULL, 0);
>> +	u32 pvr =3D mfspr(SPRN_PVR);
>> +
>> +	if ((PVR_VER(pvr) =3D=3D PVR_VER_E500V1) ||
>> +	    (PVR_VER(pvr) =3D=3D PVR_VER_E500V2)) {
>> +		on_each_cpu(mpc85xx_mc_restore_hid1, NULL, 0);
>> +	}
>> #endif
>> #ifdef CONFIG_PCI
>> -	of_unregister_platform_driver(&mpc85xx_pci_err_driver);
>> +	of_unregistr_platform_driver(&mpc85xx_pci_err_driver);
>=20
> Unintended change?

Yep, thanks for catching.

- k=
