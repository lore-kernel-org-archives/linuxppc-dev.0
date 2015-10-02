Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EAF001A04D3
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Oct 2015 03:07:41 +1000 (AEST)
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Fri, 2 Oct 2015 13:07:38 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 48F5CC9004A
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Oct 2015 12:55:48 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t92H7a4458654808
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Oct 2015 17:07:36 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t92H7XL9000872
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Oct 2015 13:07:34 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH v5 00/34] cxlflash: Miscellaneous bug fixes and corrections
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
In-Reply-To: <1443714773-9176-1-git-send-email-mrochs@linux.vnet.ibm.com>
Date: Fri, 2 Oct 2015 12:07:32 -0500
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Message-Id: <B0CDB2CE-13C0-4CFA-84C1-B90CB8288294@linux.vnet.ibm.com>
References: <1443714773-9176-1-git-send-email-mrochs@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
 Brian King <brking@linux.vnet.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Daniel Axtens <dja@ozlabs.au.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Tomas Henzl <thenzl@redhat.com>, David Laight <David.Laight@ACULAB.COM>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi James,

This series has been fairly well vetted. With cxlflash being a new =
driver the majority
of these patches fix critical bugs. Is there anything else you're =
looking for in order to
get this set pulled into 4.3-rc?


-matt

> On Oct 1, 2015, at 10:52 AM, Matthew R. Ochs =
<mrochs@linux.vnet.ibm.com> wrote:
>=20
> This patch set contains various fixes and corrections for issues that
> were found during test and code review. The series is based upon the
> code upstreamed in 4.3 and is intended for the rc phase. The entire
> set is bisectable. Please reference the changelog below for details
> on what has been altered from previous versions of this patch set.
>=20
> v5 Changes:
> - Incorporate comments from Daniel Axtens
> - Incorporate comments from Andrew Donnellan=20
> - Added additional clarifications to several commit messages
> - Specified some return codes as failures in "Fix function prolog..."
> - Made port online failure noisier in "Remove dual port online..."
> - Added patch to properly cleanup when encountering an unsupported AFU
> - Added patch to escalate a link reset on login timeout
>=20
> v4 Changes:
> - Incorporate comments from Brian King
> - Removed unnecessary check_state() parameter from "Fix to avoid =
CXL..."
> - Added patch to fix potential deadlock on EEH
> - Removed patch to avoid state change collision
> - Changed fops initialization location in "Fix to avoid corrupting..."
>=20
> v3 Changes:
> - Rebased the series on top of patch by Dan Carpenter ("a couple =
off...")
> - Incorporate comments from David Laight
> - Incorporate comments from Tomas Henzl
> - Incorporate comments from Brian King
> - Removed patch to stop interrupt processing on remove
> - Removed double scsi_device_put() from "Fix potential oops"
> - Fixed usage of scnprintf() in "Refine host/device attributes"
> - Removed unnecessary parenthesis from "Fix read capacity timeout"
> - Added patch to use correct operator for doubling delay
> - Changed location of cancel_work_sync() in "Fix to prevent workq..."
> - Removed local mutex from cxlflash_afu_sync() in "Fix to avoid =
state..."
> - Added patch to correctly identify a failed function in a trace
> - Added patch to fix a fops corruption bug
>=20
> v2 Changes:
> - Incorporate comments from Ian Munsie
> - Rework commit messages to be more descriptive
> - Add state change serialization patch
>=20
> Manoj Kumar (5):
>  cxlflash: Fix to avoid invalid port_sel value
>  cxlflash: Replace magic numbers with literals
>  cxlflash: Fix read capacity timeout
>  cxlflash: Fix to double the delay each time
>  cxlflash: Fix to escalate to LINK_RESET on login timeout
>=20
> Matthew R. Ochs (29):
>  cxlflash: Fix potential oops following LUN removal
>  cxlflash: Fix data corruption when vLUN used over multiple cards
>  cxlflash: Fix to avoid sizeof(bool)
>  cxlflash: Fix context encode mask width
>  cxlflash: Fix to avoid CXL services during EEH
>  cxlflash: Correct naming of limbo state and waitq
>  cxlflash: Make functions static
>  cxlflash: Refine host/device attributes
>  cxlflash: Fix to avoid spamming the kernel log
>  cxlflash: Fix to avoid stall while waiting on TMF
>  cxlflash: Fix location of setting resid
>  cxlflash: Fix host link up event handling
>  cxlflash: Fix async interrupt bypass logic
>  cxlflash: Remove dual port online dependency
>  cxlflash: Fix AFU version access/storage and add check
>  cxlflash: Correct usage of scsi_host_put()
>  cxlflash: Fix to prevent workq from accessing freed memory
>  cxlflash: Correct behavior in device reset handler following EEH
>  cxlflash: Remove unnecessary scsi_block_requests
>  cxlflash: Fix function prolog parameters and return codes
>  cxlflash: Fix MMIO and endianness errors
>  cxlflash: Fix to prevent EEH recovery failure
>  cxlflash: Correct spelling, grammar, and alignment mistakes
>  cxlflash: Fix to prevent stale AFU RRQ
>  MAINTAINERS: Add cxlflash driver
>  cxlflash: Fix to avoid corrupting adapter fops
>  cxlflash: Correct trace string
>  cxlflash: Fix to avoid potential deadlock on EEH
>  cxlflash: Fix to avoid leaving dangling interrupt resources
>=20
> MAINTAINERS                       |    9 +
> drivers/scsi/cxlflash/common.h    |   30 +-
> drivers/scsi/cxlflash/lunmgt.c    |    9 +-
> drivers/scsi/cxlflash/main.c      | 1549 =
++++++++++++++++++++-----------------
> drivers/scsi/cxlflash/main.h      |    1 +
> drivers/scsi/cxlflash/sislite.h   |    8 +-
> drivers/scsi/cxlflash/superpipe.c |  204 +++--
> drivers/scsi/cxlflash/superpipe.h |   13 +-
> drivers/scsi/cxlflash/vlun.c      |   68 +-
> 9 files changed, 1055 insertions(+), 836 deletions(-)
>=20
> --=20
> 2.1.0
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-scsi" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
