Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id 97700DDE47
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Dec 2007 08:21:28 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [RFC][POWERPC] Provide a way to protect 4k subpages when using
	64k pages
Date: Tue, 11 Dec 2007 22:21:15 +0100
References: <18264.58263.818005.757831@cargo.ozlabs.ibm.com>
	<20071211155305.GA28055@lst.de>
In-Reply-To: <20071211155305.GA28055@lst.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200712112221.17697.arnd@arndb.de>
Cc: Paul Mackerras <paulus@samba.org>, Christoph Hellwig <hch@lst.de>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 11 December 2007, Christoph Hellwig wrote:
> Using 4k pages should basically be a pre-process flag
> (which it already is as an implementation detail in your patch), and
> thus the proper way to mark it should be a personality flag. =A0This
> also means it could be implied by certain personalities, e.g. powerpc
> 32bit for full compatiblity. =A0 All these process would use plain mmap/
> mprotect to deal with the subpage protections.

If you want to make it a per-process flag, wouldn't a prctl bit be more
appropriate than a personality flag? That way you could at least set
it independent from other personality settings.

> At least ia64 and mips have multiple pages sizes already and I suspect
> more architectures will grow support for it.

Another related option might be the alternative page table layouts that
Martin Schwidefsky has implemented for concurrent 2/3/4-level page tables
on s390.

	Arnd <><
