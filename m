Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D1C7DDDEEA
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 16:35:18 +1000 (EST)
Subject: Re: [PATCH 0/6] powerpc topology updates
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nathan Lynch <ntl@pobox.com>
In-Reply-To: <1217136295-18693-1-git-send-email-ntl@pobox.com>
References: <1217136295-18693-1-git-send-email-ntl@pobox.com>
Content-Type: text/plain
Date: Mon, 28 Jul 2008 16:34:57 +1000
Message-Id: <1217226897.11188.172.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2008-07-27 at 00:24 -0500, Nathan Lynch wrote:
> This series consists of a couple of cleanups and a few feature
> additions, all of which are more or less related to system topology
> (threads, cores, caches, sysfs...)  These are independent of
> each other except for 4 and 5 (core sibling and core id info).
> 
> I'd say the highlights are the last three patches, which add core and
> cache information to sysfs.  Here is some example output with the
> patches applied:

Applied with minor changes.

I made cpu_to_l2cache() use of_find_device_by_phandle() which should
work as well on pseries and should have the added advantage of working
on others too (ie. it will use device_node->linux_phandle to do the
compare, which is setup with the base phandle and overriden by the
ibm,phandle if there is one).

I also did a few cleanups of printk's and error checking.

Cheers,
Ben.
