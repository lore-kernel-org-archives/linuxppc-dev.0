Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17489.18925.506395.279443@cargo.ozlabs.ibm.com>
Date: Fri, 28 Apr 2006 08:47:09 +1000
From: Paul Mackerras <paulus@samba.org>
To: Gerhard Jaeger <g.jaeger@sysgo.com>
Subject: Re: do_mmap_pgoff issue...
In-Reply-To: <200604271559.19818.g.jaeger@sysgo.com>
References: <200604271559.19818.g.jaeger@sysgo.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Gerhard Jaeger writes:

> The facts:
> - mmap the last page @ 0xFFFFF000, len 4K
> - result: mmap says EOVERFLOW...
> - the function that failed was do_mmap_pgoff()
> 
> Here's the pice of code
> 
> /* offset overflow? */
> if ((pgoff + (len >> PAGE_SHIFT)) < pgoff)
>     return -EOVERFLOW;
> 
> It's quite clear why it fails in my case:
> pgoff + (len >> PAGE_SHIFT) will be 0

No, pgoff will be 0xfffff, len will be 1, the sum is 0x100000.  You
need to look elsewhere for the problem.

Paul.
