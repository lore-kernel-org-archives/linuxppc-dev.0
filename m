Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 367051A0C7E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 04:56:09 +1100 (AEDT)
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Tue, 8 Mar 2016 10:56:07 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 8803C1FF0021
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Mar 2016 10:44:13 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u28Hu4sr38338814
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Mar 2016 10:56:04 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u28Hu3MZ024881
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Mar 2016 10:56:04 -0700
Subject: Re: [PATCH 6/7] cxlflash: Fix to avoid unnecessary scan with internal
 LUNs
To: linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
References: <1457128424-53017-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 <1457128520-53056-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 <1457128520-53056-6-git-send-email-ukrishn@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Brian King <brking@linux.vnet.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
Message-ID: <56DF1234.603@linux.vnet.ibm.com>
Date: Tue, 8 Mar 2016 11:56:04 -0600
MIME-Version: 1.0
In-Reply-To: <1457128520-53056-6-git-send-email-ukrishn@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 3/4/2016 3:55 PM, Uma Krishnan wrote:
> From: "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
>
> When switching to the internal LUN defined on the
> IBM CXL flash adapter, there is an unnecessary
> scan occurring on the second port. This scan leads
> to the following extra lines in the log:
>
> Dec 17 10:09:00 tul83p1 kernel: [ 3708.561134] cxlflash 0008:00:00.0: cxlflash_queuecommand: (scp=c0000000fc1f0f00) 11/1/0/0 cdb=(A0000000-00000000-10000000-00000000)
> Dec 17 10:09:00 tul83p1 kernel: [ 3708.561147] process_cmd_err: cmd failed afu_rc=32 scsi_rc=0 fc_rc=0 afu_extra=0xE, scsi_extra=0x0, fc_extra=0x0
>
> By definition, both of the internal LUNs are on the first port/channel.
>
> When the lun_mode is switched to internal LUN the
> same value for host->max_channel is retained. This
> causes an unnecessary scan over the second port/channel.
>
> This fix alters the host->max_channel to 0 (1 port), if internal
> LUNs are configured and switches it back to 1 (2 ports) while
> going back to external LUNs.
>
> Signed-off-by: Manoj N. Kumar <manoj@linux.vnet.ibm.com>

Reviewed-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
