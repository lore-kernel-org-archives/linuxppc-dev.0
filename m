Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 142FC687BB
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Nov 2005 09:44:15 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc64-dev@ozlabs.org
Date: Tue, 15 Nov 2005 23:38:53 +0100
References: <437A5049.9090308@nortel.com>
In-Reply-To: <437A5049.9090308@nortel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200511152338.53238.arnd@arndb.de>
Cc: Christopher Friesen <cfriesen@nortel.com>, linuxppc-embedded@ozlabs.org
Subject: Re: modify the cache-inhibit and guard bits from userspace?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Am Dienstag 15 November 2005 22:16 schrieb Christopher Friesen:
> What's the most logical way for me to do this? =A0Do I extend mprotect()
> to support additional flags?
>
> Has anyone done this before? =A0I didn't find anything in google.
> Currently the guard bit seems to only be used for ioremap() and in
> __pci_mmap_set_pgprot() if the memory doesn't support write combining.

I have seen an earlier patch that modifies madvise to do this, which seems
a little saner than mprotect, although they can probably both be implemented
in a similar way.

Alternatively, you could write a new file system similar to hugetlbfs and s=
et=20
the cache-inhibit bit in its mmap function.

	Arnd <><
