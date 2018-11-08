Return-Path: <SRS0=TQYx=NT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E371DC32789
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 06:51:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38FCC2081D
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 06:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="yWU6Q7CS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38FCC2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42rDTP58jzzF3Lp
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 17:51:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="yWU6Q7CS";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=aik@ozlabs.ru; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com
 header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="yWU6Q7CS"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42rDQq5SxlzF3JP
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Nov 2018 17:49:07 +1100 (AEDT)
Received: by mail-pl1-x643.google.com with SMTP id s5-v6so9059756plq.11
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Nov 2018 22:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to;
 bh=PL0P0ZRib7bGc6iIFPcwOahzJBfWubVceCVGuWqZGRs=;
 b=yWU6Q7CSB+ATdMHDQLRP147vUVsAIRjGgEn2YSqVSS0X6QEmzr2dnJiqB3eFc/7aqo
 Sip1Tmz23IyCPWs7uz7QycMciDNxMogZettwYrp6qhWmDS/VBkLEiSPpfZoRQPEty95w
 0zEQxsvBZSVhZXnjLrTsXxafmIjuoXM8F1/N4fWtPyWmEt6dA7najaYpj9f++TCVqbLy
 4mQCavXvP8ana4oN1fZibJ14NLnUaO5EBlz79uOvimA6AxJuQbZSYt05tu4OAhDbupU9
 X77gyQiF1glkdmbqpcMHrcTBkO/BMdC2wosIu6H9ZholaHjS0j0gr66qf9CCtDyP1qtU
 dmrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to;
 bh=PL0P0ZRib7bGc6iIFPcwOahzJBfWubVceCVGuWqZGRs=;
 b=iy0VZujN2moLAmBggXURoDStYRWXnCodKi8ZBbIQOioSRy4tTYbSFG6HOV/5gljyaM
 c9fsaVTlBfvRaY+SHUDI6ZoBtHPSBxjuQbR03AP2kVoU2QTqWJVAs09OFhDAEt/uPhFY
 IdNE5AI6ftZUGTbQT5o+rmg0cO0qcMN4Mgmg/pWBCnS6AH+zHOySqlB5nfWO/MFrgIIS
 jZvY1kn2QLNZvamQPhQ7vJXO2kUCaImC5uoFlgvR6n8fRI1qieX/Tp05BvVaMtSPv9m5
 aPsFcPDreKhBOFTli5HXEY+MBMF4PWE7/f1bpO0KQdApiP3ddnsPL77wsBeql/LkCe/H
 1Oyg==
X-Gm-Message-State: AGRZ1gKL3+twj8X7SU3nsMXxuPSfABo1ur06DvvY3SLZvzo2vCSMSH7H
 7P4fqy5Vg2jz8bTbrnZr9tuGhA==
X-Google-Smtp-Source: AJdET5flAbsd7bphNRAX7CoJsUJUt2r/xzX8nUXARxl9ByTa4ipALaL2yLBnOiQdYkz/cirh0rHK+Q==
X-Received: by 2002:a17:902:a587:: with SMTP id
 az7-v6mr3480331plb.151.1541659745131; 
 Wed, 07 Nov 2018 22:49:05 -0800 (PST)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id i189-v6sm5217015pfc.16.2018.11.07.22.49.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Nov 2018 22:49:04 -0800 (PST)
Subject: Re: [PATCH kernel 2/3] vfio_pci: Allow regions to add own capabilities
To: David Gibson <david@gibson.dropbear.id.au>
References: <20181015094233.1324-1-aik@ozlabs.ru>
 <20181015094233.1324-3-aik@ozlabs.ru> <20181108062139.GQ5575@umbus.fritz.box>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Openpgp: preference=signencrypt
Autocrypt: addr=aik@ozlabs.ru; keydata=
 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
Message-ID: <72022e34-6cf0-3946-8049-ba3d998097f3@ozlabs.ru>
Date: Thu, 8 Nov 2018 17:48:58 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181108062139.GQ5575@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9j9ckKi0u39cTezFYjVRcKAmLGrvreSek"
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
Cc: kvm@vger.kernel.org, Alistair Popple <alistair@popple.id.au>,
 linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>, Reza Arbab <arbab@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9j9ckKi0u39cTezFYjVRcKAmLGrvreSek
Content-Type: multipart/mixed; boundary="87ZmbvDIExPB6hFLvivDf054qN6ccPNTa";
 protected-headers="v1"
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Alistair Popple <alistair@popple.id.au>, Reza Arbab <arbab@linux.ibm.com>
Message-ID: <72022e34-6cf0-3946-8049-ba3d998097f3@ozlabs.ru>
Subject: Re: [PATCH kernel 2/3] vfio_pci: Allow regions to add own
 capabilities
References: <20181015094233.1324-1-aik@ozlabs.ru>
 <20181015094233.1324-3-aik@ozlabs.ru> <20181108062139.GQ5575@umbus.fritz.box>
In-Reply-To: <20181108062139.GQ5575@umbus.fritz.box>

--87ZmbvDIExPB6hFLvivDf054qN6ccPNTa
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 08/11/2018 17:21, David Gibson wrote:
> On Mon, Oct 15, 2018 at 08:42:32PM +1100, Alexey Kardashevskiy wrote:
>> VFIO regions already support region capabilities with a limited set of=

>> fields. However the subdriver might have to report to the userspace
>> additional bits.
>>
>> This adds an add_capability() hook to vfio_pci_regops.
>>
>> This is aiming Witherspoon POWER9 machines which have multiple
>> interconnected NVIDIA V100 GPUs with coherent RAM; each GPU's RAM
>> is mapped to a system bus and to each of GPU internal system bus and
>> the GPUs use this for DMA routing as DMA trafic can go via any
>> of many NVLink2 (GPU-GPU or GPU-CPU) or even stay local within a
>> GPU.
>=20
> This description doesn't really make clear how per-region capabilities
> are relevant to these devices.


I am confused. This patch just adds a hook, and the device specifics are
explained in the next patch where they are used...


>=20
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>
>> This is based on top of "vfio_pci: Allow mapping extra regions"
>> ---
>>  drivers/vfio/pci/vfio_pci_private.h | 3 +++
>>  drivers/vfio/pci/vfio_pci.c         | 6 ++++++
>>  2 files changed, 9 insertions(+)
>>
>> diff --git a/drivers/vfio/pci/vfio_pci_private.h b/drivers/vfio/pci/vf=
io_pci_private.h
>> index 86aab05..93c1738 100644
>> --- a/drivers/vfio/pci/vfio_pci_private.h
>> +++ b/drivers/vfio/pci/vfio_pci_private.h
>> @@ -62,6 +62,9 @@ struct vfio_pci_regops {
>>  	int	(*mmap)(struct vfio_pci_device *vdev,
>>  			struct vfio_pci_region *region,
>>  			struct vm_area_struct *vma);
>> +	int	(*add_capability)(struct vfio_pci_device *vdev,
>> +				  struct vfio_pci_region *region,
>> +				  struct vfio_info_cap *caps);
>>  };
>> =20
>>  struct vfio_pci_region {
>> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c=

>> index 7923314..4a3b93e 100644
>> --- a/drivers/vfio/pci/vfio_pci.c
>> +++ b/drivers/vfio/pci/vfio_pci.c
>> @@ -759,6 +759,12 @@ static long vfio_pci_ioctl(void *device_data,
>>  			if (ret)
>>  				return ret;
>> =20
>> +			if (vdev->region[i].ops->add_capability) {
>> +				ret =3D vdev->region[i].ops->add_capability(vdev,
>> +						&vdev->region[i], &caps);
>> +				if (ret)
>> +					return ret;
>> +			}
>>  		}
>>  		}
>> =20
>=20

--=20
Alexey


--87ZmbvDIExPB6hFLvivDf054qN6ccPNTa--

--9j9ckKi0u39cTezFYjVRcKAmLGrvreSek
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEECIb1sawlPgRl/px9ze7KtGKK020FAlvj3FsACgkQze7KtGKK
0233oBAAo/ILPRKBB1qfck905TS82yXuiSKF8FUVCoaTryBi3LbfdC1MYAHoITvt
x0ST2ZeKMOgVFRdLKF/AmQjztEBM9uHm+v2skSKs4IU5IeS2IqFuBlknp8PPBgZV
91a19RkieiVuZq2UwYn5IQ/N6Oxgn3br2IRr1yKp6iK/GmsG5jB30SFQAlCO2P3p
myAPZ1uoqtzCdMUFle64ejQw/A/zshf2FfmLLWq7A+mk5bpsEkgeqsJ+Fxwr+VRx
tp/vE1/Xddj2iwJOMTr6eiGprlgzfOImLUDpDqcyxSr4eOtC1SxWjbwS6OX5YpuP
yUg1y9BnCsiBcZO2IKZz7/BP40XflfDEFXBB9MHVivaJykn55sPOd+2jO0xpyQ89
XmHIG2ua4hn4IMv2hNWdBLfa9h/9x7Dqq6v0LH6UZHn2hmFZLW8NXR9WVdjdLQR+
p1BctXsL82JMBvh1L+btnIi+qwUIyMpcn+OhKXtOn9KGzXhJ42btFw+QnMRx0cX7
asB4/nlxri1jrQvy2AN2TUAFME+oi+YQNdmrjnVbB/XHN6bOgVP1W15iwr0d6DmN
i9RsAnKYAZAuuouofIlCqYk90fWmIL9bTDvjBsuM8dbjfW3X1+A0Z4WjwMnzSP2W
iBLngYf8zyfhOFoPJkJi4lrQIuZlx48e2EmBekBnDypnOTqHVvY=
=AXDg
-----END PGP SIGNATURE-----

--9j9ckKi0u39cTezFYjVRcKAmLGrvreSek--
