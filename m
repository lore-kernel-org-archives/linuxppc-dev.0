Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [Cbe-oss-dev] [RFC,
	PATCH 4/4] Add support to OProfile for profiling Cell BE SPUs --
	update
Date: Fri, 2 Feb 2007 01:54:05 +0100
References: <45BE4FA4.9020105@us.ibm.com> <200701311642.42397.arnd@arndb.de>
	<ca40499f1ef66ec7ca889a02ee2ba7cd@bga.com>
In-Reply-To: <ca40499f1ef66ec7ca889a02ee2ba7cd@bga.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702020154.06558.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	Carl Love <carll@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 01 February 2007 19:56, Milton Miller wrote:
> > * The effective address identifies the SPU ELF binary mapped
> > =A0 at that address. It may however be in the middle of a VMA,
> > =A0 so you get another offset into the mapped file.
>=20
> I think this is where we start to diverge.
>=20
> Can you only map 1 linear range of 1 file as the SPU local store?
>=20
> I thought you were mentioning shared libraries, and had mmap,
> shared mappings of text, etc.

There are two address spaces in the SPU. Code and local variables
are all in the local store (256kb), so the samples that oprofile
takes come from there.=20

The other address space is the DMA space, which is defined by
the mm_struct of the process, and established on the PPU (the
linux program). Shared libraries and mappings are all in this
space.

To load an SPU program, the SPU ELF file is mapped into the
process address space (DMA space) and the ELF loader transfers
sections from it to the local store of the SPU. Consequently,
there is a unique translation from every local store address
to a file offset in the original ELF file, but there can
be multiple linear ranges.

> > For each sample, you then get an offset into the ls, an offset
> > into the file to identify the ELF object, and the dcookie
> > for the file containing that object
>=20
> You are supplying
> =A0 =A0 (1) offset in local store
> =A0 =A0 (2) offset from dcookie to local store (? =A0 you said ELF object)
> =A0 =A0 (3) file containing #2
>=20
> So there is exactly one backing object for the entire local
> store, and its mapped linearly?

1 object, but not linearly. To make things worse, there can
also be overlays (think turbo pascal on MS-DOS), so the
object can be larger than the actual local store, and parts
of it get loaded on demand.

Also, a file can contain multiple SPU ELF binaries, we have
the embedspu tool that encapsulates a statically linked
SPU program into a powerpc object containing a single
symbol. You can then link multiple such objects into a
shared library or your main powerpc-side application.

> > As a consequence, you only need dcookies for the case where
> > a context switch happens (the executable changes), but not
> > for each of the samples during the a time slice, they all
> > point to the same object.
>=20
>=20
> My understanding is the dcookie is supposed to represent a backing
> file object. =A0The combination (dcookie, offset) should lead to
> the backing object, which userspace can then disassemble, etc.

The (dcookie, offset) tuple first identifies the SPU ELF binary,
offset here being the file offset where the actual ELF image
starts. You need the second offset to identify the pointer in there.

> Therefore, if you allow multiple pieces to be mapped into local store,
> then you should be reverse translating each ls address into (file,=20
> offset)
> of that file system object. =A0 The fact that its contained in a bigger
> elf file may mean that userspace needs some more info, but it still
> needs the same info.

At the minimum, userspaces needs information like

* spu3 is <dcookie=3D87656323, offset=3D4567> /* first program gets loaded =
*/
* sample at <spu=3D3, offset=3D1234>          /* samples */
* sample at <spu=3D3, offset=3D1248>
* sample at <spu=3D3, offset=3D160c>
* spu3 is <dcookie=3D34563287, offset=3D5476> /* context switch to other */
* sample at <spu=3D3, offset=3D5a32>          /* samples in new program */
* sample at <spu=3D3, offset=3D7231>

The same can be expressed as

* sample at <dcookie=3D87656323, foffset=3D4567, offset=3D1234> /* samples =
*/
* sample at <dcookie=3D87656323, foffset=3D4567, offset=3D1248>
* sample at <dcookie=3D87656323, foffset=3D4567, offset=3D160c>
* sample at <dcookie=3D34563287, foffset=3D5476, offset=3D5a32> /* samples =
in new program */
* sample at <dcookie=3D34563287, foffset=3D5476, offset=3D7231>

And potentially other information per sample.

> If you do allow more than 1 backing object, then my suggestion was
> to use the common code by setting up a fake vm context that has
> kernel vmas and let the generic code lookup the file from this context.

The problem of more than one backing object is only if you look
the samples being collected per physical SPU, because that means
it will see context switches. If the samples get collected per
context, there is only one backing object.

	Arnd <><
