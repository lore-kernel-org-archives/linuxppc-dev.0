Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3CBE51A0705
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 06:33:50 +1000 (AEST)
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Tue, 29 Sep 2015 16:33:48 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 4E1C738C8041
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2015 16:33:46 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8TKXkef56950978
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2015 20:33:46 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8TKXiS4025832
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2015 16:33:45 -0400
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [PATCH v4 23/32] cxlflash: Fix function prolog parameters and
 return codes
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
In-Reply-To: <560A153B.5000101@au1.ibm.com>
Date: Tue, 29 Sep 2015 15:31:28 -0500
Cc: linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
 Brian King <brking@linux.vnet.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Daniel Axtens <dja@ozlabs.au.ibm.com>, Tomas Henzl <thenzl@redhat.com>,
 David Laight <David.Laight@ACULAB.COM>,
 Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Message-Id: <5311CCA4-21BF-4D85-90FF-2984C8C22BB9@linux.vnet.ibm.com>
References: <1443222593-8828-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <1443223098-9809-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <560A153B.5000101@au1.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Sep 28, 2015, at 11:36 PM, Andrew Donnellan =
<andrew.donnellan@au1.ibm.com> wrote:
> On 26/09/15 09:18, Matthew R. Ochs wrote:
>>=20
>>   */
>>  static int send_tmf(struct afu *afu, struct scsi_cmnd *scp, u64 =
tmfcmd)
>>  {
>> @@ -491,9 +490,7 @@ static const char *cxlflash_driver_info(struct =
Scsi_Host *host)
>>   * @host:	SCSI host associated with device.
>>   * @scp:	SCSI command to send.
>>   *
>> - * Return:
>> - *	0 on success
>> - *	SCSI_MLQUEUE_HOST_BUSY when host is busy
>> + * Return: 0 on success or SCSI_MLQUEUE_HOST_BUSY
>>   */
>=20
> I'd prefer it to say "SCSI_MLQUEUE_HOST_BUSY on failure". =
(Aesthetically I prefer having it on a separate line, but that's just =
personal preference.)
>=20
> As an aside, while checking the correctness of this, I found that the =
comment for cxlflash_send_cmd() states that it returns -1 on failure, =
when the only error value it actually returns is SCSI_MLQUEUE_HOST_BUSY. =
If you send a v5 you might want to fix this.

I'll make a note of this.
