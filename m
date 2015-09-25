Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 50F1F1A0014
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Sep 2015 08:35:59 +1000 (AEST)
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Fri, 25 Sep 2015 18:35:56 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 5F5236E8047
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2015 18:27:38 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8PMZtVl49545342
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2015 22:35:55 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8PMZsX5002422
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2015 18:35:54 -0400
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [PATCH v3 31/32] cxlflash: Fix to avoid corrupting adapter fops
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
In-Reply-To: <5605BB6F.1030905@linux.vnet.ibm.com>
Date: Fri, 25 Sep 2015 17:35:55 -0500
Cc: linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
 Ian Munsie <imunsie@au1.ibm.com>, Daniel Axtens <dja@ozlabs.au.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Tomas Henzl <thenzl@redhat.com>, David Laight <David.Laight@ACULAB.COM>,
 Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Message-Id: <705BCC10-2E28-4B26-AD9E-DABD594A1437@linux.vnet.ibm.com>
References: <1443123193-16498-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <1443123851-17893-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <5605BB6F.1030905@linux.vnet.ibm.com>
To: Brian King <brking@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Sep 25, 2015, at 4:23 PM, Brian King <brking@linux.vnet.ibm.com> =
wrote:
> On 09/24/2015 02:44 PM, Matthew R. Ochs wrote:
>> @@ -1293,8 +1291,8 @@ static int cxlflash_disk_attach(struct =
scsi_device *sdev,
>>=20
>> 	int fd =3D -1;
>>=20
>> -	/* On first attach set fileops */
>> -	if (atomic_read(&cfg->num_user_contexts) =3D=3D 0)
>> +	/* On very first attach set fileops for adapter */
>> +	if (cfg->cxl_fops.owner !=3D THIS_MODULE)
>> 		cfg->cxl_fops =3D cxlflash_cxl_fops;
>=20
> Hmm... Why not just set this up once at probe time instead?

I tried to explain this in the commit message. I left it out of probe
time in an attempt to keep it separate from the legacy support as
it's only needed for superpipe.

I'll fix up this commit and just move it to probe as that seems easiest.


-matt=
