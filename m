Return-Path: <jdl@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id DAFE967C4A
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jul 2005 06:25:34 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	j6IKVFQM024896
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Jul 2005 13:31:15 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id j6IKTreR016658
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Jul 2005 15:29:53 -0500 (CDT)
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1121718331.2400.24.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Mon, 18 Jul 2005 15:25:31 -0500
Subject: DTC memory reserve question
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, when the Device Tree Compiler lays down a memory
reserve table into an assembly file, it always adds
a reserved region covering the whole DT blob itself.
That is, it does this:

        .balign 8
        .globl  dt_reserve_map
dt_reserve_map:
_dt_reserve_map:
        .long   0, _dt_blob_start
        .long   0, _dt_blob_end - _dt_blob_start
        .llong  0
        .llong  0

Naturally, that yields System.map entries like this:

c0013988 t _dt_blob_start
c0013988 T dt_blob_start
c0013988 t _dt_header
c0013988 T dt_header
c00139b0 t _dt_reserve_map
c00139b0 T dt_reserve_map
c00139d0 t _dt_struct_start
c00139d0 T dt_struct_start
c0013df0 t _dt_strings_start
c0013df0 T dt_strings_start
c0013df0 t _dt_struct_end
c0013df0 T dt_struct_end
c0013f05 t _dt_blob_end
c0013f05 T dt_blob_end

Notice that these are 0xC-gazillion addresses.

And way over here in the Ben H documentation, the memory
reserve map is described as containing physical addresses:

   - off_mem_rsvmap

     This is an offset from the beginning of the header to the start
     of the reserved memory map. This map is a list of pairs of 64
     bits integers. Each pair is a physical address and a size. The
     list is terminated by an entry of size 0. This map provides the
     kernel with a list of physical memory areas that are "reserved"
     and thus not to be used for memory allocations, especially during
     early initialisation.

Uh, so here's my dilemma: I can't just pa() all the addresses
that come in from the memreserve table, can I?  They should
already _be_ physical, right?  We aren't going to be able to
handle a mix of them without a flag or test or something?

jdl
