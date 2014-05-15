Return-Path: <computersforpeace@gmail.com>
Received: from mail-pa0-x229.google.com (mail-pa0-x229.google.com
 [IPv6:2607:f8b0:400e:c03::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CE5D51400D8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 May 2014 12:22:45 +1000 (EST)
Received: by mail-pa0-f41.google.com with SMTP id lj1so403696pab.14
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 May 2014 19:22:42 -0700 (PDT)
Date: Wed, 14 May 2014 19:22:38 -0700
From: Brian Norris <computersforpeace@gmail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: roundup_pow_of_two() may not handle 64-bit integers
Message-ID: <20140515022238.GL28907@ld-irv-0074>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Howells <dhowells@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Brian Norris <computersforpeace@gmail.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I'm looking to use roundup_pow_of_two() (actually, order_base_2())
from <linux/log2.h>, but it seems that it only supports 64-bit integers
if your toolchain uses a 64-bit 'unsigned long' type. This is strange,
considering that ilog2() is explicitly designed for 32-bit or 64-bit
compatibility.

I also note that there is at least one location in which this limitation
currently might be problematic: in pnv_pci_ioda2_set_bypass()
(arch/powerpc/platforms/powernv/pci-ioda.c). It looks like this could be
a problem if using large amounts of DRAM on a 32-bit PPC build, with
64-bit physical addresses.

(There may be other cases like this one, but I haven't closely studied
all callers of roundup_pow_of_two().)

I'm thinking of cooking a patch to improve roundup_pow_of_two() (and
thus order_base_2()), but I'd like to solicit comments on the basic
problem first.

Regards,
Brian

P.S. And of course, rounddown_pow_of_two() has the same issue.
