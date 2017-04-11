Return-Path: <minchan@kernel.org>
Received: from lgeamrelo11.lge.com (LGEAMRELO11.lge.com [156.147.23.51])
 by lists.ozlabs.org (Postfix) with ESMTP id 3w2BpP1QrXzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 13:08:44 +1000 (AEST)
Date: Tue, 11 Apr 2017 12:08:23 +0900
From: Minchan Kim <minchan@kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: clear_page, copy_page address align question?
Message-ID: <20170411030823.GB6545@bbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

When I tested zram in ppc64, I got random corruption.
With investigation, it seems clear_page corrupted the memory.
I passed 64K kmalloced(kmalloc(PAGE_SIZE)) address to clear_page
and turned on slub debug so address is not aligned with PAGE_SIZE.
Is it a valid usecase that non-PAGE_SIZE aligned address is
used for clear_page in ppc64?

As well, copy_page have same rule, too?

Anyway, when I changed clear_page to memset, it seems the problem
is gone.

Thanks.
