Return-Path: <jk@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sXhWm21mMzDsN0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 18:57:08 +1000 (AEST)
From: Jeremy Kerr <jk@ozlabs.org>
To: Corey Minyard <minyard@acm.org>, openipmi-developer@lists.sourceforge.net
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/4] ipmi: Allow dynamic device IDs
Date: Mon, 12 Sep 2016 16:55:33 +0800
Message-Id: <1473670537-26428-1-git-send-email-jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series implements a more dynamic method of reporting BMC version &
identification. The current method of registering versions and IDs
during ipmi_register_smi means that if a BMC is upgraded during a boot,
the IPMI core code will report old version information.

We do this by querying the BMC (using a Get Device ID request) at smi
registration in the IPMI core code, and when the sysfs version & id
attributes are accessed.

The core of the change is in patch 3/4. Patches 1 and 2 implement a
couple of minor API changes leading up to this.

Patch 4 converts the powernv IPMI driver to use the dynamic IDs; the
behaviour of the other SMIs is not changed by this series. However,
if there's interest, I'm happy to alter the existing SMIs too, in a
follow-up series.

Questions & comments most welcome.

Cheers,

	
Jeremy
---

Jeremy Kerr (4):
  ipmi: Add a reference from BMC devices to their interfaces
  ipmi: Make ipmi_demangle_device_id more generic
  ipmi: allow dynamic BMC version information
  ipmi/powernv: Use dynamic device ids

 drivers/char/ipmi/ipmi_msghandler.c | 160 ++++++++++++++++++++++++++++++++++--
 drivers/char/ipmi/ipmi_powernv.c    |   5 +-
 drivers/char/ipmi/ipmi_si_intf.c    |   3 +-
 drivers/char/ipmi/ipmi_ssif.c       |   3 +-
 include/linux/ipmi_smi.h            |  16 ++--
 5 files changed, 169 insertions(+), 18 deletions(-)

-- 
2.7.4
