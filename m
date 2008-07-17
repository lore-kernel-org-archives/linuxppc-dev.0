Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id D6509DDF0E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Jul 2008 18:29:15 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: how to allocate 9MB of memory in kernel ?
Date: Thu, 17 Jul 2008 10:24:02 +0200
References: <18503022.post@talk.nabble.com> <200807170956.52101.arnd@arndb.de>
	<18503765.post@talk.nabble.com>
In-Reply-To: <18503765.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807171024.02514.arnd@arndb.de>
Cc: Misbah khan <misbah_khan@engineer.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thursday 17 July 2008, Misbah khan wrote:
> vmalloc can only allocate 128k i guess where in i need 9MB allocated when
> driver is inserted and would be released only when its removed. mapping to
> user space is not a concern 

The 128kb limitation is in kmalloc, not vmalloc. The latter is
specifically meant to have no limitations on the memory size
(other than the available resources), at the expense of having
to create a new virtual mapping.

	Arnd <><
