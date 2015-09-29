Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 072501A0024
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2015 14:36:49 +1000 (AEST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Tue, 29 Sep 2015 14:36:48 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 4F7EC357804F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2015 14:36:45 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8T4aQlc56295558
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2015 14:36:34 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8T4aCjq032610
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2015 14:36:13 +1000
Message-ID: <560A153B.5000101@au1.ibm.com>
Date: Tue, 29 Sep 2015 14:36:11 +1000
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
MIME-Version: 1.0
To: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>, linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
 Brian King <brking@linux.vnet.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Daniel Axtens <dja@ozlabs.au.ibm.com>, Tomas Henzl <thenzl@redhat.com>,
 David Laight <David.Laight@ACULAB.COM>
CC: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 23/32] cxlflash: Fix function prolog parameters and
 return codes
References: <1443222593-8828-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <1443223098-9809-1-git-send-email-mrochs@linux.vnet.ibm.com>
In-Reply-To: <1443223098-9809-1-git-send-email-mrochs@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 26/09/15 09:18, Matthew R. Ochs wrote:
> Several function prologs have incorrect parameter names and return
> code descriptions. This can lead to confusion when reviewing the
> source and creates inaccurate documentation.
>
> To remedy, update the function prologs to properly reflect parameter
> names and return codes.
>
> Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
> Signed-off-by: Manoj N. Kumar <manoj@linux.vnet.ibm.com>
> Reviewed-by: Brian King <brking@linux.vnet.ibm.com>

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

See further comments below.

> --- a/drivers/scsi/cxlflash/main.c
> +++ b/drivers/scsi/cxlflash/main.c
> @@ -401,8 +401,7 @@ static void wait_resp(struct afu *afu, struct afu_cmd *cmd)
>    * @tmfcmd:	TMF command to send.
>    *
>    * Return:
> - *	0 on success
> - *	SCSI_MLQUEUE_HOST_BUSY when host is busy
> + *	0 on success or SCSI_MLQUEUE_HOST_BUSY
>    */
>   static int send_tmf(struct afu *afu, struct scsi_cmnd *scp, u64 tmfcmd)
>   {
> @@ -491,9 +490,7 @@ static const char *cxlflash_driver_info(struct Scsi_Host *host)
>    * @host:	SCSI host associated with device.
>    * @scp:	SCSI command to send.
>    *
> - * Return:
> - *	0 on success
> - *	SCSI_MLQUEUE_HOST_BUSY when host is busy
> + * Return: 0 on success or SCSI_MLQUEUE_HOST_BUSY
>    */

I'd prefer it to say "SCSI_MLQUEUE_HOST_BUSY on failure". (Aesthetically 
I prefer having it on a separate line, but that's just personal preference.)

As an aside, while checking the correctness of this, I found that the 
comment for cxlflash_send_cmd() states that it returns -1 on failure, 
when the only error value it actually returns is SCSI_MLQUEUE_HOST_BUSY. 
If you send a v5 you might want to fix this.


Andrew

-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
