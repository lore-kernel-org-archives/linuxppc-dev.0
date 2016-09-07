Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sV0V74YyqzDsFS
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Sep 2016 09:46:23 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u87NgubC083248
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Sep 2016 19:46:20 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25at7057w9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Sep 2016 19:46:20 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Wed, 7 Sep 2016 17:46:19 -0600
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 1/6] cxlflash: Scan host only after the port is ready for
 I/O
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
In-Reply-To: <1472848728-64961-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Date: Wed, 7 Sep 2016 18:46:12 -0500
Cc: linux-scsi@vger.kernel.org, James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>,
 Brian King <brking@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
References: <1472848612-64888-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 <1472848728-64961-1-git-send-email-ukrishn@linux.vnet.ibm.com>
To: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
Message-Id: <F1892F61-1208-4C29-8EDA-785C22B3D8A6@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Sep 2, 2016, at 3:38 PM, Uma Krishnan <ukrishn@linux.vnet.ibm.com> =
wrote:
>=20
> When a port link is established, the AFU sends a 'link up' interrupt.
> After the link is up, corresponding initialization steps are performed
> on the card. Following that, when the card is ready for I/O, the AFU
> sends 'login succeeded' interrupt. Today, cxlflash invokes
> scsi_scan_host() upon receipt of both interrupts.
>=20
> SCSI commands sent to the port prior to the 'login succeeded' =
interrupt
> will fail with 'port not available' error. This is not desirable.
> Moreover, when async_scan is active for the host, subsequent scan =
calls
> are terminated with error. Due to this, the scsi_scan_host() call
> performed after 'login succeeded' interrupt could portentially return
> error and the devices may not be scanned properly.
>=20
> To avoid this problem, scsi_scan_host() should be called only after =
the
> 'login succeeded' interrupt.
>=20
> Signed-off-by: Uma Krishna <ukrishn@linux.vnet.ibm.com>

Acked-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
