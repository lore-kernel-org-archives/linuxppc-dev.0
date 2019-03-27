Return-Path: <SRS0=MnD0=R6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BA2C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 17:13:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 402AB206BA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 17:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="A7B+rSp2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 402AB206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44TvjB15PyzDqQN
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Mar 2019 04:13:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=yadro.com
 (client-ip=89.207.88.251; helo=mta-01.yadro.com;
 envelope-from=s.miroshnichenko@yadro.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=yadro.com header.i=@yadro.com header.b="A7B+rSp2"; 
 dkim-atps=neutral
Received: from mta-01.yadro.com (mta-01.yadro.com [89.207.88.251])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44TvgT5sb2zDqPl
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Mar 2019 04:12:05 +1100 (AEDT)
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id EDAE241A41;
 Wed, 27 Mar 2019 17:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 content-type:content-type:in-reply-to:mime-version:user-agent
 :date:date:message-id:from:from:references:subject:subject
 :received:received:received; s=mta-01; t=1553706718; x=
 1555521119; bh=qvH2JYhpsSI2xZn952KeehFyQj7LM2QFQxSV0zp1zmw=; b=A
 7B+rSp2DYb6F/xBsUsBv+o31gPIBN8RHzIzBXaaC2EG5Q4VPTCMlLVNzWQhbDP0S
 4aXlmuB96MSVNIYhcs3NE6YUI68sWVWZs8VlaC5ltWeV6RJycuSoLc13QkshMP4/
 NWcxby/NuGYoktfQJuD6e149TMF1tVDDDQw7iDOUIs=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8Mud4U-nZkJX; Wed, 27 Mar 2019 20:11:58 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id CB94441A0C;
 Wed, 27 Mar 2019 20:11:57 +0300 (MSK)
Received: from [172.17.15.60] (172.17.15.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Wed, 27
 Mar 2019 20:11:57 +0300
Subject: Re: [PATCH RFC v4 02/21] PCI: Fix race condition in
 pci_enable/disable_device()
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20190311133122.11417-1-s.miroshnichenko@yadro.com>
 <20190311133122.11417-3-s.miroshnichenko@yadro.com>
 <20190326190038.GL24180@google.com>
From: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Openpgp: preference=signencrypt
Autocrypt: addr=s.miroshnichenko@yadro.com; prefer-encrypt=mutual; keydata=
 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
 lHi50np+KDDPzZS51tw=
Message-ID: <f0a5be4c-4a90-d5d3-f4fc-7b364143a85b@yadro.com>
Date: Wed, 27 Mar 2019 20:11:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190326190038.GL24180@google.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="MzcZ8NHdkHNPKzrPfEdUWBQ8QvIkrwKiD"
X-Originating-IP: [172.17.15.60]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Marta Rybczynska <mrybczyn@kalray.eu>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux@yadro.com,
 Srinath Mannam <srinath.mannam@broadcom.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

--MzcZ8NHdkHNPKzrPfEdUWBQ8QvIkrwKiD
Content-Type: multipart/mixed; boundary="SZX8gVbqDGgIpm1j0BU84HpFvIMDCudKR";
 protected-headers="v1"
From: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux@yadro.com, Srinath Mannam <srinath.mannam@broadcom.com>,
 Marta Rybczynska <mrybczyn@kalray.eu>, linux-kernel@vger.kernel.org
Message-ID: <f0a5be4c-4a90-d5d3-f4fc-7b364143a85b@yadro.com>
Subject: Re: [PATCH RFC v4 02/21] PCI: Fix race condition in
 pci_enable/disable_device()
References: <20190311133122.11417-1-s.miroshnichenko@yadro.com>
 <20190311133122.11417-3-s.miroshnichenko@yadro.com>
 <20190326190038.GL24180@google.com>
In-Reply-To: <20190326190038.GL24180@google.com>

--SZX8gVbqDGgIpm1j0BU84HpFvIMDCudKR
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 3/26/19 10:00 PM, Bjorn Helgaas wrote:
> [+cc Srinath, Marta, LKML]
>=20
> On Mon, Mar 11, 2019 at 04:31:03PM +0300, Sergey Miroshnichenko wrote:
>>  CPU0                                      CPU1
>>
>>  pci_enable_device_mem()                   pci_enable_device_mem()
>>    pci_enable_bridge()                       pci_enable_bridge()
>>      pci_is_enabled()
>>        return false;
>>      atomic_inc_return(enable_cnt)
>>      Start actual enabling the bridge
>>      ...                                       pci_is_enabled()
>>      ...                                         return true;
>>      ...                                   Start memory requests <-- F=
AIL
>>      ...
>>      Set the PCI_COMMAND_MEMORY bit <-- Must wait for this
>>
>> This patch protects the pci_enable/disable_device() and pci_enable_bri=
dge()
>> with mutexes.
>=20
> This is a subtle issue that we've tried to fix before, but we've never
> had a satisfactory solution, so I hope you've figured out the right
> fix.
>=20
> I'll include some links to previous discussion.  This patch is very
> similar to [2], which we didn't actually apply.  We did apply the
> patch from [3] as 40f11adc7cd9 ("PCI: Avoid race while enabling
> upstream bridges"), but it caused the regressions reported in [4,5],
> so we reverted it with 0f50a49e3008 ("Revert "PCI: Avoid race while
> enabling upstream bridges"").
>=20

Thanks for the links, I wasn't aware of these discussions and patches!

On PowerNV this issue is partially hidden by db2173198b95 ("powerpc/power=
nv/pci: Work
around races in PCI bridge enabling"), and on x86 BIOS pre-initializes al=
l the bridges, so
it doesn't reproduce until hotplugging in a hotplugged bridge.

This patch is indeed similar to 40f11adc7cd9 ("PCI: Avoid race while enab=
ling upstream
bridges"), but instead of a single static mutex it adds per-device mutexe=
s and prevents
the dev->enable_cnt from incrementing too early. So it's not needed anymo=
re to carefully
select a moment safe enough to enable the device.

Serge

> I think the underlying design problem is that we have a driver for
> device B calling pci_enable_device(), and it is changing the state of
> device A (an upstream bridge).  The model generally is that a driver
> should only touch the device it is bound to.
>=20
> It's tricky to get the locking right when several children of device A
> all need to operate on A.
>=20
> That's all to say I'll have to think carefully about this particular
> patch, so I'll go on to the others and come back to this one.
>=20
> Bjorn
>=20
> [1] https://lore.kernel.org/linux-pci/1494256190-28993-1-git-send-email=
-srinath.mannam@broadcom.com/T/#u
>     [RFC PATCH] pci: Concurrency issue in NVMe Init through PCIe switch=

>=20
> [2] https://lore.kernel.org/linux-pci/1496135297-19680-1-git-send-email=
-srinath.mannam@broadcom.com/T/#u
>     [RFC PATCH v2] pci: Concurrency issue in NVMe Init through PCIe swi=
tch
>=20
> [3] https://lore.kernel.org/linux-pci/1501858648-22228-1-git-send-email=
-srinath.mannam@broadcom.com/T/#u
>     [RFC PATCH v3] pci: Concurrency issue during pci enable bridge
>=20
> [4] https://lore.kernel.org/linux-pci/150547971091.977464.1629404586617=
9907260.stgit@buzz/T/#u
>     [PATCH bisected regression in 4.14] PCI: fix race while enabling up=
stream bridges concurrently
>=20
> [5] https://lore.kernel.org/linux-wireless/04c9b578-693c-1dc6-9f0f-9045=
80231b21@kernel.dk/T/#u
>     iwlwifi firmware load broken in current -git
>=20
> [6] https://lore.kernel.org/linux-pci/744877924.5841545.1521630049567.J=
avaMail.zimbra@kalray.eu/T/#u
>     [RFC PATCH] nvme: avoid race-conditions when enabling devices
>=20
>> Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
>> ---
>>  drivers/pci/pci.c   | 26 ++++++++++++++++++++++----
>>  drivers/pci/probe.c |  1 +
>>  include/linux/pci.h |  1 +
>>  3 files changed, 24 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index f006068be209..895201d4c9e6 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -1615,6 +1615,8 @@ static void pci_enable_bridge(struct pci_dev *de=
v)
>>  	struct pci_dev *bridge;
>>  	int retval;
>> =20
>> +	mutex_lock(&dev->enable_mutex);
>> +
>>  	bridge =3D pci_upstream_bridge(dev);
>>  	if (bridge)
>>  		pci_enable_bridge(bridge);
>> @@ -1622,6 +1624,7 @@ static void pci_enable_bridge(struct pci_dev *de=
v)
>>  	if (pci_is_enabled(dev)) {
>>  		if (!dev->is_busmaster)
>>  			pci_set_master(dev);
>> +		mutex_unlock(&dev->enable_mutex);
>>  		return;
>>  	}
>> =20
>> @@ -1630,11 +1633,14 @@ static void pci_enable_bridge(struct pci_dev *=
dev)
>>  		pci_err(dev, "Error enabling bridge (%d), continuing\n",
>>  			retval);
>>  	pci_set_master(dev);
>> +	mutex_unlock(&dev->enable_mutex);
>>  }
>> =20
>>  static int pci_enable_device_flags(struct pci_dev *dev, unsigned long=
 flags)
>>  {
>>  	struct pci_dev *bridge;
>> +	/* Enable-locking of bridges is performed within the pci_enable_brid=
ge() */
>> +	bool need_lock =3D !dev->subordinate;
>>  	int err;
>>  	int i, bars =3D 0;
>> =20
>> @@ -1650,8 +1656,13 @@ static int pci_enable_device_flags(struct pci_d=
ev *dev, unsigned long flags)
>>  		dev->current_state =3D (pmcsr & PCI_PM_CTRL_STATE_MASK);
>>  	}
>> =20
>> -	if (atomic_inc_return(&dev->enable_cnt) > 1)
>> +	if (need_lock)
>> +		mutex_lock(&dev->enable_mutex);
>> +	if (pci_is_enabled(dev)) {
>> +		if (need_lock)
>> +			mutex_unlock(&dev->enable_mutex);
>>  		return 0;		/* already enabled */
>> +	}
>> =20
>>  	bridge =3D pci_upstream_bridge(dev);
>>  	if (bridge)
>> @@ -1666,8 +1677,10 @@ static int pci_enable_device_flags(struct pci_d=
ev *dev, unsigned long flags)
>>  			bars |=3D (1 << i);
>> =20
>>  	err =3D do_pci_enable_device(dev, bars);
>> -	if (err < 0)
>> -		atomic_dec(&dev->enable_cnt);
>> +	if (err >=3D 0)
>> +		atomic_inc(&dev->enable_cnt);
>> +	if (need_lock)
>> +		mutex_unlock(&dev->enable_mutex);
>>  	return err;
>>  }
>> =20
>> @@ -1910,15 +1923,20 @@ void pci_disable_device(struct pci_dev *dev)
>>  	if (dr)
>>  		dr->enabled =3D 0;
>> =20
>> +	mutex_lock(&dev->enable_mutex);
>>  	dev_WARN_ONCE(&dev->dev, atomic_read(&dev->enable_cnt) <=3D 0,
>>  		      "disabling already-disabled device");
>> =20
>> -	if (atomic_dec_return(&dev->enable_cnt) !=3D 0)
>> +	if (atomic_dec_return(&dev->enable_cnt) !=3D 0) {
>> +		mutex_unlock(&dev->enable_mutex);
>>  		return;
>> +	}
>> =20
>>  	do_pci_disable_device(dev);
>> =20
>>  	dev->is_busmaster =3D 0;
>> +
>> +	mutex_unlock(&dev->enable_mutex);
>>  }
>>  EXPORT_SYMBOL(pci_disable_device);
>> =20
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index 2ec0df04e0dc..977a127ce791 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -2267,6 +2267,7 @@ struct pci_dev *pci_alloc_dev(struct pci_bus *bu=
s)
>>  	INIT_LIST_HEAD(&dev->bus_list);
>>  	dev->dev.type =3D &pci_dev_type;
>>  	dev->bus =3D pci_bus_get(bus);
>> +	mutex_init(&dev->enable_mutex);
>> =20
>>  	return dev;
>>  }
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 77448215ef5b..cb2760a31fe2 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -419,6 +419,7 @@ struct pci_dev {
>>  	unsigned int	no_vf_scan:1;		/* Don't scan for VFs after IOV enableme=
nt */
>>  	pci_dev_flags_t dev_flags;
>>  	atomic_t	enable_cnt;	/* pci_enable_device has been called */
>> +	struct mutex	enable_mutex;
>> =20
>>  	u32		saved_config_space[16]; /* Config space saved at suspend time *=
/
>>  	struct hlist_head saved_cap_space;
>> --=20
>> 2.20.1
>>


--SZX8gVbqDGgIpm1j0BU84HpFvIMDCudKR--

--MzcZ8NHdkHNPKzrPfEdUWBQ8QvIkrwKiD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEHW7T7ovP/cFp8+b3DHQ+aNFTs7UFAlybrtcACgkQDHQ+aNFT
s7Uzfw/+Pvmd871A1hqb3OmxCrLtfBb5rY2ePq4LkqoG0bddw4X4is1M/dj0EhxX
NLvX6VPOYMSPz9U3GWW7fjrwSa0LKX8hOsAH1zSeYU7YEclY/JzsbuVRqu51bjOZ
I5rXmXumyXmrlPoBKQGGcGjUkhN2QPVT4fbJMlzQfLAU9bmJse4zlIKTaIux4bf/
iNfSZ7SWBo48dKBR+4nldHgy3pHg8FEYCvfmlsjoWcEsuTVZMU6ZU/5waJ+Atw63
S7UFlduSmHKQ36DLnrhbt7P13paX2REIvs7XAyUqYTMrffv6gl3+sIiTPPbcexBS
UGgok2lfIJ5EG+GPn5AtrmWniZsCSv7hmcHL/qGekzwP8P4JFVhmgIlh0HcLATZr
z+oevX1xZuGHN8OWA8Av4qmVw5rnEPt3ON+vvEsDtpET4U1Y6zKFC5ePNNwQV0/l
38zc+aRXSBKq5tWE652jVhb3GQshQ2aXAPFfPReKYfiWeFuSOkJwdDzNjwBquLKn
ijHdIw0we7hoFr9Z665RLLyAf0haaPiu3dGRqNHFiT5gjLjfefk7+Y4lhoeCM5cS
BU3VC0GaYl2LU+RXBJK8Cvk/QK3JyleD6f3PCiKRV8jFPfNuU9+ZeJY/SMJQOMDq
H3JdM7o/q+16GYcN0//BbH1Sldkw06HmDnEBMSYrbPSBfGH9ivE=
=hfd7
-----END PGP SIGNATURE-----

--MzcZ8NHdkHNPKzrPfEdUWBQ8QvIkrwKiD--
