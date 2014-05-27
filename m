Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by lists.ozlabs.org (Postfix) with ESMTP id B094B1A05CA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 May 2014 03:40:05 +1000 (EST)
Message-ID: <1401212394.3289.590.camel@ul30vt.home>
Subject: Re: [PATCH v6 2/3] drivers/vfio: EEH support for VFIO PCI device
From: Alex Williamson <alex.williamson@redhat.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Date: Tue, 27 May 2014 11:39:54 -0600
In-Reply-To: <20140524020620.GB4900@shangw>
References: <1400747034-15045-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1400747034-15045-3-git-send-email-gwshan@linux.vnet.ibm.com>
 <1400814653.3289.428.camel@ul30vt.home> <20140523043722.GA11572@shangw>
 <1400855399.3289.450.camel@ul30vt.home> <20140524020620.GB4900@shangw>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: aik@ozlabs.ru, agraf@suse.de, kvm-ppc@vger.kernel.org,
 qiudayu@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2014-05-24 at 12:06 +1000, Gavin Shan wrote:
> On Fri, May 23, 2014 at 08:29:59AM -0600, Alex Williamson wrote:
> >On Fri, 2014-05-23 at 14:37 +1000, Gavin Shan wrote:
> >> On Thu, May 22, 2014 at 09:10:53PM -0600, Alex Williamson wrote:
> >> >On Thu, 2014-05-22 at 18:23 +1000, Gavin Shan wrote:
> 
> .../...
> 
> >No, sorry, I mean how does the user get information about the error?
> >The interface we have here is:
> >a) find that something bad has happened
> >b) kick it into working again
> >c) continue
> >
> >How does the user figure out what happened and if it makes sense to
> >attempt to recover?  Where does the user learn that their disk is on
> >fire?
> >
> 
> When 0xFF's returned from config or IO read, user should check the
> device (PE)'s state with ioctl command VFIO_EEH_PE_GET_STATE. If the
> device (PE) has been put into "frozen" state, It's confirmed the device
> ("disk" you mentioned) is on fire.

No, this only confirms that something bad happened, not _what_ bad thing
happened.

>  User should kick off recovery, which
> includes:

And here you're just describing the kick operation again...

> 
> - User stops any operatins (config, IO, DMA) on the device because any
>   PCI traffic to "frozen" device will be dropped from software or hardware
>   level. Also, we don't expect DMA traffic during recovery. Otherwise,
>   we will bump into recursive errors and the recovery should fail.
> - VFIO_EEH_PE_SET_OPTION to enable I/O path ("DMA" path is still under frozen
>   state). EEH_VFIO_PE_CONFIGURE to reconfigure affected PCI bridges and then
>   do error log retrieval.

These logs, where do they go?  How does the user get access?  That's
what I'm trying to ask about.

> - VFIO_EEH_PE_RESET to reset the affected device (PE). EEH_VFIO_PE_CONFIUGRE
>   to restore BARs.
> - User resumes the device to start PCI traffic and device is brought to
>   funtional state.
> 
> .../...
> 
> >
> >No, I prefer to stay consistent with the rest of the VFIO API and use
> >argsz + flags.
> >
> 
> Here's the recap for previous reply: I have several cases for ioctl().
> 
> - ioctl(fd, cmd, NULL):   I needn't any input info.
> - ioctl(fd, cmd, &data):  I need input info
> 
> For all the cases, should I simply have a data struct to include "argsz+flags"?

Anything that requires data should have argsz+flags, if it doesn't
require data, it doesn't need them, but think long an hard about whether
there's any possibility that we'll need parameters in the future.

> For return value from ioctl(), can we simply to have additional field in the
> above data struct to carry it? "0" is the information I have to return for
> some of the cases.

If for instance your ioctl is returning something like "number of
errors", then it's perfectly fine to use that as the ioctl return.  <0
is error, >= zero is a success with value.
