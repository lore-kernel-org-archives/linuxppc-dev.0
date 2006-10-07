Return-Path: <ntl@pobox.com>
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by ozlabs.org (Postfix) with ESMTP id 6C8DD67CEB
	for <linuxppc-dev@ozlabs.org>; Sun,  8 Oct 2006 09:37:02 +1000 (EST)
Date: Sat, 7 Oct 2006 18:36:52 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: vsdo_datapage.h WTF?
Message-ID: <20061007233652.GB26378@localdomain>
References: <1160148208.4795.30.camel@pmac.infradead.org>
	<1160170374.22232.135.camel@localhost.localdomain>
	<20061007145811.GA4043@krispykreme>
	<1160258075.7122.7.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1160258075.7122.7.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, David Woodhouse <dwmw2@infradead.org>,
	Anton Blanchard <anton@samba.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Sun, 2006-10-08 at 00:58 +1000, Anton Blanchard wrote:
> > Hi,
> > 
> > > No. There -used- to be this systemcfg structure that was exposed to
> > > userspace on ppc64. I made it deprecated. However, for the sake of
> > > backward compatbility, I kept vdso datapage with the exact same layout
> > > for the first part of it (before the syscall maps) and haven't removed
> > > the mmap call for it, but it will be gone soon.
> > 
> > We need a way to export cache size/associativity information (sysfs,
> > /proc/device-tree parsing?) and a plan to fix the applications using it
> > first.
> 
> The application using it can still use its own copy of the old header
> tho. And that's why I haven't removed the /proc file and will probably
> not do in the near future.
> 
> Regarding cache infos, I noticed the lack of anything useful in the
> device-tree on Power5 LPAR or did I miss something ? Which means that on
> recent machines, the kernel doesn't even know.

On shared-processor partitions device nodes for caches are not
provided at all.  In dedicated mode the caches can be correlated to
their respective processors by looking at the "l2-cache" properties
iirc.
