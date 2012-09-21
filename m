Return-Path: <galak@kernel.crashing.org>
Subject: Re: Deprecating reserve-map in favor of properties
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1348179051.1132.32.camel@pasglop>
Date: Thu, 20 Sep 2012 20:35:26 -0500
Message-Id: <8C5A5EB8-6CD7-4E35-AACF-A2CC04CDBE48@kernel.crashing.org>
References: <1348179051.1132.32.camel@pasglop>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: devicetree-discuss@lists.ozlabs.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 20, 2012, at 5:10 PM, Benjamin Herrenschmidt wrote:

> Hi folks !
>=20
> The reserve map is, imho, my biggest mistake when coming up with the =
FDT
> format.
>=20
> The main problem is that it doesn't survive the transition via a real
> Open Firmware interface. There is no practical way to indicate =
reserved
> regions of memory accross in that case, unless you have an OS that is
> nice enough to try to keep OF alive and accomodate its advertised
> "available" properties, but that's typically not the case of Linux on
> ppc.
>=20
> So I would like to propose that we add a new "better" way to convey
> reserved memory information, via properties in the tree.
>=20
> I originally though of having these in the "memory" nodes themselves =
but
> this can be tricky on machines that have multiple nodes (ie, NUMA
> generally means a memory node per NUMA node) since the reserved =
regions
> can spawn accross nodes and I don't want to complicate FW life too =
much
> by requiring breaking them up in that case.
>=20
> So what about something at the root of the tree:
>=20
> reserved-ranges: An array of ranges of reserved memory
>=20
> reserved-names: A list of zero terminated strings, one for each entry =
in
> the reserved-ranges array, providing optional "names" for the reserved
> ranges.
>=20
> The idea here is that we could have well defined names (using a =
similar
> prefix we use for properties) such as linux,initrd, which indicates
> clearly to the kernel that the only reason that range is reserved is
> because it contains an initrd (ie, it can be freed once that's been
> extracted).
>=20
> It would also be generally handy in case a reserved area is meant to =
be
> used by a specific driver, such as an in-memory framebuffer
> pre-initialized by the firmware. The generic memory management code
> doesn't need to know, but later on, the gfx driver can pick it up =
easily
> provided the name is part of the binding for that device.
>=20
> Any objection ? If none, I'll cook up a patch to add support for it =
(at
> least on powerpc :-)
>=20
> Cheers,
> Ben.

If you do this, please update the code in dtc/libfdt to construct the =
new nodes.  We use this in u-boot to reserve kernel, dtb, initrd, etc =
regions.  So would be nice to have drop in replacement code that could =
use same APIs if possible.

- k=
