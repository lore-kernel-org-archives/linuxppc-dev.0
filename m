Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [RFC 1/3] powerpc: __copy_tofrom_user tweaked for Cell
Date: Thu, 19 Jun 2008 16:43:58 +0200
References: <200806191753.59599.markn@au1.ibm.com>
In-Reply-To: <200806191753.59599.markn@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806191643.59037.arnd@arndb.de>
Cc: Mark Nelson <markn@au1.ibm.com>, Gunnar von Boehn <VONBOEHN@de.ibm.com>,
	cbe-oss-dev@ozlabs.org, Michael Ellerman <ellerman@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 19 June 2008, Mark Nelson wrote:

>  * __copy_tofrom_user routine optimized for CELL-BE-PPC

A few things I noticed:

* You don't have a page wise user copy, which the regular code
has. This is probably not so noticable in iperf, but should
have a significant impact on lmbench and on a number of file
system tests that copy large amounts of data. Have you checked
that the loop around cache lines is just as fast?

* You don't align the source to word size, only the target.
Does this get handled correctly when the source is a noncacheable
mapping, e.g. an unaligned copy_from_user where the source points
to a physical local store mapping of an SPU? I don't think we
need to optimize this case for performance, but I'm not sure
if it would crash. AFAIR, unaligned loads from noncacheable storage
give you an alignment exception that you need to handle, right?

* The naming of the labels (with just numbers) is rather confusing,
it would be good to have something better, but I must admit that
I don't have a good idea either.

* The trick of using the condition code in cr7 for the last bytes
is really cute, but are the four branches actually better than a
single computed branch into the middle of 15 byte wise copies?

	Arnd <><
