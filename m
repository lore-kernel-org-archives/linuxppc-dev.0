Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 96E311A0024
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 06:40:17 +1000 (AEST)
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Tue, 29 Sep 2015 14:37:14 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 9935C1FF004C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2015 14:28:12 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8TKXuJW1245582
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2015 13:33:56 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8TKb2Wx029267
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2015 14:37:03 -0600
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [PATCH v4 12/32] cxlflash: Fix to avoid spamming the kernel log
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
In-Reply-To: <560A1C33.8040709@au1.ibm.com>
Date: Tue, 29 Sep 2015 15:37:00 -0500
Cc: linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
 Brian King <brking@linux.vnet.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Daniel Axtens <dja@ozlabs.au.ibm.com>, Tomas Henzl <thenzl@redhat.com>,
 David Laight <David.Laight@ACULAB.COM>,
 Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Message-Id: <607D0508-883D-4CF3-8843-5853A376ED38@linux.vnet.ibm.com>
References: <1443222593-8828-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <1443222936-9385-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <560A1C33.8040709@au1.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Sep 29, 2015, at 12:05 AM, Andrew Donnellan =
<andrew.donnellan@au1.ibm.com> wrote:
> On 26/09/15 09:15, Matthew R. Ochs wrote:
>> During run-time the driver can be very chatty and spam the system
>> kernel log. Various print statements can be limited and/or moved
>> to development-only mode. Additionally, numerous prints can be
>> converted to trace the corresponding device.
>>=20
>> The following changes were made:
>>  - pr_debug to pr_devel
>>  - pr_debug to pr_debug_ratelimited
>>  - pr_err to dev_err
>>  - pr_debug to dev_dbg
>>=20
>> Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
>> Signed-off-by: Manoj N. Kumar <manoj@linux.vnet.ibm.com>
>> Reviewed-by: Brian King <brking@linux.vnet.ibm.com>
>=20
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
>=20
> Changes mostly look fine, further comments below.
>=20
>> --- a/drivers/scsi/cxlflash/main.c
>> +++ b/drivers/scsi/cxlflash/main.c
>> @@ -58,8 +58,8 @@ static struct afu_cmd *cmd_checkout(struct afu =
*afu)
>>  		cmd =3D &afu->cmd[k];
>>=20
>>  		if (!atomic_dec_if_positive(&cmd->free)) {
>> -			pr_debug("%s: returning found index=3D%d\n",
>> -				 __func__, cmd->slot);
>> +			pr_devel("%s: returning found index=3D%d =
cmd=3D%p\n",
>> +				 __func__, cmd->slot, cmd);
>=20
>>  	pr_debug("%s: cmd failed afu_rc=3D%d scsi_rc=3D%d fc_rc=3D%d "
>> -		 "afu_extra=3D0x%X, scsi_entra=3D0x%X, fc_extra=3D0x%X\n",=

>> +		 "afu_extra=3D0x%X, scsi_extra=3D0x%X, fc_extra=3D0x%X\n",=

>>  		 __func__, ioasa->rc.afu_rc, ioasa->rc.scsi_rc,
>>  		 ioasa->rc.fc_rc, ioasa->afu_extra, ioasa->scsi_extra,
>>  		 ioasa->fc_extra);
>=20
> Minor nitpicking: mention that you fix these in the commit message.

Noted for the future.

>> @@ -240,9 +240,9 @@ static void cmd_complete(struct afu_cmd *cmd)
>>  		cmd_is_tmf =3D cmd->cmd_tmf;
>>  		cmd_checkin(cmd); /* Don't use cmd after here */
>>=20
>> -		pr_debug("%s: calling scsi_set_resid, scp=3D%p "
>> -			 "result=3D%X resid=3D%d\n", __func__,
>> -			 scp, scp->result, resid);
>> +		pr_debug_ratelimited("%s: calling scsi_done scp=3D%p =
result=3D%X "
>> +				     "ioasc=3D%d\n", __func__, scp, =
scp->result,
>> +				     cmd->sa.ioasc);
>>=20
>>  		scsi_set_resid(scp, resid);
>>  		scsi_dma_unmap(scp);
>=20
> Why has the message changed from scsi_set_resid to scsi_done, and =
should the message be moved to immediately before the scsi_done call?

In a later patch in the series the scsi_set_resid() is actually moved.
