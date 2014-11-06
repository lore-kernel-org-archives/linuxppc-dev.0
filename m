Return-Path: <jk@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2F35C1A02F4
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Nov 2014 14:38:35 +1100 (AEDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Subject: [PATCH 0/2] Add IPMI support for powernv powerpc machines
Message-Id: <1415245107.292153.444216242273.0.gpush@pablo>
In-Reply-To: <1415245107.292153.444216242273.0.gpush@pablo>
To: <openipmi-developer@lists.sourceforge.net>, Corey Minyard <minyard@acm.org>,
 linuxppc-dev@lists.ozlabs.org
From: Jeremy Kerr <jk@ozlabs.org>
Date: Thu, 06 Nov 2014 11:38:27 +0800
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series adds IPMI driver and arch glue for OPAL-firmware-based
powernv machines. The first change exposes the firmware's IPMI API, and
the second adds an actual driver.

IPMI folks: the IPMI driver could do with a little review, as it's not a
conventional BT/KCS/SMI SI, in that the low-level send/recv interface
will handle the entire message at once.

Corey & Michael: if this is acceptable, it may be mergable as two
separate patches - one for the IPMI subsystem, one for the powernv
platform.  However, we'd need to preserve their order: patch 2/2 depends
on 1/2, which provides the structure & function definitions. This'll
break the build if only 2/2 is in the tree, and CONFIG_IPMI_POWERNV is
set.

Alternatively, they could be merged by one maintainer, pending an ack
from the other.

Comments / queries / etc welcome.

Cheers,


Jeremy

---
Jeremy Kerr (2):
      powerpc/powernv: Add OPAL IPMI interface
      drivers/char/ipmi: Add powernv IPMI driver
