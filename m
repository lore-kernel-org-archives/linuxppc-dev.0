Return-Path: <seroyer@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C28CD1A03E6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 10:24:01 +1100 (AEDT)
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <seroyer@linux.vnet.ibm.com>;
 Wed, 17 Feb 2016 18:23:59 -0500
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 2D6856E8040
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 18:10:48 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1HNNuhf22085860
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 23:23:56 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1HNNtFT002930
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 18:23:56 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Wed, 17 Feb 2016 17:23:55 -0600
From: Steven Royer <seroyer@linux.vnet.ibm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael
 Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Steven Royer <seroyer@us.ibm.com>
Subject: Re: [PATCH] add POWER Virtual Management Channel driver
In-Reply-To: <20160217223141.GA16341@kroah.com>
References: <1455655393-3137-1-git-send-email-seroyer@linux.vnet.ibm.com>
 <20160216221822.GA32255@kroah.com>
 <e2c42d22f68dbb943363bfb6e06c8f79@imap.linux.ibm.com>
 <20160217223141.GA16341@kroah.com>
Message-ID: <0523320d3efd5c9dcac10a85aecd1fe1@imap.linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016-02-17 16:31, Greg Kroah-Hartman wrote:
> On Wed, Feb 17, 2016 at 03:18:26PM -0600, Steven Royer wrote:
>> On 2016-02-16 16:18, Greg Kroah-Hartman wrote:
>> >On Tue, Feb 16, 2016 at 02:43:13PM -0600, Steven Royer wrote:
>> >>From: Steven Royer <seroyer@us.ibm.com>
>> >>
>> >>The ibmvmc driver is a device driver for the POWER Virtual Management
>> >>Channel virtual adapter on the PowerVM platform.  It is used to
>> >>communicate with the hypervisor for virtualization management.  It
>> >>provides both request/response and asynchronous message support through
>> >>the /dev/ibmvmc node.
>> >
>> >What is the protocol for that device node?
>> The protocol is not currently published.  I am pushing on getting it
>> published, but that process will take time.  If you have a PowerVM 
>> system
>> with NovaLink, it would not be hard to reverse engineer it...  If you 
>> don't
>> have a PowerVM system, then this driver isn't interesting anyway...
> 
> You can't just expect us to review this code without at least having a
> clue as to how it is supposed to work?
There are two layers to the protocol.  The first layer is the only layer 
that the driver actually cares about.  The second layer is just a 
payload that is between the application and the hypervisor and can 
change independently from the kernel/driver (this is what is transported 
over the /dev/ibmvmc node).  The first layer technically is published in 
the PAPR (appendix G), but it is not trivial for most people to access 
online.  I'll put together some documentation that describes that first 
layer of the protocol in my next revision of the patch.  In many 
respects, the interface between driver and hypervisor is similar to 
ibmvscsi.  Both are CRQ based devices.  ibmvmc is actually a little 
closer to the old ibmvstgt driver since it is a CRQ server device.
> 
>> >Where is the documentation here?  Why does this have to be a character
>> >device?  Why can't it fit in with other drivers of this type?
>> This is a character device for historical reasons.  The short version 
>> is
>> that this driver is a clean-room rewrite of an AIX driver which made 
>> it a
>> character device.  The user space application was ported from AIX to 
>> Linux
>> and it is convenient to have the AIX and Linux drivers match behavior 
>> where
>> possible.
> 
> Note that we don't let random userspace applications dictate kernel api
> decisions, please make the best choice for this interface without being
> influenced by AIX.
That is fair.  I actually started down the path of using a block 
interface early on, and I ran into some complications that made it seem 
less desirable than character.  Specifically the interface has variable 
length messages from 32 bytes to 4kb (mostly closer to 32 bytes than 4kb 
per message) and I was worried about overhead of dealing with all the 
zeros in the majority of the messages.  I've never made a block 
interface before and it's entirely possible (likely) I missed something 
obvious.  I'll revisit before I post the next revision.
> 
>> >>+/*
>> >>+ * IBM Power Systems Virtual Management Channel Support.
>> >>+ *
>> >>+ * Copyright (c) 2004, 2016 IBM Corp.
>> >>+ *   Dave Engebretsen engebret@us.ibm.com
>> >>+ *   Steven Royer seroyer@linux.vnet.ibm.com
>> >>+ *   Adam Reznechek adreznec@linux.vnet.ibm.com
>> >>+ *
>> >>+ * This program is free software; you can redistribute it and/or
>> >>+ * modify it under the terms of the GNU General Public License
>> >>+ * as published by the Free Software Foundation; either version 2
>> >>+ * of the License, or (at your option) any later version.
>> >
>> >I have to ask, but do you really mean "or any later version"?
>> This actually matches closely to other similar PowerVM virtual device
>> drivers, like ibmvscsi or ibmveth.
> 
> That did not answer the question, picking a license in a cargo-cult
> manner is not a wise decision :(
This is boilerplate for IBM provided PowerVM drivers.  So yes, I did 
mean this.
