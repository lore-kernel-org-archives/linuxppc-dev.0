Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E2EED1A044F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 16:30:30 +1100 (AEDT)
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Wed, 17 Feb 2016 22:30:28 -0700
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id D15AE19D8041
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 22:18:22 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1I5UPC612255332
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 22:30:25 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1I5UORi002335
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 22:30:24 -0700
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Steven Royer <seroyer@linux.vnet.ibm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
 Steven Royer <seroyer@us.ibm.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] add POWER Virtual Management Channel driver
In-Reply-To: <0523320d3efd5c9dcac10a85aecd1fe1@imap.linux.ibm.com>
References: <1455655393-3137-1-git-send-email-seroyer@linux.vnet.ibm.com>
 <20160216221822.GA32255@kroah.com>
 <e2c42d22f68dbb943363bfb6e06c8f79@imap.linux.ibm.com>
 <20160217223141.GA16341@kroah.com>
 <0523320d3efd5c9dcac10a85aecd1fe1@imap.linux.ibm.com>
Date: Thu, 18 Feb 2016 16:30:12 +1100
Message-ID: <87fuwqio0r.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Steven Royer <seroyer@linux.vnet.ibm.com> writes:
> On 2016-02-17 16:31, Greg Kroah-Hartman wrote:
>> On Wed, Feb 17, 2016 at 03:18:26PM -0600, Steven Royer wrote:
>>> On 2016-02-16 16:18, Greg Kroah-Hartman wrote:
>>> >On Tue, Feb 16, 2016 at 02:43:13PM -0600, Steven Royer wrote:
>>> >>From: Steven Royer <seroyer@us.ibm.com>
>>> >>
>>> >>The ibmvmc driver is a device driver for the POWER Virtual Management
>>> >>Channel virtual adapter on the PowerVM platform.  It is used to
>>> >>communicate with the hypervisor for virtualization management.  It
>>> >>provides both request/response and asynchronous message support through
>>> >>the /dev/ibmvmc node.
>>> >
>>> >What is the protocol for that device node?
>>> The protocol is not currently published.  I am pushing on getting it
>>> published, but that process will take time.  If you have a PowerVM 
>>> system
>>> with NovaLink, it would not be hard to reverse engineer it...  If you 
>>> don't
>>> have a PowerVM system, then this driver isn't interesting anyway...

Stephen - if you need some help pushing for it to be published, let me
know, there's a few internal things I could help push.

>> You can't just expect us to review this code without at least having a
>> clue as to how it is supposed to work?
> There are two layers to the protocol.  The first layer is the only layer 
> that the driver actually cares about.  The second layer is just a 
> payload that is between the application and the hypervisor and can 
> change independently from the kernel/driver (this is what is transported 
> over the /dev/ibmvmc node).  The first layer technically is published in 
> the PAPR (appendix G), but it is not trivial for most people to access

https://members.openpowerfoundation.org/document/dl/469 is LoPAPR which
has been published through OpenPower Foundation and anyone can access,
although Appendix G there is on EEH. Although VMC (Virtual Management
Channel) is mentioned in that document the details aren't there... so
it's possible that this is only in some other PAPR version :/
and... looking in internal places, it is. *sigh*

With my OpenPower Foundation hat on, I'll say that it's a
work-in-progress getting all this documentation in order.

The questions of if it's a sensible hypervisor to partition interface
and if it's a sensible userspace API are open for debate :)

Would we implement this way of communicating between a KVM guest and the
host linux system? If not, then it's probably not a generally good
idea. That being said, it seems to be what already exists in PowerVM

-- 
Stewart Smith
OPAL Architect, IBM.
