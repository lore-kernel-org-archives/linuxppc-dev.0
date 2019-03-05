Return-Path: <SRS0=9sKl=RI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F349AC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Mar 2019 16:52:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72DCE20661
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Mar 2019 16:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="It4yqZ/w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72DCE20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44DNGy6zHHzDqDP
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Mar 2019 03:52:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=yadro.com
 (client-ip=89.207.88.251; helo=mta-01.yadro.com;
 envelope-from=s.miroshnichenko@yadro.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=yadro.com header.i=@yadro.com header.b="It4yqZ/w"; 
 dkim-atps=neutral
Received: from mta-01.yadro.com (mta-01.yadro.com [89.207.88.251])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44DNF65sWyzDqCw
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Mar 2019 03:50:50 +1100 (AEDT)
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id B4493419CF;
 Tue,  5 Mar 2019 16:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 content-type:content-type:in-reply-to:mime-version:user-agent
 :date:date:message-id:from:from:references:subject:subject
 :received:received:received; s=mta-01; t=1551804644; x=
 1553619045; bh=TAewmVqMFNA+pWtjGytvKjuYKY2gWNm8DHJuP7oAZsQ=; b=I
 t4yqZ/wz+H7sqMXH85ODxzUXjq/W1Q07jrnUkQC3C8j4UzxjpQReKqL+xuzkiIq/
 m2duCHiqlKkhvjzYNcGTsCdYofzA3RYNF3yWvpc1XMRbuVN6akGcxm3239+SFFRi
 7G+0OcTTC5uTxq+BZ9JZ2KiWJxWnEuZC6fk1vfCFOo=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xwqVK2ycyczW; Tue,  5 Mar 2019 19:50:44 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 6A0524122E;
 Tue,  5 Mar 2019 19:50:44 +0300 (MSK)
Received: from [172.17.15.60] (172.17.15.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Tue, 5 Mar
 2019 19:50:43 +0300
Subject: Re: [PATCH RFC v4 3/9] powerpc/pci: Create pci_dn on demand
To: Oliver <oohall@gmail.com>
References: <20190301160440.26262-1-s.miroshnichenko@yadro.com>
 <20190301160440.26262-4-s.miroshnichenko@yadro.com>
 <CAOSf1CGZcy3N5-KztkakNSDD5w4kg5CL4ucMMbWyYxd=eEa5dw@mail.gmail.com>
From: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Openpgp: preference=signencrypt
Autocrypt: addr=s.miroshnichenko@yadro.com; prefer-encrypt=mutual; keydata=
 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
 lHi50np+KDDPzZS51tw=
Message-ID: <3d6f5dd1-2ed6-68e5-e5f1-2c39cc7b32ac@yadro.com>
Date: Tue, 5 Mar 2019 19:50:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAOSf1CGZcy3N5-KztkakNSDD5w4kg5CL4ucMMbWyYxd=eEa5dw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="QnQBAdG7SQyMr7pV3sFk3TADMckaw6bBW"
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
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, linux@yadro.com,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

--QnQBAdG7SQyMr7pV3sFk3TADMckaw6bBW
Content-Type: multipart/mixed; boundary="Wi1oEvz1CWfY5ZmWUywx9fFvPeGyBcs9G";
 protected-headers="v1"
From: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To: Oliver <oohall@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux@yadro.com,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Russell Currey <ruscur@russell.cc>
Message-ID: <3d6f5dd1-2ed6-68e5-e5f1-2c39cc7b32ac@yadro.com>
Subject: Re: [PATCH RFC v4 3/9] powerpc/pci: Create pci_dn on demand
References: <20190301160440.26262-1-s.miroshnichenko@yadro.com>
 <20190301160440.26262-4-s.miroshnichenko@yadro.com>
 <CAOSf1CGZcy3N5-KztkakNSDD5w4kg5CL4ucMMbWyYxd=eEa5dw@mail.gmail.com>
In-Reply-To: <CAOSf1CGZcy3N5-KztkakNSDD5w4kg5CL4ucMMbWyYxd=eEa5dw@mail.gmail.com>

--Wi1oEvz1CWfY5ZmWUywx9fFvPeGyBcs9G
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 3/5/19 11:04 AM, Oliver wrote:
> On Sat, Mar 2, 2019 at 3:04 AM Sergey Miroshnichenko
> <s.miroshnichenko@yadro.com> wrote:
>>
>> If a struct pci_dn hasn't yet been created for the PCIe device (there =
was
>> no DT node for it), allocate this structure and fill with info read fr=
om
>> the device directly.
>>
>> Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
>> ---
>>  arch/powerpc/kernel/pci_dn.c | 79 ++++++++++++++++++++++++++++++++---=
-
>>  1 file changed, 72 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn=
=2Ec
>> index 341ed71250f1..67ccd7be8344 100644
>> --- a/arch/powerpc/kernel/pci_dn.c
>> +++ b/arch/powerpc/kernel/pci_dn.c
>> @@ -33,6 +33,8 @@
>>  #include <asm/firmware.h>
>>  #include <asm/eeh.h>
>>
>> +static struct pci_dn *create_pdn(struct pci_dev *pdev, struct pci_dn =
*parent);
>> +
>>  /*
>>   * The function is used to find the firmware data of one
>>   * specific PCI device, which is attached to the indicated
>> @@ -65,6 +67,9 @@ struct pci_dn *pci_bus_to_pdn(struct pci_bus *bus)
>>         dn =3D pci_bus_to_OF_node(pbus);
>>         pdn =3D dn ? PCI_DN(dn) : NULL;
>>
>> +       if (!pdn && pbus->self)
>> +               pdn =3D pbus->self->dev.archdata.pci_data;
>> +
>>         return pdn;
>>  }
>>
>> @@ -74,10 +79,13 @@ struct pci_dn *pci_get_pdn_by_devfn(struct pci_bus=
 *bus,
>>         struct device_node *dn =3D NULL;
>>         struct pci_dn *parent, *pdn;
>>         struct pci_dev *pdev =3D NULL;
>> +       bool pdev_found =3D false;
>>
>>         /* Fast path: fetch from PCI device */
>>         list_for_each_entry(pdev, &bus->devices, bus_list) {
>>                 if (pdev->devfn =3D=3D devfn) {
>> +                       pdev_found =3D true;
>> +
>>                         if (pdev->dev.archdata.pci_data)
>>                                 return pdev->dev.archdata.pci_data;
>>
>> @@ -86,6 +94,9 @@ struct pci_dn *pci_get_pdn_by_devfn(struct pci_bus *=
bus,
>>                 }
>>         }
>>
>> +       if (!pdev_found)
>> +               pdev =3D NULL;
>> +
>>         /* Fast path: fetch from device node */
>>         pdn =3D dn ? PCI_DN(dn) : NULL;
>>         if (pdn)
>> @@ -98,9 +109,12 @@ struct pci_dn *pci_get_pdn_by_devfn(struct pci_bus=
 *bus,
>>
>>         list_for_each_entry(pdn, &parent->child_list, list) {
>>                 if (pdn->busno =3D=3D bus->number &&
>> -                    pdn->devfn =3D=3D devfn)
>> -                        return pdn;
>> -        }
>> +                   pdn->devfn =3D=3D devfn) {
>> +                       if (pdev)
>> +                               pdev->dev.archdata.pci_data =3D pdn;
>> +                       return pdn;
>> +               }
>> +       }
>>
>>         return NULL;
>>  }
>> @@ -130,14 +144,15 @@ struct pci_dn *pci_get_pdn(struct pci_dev *pdev)=

>>
>>         list_for_each_entry(pdn, &parent->child_list, list) {
>>                 if (pdn->busno =3D=3D pdev->bus->number &&
>> -                   pdn->devfn =3D=3D pdev->devfn)
>> +                   pdn->devfn =3D=3D pdev->devfn) {
>> +                       pdev->dev.archdata.pci_data =3D pdn;
>>                         return pdn;
>> +               }
>>         }
>>
>> -       return NULL;
>> +       return create_pdn(pdev, parent);
>>  }
>=20
> Eh... If it works I guess it's fine? Killing pdn entirely (or at the
> very least greatly restricting it's role) is something we should work
> towards though since it doesn't make much sense on PNV.
>=20

As I can see, pdns are mostly used on PNV for the following:
 - storing a pe_number;
 - storing struct resource holes - to reserve memory for SR-IOV;
 - IOMMU table_group;
 - storing m64_map;
 - storing struct eeh_dev *edev;

Other fields (busno, devfn, etc.) are available in struct pci_dev.

The pe_numbers are probably can be somehow moved to struct pnv_phb, and
they can be fetched from there by a bdfn. The same for other used
fields. Or there could some new structure - shorter version of struct
pci_dn, without .child_list etc.

Thanks for the review, all the issues you've pointed below will be fixed
in v5!

Best regards,
Serge

>> -#ifdef CONFIG_PCI_IOV
>>  static struct pci_dn *add_one_dev_pci_data(struct pci_dn *parent,
>>                                            int vf_index,
>>                                            int busno, int devfn)
>> @@ -156,7 +171,9 @@ static struct pci_dn *add_one_dev_pci_data(struct =
pci_dn *parent,
>>         pdn->parent =3D parent;
>>         pdn->busno =3D busno;
>>         pdn->devfn =3D devfn;
>> +       #ifdef CONFIG_PCI_IOV
>>         pdn->vf_index =3D vf_index;
>> +       #endif /* CONFIG_PCI_IOV */
>=20
> This function is currently only used when adding VFs, so I'd move the
> VF specific params from this and put them in the call site at
> add_dev_pci_data(). Then you can drop the #ifdef hacks. It might be
> worth renaming add_one_dev_pci_data() and add_one_dev_pci_data() since
> their actual usage is limited to the VF init path, but their name seem
> generic.
>=20
>>         pdn->pe_number =3D IODA_INVALID_PE;
>>         INIT_LIST_HEAD(&pdn->child_list);
>>         INIT_LIST_HEAD(&pdn->list);
>> @@ -164,7 +181,55 @@ static struct pci_dn *add_one_dev_pci_data(struct=
 pci_dn *parent,
>>
>>         return pdn;
>>  }
>> -#endif
>> +
>> +static struct pci_dn *create_pdn(struct pci_dev *pdev, struct pci_dn =
*parent)
>> +{
>> +       struct pci_dn *pdn =3D NULL;
>> +
>> +       if (!parent)
>> +               return NULL;
>> +
>> +       pdn =3D add_one_dev_pci_data(parent, 0, pdev->bus->busn_res.st=
art, pdev->devfn);
>> +       dev_info(&pdev->dev, "Create a new pdn for devfn %2x\n", pdev-=
>devfn / 8);
>> +
>=20
>> +       if (pdn) {
>=20
> Check for !pdn and exit early. Stacking indentation levels just gets
> kind of ugly.
>=20
>> +               #ifdef CONFIG_EEH
>> +               struct eeh_dev *edev;
>> +               #endif /* CONFIG_EEH */
> You don't use the variable for anything. You can either switch this to
> a void pointer or just check the return value of eeh_dev_init()
> directly and drop this.
>=20
>> +               u32 class_code;
>> +               u16 device_id;
>> +               u16 vendor_id;
>> +
>=20
>> +               #ifdef CONFIG_EEH
>> +               edev =3D eeh_dev_init(pdn);
>> +               if (!edev) {
>> +                       kfree(pdn);
>> +                       dev_err(&pdev->dev, "%s: Failed to allocate ed=
ev\n", __func__);
>> +                       return NULL;
>> +               }
>> +               #endif /* CONFIG_EEH */
>> +
>> +               pci_bus_read_config_word(pdev->bus, pdev->devfn,
>> +                                        PCI_VENDOR_ID, &vendor_id);
>> +               pdn->vendor_id =3D vendor_id;
>> +
>> +               pci_bus_read_config_word(pdev->bus, pdev->devfn,
>> +                                        PCI_DEVICE_ID, &device_id);
>> +               pdn->device_id =3D device_id;
>> +
>> +               pci_bus_read_config_dword(pdev->bus, pdev->devfn,
>> +                                         PCI_CLASS_REVISION, &class_c=
ode);
>> +               class_code >>=3D 8;
>> +               pdn->class_code =3D class_code;
>> +
>> +               pdn->pci_ext_config_space =3D 0;
> Does this need to be explicitly initialised or can we rely on it being
> allocated with kzalloc() or similar?
>=20
>> +               pdev->dev.archdata.pci_data =3D pdn;
>> +       } else {
>> +               dev_err(&pdev->dev, "%s: Failed to allocate pdn\n", __=
func__);
>> +       }
>> +
>> +       return pdn;
>> +}
>>
>>  struct pci_dn *add_dev_pci_data(struct pci_dev *pdev)
>>  {
>> --
>> 2.20.1
>>


--Wi1oEvz1CWfY5ZmWUywx9fFvPeGyBcs9G--

--QnQBAdG7SQyMr7pV3sFk3TADMckaw6bBW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEHW7T7ovP/cFp8+b3DHQ+aNFTs7UFAlx+qOMACgkQDHQ+aNFT
s7VPNg//ZT4nozLTaQuAEGz7BY0jtJX8ok2mctnTkHPr650V71kcYZ57XPgMM3FM
EPOiRzXdvOzmP+u/GGkEVWj3BTPNDE4rHEugd7H9rT6QoGQMDSesYoyBgrIHYL+n
WNEKrIyGI5Y2ERDzy4u4DKVbF0gWUUK44PTGPrRlZ2DorHnv/zDACVVnBoKE4nU8
38cb8IbfOpkzMk7NIlgIhOWpKwjeHbuFuzHz9dU9nfSTg+gb9fkzB/j6+DT0Dwy8
HWYVA4bYJTcsERiBolhyVraxPKuWlBpJ3yFlj3fzuQY3prZxwWfVT0mAs1F/dl2C
wt1cIvptl8NxXJK7ro7yH04X4U/Rr/quKqNo/A55qWAUpcij6qNDLj//rxrr8oQP
tlhp/+y4Vw7v+GdBM/6Ow/0wntfbTRXR8J2HcCQOK5WpE13A+HtRrK2uvT/tea4i
2SdUnoeuKewmnpEeVNu2EJks4O0OcEMcdVGm/zKpwBNbT2TRZs+sI2YFCat4N20N
hR15Bl0nY4v8Z9Rvi7vgkakZXIGueJ1gLAObTNtjY+6OhPfpbuf8/sKCAcmud5bf
V3erAhhvxcnJYNjgiAeSi9Wd6qqPrwyBYrZc71vwA8kTem5zfcZGL5JijO7J8GOy
0ZmHKp4oIKp3qGaf/bka3I8AFwuc9eQ3zSssAVF3ERL+DkLM47I=
=Bf88
-----END PGP SIGNATURE-----

--QnQBAdG7SQyMr7pV3sFk3TADMckaw6bBW--
