Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 02B89DDFC2
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jan 2009 08:41:30 +1100 (EST)
Subject: Re: can't mmap PCI legacy_mem on Powerbook G4
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Daniel Drake <dsd@gentoo.org>
In-Reply-To: <496B2983.2030601@gentoo.org>
References: <496B2983.2030601@gentoo.org>
Content-Type: text/plain
Date: Tue, 13 Jan 2009 08:41:09 +1100
Message-Id: <1231796469.22571.33.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, dliana@frontiernet.net,
	linux kernel <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2009-01-12 at 11:29 +0000, Daniel Drake wrote:
> Hi,
> 
> Dave reports a 2.6.28 regression here:
> https://bugs.gentoo.org/show_bug.cgi?id=253149
> 
> X (server v1.5.3) no longer starts, it aborts with a mmap() error.
> 
> 
> This is because X tries to use sysfs pci legacy_mem to map the VGA frame 
> buffer if it is available, and this became available in 2.6.28 for ppc, 
> but the mmap() fails with -ENXIO.

Argh... Can the X folks stop being full of sh*t ? I'll have to have a
look there, fortunately, I'm occasionally one of them :-)

I made the files available on all powerpc, however, not all platforms
support legacy mem access. The PowerBook doesn't, which is why it
returns the error. It would be more complicated to make the file's
existence conditional instead, but I'll loo kat it.

In the meantime, please file an X bug. It shouldn't fallback to /proc or
whatever junk it did with /dev/mem, it should understand that as "the
kernel supports the legacy interfaces, and tells you this machine has no
access to legacy mem" and thus disable all attempts at whacking VGA text
mode.

Ben.
