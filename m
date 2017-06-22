Return-Path: <robherring2@gmail.com>
Received: from mail-it0-f41.google.com (mail-it0-f41.google.com
 [209.85.214.41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtmP31gQ0zDr2R
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jun 2017 01:54:47 +1000 (AEST)
Received: by mail-it0-f41.google.com with SMTP id m47so52513280iti.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 08:54:47 -0700 (PDT)
Date: Thu, 22 Jun 2017 10:54:43 -0500
From: Rob Herring <robh@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: frowand.list@gmail.com, Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/4] of: remove *phandle properties from expanded
 device tree
Message-ID: <20170622155443.vyrozpzlydi32yzu@rob-hp-laptop>
References: <1497996172-821-1-git-send-email-frowand.list@gmail.com>
 <1497996172-821-2-git-send-email-frowand.list@gmail.com>
 <87mv92szsw.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <87mv92szsw.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 21, 2017 at 02:57:35PM +1000, Michael Ellerman wrote:
> Hi Frank,
> 
> frowand.list@gmail.com writes:
> > From: Frank Rowand <frank.rowand@sony.com>
> >
> > Remove "phandle", "linux,phandle", and "ibm,phandle" properties from
> > the internal device tree.  The phandle will still be in the struct
> > device_node phandle field and will still be displayed as if it is
> > a property in /proc/device_tree.
> >
> > This is to resolve the issue found by Stephen Boyd [1] when he changed
> > the type of struct property.value from void * to const void *.  As
> > a result of the type change, the overlay code had compile errors
> > where the resolver updates phandle values.
> >
> >   [1] http://lkml.iu.edu/hypermail/linux/kernel/1702.1/04160.html
> >
> > - Add sysfs infrastructure to report np->phandle, as if it was a property.
> > - Do not create "phandle" "ibm,phandle", and "linux,phandle" properties
> >   in the expanded device tree.
> > - Remove phandle properties in of_attach_node(), for nodes dynamically
> >   attached to the live tree.  Add the phandle sysfs entry for these nodes.
> > - When creating an overlay changeset, duplicate the node phandle in
> >   __of_node_dup().
> > - Remove no longer needed checks to exclude "phandle" and "linux,phandle"
> >   properties in several locations.
> > - A side effect of these changes is that the obsolete "linux,phandle" and
> >   "ibm,phandle" properties will no longer appear in /proc/device-tree (they
> >   will appear as "phandle").
> 
> Sorry but I don't think that can work for us.
> 
> Our DLPAR (ie. CPU/memory/device hotplug) stuff on PowerVM uses
> "ibm,phandle", and it's not the same thing as "phandle" /
> "linux,phandle".
> 
> I don't know the code well myself, but the spec (PAPR) says:
> 
>   Note: If the “ibm,phandle” property exists, there are two “phandle”
>   namespaces which must be kept separate. One is that actually used by
>   the OF client interface, the other is properties in the device tree
>   making reference to device tree nodes. These requirements are written
>   to maintain backward compatibility with older FW versions predating
>   these requirements; if the “ibm,phandle” property is not present, the
>   OS may assume that any device tree properties which refer to this node
>   will have a phandle value matching that returned by client interface
>   services.
> 
> I have systems here that still use "ibm,phandle". I also see at least
> some of the userspace code that looks for "ibm,phandle", and nothing
> else.
> 
> The note above actually implies that the current Linux code is wrong,
> when it uses "ibm,phandle" as the value of np->phandle.
> 
> So sorry that's a big mess, but we can't just rip out those properties.
> 
> I think the minimal change would be to treat "ibm,phandle" like a normal
> property, I think that would allow our tools to keep working?
> 
> 
> The other thing that worries me is that by renaming (effectively)
> "linux,phandle" to "phandle", we lose the ability to accurately
> regenerate the device tree from /proc/device-tree. In theory it
> shouldn't matter, but I worry that in practice something will break.

The only scenario I can come up with is booting a kernel with this 
change and kexec'ing to a kernel older than 2010 (when ePAPR phandle was 
added). Some how I doubt that would work without this change.

> What if we just kept a single bit flag somewhere indicating if the name of
> the phandle property we found was "phandle" or "linux,phandle", and
> create the sysfs phandle using that name?

I'd like to move towards dropping 'linux,phandle' including changing 
dtc to stop generating both properties by default. Perhaps we should 
just be more explicit that we are doing that. Stop exposing it first and 
then change how phandles are stored/managed a cycle later. Then we can 
easily revert it if needed.

Rob
