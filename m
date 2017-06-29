Return-Path: <oohall@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyrV10tb8zDr3x
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 17:13:13 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id d5so11994656pfe.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 00:13:13 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org
Subject: power9 shared caches support
Date: Thu, 29 Jun 2017 17:12:52 +1000
Message-Id: <20170629071256.8159-1-oohall@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a pretty substantial rework of the last patch that should address most of the comment mpe had, namely:

1. Removed the random cpu_feature(ARCH_300) check. The new series always builds the cache mask and the new scheduler topology is used if we detect a mismatch of the thread and 

2. In the previous series the online and offlining paths were symmetrical. Althoug this is nice in theory it resulted in a bit unnecessary indirection. To simplify things it now only parse the device-tree, etc in the onlining path. When offlining a CPU all we need to do is walk the masks of the offlining CPU.

There's also fixes for various nitpicks.
