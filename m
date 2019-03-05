Return-Path: <SRS0=9sKl=RI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFFFC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Mar 2019 15:17:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BA8020848
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Mar 2019 15:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="SIaO/cK+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BA8020848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44DL973bJ5zDqBb
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Mar 2019 02:17:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=yadro.com
 (client-ip=89.207.88.251; helo=mta-01.yadro.com;
 envelope-from=s.miroshnichenko@yadro.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=yadro.com header.i=@yadro.com header.b="SIaO/cK+"; 
 dkim-atps=neutral
Received: from mta-01.yadro.com (mta-01.yadro.com [89.207.88.251])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44DL5S5RyjzDq99
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Mar 2019 02:14:04 +1100 (AEDT)
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 1AEC3419E1;
 Tue,  5 Mar 2019 15:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 content-type:content-type:in-reply-to:mime-version:user-agent
 :date:date:message-id:from:from:references:subject:subject
 :received:received:received; s=mta-01; t=1551798838; x=
 1553613239; bh=uYMkQriB119+stgXOCuC1DFL3wbkbVq2+Hi9zhP8IZY=; b=S
 IaO/cK+IHvUknoEXnIsgxMI9NFwAuKJawVJWVK+mAoaQhu9lJ+0YvVmT42YI2n0a
 fNQVGvmV6/CsaaHlqcwSQpK01bwJBUq7KAfgYM4PHSusMKOHOaGWoWFIYJjh46lS
 4H6FSZeFFvGRa2WsV/hmtCumpPVwROyrTpNkDXMacY=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hFOko1aIPHZ3; Tue,  5 Mar 2019 18:13:58 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 834E641970;
 Tue,  5 Mar 2019 18:13:57 +0300 (MSK)
Received: from [172.17.15.60] (172.17.15.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Tue, 5 Mar
 2019 18:13:56 +0300
Subject: Re: [PATCH RFC v4 2/9] powerpc/powernv/pci: Suppress an EEH error
 when reading an empty slot
To: Oliver <oohall@gmail.com>
References: <20190301160440.26262-1-s.miroshnichenko@yadro.com>
 <20190301160440.26262-3-s.miroshnichenko@yadro.com>
 <CAOSf1CG0c_4jZQKanq7WHo-n9Urmx8NG8yVWbbx07ivZDu9e-A@mail.gmail.com>
From: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Openpgp: preference=signencrypt
Autocrypt: addr=s.miroshnichenko@yadro.com; prefer-encrypt=mutual; keydata=
 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
 lHi50np+KDDPzZS51tw=
Message-ID: <9482c29d-df9a-8970-c407-6f99649c9e78@yadro.com>
Date: Tue, 5 Mar 2019 18:13:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAOSf1CG0c_4jZQKanq7WHo-n9Urmx8NG8yVWbbx07ivZDu9e-A@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="PYy7ozVUL4W6vGOozM97POjmGFGKbk7vI"
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

--PYy7ozVUL4W6vGOozM97POjmGFGKbk7vI
Content-Type: multipart/mixed; boundary="Hn8DeZVSoUMD9sxtTEDtYJd5HaSZty5aN";
 protected-headers="v1"
From: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To: Oliver <oohall@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux@yadro.com,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Russell Currey <ruscur@russell.cc>
Message-ID: <9482c29d-df9a-8970-c407-6f99649c9e78@yadro.com>
Subject: Re: [PATCH RFC v4 2/9] powerpc/powernv/pci: Suppress an EEH error
 when reading an empty slot
References: <20190301160440.26262-1-s.miroshnichenko@yadro.com>
 <20190301160440.26262-3-s.miroshnichenko@yadro.com>
 <CAOSf1CG0c_4jZQKanq7WHo-n9Urmx8NG8yVWbbx07ivZDu9e-A@mail.gmail.com>
In-Reply-To: <CAOSf1CG0c_4jZQKanq7WHo-n9Urmx8NG8yVWbbx07ivZDu9e-A@mail.gmail.com>

--Hn8DeZVSoUMD9sxtTEDtYJd5HaSZty5aN
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 3/5/19 9:14 AM, Oliver wrote:
> On Sat, Mar 2, 2019 at 3:04 AM Sergey Miroshnichenko
> <s.miroshnichenko@yadro.com> wrote:
>>
>> Reading an empty slot returns all ones, which triggers a false
>> EEH error event on PowerNV. This patch unfreezes the bus where
>> it has happened.
>>
>> Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
>> ---
>>  arch/powerpc/include/asm/ppc-pci.h   |  1 +
>>  arch/powerpc/kernel/pci_dn.c         |  2 +-
>>  arch/powerpc/platforms/powernv/pci.c | 34 ++++++++++++++++++++++++---=
-
>>  3 files changed, 32 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/ppc-pci.h b/arch/powerpc/include=
/asm/ppc-pci.h
>> index f67da277d652..737393c54f58 100644
>> --- a/arch/powerpc/include/asm/ppc-pci.h
>> +++ b/arch/powerpc/include/asm/ppc-pci.h
>> @@ -40,6 +40,7 @@ void *traverse_pci_dn(struct pci_dn *root,
>>                       void *(*fn)(struct pci_dn *, void *),
>>                       void *data);
>>  extern void pci_devs_phb_init_dynamic(struct pci_controller *phb);
>> +struct pci_dn *pci_bus_to_pdn(struct pci_bus *bus);
>>
>>  /* From rtas_pci.h */
>>  extern void init_pci_config_tokens (void);
>> diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn=
=2Ec
>> index ab147a1909c8..341ed71250f1 100644
>> --- a/arch/powerpc/kernel/pci_dn.c
>> +++ b/arch/powerpc/kernel/pci_dn.c
>> @@ -40,7 +40,7 @@
>>   * one of PF's bridge. For other devices, their firmware
>>   * data is linked to that of their bridge.
>>   */
>> -static struct pci_dn *pci_bus_to_pdn(struct pci_bus *bus)
>> +struct pci_dn *pci_bus_to_pdn(struct pci_bus *bus)
>>  {
>>         struct pci_bus *pbus;
>>         struct device_node *dn;
>> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platf=
orms/powernv/pci.c
>> index 3260250d2029..73c2d0aed996 100644
>> --- a/arch/powerpc/platforms/powernv/pci.c
>> +++ b/arch/powerpc/platforms/powernv/pci.c
>> @@ -761,6 +761,21 @@ static inline pnv_pci_cfg_check(struct pci_dn *pd=
n)
>>  }
>>  #endif /* CONFIG_EEH */
>>
>> +static int get_bus_pe_number(struct pci_bus *bus)
>> +{
>> +       struct pci_dn *pdn =3D pci_bus_to_pdn(bus);
>> +       struct pci_dn *child;
>> +
>> +       if (!pdn)
>> +               return IODA_INVALID_PE;
>> +
>> +       list_for_each_entry(child, &pdn->child_list, list)
>> +               if (child->pe_number !=3D IODA_INVALID_PE)
>> +                       return child->pe_number;
>> +
>> +       return IODA_INVALID_PE;
>> +}
>> +
>>  static int pnv_pci_read_config(struct pci_bus *bus,
>>                                unsigned int devfn,
>>                                int where, int size, u32 *val)
>> @@ -769,12 +784,23 @@ static int pnv_pci_read_config(struct pci_bus *b=
us,
>>         struct pci_controller *hose =3D pci_bus_to_host(bus);
>>         struct pnv_phb *phb =3D hose->private_data;
>>         int ret;
>> +       u32 empty_val =3D 0xFFFFFFFF;
>>
>> -       *val =3D 0xFFFFFFFF;
>> +       *val =3D empty_val;
>>         pdn =3D pci_get_pdn_by_devfn(bus, devfn);
>> -       if (!pdn)
>> -               return pnv_pci_cfg_read_raw(phb->opal_id, bus->number,=
 devfn,
>> -                                           where, size, val);
>> +       if (!pdn) {
>> +               int pe_number =3D get_bus_pe_number(bus);
>> +
>> +               ret =3D pnv_pci_cfg_read_raw(phb->opal_id, bus->number=
, devfn,
>> +                                          where, size, val);
>> +
>> +               if (!ret && (*val =3D=3D empty_val) && phb->unfreeze_p=
e)
>=20
> Do this empty val check work when using 1 or 2 byte cfg accesses?
>=20

That was intentional because 0xff and 0xffff are valid values, but the
0xffffffff is the only reliable sign of an empty slot. And the kernel
pokes a slot by the pci_bus_generic_read_dev_vendor_id() function, which
in turn tries to pci_bus_read_config_dword(PCI_VENDOR_ID).

But I haven't tried actually to read 1-2 bytes from an empty slot to
test if that triggers an EEH. If it does, I'll change that to
EEH_IO_ERROR_VALUE(size).

>> +                       phb->unfreeze_pe(phb, (pe_number =3D=3D IODA_I=
NVALID_PE) ?
>> +                                        0xff : pe_number,
>=20
> Use phb->ioda.reserved_pe_idx rather than guessing that 0xff is safe
> to use. On P9 we have PHBs with 512 PEs and some older P8 firmware
> releases used 0 as the reserved PE rather than 0xff.
>=20

Thanks for the catch! I'll fix that in v5.

Best regards,
Serge

>> +                                        OPAL_EEH_ACTION_CLEAR_FREEZE_=
ALL);
>> +
>> +               return ret;
>> +       }
>>
>>         if (!pnv_pci_cfg_check(pdn))
>>                 return PCIBIOS_DEVICE_NOT_FOUND;
>> --
>> 2.20.1
>>


--Hn8DeZVSoUMD9sxtTEDtYJd5HaSZty5aN--

--PYy7ozVUL4W6vGOozM97POjmGFGKbk7vI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEHW7T7ovP/cFp8+b3DHQ+aNFTs7UFAlx+kjQACgkQDHQ+aNFT
s7WCshAAgKl0mkjK1Yg5hActg6ct8SUfk2Amh+gnl1UOwuUeyAfAy4WsPnfKDc0v
5OHhZRe9B9skdO5G1b4QJc0gRGK1B6s3tliVTt3Q1OjgiAFxu06Tg70gmpZ9eIYn
zpWn7QSwZNItmE3YUtjrTvrKXFXZacIXzwsSLcjfVPUNNeKei4UBr3qOKrvQXn48
PI/VgwvbbVUym+ewUNtvokZsPEAST0MGFqusArOeTNLBkWkJcK4taGcEpO9ouXGN
335FGhXyLfoLrQStyo/qidq9yq3d89NKAQUOh8Hbs2rklB59VGpf31amQnf30FPT
5lMxoDRmqPSMGtEKzP6Qzs305jVsksAqg5zEymiCTGwVzaTjV8e7wSd5yP8ogg+8
lgrbf690Tn5iWqTbSKGKUlC9H+MTFdlJsYNs/2Tz9ARBhqApAD8u5lJwQ+MJHTir
3O1SoyaYAWe3Hd3bfCk0Tcz17Ie/N3OfE/WzLKl4rL1PgAf7KX3PBs4QocUPMFwk
FWboVccNEnkN4RnshY+3ob2JryDNwLY1JrI6HE2SrYbXadkQpuvwrizv6rKedzZh
N2Kil95lrgGgdLu/pqe6qHkwjlG5vkZVTXQesi7SKj9XfeAk9PWMk4TGcaQNpj9l
FmHohidyHFC0xj9Nx/xV9TuvpRV1Mo+sefXVUyKf2kAAkvLWl7U=
=1QgC
-----END PGP SIGNATURE-----

--PYy7ozVUL4W6vGOozM97POjmGFGKbk7vI--
