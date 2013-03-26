Return-Path: <cody@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8F3FD2C0084
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2013 04:46:45 +1100 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cody@linux.vnet.ibm.com>;
 Tue, 26 Mar 2013 13:46:41 -0400
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 62F9738C804D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2013 13:46:38 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2QHkcpC286402
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2013 13:46:38 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2QHkbnu003405
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2013 13:46:38 -0400
From: Cody P Schafer <cody@linux.vnet.ibm.com>
To: linux-mm@kvack.org
Subject: [PATCH 0/3] mm: avoid duplication of setup_nr_node_ids()
Date: Tue, 26 Mar 2013 10:45:59 -0700
Message-Id: <1364319962-30967-1-git-send-email-cody@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>,
 Cody P Schafer <cody@linux.vnet.ibm.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In arch/powerpc, arch/x86, and mm/page_alloc code to setup nr_node_ids based on
node_possible_map is duplicated.

This patchset switches those copies to calling the function provided by page_alloc.
