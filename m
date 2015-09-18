Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EFCDD1A2C6E
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Sep 2015 09:56:30 +1000 (AEST)
Received: from /spool/local
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Fri, 18 Sep 2015 19:56:28 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 82F50C90041
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2015 19:47:30 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8INuQGn58589188
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2015 23:56:26 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8INuQqS018660
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2015 19:56:26 -0400
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [PATCH v2 12/30] cxlflash: Refine host/device attributes
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
In-Reply-To: <55FC8371.5010900@linux.vnet.ibm.com>
Date: Fri, 18 Sep 2015 18:56:25 -0500
Cc: linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
 Ian Munsie <imunsie@au1.ibm.com>, Daniel Axtens <dja@ozlabs.au.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Shane Seymour <shane.seymour@hp.com>,
 Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Message-Id: <AA42C2F0-94E8-45D6-8438-7F7BE0C9E046@linux.vnet.ibm.com>
References: <1442438635-49044-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <1442438954-49663-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <55FC8371.5010900@linux.vnet.ibm.com>
To: Brian King <brking@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Sep 18, 2015, at 4:34 PM, Brian King <brking@linux.vnet.ibm.com> =
wrote:
> On 09/16/2015 04:29 PM, Matthew R. Ochs wrote:
>>=20
>> +	ssize_t bytes =3D 0;
>> +	__be64 __iomem *fc_port;
>> +
>> +	if (port >=3D NUM_FC_PORTS)
>> +		return 0;
>> +
>> +	fc_port =3D &afu->afu_map->global.fc_port[port][0];
>> +
>> +	for (i =3D 0; i < CXLFLASH_NUM_VLUNS; i++, buf +=3D 22)
>=20
> Rather than this bug prone hard coded 22, how about never incrementing =
buf and do something
> similar to this:
>=20
>> +		bytes +=3D scnprintf(buf, PAGE_SIZE, "%03d: %016llX\n",
>> +				   i, readq_be(&fc_port[i]));
>=20
> 		bytes +=3D scnprintf(&buf[bytes], PAGE_SIZE, "%03d: =
%016llX\n",
> 				   i, readq_be(&fc_port[i]));
>=20
>> +	return bytes;
>> +}
>> +

Great suggestion! Will fix in v3.


-matt=
