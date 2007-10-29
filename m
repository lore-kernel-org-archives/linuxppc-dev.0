Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id BDEAEDE0EE
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 08:14:09 +1100 (EST)
Date: Mon, 29 Oct 2007 16:22:13 -0500
From: Olof Johansson <olof@lixom.net>
To: Yoder Stuart-B08248 <stuart.yoder@freescale.com>
Subject: Re: RFC:  replace device_type with new "class" property?
Message-ID: <20071029212213.GA28073@lixom.net>
References: <9696D7A991D0824DBA8DFAC74A9C5FA30359F9BB@az33exm25.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9696D7A991D0824DBA8DFAC74A9C5FA30359F9BB@az33exm25.fsl.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Oct 29, 2007 at 07:37:04AM -0700, Yoder Stuart-B08248 wrote:
> 
> We've had some discussions internally here at Freescale among 
> various PPC Linux developers about the device_type property
> and how 'classes' of devices should be represented in the
> device tree.
> 
> Taking a long term view, the question I'd like to pose is
> how should classes of device should be identified in the
> flat device tree model?   A device class, as I'm using it,
> refers basically to general categories of devices-- devices
> that share common properties.   Examples in current device
> would be "cpu", "memory", "pci", "network", "serial".
> 
> Today the device_type property serves this purpose to some
> degree.  However, the original meaning of device_type in
> Open Firmware is related to the method interface of a node
> it has a recent history of abuse in the Linux kernel DTS
> files, with a plethora of types made up in an ad hoc way.
> In addition, an OS can match on "compatible" and in the
> absence of method interfaces really doesn't need
> device_type anyway.
> 
> However, one good thing about device_type (if properly used)
> is that it could identify which device nodes follow an official
> binding, vs proprietary devices or one-off device node definitions.
> Without something like device_type the _human_ reader of a DTS
> file has to infer from the name or compatible what the device
> type is.  So, device class identifiers like "memory", "cpu",
> "serial", "pci", "network" provide that clarity.
> 
> So, what should the long term approach be?  Here are a couple
> of options:
> 
> 1.  Keep device_type, with it's use specifically defined to
>     mean that the node with that property implements an
>     'official' binding.   In the flat device tree model a
>     binding is just a defined set of required (and optional
>     properties.
> 
> 2.  Get rid of device_type and create a _new_ property like
>     "class".  The only nodes permitted to have this property
>     are those with 'official' bindings.  These nodes would
>     have a set of required (and optional) properties.
> 
>     The benefit of a new property is cutting all baggage
>     associated with the old device_type property.

I don't see how switching the property name from "device_type" to
"class" is going to stop people from misunderstanding it's intended
use. There's nothing inherently more understandable in calling it
"class" -- it also invites people to make up their own class names
as they go along, just as what happened to "device_type".

I also don't understand the people wanting to use "compatible"
for _everything_. It's just mashing together two separate pieces of
information into one property, and I seriously don't see how that helps
anything or anyone. It's absolutely useless for a driver to be able to
bind to a compatible field of "standard,network" or whatever it might be,
since there's no way that "standard," will imply that the register layout
and programming model is somehow the same as all other standard-labelled
devices.

So yes, there is a problem with the device trees and how people build
them, and it requires education on how to properly craft one. I don't
think changing the layout to either be flatter (only using compatible),
or changing names of a property (device_type->class) will help anything
at all.

I actually prefer keeping device_type myself, since it means existing
OF-based device trees will already have some of the labels.


-Olof
