Return-Path: <newsuser@famdijkstra.org>
Received: from baardmijt.demon.nl (baardmijt.demon.nl [212.238.157.49])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 13975DDF8E
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Mar 2007 01:32:05 +1100 (EST)
Date: Thu, 22 Mar 2007 15:31:56 +0100
From: Tim Dijkstra <newsuser@famdijkstra.org>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: hibernate, suspend and s2both support
Message-ID: <20070322153156.6057ead7@commensaal.drs.p>
In-Reply-To: <1174262983.13027.58.camel@johannes.berg>
References: <20070318010044.0b0bebf0@commensaal.drs.p>
	<1174208083.13027.36.camel@johannes.berg>
	<20070318144115.00ab8912@commensaal.drs.p>
	<1174228670.13027.46.camel@johannes.berg>
	<20070318234601.3f6cc53b@commensaal.drs.p>
	<1174262983.13027.58.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	debian-powerpc@lists.debian.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I'm trying to get suspend-to-both (save state to disk, just like
hibernate, but then suspend to ram) to work on ppc.

In the end it is probably simpler than I imagined. Due to the work the
linux-pm guys did, it appears I only had to rip out all the evil hacks
some x86 machines need.

If someone could test the powerpc packages on debian by doing roughly
the following, that would be really nice:

a) Download:

http://www.famdijkstra.org/~tdykstra/debian/uswsusp/uswsusp_0.6~cvs20070202-2.diff.gz
http://www.famdijkstra.org/~tdykstra/debian/uswsusp/uswsusp_0.6~cvs20070202-2.dsc
http://www.famdijkstra.org/~tdykstra/debian/uswsusp/uswsusp_0.6~cvs20070202.orig.tar.gz

b) install debhelper (>= 5), pciutils-dev, docbook2x, po-debconf, libgcrypt-dev, zlib1g-dev, libsplashy0-dev

c) Unpack & Compile
$ dpkg-source -x uswsusp_0.6~cvs20070202-2.dsc
$ cd uswsusp-0.6~cvs20070202/
$ dpkg-buildpackage -us -uc -rfakeroot

d) Install
$ dpkg -i <the resulting deb>


The install process should update your initramfs if you use initramfs-tools.
You need an initramfs that includes the resume binary else it won't work.

For testing purposes it is best you don't have splashy installed or at least
disabled in /etc/uswsusp.conf.

Then run s2both. This should save to disk (you'll get some messages
reporting progress of that) and suspend-to-ram. Now wake up
your system.

If that went OK then run s2both and poweroff the hard way. Boot up again.

All this is of course on your own risk, but you knew that;)

As a bonus there is also a s2ram binary which won't do much more than
'echo mem > /sys/power/state' and ioctl(/dev/pmu,...) on older kernels.

grts Tim
