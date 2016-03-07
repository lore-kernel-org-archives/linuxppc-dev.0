Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 61A221A01EC
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Mar 2016 05:37:23 +1100 (AEDT)
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Mon, 7 Mar 2016 11:37:21 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 2F33519D8047
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Mar 2016 11:25:14 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id u27IbIjV32309416
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Mar 2016 11:37:18 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u27IbG9w017494
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Mar 2016 11:37:17 -0700
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH 5/7] cxlflash: Reorder user context initialization
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
In-Reply-To: <1457128520-53056-5-git-send-email-ukrishn@linux.vnet.ibm.com>
Date: Mon, 7 Mar 2016 12:37:10 -0600
Cc: linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Brian King <brking@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Message-Id: <E45FF842-056A-4FE3-864B-9BB1FD246F56@linux.vnet.ibm.com>
References: <1457128424-53017-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 <1457128520-53056-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 <1457128520-53056-5-git-send-email-ukrishn@linux.vnet.ibm.com>
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
> In order to support cxlflash in the PowerVM environment, underlying
> hypervisor APIs have imposed a kernel API ordering change.
>=20
> For the superpipe access to LUN, user applications need a context.
> The cxlflash module creates this context by making a sequence of
> cxl calls. In the current code, a context is initialized via
> cxl_dev_context_init() followed by cxl_process_element(), a function
> that obtains the process element id. Finally, cxl_start_work()
> is called to attach the process element.
>=20
> In the PowerVM environment, a process element id cannot be obtained
> from the hypervisor until the process element is attached. The
> cxlflash module is unable to create contexts without a valid
> process element id.
>=20
> To fix this problem, cxl_start_work() is called before obtaining
> the process element id.
>=20
> Signed-off-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>

Acked-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
