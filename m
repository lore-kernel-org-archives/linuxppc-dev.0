Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.168])
	by ozlabs.org (Postfix) with ESMTP id F091B67BAB
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Dec 2006 19:41:51 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so2351794ugf
	for <linuxppc-dev@ozlabs.org>; Sat, 02 Dec 2006 00:41:49 -0800 (PST)
Message-ID: <528646bc0612020041q32e8b1el3e8362f980f8f7b@mail.gmail.com>
Date: Sat, 2 Dec 2006 01:41:48 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: linuxppc-dev@ozlabs.org, "David Gibson" <david@gibson.dropbear.id.au>
Subject: Re: libfdt - flat tree manipulation library
In-Reply-To: <20061201060038.GA25476@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20061127055905.GA6428@localhost.localdomain>
	<20061129055904.GA11883@localhost.localdomain>
	<20061201060038.GA25476@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/30/06, David Gibson <david@gibson.dropbear.id.au> wrote:
> On Wed, Nov 29, 2006 at 04:59:04PM +1100, David Gibson wrote:
> > On Mon, Nov 27, 2006 at 04:59:05PM +1100, David Gibson wrote:
> > [snip]
> > > The code, such as it is, is at:
> > >     git://ozlabs.org/home/dgibson/git/libfdt.git
> >
> > Code for writing device trees from scratch, sequentially, is now
> > implemented.
>
> And now support for random access read-write is implemented.  The
> library is now close to feature-complete, cleanups and convenience
> wrappers remain.

I've run into some problems running this on an amd64 host.  There are
problems with the byte swapping code where libfdt.h is trying to byte
swap the fdt pointer, not the value it points to.

Ie, I think this:
#define fdt_magic(fdt)			(fdt32_to_cpu(fdt)->magic)
should really be this:
#define fdt_magic(fdt)			(fdt32_to_cpu(fdt->magic))

As is it doesn't compile on amd64 (and probably not x86 either).  I
suspect that you want to do your byte swap on the value in the
structure field, not on the pointer to the structure.  :)  However,
the test cases fail spectacularly when I change the byte swap to be on
the value in the structure.  If I comment out the byte swap entirely
in libfdt_env.h; then the test cases unexpectedly pass!  So I did some
digging.  The test cases are generating little-endian device trees;
looks like test/trees.S is at fault.  I would say that a different
mechanism is needed to generate the .dtb files.

For example; here's the first 16 bytes of my lite5200 device tree:
00000000  d0 0d fe ed 00 00 15 b7  00 00 00 38 00 00 14 5c  |...........8...\|
Here's the first 16 bytes of tests/rw_tree1.test.dtb; clearly wrong endian!
00000000  ed fe 0d d0 1a 01 00 00  40 00 00 00 08 01 00 00  |........@.......|

Anyway; I'll send a patch to fix up part of the byte swapping code;
but I haven't looked into other ways of creating the .dtb files.

Cheers,
g.



-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
