Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id CB17DDDEA0
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jan 2008 10:34:53 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCh v3] powerpc: add hugepagesz boot-time parameter
Date: Fri, 4 Jan 2008 00:34:24 +0100
References: <477D68E6.2070108@linux.vnet.ibm.com>
In-Reply-To: <477D68E6.2070108@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200801040034.25329.arnd@arndb.de>
Cc: mel@csn.ul.ie, Jon Tollefson <kniht@linux.vnet.ibm.com>, csnook@redhat.com,
	Paul Mackerras <paulus@samba.org>, David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 03 January 2008, Jon Tollefson wrote:
> Paul, please include this in 2.6.25 if there are no objections.

No objections to this version from me, just questions.

> This patch adds the hugepagesz boot-time parameter for ppc64. =A0It lets
> one pick the size for huge pages. The choices available are 64K and 16M
> when the base page size is 4k. It defaults to 16M (previously the only
> only choice) if nothing or an invalid choice is specified.

We started discussing this in v1, but the discussion got sidetracked:
Is there a technical reason why you don't also allow 1M pages, which
may be useful in certain scenarios?

On the Cell/B.E. platforms (IBM/Mercury blades, Toshiba Celleb, PS3), the
second large page size is an option that can be set in a HID SPR
to either 64KB or 1MB. Unfortunately, we can't do these two simultaneously,
but the firmware can change the default and put it into the device tree,
or you could have the kernel override the firmware settings.

Going a lot further, do you have plans for a fully dynamic hugepage size,
e.g. using a mount option for hugetlbfs? I can see that as rather useful,
but at the same time it's probably much more complicated than the boot time
option.

	Arnd <><
