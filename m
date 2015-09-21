Return-Path: <brking@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 639FF1A0052
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 04:28:39 +1000 (AEST)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <brking@linux.vnet.ibm.com>;
 Mon, 21 Sep 2015 12:28:37 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 19CF13E40047
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 12:28:35 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8LISYYd11010308
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 11:28:34 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8LISY1S015660
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 12:28:34 -0600
Subject: Re: [PATCH v2 15/30] cxlflash: Fix location of setting resid
To: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>, linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
 Ian Munsie <imunsie@au1.ibm.com>, Daniel Axtens <dja@ozlabs.au.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
References: <1442438635-49044-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <1442439027-49780-1-git-send-email-mrochs@linux.vnet.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
From: Brian King <brking@linux.vnet.ibm.com>
Message-ID: <56004C4E.4050004@linux.vnet.ibm.com>
Date: Mon, 21 Sep 2015 13:28:30 -0500
MIME-Version: 1.0
In-Reply-To: <1442439027-49780-1-git-send-email-mrochs@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/16/2015 04:30 PM, Matthew R. Ochs wrote:
> @@ -158,8 +160,7 @@ static void process_cmd_err(struct afu_cmd *cmd, struct scsi_cmnd *scp)
>  				/* If the SISL_RC_FLAGS_OVERRUN flag was set,
>  				 * then we will handle this error else where.
>  				 * If not then we must handle it here.
> -				 * This is probably an AFU bug. We will
> -				 * attempt a retry to see if that resolves it.
> +				 * This is probably an AFU bug.

I would tend to agree with this statement. ioasa->resid should be zero in an overrun case.

>  				 */
>  				scp->result = (DID_ERROR << 16);
>  			}

Reviewed-by: Brian King <brking@linux.vnet.ibm.com>


-- 
Brian King
Power Linux I/O
IBM Linux Technology Center
