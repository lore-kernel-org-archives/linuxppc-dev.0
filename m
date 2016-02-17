Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2D5691A03D6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 09:31:44 +1100 (AEDT)
Date: Wed, 17 Feb 2016 14:31:41 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Steven Royer <seroyer@linux.vnet.ibm.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Steven Royer <seroyer@us.ibm.com>
Subject: Re: [PATCH] add POWER Virtual Management Channel driver
Message-ID: <20160217223141.GA16341@kroah.com>
References: <1455655393-3137-1-git-send-email-seroyer@linux.vnet.ibm.com>
 <20160216221822.GA32255@kroah.com>
 <e2c42d22f68dbb943363bfb6e06c8f79@imap.linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e2c42d22f68dbb943363bfb6e06c8f79@imap.linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 17, 2016 at 03:18:26PM -0600, Steven Royer wrote:
> On 2016-02-16 16:18, Greg Kroah-Hartman wrote:
> >On Tue, Feb 16, 2016 at 02:43:13PM -0600, Steven Royer wrote:
> >>From: Steven Royer <seroyer@us.ibm.com>
> >>
> >>The ibmvmc driver is a device driver for the POWER Virtual Management
> >>Channel virtual adapter on the PowerVM platform.  It is used to
> >>communicate with the hypervisor for virtualization management.  It
> >>provides both request/response and asynchronous message support through
> >>the /dev/ibmvmc node.
> >
> >What is the protocol for that device node?
> The protocol is not currently published.  I am pushing on getting it
> published, but that process will take time.  If you have a PowerVM system
> with NovaLink, it would not be hard to reverse engineer it...  If you don't
> have a PowerVM system, then this driver isn't interesting anyway...

You can't just expect us to review this code without at least having a
clue as to how it is supposed to work?

> >Where is the documentation here?  Why does this have to be a character
> >device?  Why can't it fit in with other drivers of this type?
> This is a character device for historical reasons.  The short version is
> that this driver is a clean-room rewrite of an AIX driver which made it a
> character device.  The user space application was ported from AIX to Linux
> and it is convenient to have the AIX and Linux drivers match behavior where
> possible.

Note that we don't let random userspace applications dictate kernel api
decisions, please make the best choice for this interface without being
influenced by AIX.

> >>+/*
> >>+ * IBM Power Systems Virtual Management Channel Support.
> >>+ *
> >>+ * Copyright (c) 2004, 2016 IBM Corp.
> >>+ *   Dave Engebretsen engebret@us.ibm.com
> >>+ *   Steven Royer seroyer@linux.vnet.ibm.com
> >>+ *   Adam Reznechek adreznec@linux.vnet.ibm.com
> >>+ *
> >>+ * This program is free software; you can redistribute it and/or
> >>+ * modify it under the terms of the GNU General Public License
> >>+ * as published by the Free Software Foundation; either version 2
> >>+ * of the License, or (at your option) any later version.
> >
> >I have to ask, but do you really mean "or any later version"?
> This actually matches closely to other similar PowerVM virtual device
> drivers, like ibmvscsi or ibmveth.

That did not answer the question, picking a license in a cargo-cult
manner is not a wise decision :(
