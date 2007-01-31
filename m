Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Subject: Re: [Cbe-oss-dev] [RFC,
	PATCH 4/4] Add support to OProfile for profiling Cell BE SPUs --
	update
Date: Wed, 31 Jan 2007 16:42:41 +0100
References: <45BE4FA4.9020105@us.ibm.com>
	<f00c5b64177eafd5445b9da2c8432aa8@bga.com>
In-Reply-To: <f00c5b64177eafd5445b9da2c8432aa8@bga.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200701311642.42397.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Milton Miller <miltonm@bga.com>,
	Carl Love <carll@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 31 January 2007 10:24, Milton Miller wrote:
> > +/* The three functions below are for maintaining and accessing
> > + * the vma-to-file offset map.
> > + */
> > +vma_map_t * create_vma_map(const struct spu * spu, u64 objectid);
> > +unsigned int vma_map_lookup(vma_map_t *map, unsigned int vma,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0 =
=A0const struct spu * aSpu);
> > +void vma_map_free(struct vma_map *map);
> > +
>=20
> Why would the SPU to cookie translation need to be different
> than the standard vm one? =A0 Is it that spufs takes refs on the
> pages but doesn't have the standard vma? =A0 Maybe an approach
> of creating them would reuse the oprofile code.

It's a two stage process for SPUs:

* samples are relative to the local store, and for each sample
  we need to know what context was running. The context is
  identified over a pointer to user space effective addresses.
* The effective address identifies the SPU ELF binary mapped
  at that address. It may however be in the middle of a VMA,
  so you get another offset into the mapped file.

=46or each sample, you then get an offset into the ls, an offset
into the file to identify the ELF object, and the dcookie
for the file containing that object.

As a consequence, you only need dcookies for the case where
a context switch happens (the executable changes), but not
for each of the samples during the a time slice, they all
point to the same object.

	Arnd <><
