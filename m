Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A26E91A01EC
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Mar 2016 05:45:28 +1100 (AEDT)
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Mon, 7 Mar 2016 11:45:26 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id EFE3B3E4003E
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Mar 2016 11:45:15 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id u27IjFau43384874
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Mar 2016 11:45:15 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u27IjD4x011648
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Mar 2016 11:45:15 -0700
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH 6/7] cxlflash: Fix to avoid unnecessary scan with internal
 LUNs
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
In-Reply-To: <1457128520-53056-6-git-send-email-ukrishn@linux.vnet.ibm.com>
Date: Mon, 7 Mar 2016 12:45:04 -0600
Cc: linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Brian King <brking@linux.vnet.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
Message-Id: <94EC3AB2-2DD8-4A2B-AB9E-7AF3E4D51EF7@linux.vnet.ibm.com>
References: <1457128424-53017-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 <1457128520-53056-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 <1457128520-53056-6-git-send-email-ukrishn@linux.vnet.ibm.com>
To: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Mar 4, 2016, at 3:55 PM, Uma Krishnan <ukrishn@linux.vnet.ibm.com> =
wrote:
>=20
> From: "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
>=20
> When switching to the internal LUN defined on the
> IBM CXL flash adapter, there is an unnecessary
> scan occurring on the second port. This scan leads
> to the following extra lines in the log:
>=20
> Dec 17 10:09:00 tul83p1 kernel: [ 3708.561134] cxlflash 0008:00:00.0: =
cxlflash_queuecommand: (scp=3Dc0000000fc1f0f00) 11/1/0/0 =
cdb=3D(A0000000-00000000-10000000-00000000)
> Dec 17 10:09:00 tul83p1 kernel: [ 3708.561147] process_cmd_err: cmd =
failed afu_rc=3D32 scsi_rc=3D0 fc_rc=3D0 afu_extra=3D0xE, =
scsi_extra=3D0x0, fc_extra=3D0x0
>=20
> By definition, both of the internal LUNs are on the first =
port/channel.
>=20
> When the lun_mode is switched to internal LUN the
> same value for host->max_channel is retained. This
> causes an unnecessary scan over the second port/channel.
>=20
> This fix alters the host->max_channel to 0 (1 port), if internal
> LUNs are configured and switches it back to 1 (2 ports) while
> going back to external LUNs.
>=20
> Signed-off-by: Manoj N. Kumar <manoj@linux.vnet.ibm.com>

Acked-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
