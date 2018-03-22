Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 406hGW0lmZzF204
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 09:31:14 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2MMSfqt061492
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 18:31:12 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gvkhjbyjp-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 18:31:11 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Thu, 22 Mar 2018 18:31:10 -0400
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH v2 12/38] cxlflash: Use IDR to manage adapter contexts
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
In-Reply-To: <ae514fa6-9c55-5247-2531-579d5ca84079@linux.vnet.ibm.com>
Date: Thu, 22 Mar 2018 17:26:39 -0500
Cc: linux-scsi@vger.kernel.org, James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
References: <1519683513-16731-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 <1519683712-17186-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 <ae514fa6-9c55-5247-2531-579d5ca84079@linux.vnet.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Message-Id: <A27F5BBC-BCA7-491B-8A71-8D47B45663D0@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> On Mar 22, 2018, at 11:40 AM, Frederic Barrat =
<fbarrat@linux.vnet.ibm.com> wrote:
>=20
>=20
>=20
> Le 26/02/2018 =C3=A0 23:21, Uma Krishnan a =C3=A9crit :
>> A range of PASIDs are used as identifiers for the adapter contexts. =
These
>> contexts may be destroyed and created randomly. Use an IDR to keep =
track
>> of contexts that are in use and assign a unique identifier to new =
ones.
>> Signed-off-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
>> Acked-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
>> ---
>>  drivers/scsi/cxlflash/ocxl_hw.c | 20 ++++++++++++++++++--
>>  drivers/scsi/cxlflash/ocxl_hw.h |  2 ++
>>  2 files changed, 20 insertions(+), 2 deletions(-)
>> diff --git a/drivers/scsi/cxlflash/ocxl_hw.c =
b/drivers/scsi/cxlflash/ocxl_hw.c
>> index d75b873..6472210 100644
>> --- a/drivers/scsi/cxlflash/ocxl_hw.c
>> +++ b/drivers/scsi/cxlflash/ocxl_hw.c
>> @@ -12,6 +12,8 @@
>>   * 2 of the License, or (at your option) any later version.
>>   */
>> +#include <linux/idr.h>
>> +
>>  #include <misc/ocxl.h>
>>  #include "backend.h"
>> @@ -60,14 +62,25 @@ static void *ocxlflash_dev_context_init(struct =
pci_dev *pdev, void *afu_cookie)
>>  	if (unlikely(!ctx)) {
>>  		dev_err(dev, "%s: Context allocation failed\n", =
__func__);
>>  		rc =3D -ENOMEM;
>> -		goto err;
>> +		goto err1;
>> +	}
>> +
>> +	idr_preload(GFP_KERNEL);
>> +	rc =3D idr_alloc(&afu->idr, ctx, 0, afu->max_pasid, GFP_NOWAIT);
>> +	idr_preload_end();
>=20
>=20
> I believe we can call idr_alloc(... GFP_KERNEL) directly in that
> context now.
>=20
>=20
>> +	if (unlikely(rc < 0)) {
>> +		dev_err(dev, "%s: idr_alloc failed rc=3D%d\n", __func__, =
rc);
>> +		goto err2;
>>  	}
>> +	ctx->pe =3D rc;
>>  	ctx->master =3D false;
>>  	ctx->hw_afu =3D afu;
>>  out:
>>  	return ctx;
>> -err:
>> +err2:
>> +	kfree(ctx);
>> +err1:
>>  	ctx =3D ERR_PTR(rc);
>>  	goto out;
>>  }
>> @@ -86,6 +99,7 @@ static int ocxlflash_release_context(void =
*ctx_cookie)
>>  	if (!ctx)
>>  		goto out;
>> +	idr_remove(&ctx->hw_afu->idr, ctx->pe);
>>  	kfree(ctx);
>>  out:
>>  	return rc;
>> @@ -103,6 +117,7 @@ static void ocxlflash_destroy_afu(void =
*afu_cookie)
>>  		return;
>>  	ocxlflash_release_context(afu->ocxl_ctx);
>> +	idr_destroy(&afu->idr);
>>  	kfree(afu);
>>  }
>> @@ -237,6 +252,7 @@ static void *ocxlflash_create_afu(struct pci_dev =
*pdev)
>>  		goto err1;
>>  	}
>> +	idr_init(&afu->idr);
>=20
> You initialize the IDR too late. ocxlflash_dev_context_init() was =
called just above and allocated a PE.
>=20
>  Fred

Good Catch. I will fix this bug and send out a V3 soon. Thanks for the =
review !!

>=20
>>  	afu->ocxl_ctx =3D ctx;
>>  out:
>>  	return afu;
>> diff --git a/drivers/scsi/cxlflash/ocxl_hw.h =
b/drivers/scsi/cxlflash/ocxl_hw.h
>> index de43c04..0381682 100644
>> --- a/drivers/scsi/cxlflash/ocxl_hw.h
>> +++ b/drivers/scsi/cxlflash/ocxl_hw.h
>> @@ -26,10 +26,12 @@ struct ocxl_hw_afu {
>>  	int afu_actag_base;		/* AFU acTag base */
>>  	int afu_actag_enabled;		/* AFU acTag number enabled */
>> +	struct idr idr;			/* IDR to manage contexts */
>>  	int max_pasid;			/* Maximum number of contexts */
>>  };
>>  struct ocxlflash_context {
>>  	struct ocxl_hw_afu *hw_afu;	/* HW AFU back pointer */
>>  	bool master;			/* Whether this is a master =
context */
>> +	int pe;				/* Process element */
>>  };
>=20
