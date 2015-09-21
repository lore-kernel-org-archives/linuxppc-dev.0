Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 645EC1A0293
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 08:12:02 +1000 (AEST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Mon, 21 Sep 2015 16:12:00 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 674701FF0042
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 16:03:06 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8LM8rY010158492
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 15:08:53 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8LMBuB4022767
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 16:11:57 -0600
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [PATCH v2 03/30] cxlflash: Fix read capacity timeout
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
In-Reply-To: <55FFEBC0.5020507@redhat.com>
Date: Mon, 21 Sep 2015 17:11:57 -0500
Cc: linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
 Brian King <brking@linux.vnet.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Daniel Axtens <dja@ozlabs.au.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Manoj Kumar <kumarmn@us.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Message-Id: <62052676-EEC9-4B42-A5BA-BFADC628A18F@linux.vnet.ibm.com>
References: <1442438635-49044-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <1442438806-49198-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <55FFEBC0.5020507@redhat.com>
To: Tomas Henzl <thenzl@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Sep 21, 2015, at 6:36 AM, Tomas Henzl <thenzl@redhat.com> wrote:
> On 16.9.2015 23:26, Matthew R. Ochs wrote:
>> From: Manoj Kumar <kumarmn@us.ibm.com>
>>=20
>> The timeout value for read capacity is too small. Certain devices
>> may take longer to respond and thus the command may prematurely
>> timeout. Additionally the literal used for the timeout is stale.
>>=20
>> Update the timeout to 30 seconds (matches the value used in sd.c)
>> and rework the timeout literal to a more appropriate description.
>>=20
>> Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
>> Signed-off-by: Manoj N. Kumar <manoj@linux.vnet.ibm.com>
>> Suggested-by: Brian King <brking@linux.vnet.ibm.com>
>> ---
>> drivers/scsi/cxlflash/superpipe.c | 9 ++++-----
>> drivers/scsi/cxlflash/superpipe.h | 2 +-
>> drivers/scsi/cxlflash/vlun.c      | 4 ++--
>> 3 files changed, 7 insertions(+), 8 deletions(-)
>>=20
>> diff --git a/drivers/scsi/cxlflash/superpipe.c =
b/drivers/scsi/cxlflash/superpipe.c
>> index 7df985d..fa513ba 100644
>> --- a/drivers/scsi/cxlflash/superpipe.c
>> +++ b/drivers/scsi/cxlflash/superpipe.c
>> @@ -296,7 +296,7 @@ static int read_cap16(struct scsi_device *sdev, =
struct llun_info *lli)
>> 	int rc =3D 0;
>> 	int result =3D 0;
>> 	int retry_cnt =3D 0;
>> -	u32 tout =3D (MC_DISCOVERY_TIMEOUT * HZ);
>> +	u32 to =3D (CMD_TIMEOUT * HZ);
>=20
> In V3 please remove the parenthesis here^

Sure.

>=20
>>=20
>> retry:
>> 	cmd_buf =3D kzalloc(CMD_BUFSIZE, GFP_KERNEL);
> ...
>=20
>> @@ -1376,8 +1375,8 @@ out_attach:
>> 	attach->block_size =3D gli->blk_len;
>> 	attach->mmio_size =3D sizeof(afu->afu_map->hosts[0].harea);
>> 	attach->last_lba =3D gli->max_lba;
>> -	attach->max_xfer =3D (sdev->host->max_sectors * MAX_SECTOR_UNIT) =
/
>> -		gli->blk_len;
>> +	attach->max_xfer =3D (sdev->host->max_sectors * =
MAX_SECTOR_UNIT);
>=20
> and here^ too.

done.
