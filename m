Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qVjJK5brVzDq72
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Mar 2016 08:24:49 +1100 (AEDT)
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Wed, 23 Mar 2016 15:24:47 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 7BC1619D803E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Mar 2016 15:12:37 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2NLOhJq22937750
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Mar 2016 14:24:43 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2NLOhbs010822
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Mar 2016 15:24:43 -0600
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH 2/2] cxlflash: Move to exponential back-off when cmd_room
 is not available
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
In-Reply-To: <1458762636-44422-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Date: Wed, 23 Mar 2016 16:24:41 -0500
Cc: linux-scsi@vger.kernel.org, James Bottomley <jejb@us.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>,
 Brian King <brking@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
Message-Id: <B3487E74-E14C-41AA-A3D7-80599D5912F0@linux.vnet.ibm.com>
References: <1458762572-44316-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 <1458762636-44422-1-git-send-email-ukrishn@linux.vnet.ibm.com>
To: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Mar 23, 2016, at 2:50 PM, Uma Krishnan <ukrishn@linux.vnet.ibm.com> =
wrote:
>=20
> From: "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
>=20
> While profiling the cxlflash_queuecommand() path under a heavy load it
> was found that number of retries to find cmd_room was fairly high.
>=20
> There are two problems with the current back-off:
> a) It starts with a udelay of 0
> b) It backs-off linearly
>=20
> Tried several approaches (a higher multiple 10*n, 100*n, as well as =
n^2,
> 2^n) and found that the exponential back-off(2^n) approach had the =
least
> overall cost. Cost as being defined as overall time spent waiting.
>=20
> The fix is to change the linear back-off to an exponential back-off.
> This solution also takes care of the problem with the initial
> delay (starts with 1 usec).
>=20
> Signed-off-by: Manoj N. Kumar <manoj@linux.vnet.ibm.com>

Acked-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
