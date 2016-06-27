Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdSny5n3tzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 22:25:42 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rdSny0TCFz9t1M
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Jun 2016 22:25:41 +1000 (AEST)
Received: from pasglop.au.ibm.com (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id u5RCPbV8025193
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Jun 2016 07:25:38 -0500
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 00/17] Initial POWER9 XIVE and PHB4 support
Date: Mon, 27 Jun 2016 22:25:16 +1000
Message-Id: <1467030333-31435-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This provides an initial base support for the XIVE interrupt controller
and the new IODA3 compliant PHB4, both found on POWER9. The series
is interleaved with a bug fix or two as I found problems in sim.

The new OPAL APIs haven't been committed yet so are still subject
to change, thus the patches relying on them shouldn't bee merged just
yet, at least not until we freeze those APIs. The individual fixes
are good to go though.

This is very basic support for XIVE by using OPAL APIs that simulate
a XICS. This is meant as a fallback if the interrupt controller
implementation is unknown.

A subsequent series will provide the native support for XIVE (aka
exploitation mode) and this will remain as a fallback for future
chip that might implement a variant that isn't backward compatible.

Similarily, we use an OPAL call for TCE invalidations in IODA3. We
may at some point add native support for PHB4, but this gives us
a fallback in case the HW changes in unsupported ways.
