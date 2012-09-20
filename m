Return-Path: <benh@kernel.crashing.org>
Message-ID: <1348179051.1132.32.camel@pasglop>
Subject: Deprecating reserve-map in favor of properties
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: devicetree-discuss@lists.ozlabs.org
Date: Fri, 21 Sep 2012 08:10:51 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi folks !

The reserve map is, imho, my biggest mistake when coming up with the FDT
format.

The main problem is that it doesn't survive the transition via a real
Open Firmware interface. There is no practical way to indicate reserved
regions of memory accross in that case, unless you have an OS that is
nice enough to try to keep OF alive and accomodate its advertised
"available" properties, but that's typically not the case of Linux on
ppc.

So I would like to propose that we add a new "better" way to convey
reserved memory information, via properties in the tree.

I originally though of having these in the "memory" nodes themselves but
this can be tricky on machines that have multiple nodes (ie, NUMA
generally means a memory node per NUMA node) since the reserved regions
can spawn accross nodes and I don't want to complicate FW life too much
by requiring breaking them up in that case.

So what about something at the root of the tree:

reserved-ranges: An array of ranges of reserved memory

reserved-names: A list of zero terminated strings, one for each entry in
the reserved-ranges array, providing optional "names" for the reserved
ranges.

The idea here is that we could have well defined names (using a similar
prefix we use for properties) such as linux,initrd, which indicates
clearly to the kernel that the only reason that range is reserved is
because it contains an initrd (ie, it can be freed once that's been
extracted).

It would also be generally handy in case a reserved area is meant to be
used by a specific driver, such as an in-memory framebuffer
pre-initialized by the firmware. The generic memory management code
doesn't need to know, but later on, the gfx driver can pick it up easily
provided the name is part of the binding for that device.

Any objection ? If none, I'll cook up a patch to add support for it (at
least on powerpc :-)

Cheers,
Ben.
