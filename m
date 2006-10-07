Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 504ED67BF5
	for <linuxppc-dev@ozlabs.org>; Sun,  8 Oct 2006 07:56:30 +1000 (EST)
Subject: Re: vsdo_datapage.h WTF?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anton Blanchard <anton@samba.org>
In-Reply-To: <20061007145811.GA4043@krispykreme>
References: <1160148208.4795.30.camel@pmac.infradead.org>
	<1160170374.22232.135.camel@localhost.localdomain>
	<20061007145811.GA4043@krispykreme>
Content-Type: text/plain
Date: Sun, 08 Oct 2006 07:54:35 +1000
Message-Id: <1160258075.7122.7.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, David Woodhouse <dwmw2@infradead.org>,
	paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2006-10-08 at 00:58 +1000, Anton Blanchard wrote:
> Hi,
> 
> > No. There -used- to be this systemcfg structure that was exposed to
> > userspace on ppc64. I made it deprecated. However, for the sake of
> > backward compatbility, I kept vdso datapage with the exact same layout
> > for the first part of it (before the syscall maps) and haven't removed
> > the mmap call for it, but it will be gone soon.
> 
> We need a way to export cache size/associativity information (sysfs,
> /proc/device-tree parsing?) and a plan to fix the applications using it
> first.

The application using it can still use its own copy of the old header
tho. And that's why I haven't removed the /proc file and will probably
not do in the near future.

Regarding cache infos, I noticed the lack of anything useful in the
device-tree on Power5 LPAR or did I miss something ? Which means that on
recent machines, the kernel doesn't even know.

Ben.
