Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8C85E1A0024
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2015 07:50:05 +1000 (AEST)
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Tue, 22 Sep 2015 17:50:02 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id BF1F7C90052
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 17:41:03 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8MLo0bS35127470
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 21:50:00 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8MLnxhF010463
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 17:50:00 -0400
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [PATCH v2 20/30] cxlflash: Correct usage of scsi_host_put()
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
In-Reply-To: <5601BFB2.4010308@linux.vnet.ibm.com>
Date: Tue, 22 Sep 2015 16:49:59 -0500
Cc: linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
 Ian Munsie <imunsie@au1.ibm.com>, Daniel Axtens <dja@ozlabs.au.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Message-Id: <29B7F444-8B64-4B85-8A9D-348A666E7E91@linux.vnet.ibm.com>
References: <1442438635-49044-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <1442439049-49970-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <5601BFB2.4010308@linux.vnet.ibm.com>
To: Brian King <brking@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Sep 22, 2015, at 3:53 PM, Brian King <brking@linux.vnet.ibm.com> =
wrote:
> On 09/16/2015 04:30 PM, Matthew R. Ochs wrote:
>> Currently, scsi_host_put() is being called prematurely in the
>> remove path and is missing entirely in an error cleanup path.
>> The former can lead to memory being freed too early with
>> subsequent access potentially corrupting data whilst the former
>> would result in a memory leak.
>>=20
>> Move the usage on remove to be the last cleanup action taken
>> and introduce a call to scsi_host_put() in the one initialization
>> error path that does not use remove to cleanup.
>>=20
>> Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
>> Signed-off-by: Manoj N. Kumar <manoj@linux.vnet.ibm.com>
>> ---
>> drivers/scsi/cxlflash/main.c | 3 ++-
>> 1 file changed, 2 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/scsi/cxlflash/main.c =
b/drivers/scsi/cxlflash/main.c
>> index fc77cd4..1856a73 100644
>> --- a/drivers/scsi/cxlflash/main.c
>> +++ b/drivers/scsi/cxlflash/main.c
>> @@ -734,7 +734,6 @@ static void cxlflash_remove(struct pci_dev *pdev)
>> 	case INIT_STATE_SCSI:
>> 		cxlflash_term_local_luns(cfg);
>> 		scsi_remove_host(cfg->host);
>> -		scsi_host_put(cfg->host);
>> 		/* Fall through */
>> 	case INIT_STATE_AFU:
>> 		term_afu(cfg);
>> @@ -744,6 +743,7 @@ static void cxlflash_remove(struct pci_dev *pdev)
>> 	case INIT_STATE_NONE:
>> 		flush_work(&cfg->work_q);
>> 		free_mem(cfg);
>> +		scsi_host_put(cfg->host);
>> 		break;
>> 	}
>>=20
>> @@ -2415,6 +2415,7 @@ static int cxlflash_probe(struct pci_dev *pdev,
>> 		dev_err(&pdev->dev, "%s: call to scsi_host_alloc =
failed!\n",
>=20
> This message text is wrong. Its the call to alloc_mem that has failed =
in this
> leg, not the call to scsi_host_alloc.

Good find. I'll fix this in a separate patch.


-matt
