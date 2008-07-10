Return-Path: <prodyuth@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.28])
	by ozlabs.org (Postfix) with ESMTP id 2ADE1DDFE2
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jul 2008 04:06:59 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so1574145ywh.39
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2008 11:06:56 -0700 (PDT)
Message-ID: <49c0ff980807101106x6c246421o7eec631bf08c6d03@mail.gmail.com>
Date: Thu, 10 Jul 2008 11:06:55 -0700
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
code much more readable like other architectures (eg. x86).

My questions are:
1) Why do we need to distinguish between load and store failure? If
either load or store fails, the copy did not go thru. But the code
sets r9 to 0 for load failure, and r9 to 1 for write failure. Why do
we need to care for that?

2) For read failure, why do we clear out the destination? Other
architecture don't do that.

I would appreciate any comments. I will submit my patch later.

Thanks,
Prodyut
