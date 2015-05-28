Return-Path: <gkurz@linux.vnet.ibm.com>
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48C791A1940
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2015 23:13:16 +1000 (AEST)
Received: from /spool/local
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gkurz@linux.vnet.ibm.com>;
 Thu, 28 May 2015 14:13:13 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id A2D211B08069
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2015 14:14:02 +0100 (BST)
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com
 [9.149.37.229])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4SDDA5f17498124
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2015 13:13:10 GMT
Received: from d06av05.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av05.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4SDD9am002029
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2015 07:13:10 -0600
Subject: [PATCH 0/3] fbuffer: performance improvement + code cleanup
From: Greg Kurz <gkurz@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Thomas Huth <thuth@redhat.com>,
 Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 28 May 2015 15:13:09 +0200
Message-ID: <20150528131309.5240.71135.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If booted in frame buffer mode, board-qemu currently calls hv-logical-load
and hv-logical-store for every pixel when enabling or disabling the cursor.
This is suboptimal when writing one char at a time to the console since
terminal-write always toggles the cursor. And this is precisely what grub
is doing when the user wants to edit a menu entry... the result is an
incredibly slow and barely usable interface.

This series introduces per-board helpers to be used by the frame buffer
code, so that board-qemu may have its own accelarated implementation:

- the first patch is preliminary cleanup, before moving code out to helpers.

- the second patch introduces a helper to invert a memory region byte-per-byte:
  this fixes the unbearable slowliness of grub editing mode.

- the third patch introduces a similar helper with a a quad-word pace: it
  doesn't bring any speed improvement since board-qemu already uses
  hv-logical-memop, but it allows to "unify hcall-invert-screen and
  fb8-invert-screen again".

Please comment.

---

Greg Kurz (3):
      fbuffer: simplify address computations in fb8-toggle-cursor
      fbuffer: introduce the invert-region helper
      fbuffer: introduce the invert-region-x helper


 board-js2x/slof/helper.fs               |    9 +++++++++
 board-qemu/slof/helper.fs               |    7 +++++++
 board-qemu/slof/pci-device_1234_1111.fs |   10 +---------
 slof/fs/fbuffer.fs                      |    8 +++-----
 4 files changed, 20 insertions(+), 14 deletions(-)

--
Greg
