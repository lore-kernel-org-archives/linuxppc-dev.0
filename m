Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Subject: Re: [Cbe-oss-dev] [PATCH] powerpc: Introduce address space "slices"
Date: Mon, 19 Feb 2007 17:49:03 +0100
References: <1171867418.18571.3.camel@localhost.localdomain>
	<20070219153315.GA5036@lixom.net>
In-Reply-To: <20070219153315.GA5036@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702191749.03746.arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 19 February 2007 16:33, Olof Johansson wrote:
>=20
> > =A0- SPE local store mappings using 64K pages on a 4K base page size
> > kernel on Cell
>=20
> Why? What is the reason they can't use 4K pages?
>=20
Performance: On a system with 16 SPEs, you have 4MB of local store memory.
Assuming you have an application running on them that has basically random
access with DMA to all of them, that is 1024 4k pages, while a single SPE
has only 256 TLB entries. This means you get a high overhead from loading
the PTEs, and (worse) handling all the hash miss faults, and even then
you end up thrashing your TLB.
With 64k pages, you can easily fit all the mappings for local store into
the TLB of one SPE.

Note that for regular memory, we can avoid that problem by using
16MB hugepages, which is not possible for the local store.

	Arnd <><
