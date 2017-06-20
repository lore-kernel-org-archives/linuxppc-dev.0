Return-Path: <frowand.list@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wshgR64ZJzDqhp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 08:03:31 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id s66so26120802pfs.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 15:03:31 -0700 (PDT)
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v6 0/4] of: remove *phandle properties from expanded device
 tree
Date: Tue, 20 Jun 2017 15:02:48 -0700
Message-Id: <1497996172-821-1-git-send-email-frowand.list@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Frank Rowand <frank.rowand@sony.com>

Remove "phandle" and "linux,phandle" properties from the internal
device tree.  The phandle will still be in the struct device_node
phandle field and will still be displayed as if it is a property
in /proc/device_tree.

This is to resolve the issue found by Stephen Boyd [1] when he changed
the type of struct property.value from void * to const void *.  As
a result of the type change, the overlay code had compile errors
where the resolver updates phandle values.

  [1] http://lkml.iu.edu/hypermail/linux/kernel/1702.1/04160.html

Patch 1 is the phandle related changes.

Patches 2 - 4 are minor fixups for issues that became visible
while implementing patch 1.

Changes from v5:
   - patch 1: populate_properties(), prop_is_phandle was declared
     at the wrong scope and thus was initialized before the for
     loop instead of each time through the loop.  This resulted
     in any property in a node after the phandle property not
     being unflattened.

Changes from v4:
   - rebase on 4.12-rc1
   - Add reason for "<NULL>" in of_attach_node()
   - Simplify and consolidate phandle detection logic in
     populate_properties().  This results in a change of behaviour,
     the value of property "ibm,phandle" will no longer override the
     value of properties "phandle" and "linux,phandle".

Changes from v3:
   - patch 1: fix incorrect variable name in __of_add_phandle_sysfs().
     Problem was reported by the kbuild test robot

Changes from v2:
   - patch 1: Remove check in __of_add_phandle_sysfs() that would not
     add a sysfs entry if IS_ENABLED(CONFIG_PPC_PSERIES)

Changes from v1:
   - Remove phandle properties in of_attach_node(), before attaching
     the node to the live tree.
   - Add the phandle sysfs entry for the node in of_attach_node().
   - When creating an overlay changeset, duplicate the node phandle in
     __of_node_dup().


*** BLURB HERE ***

Frank Rowand (4):
  of: remove *phandle properties from expanded device tree
  of: make __of_attach_node() static
  of: be consistent in form of file mode
  of: detect invalid phandle in overlay

 drivers/of/base.c       | 50 +++++++++++++++++++++++++++++++++++++++----
 drivers/of/dynamic.c    | 57 +++++++++++++++++++++++++++++++++++++------------
 drivers/of/fdt.c        | 43 ++++++++++++++++++-------------------
 drivers/of/of_private.h |  2 +-
 drivers/of/overlay.c    |  8 ++++---
 drivers/of/resolver.c   | 23 +-------------------
 include/linux/of.h      |  1 +
 7 files changed, 118 insertions(+), 66 deletions(-)

-- 
Frank Rowand <frank.rowand@sony.com>
