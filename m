Return-Path: <grant.likely@secretlab.ca>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
 [74.125.82.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 408292C0389
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2012 23:12:01 +1100 (EST)
Received: by mail-we0-f179.google.com with SMTP id z49so514871wey.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2012 04:11:58 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Deprecating reserve-map in favor of properties
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1351798896.12271.241.camel@pasglop>
References: <1348179051.1132.32.camel@pasglop>
 <CACxGe6sAXBJ9KkA8Urioe-VsbaLUO+=C_tb1vU+i_VKuedi=eg@mail.gmail.com>
 <1351798896.12271.241.camel@pasglop>
Date: Thu, 15 Nov 2012 12:11:55 +0000
Message-Id: <20121115121155.7B2353E0B12@localhost>
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

On Fri, 02 Nov 2012 06:41:36 +1100, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> On Thu, 2012-11-01 at 15:21 +0100, Grant Likely wrote:
> 
> > I think this makes sense. Cyril and I are just talking about what he
> > needs. He wants to set aside per-device reserved regions and would
> > like to have the ability to reference a particular reserved region
> > from a device node, probably with a phandle. I like the look of the
> > reserved-{ranges,names} properties in the root, but I see the argument
> > that it isn't very flexible. What about something like this:
> > 
> > reserved-memory {
> >         reserved@0x10000000 { reg = <0x10000000 0x08000000>; };
> >         reserved@0x01000000 { reg = <0x01000000 0x00200000>; };
> > }
> > 
> > The node name of the child nodes could be different of course.
> 
> I'm not that fan of different nodes, especially nodes with nodes in them
> for that purpose. Seems overkill.
> 
> Can't he reference reserved entries as <phandle>,<index> pairs ?

That would work too.

> I still think a single property would do fine. We could mandate those be
> in the respective "memory" nodes but them you have potentially to break
> up reserved regions if you have multiple memory nodes (NUMA) etc...

It makes sense to me for the reserved ranges to be kept with the memory
nodes themselves, even if it does mean that sometimes they need to be
split up for multiple memory nodes.

> > Right, that would work also even though I prefer phandle references in
> > general. Is it conceivable that additional data would want to be
> > attached to a particular reserved region?
> 
> phandle references and names aren't exclusive from each other. The name
> remains a useful diagnostic tool.
> 
> If you want additional data, make a node somewhere to represent that
> region along with its additional data, that node can have a reference to
> the reserved map entry.
> 
> I'd keep the reserve map itself simple. It's a "synthetic property" a
> bit like the memory nodes. IE. The "memory" nodes don't have to
> represent physical memory controllers & DIMMs. They represent the
> overall view of memory by the CPUs. You can represent the MCs and the
> DIMMs elsewhere in the SoC node.

okay.

g.
