Return-Path: <fche@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 4143AB70E7
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Nov 2010 23:49:43 +1100 (EST)
To: divya <dipraksh@linux.vnet.ibm.com>
Subject: Re: Oops while running systemtap on the p6 machine against the kernel
	version 2.6.36-rc7-git3
References: <4CB704AC.4070203@linux.vnet.ibm.com>
From: fche@redhat.com (Frank Ch. Eigler)
Date: Wed, 03 Nov 2010 08:49:39 -0400
In-Reply-To: <4CB704AC.4070203@linux.vnet.ibm.com>
	(dipraksh@linux.vnet.ibm.com's message of "Thu,
	14 Oct 2010 18:55:00 +0530")
Message-ID: <y0m8w1ah8rg.fsf@fche.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, systemtap@sources.redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


divya <dipraksh@linux.vnet.ibm.com> writes:

> While running systemtap tests on the p6 machine , against the kernel version 2.6.36-rc7-git3
> Oops occured , here are the call trace
>
>  BUG: spinlock bad magic on CPU#6, stapio/20398
> -- 0:conmux-control -- time-stamp -- Oct/13/10  2:49:18 --res
>  lock: c000000000fcfa18, .magic: 00000000, .owner:<none>/-1, .owner_cpu: 0
> [...]

jistone committed some timing-related changes last night.  Would you
mind trying a new build on your ppc box?

It seems as through there is a concurrency problem with the timer
shutdown process.  If the problem still occurs, we might need to
instrument that part of the kernel and/or runtime code to figure it
out.

- FChE
