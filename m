Return-Path: <anton@ozlabs.org>
Date: Thu, 29 Apr 2010 10:51:17 +1000
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: PowerPC ftrace function trace optimisation
Message-ID: <20100429005117.GA4622@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org, imunsie@au1.ibm.com, rostedt@goodmis.org,
	amodra@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi,

Alan Modra pointed out that he added an option to PowerPC gcc years ago
specifically for us to do lightweight mcount profiling.

The normal PowerPC gcc mcount stuff forces a stack spill and gets itself
tangled up in the function prolog, making it impossible to nop out easily:

# gcc -pg:

0000000000000000 <.foo>:
   0:   7c 08 02 a6     mflr    r0		<--- shared stack spill code
   4:   f8 01 00 10     std     r0,16(r1)	<--|
   8:   f8 21 ff 91     stdu    r1,-112(r1)	<--+
   c:   48 00 00 01     bl      c <.foo+0xc>	<--- call to mcount
  10:   60 00 00 00     nop

  14:   e9 22 00 00     ld      r9,0(r2)
  18:   e8 69 00 02     lwa     r3,0(r9)
  1c:   38 21 00 70     addi    r1,r1,112
  20:   e8 01 00 10     ld      r0,16(r1)
  24:   7c 08 03 a6     mtlr    r0
  28:   4e 80 00 20     blr

The option Alan added reduces the footprint to 3 instructions which can
be noped out completely. The rest of the function does not rely on the first
three instructions. No stack spill is forced either:

# gcc -pg -mprofile-kernel

0000000000000000 <.foo>:
   0:   7c 08 02 a6     mflr    r0
   4:   f8 01 00 10     std     r0,16(r1)
   8:   48 00 00 01     bl      8 <.foo+0x8>	<--- call to mcount

   c:   7c 08 02 a6     mflr    r0
  10:   f8 01 00 10     std     r0,16(r1)
  14:   f8 21 ff d1     stdu    r1,-48(r1)
  18:   e9 22 00 00     ld      r9,0(r2)
  1c:   e8 69 00 02     lwa     r3,0(r9)
  20:   38 21 00 30     addi    r1,r1,48
  24:   e8 01 00 10     ld      r0,16(r1)
  28:   7c 08 03 a6     mtlr    r0
  2c:   4e 80 00 20     blr


This mean we could support ftrace function trace with very little overhead.

In fact if we are careful when switching to the new mcount ABI and don't
rely on the store of r0, we could probably optimise this even further in a
future gcc and remove the store completely. mcount would be 2 instructions:

   mflr    r0              
   bl      8 <.foo+0x8>

Anton
