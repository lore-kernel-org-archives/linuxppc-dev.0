Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9C8E21A0014
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Sep 2015 08:31:45 +1000 (AEST)
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Fri, 25 Sep 2015 18:31:42 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 3CC1D38C8041
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2015 18:31:39 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8PMVdR359506764
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2015 22:31:39 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8PMVcL2021546
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2015 18:31:38 -0400
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [PATCH v3 28/32] cxlflash: Fix to avoid state change collision
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
In-Reply-To: <5605B846.5020101@linux.vnet.ibm.com>
Date: Fri, 25 Sep 2015 17:31:39 -0500
Cc: linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
 Ian Munsie <imunsie@au1.ibm.com>, Daniel Axtens <dja@ozlabs.au.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Tomas Henzl <thenzl@redhat.com>, David Laight <David.Laight@ACULAB.COM>,
 Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Message-Id: <78FBC497-AFCC-4B6C-A7D7-D965EA1BF62C@linux.vnet.ibm.com>
References: <1443123193-16498-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <1443123756-17736-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <5605B846.5020101@linux.vnet.ibm.com>
To: Brian King <brking@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Sep 25, 2015, at 4:10 PM, Brian King <brking@linux.vnet.ibm.com> =
wrote:
> On 09/24/2015 02:42 PM, Matthew R. Ochs wrote:
>> diff --git a/drivers/scsi/cxlflash/main.c =
b/drivers/scsi/cxlflash/main.c
>> index ab11ee6..325ba31 100644
>> --- a/drivers/scsi/cxlflash/main.c
>> +++ b/drivers/scsi/cxlflash/main.c
>> @@ -496,6 +496,7 @@ static int cxlflash_queuecommand(struct Scsi_Host =
*host, struct scsi_cmnd *scp)
>> 	struct cxlflash_cfg *cfg =3D (struct cxlflash_cfg =
*)host->hostdata;
>> 	struct afu *afu =3D cfg->afu;
>> 	struct device *dev =3D &cfg->dev->dev;
>> +	enum cxlflash_state state;
>> 	struct afu_cmd *cmd;
>> 	u32 port_sel =3D scp->device->channel + 1;
>> 	int nseg, i, ncount;
>> @@ -525,7 +526,11 @@ static int cxlflash_queuecommand(struct =
Scsi_Host *host, struct scsi_cmnd *scp)
>> 	}
>> 	spin_unlock_irqrestore(&cfg->tmf_slock, lock_flags);
>>=20
>> -	switch (cfg->state) {
>> +	mutex_lock(&cfg->mutex);
>> +	state =3D cfg->state;
>> +	mutex_unlock(&cfg->mutex);
>=20
> You can't grab a mutex in queuecommand, since it can sleep and =
queuecommand can be called from soft irq context.
>=20
> Also, I'm not sure what to think about this patch in general. =
Obviously state can change immediately after
> you drop the mutex, and according to =
Documentation/memory-barriers.txt, memory operations after the unlock =
can
> occur before the unlock occurs. Is this a problem?

You bring up some good points.

I'm going to remove this patch from the set and rework it.


-matt=
