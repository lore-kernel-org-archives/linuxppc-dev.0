Return-Path: <benh@kernel.crashing.org>
Message-ID: <1351798896.12271.241.camel@pasglop>
Subject: Re: Deprecating reserve-map in favor of properties
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 02 Nov 2012 06:41:36 +1100
In-Reply-To: <CACxGe6sAXBJ9KkA8Urioe-VsbaLUO+=C_tb1vU+i_VKuedi=eg@mail.gmail.com>
References: <1348179051.1132.32.camel@pasglop>
 <CACxGe6sAXBJ9KkA8Urioe-VsbaLUO+=C_tb1vU+i_VKuedi=eg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: devicetree-discuss@lists.ozlabs.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Cyril Chemparathy <cyril@ti.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-11-01 at 15:21 +0100, Grant Likely wrote:

> I think this makes sense. Cyril and I are just talking about what he
> needs. He wants to set aside per-device reserved regions and would
> like to have the ability to reference a particular reserved region
> from a device node, probably with a phandle. I like the look of the
> reserved-{ranges,names} properties in the root, but I see the argument
> that it isn't very flexible. What about something like this:
> 
> reserved-memory {
>         reserved@0x10000000 { reg = <0x10000000 0x08000000>; };
>         reserved@0x01000000 { reg = <0x01000000 0x00200000>; };
> }
> 
> The node name of the child nodes could be different of course.

I'm not that fan of different nodes, especially nodes with nodes in them
for that purpose. Seems overkill.

Can't he reference reserved entries as <phandle>,<index> pairs ?

I still think a single property would do fine. We could mandate those be
in the respective "memory" nodes but them you have potentially to break
up reserved regions if you have multiple memory nodes (NUMA) etc...

I'd vote for the simpler approach here...

> > The idea here is that we could have well defined names (using a similar
> > prefix we use for properties) such as linux,initrd, which indicates
> > clearly to the kernel that the only reason that range is reserved is
> > because it contains an initrd (ie, it can be freed once that's been
> > extracted).
> >
> > It would also be generally handy in case a reserved area is meant to be
> > used by a specific driver, such as an in-memory framebuffer
> > pre-initialized by the firmware. The generic memory management code
> > doesn't need to know, but later on, the gfx driver can pick it up easily
> > provided the name is part of the binding for that device.
> 
> Right, that would work also even though I prefer phandle references in
> general. Is it conceivable that additional data would want to be
> attached to a particular reserved region?

phandle references and names aren't exclusive from each other. The name
remains a useful diagnostic tool.

If you want additional data, make a node somewhere to represent that
region along with its additional data, that node can have a reference to
the reserved map entry.

I'd keep the reserve map itself simple. It's a "synthetic property" a
bit like the memory nodes. IE. The "memory" nodes don't have to
represent physical memory controllers & DIMMs. They represent the
overall view of memory by the CPUs. You can represent the MCs and the
DIMMs elsewhere in the SoC node.

Cheers,
Ben.
