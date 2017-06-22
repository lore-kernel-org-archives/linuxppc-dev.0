Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtskC1SHbzDr3S
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jun 2017 05:54:58 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5MJrh9R168084
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 15:54:56 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2b8kjhj090-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 15:54:56 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Thu, 22 Jun 2017 13:54:55 -0600
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 03/17] cxlflash: Reset hardware queue context via
 specified register
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
In-Reply-To: <1498097642-8789-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Date: Thu, 22 Jun 2017 14:54:40 -0500
Cc: linux-scsi@vger.kernel.org, James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
References: <1498097563-8680-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 <1498097642-8789-1-git-send-email-ukrishn@linux.vnet.ibm.com>
To: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
Message-Id: <E8049A97-D0EB-4C2A-AA81-9E177E6F69C8@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Jun 21, 2017, at 9:14 PM, Uma Krishnan <ukrishn@linux.vnet.ibm.com> =
wrote:
>=20
> Per the SISLite specification, context_reset() writes 0x1 to the LSB =
of the
> reset register. When the AFU processes this reset request, it is =
expected
> to clear the bit after reset is complete. The current implementation =
simply
> checks that the entire value read back is not 1, instead of masking =
off the
> LSB and evaluating it for a change to 0. Should the AFU manipulate =
other
> bits during the reset (reading back a value of 0xF for example), =
successful
> completion will be prematurely indicated given the existing logic.
>=20
> Additionally, in the event that the context reset operation fails, =
there
> does not currently exist a way to provide feedback to the initiator of =
the
> reset. This poses a problem for the rare case that a context reset =
fails as
> the caller will proceed on the assumption that all is well.
>=20
> To remedy these issues, refactor the context reset routine to only =
mask off
> the LSB when evaluating for success and return status to the caller. =
Also
> update the context reset handler parameters to pass a hardware queue
> reference instead of a single command to better reflect that the =
entire
> queue associated with the context is impacted by the reset.
>=20
> Signed-off-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>

Acked-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
