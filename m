Return-Path: <srs0=st7i=4o=buserror.net=oss@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wM6TZ1MZ5zDqCL
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 May 2017 01:52:50 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wM6TZ0nRrz8tjV
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 May 2017 01:52:50 +1000 (AEST)
Message-ID: <1494258757.3694.1.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Mon, 08 May 2017 10:52:37 -0500
In-Reply-To: <87zien7841.fsf@concordia.ellerman.id.au>
References: <20170505063145.21631-1-oss@buserror.net>
 <87zien7841.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH] powerpc/64e: Don't place the stack beyond TASK_SIZE
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-05-09 at 00:09 +1000, Michael Ellerman wrote:
> Scott Wood <oss@buserror.net> writes:
> 
> > Commit f4ea6dcb08ea ("powerpc/mm: Enable mappings above 128TB") increased
> > the task size on book3s, and introduced a mechanism to dynamically
> > control whether a task uses these larger addresses.  While the change to
> > the task size itself was ifdef-protected to only apply on book3s, the
> > change to STACK_TOP_USER64 was not.  On book3e, this had the effect of
> > trying to use addresses up to 128TiB for the stack despite a 64TiB task
> > size limit -- which broke 64-bit userspace producing the following errors:
> > 
> > Starting init: /sbin/init exists but couldn't execute it (error -14)
> > Starting init: /bin/sh exists but couldn't execute it (error -14)
> > Kernel panic - not syncing: No working init found.  Try passing init=
> > option to kernel. See Linux Documentation/admin-guide/init.rst for
> > guidance.
> 
> For some reason I am not seeing this on my p5020ds?
> 
> I just checked, it's definitely booting:
> 
>   [    0.000000] Linux version 4.11.0-gcc5-g13e0988 (kerkins@alpine1-p1)
> (gcc version 5.2.1 20151001 (GCC) ) #1 SMP Mon May 8 05:33:22 AEST 2017
>   [    0.000000] Using CoreNet Generic machine description
>   ...
>   [    3.216940] systemd[1]: Detected architecture ppc64.
>   ...
>   Debian GNU/Linux stretch/sid p5020ds ttyS0
>   
>   p5020ds login:
> 
> 
> Anyway patch looks good, I'll pull it in with the rest of your tree.

Are you using a 64-bit userspace?

-Scott
