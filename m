Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wM4Bp3st5zDqGx
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 May 2017 00:09:54 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Scott Wood <oss@buserror.net>, linuxppc-dev@ozlabs.org
Cc: Scott Wood <oss@buserror.net>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/64e: Don't place the stack beyond TASK_SIZE
In-Reply-To: <20170505063145.21631-1-oss@buserror.net>
References: <20170505063145.21631-1-oss@buserror.net>
Date: Tue, 09 May 2017 00:09:50 +1000
Message-ID: <87zien7841.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood <oss@buserror.net> writes:

> Commit f4ea6dcb08ea ("powerpc/mm: Enable mappings above 128TB") increased
> the task size on book3s, and introduced a mechanism to dynamically
> control whether a task uses these larger addresses.  While the change to
> the task size itself was ifdef-protected to only apply on book3s, the
> change to STACK_TOP_USER64 was not.  On book3e, this had the effect of
> trying to use addresses up to 128TiB for the stack despite a 64TiB task
> size limit -- which broke 64-bit userspace producing the following errors:
>
> Starting init: /sbin/init exists but couldn't execute it (error -14)
> Starting init: /bin/sh exists but couldn't execute it (error -14)
> Kernel panic - not syncing: No working init found.  Try passing init= option to kernel. See Linux Documentation/admin-guide/init.rst for guidance.

For some reason I am not seeing this on my p5020ds?

I just checked, it's definitely booting:

  [    0.000000] Linux version 4.11.0-gcc5-g13e0988 (kerkins@alpine1-p1) (gcc version 5.2.1 20151001 (GCC) ) #1 SMP Mon May 8 05:33:22 AEST 2017
  [    0.000000] Using CoreNet Generic machine description
  ...
  [    3.216940] systemd[1]: Detected architecture ppc64.
  ...
  Debian GNU/Linux stretch/sid p5020ds ttyS0
  
  p5020ds login:


Anyway patch looks good, I'll pull it in with the rest of your tree.

cheers
