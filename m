Return-Path: <prodyuth@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.170])
	by ozlabs.org (Postfix) with ESMTP id 86224DDFC8
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jul 2008 09:44:28 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so4159ugf.0
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2008 16:44:26 -0700 (PDT)
Message-ID: <49c0ff980807101644x6ffb9a66x3f73c72f1be86e3@mail.gmail.com>
Date: Thu, 10 Jul 2008 16:44:26 -0700
From: "prodyut hazarika" <prodyuth@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: Making __copy_tofrom_user more readable for powerpc
	(arch/powerpc/lib/copy_32.S)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,
I am trying to optimize the __copy_tofrom_user function for PPC4xx,
and I would want to know why the exception handling code has been made
so complicated. All the fixup code should do is to store the number of
bytes that failed in copy in r3 and return back.

The current code tries to copy one byte at a time after read fault. I
don't understand why that is necessary. It then clears out the
destination. All these logic has made the code very unfriendly to
read.

I have a version which just keeps a count of bytes copied till any
fault happened. Then for any exception, I just substract this value
from the total number of bytes to be copied, and store in r3 and
return back. This is the common fixup code for all paths. It makes the
fixup code much more readable like other architectures (eg. x86).

My questions are:
1) Why do we need to distinguish between load and store failure? If
either load or store fails, the copy did not go thru. But the code
sets r9 to 0 for load failure, and r9 to 1 for write failure. Why do
we need to care for that?

2) For read failure, why do we clear out the destination (lines 509 to
529 in arch/powerpc/lib/copy_32.S)? Other architecture don't do that.

I would appreciate any comments.

Thanks,
Prodyut
