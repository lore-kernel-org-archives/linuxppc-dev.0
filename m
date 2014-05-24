Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5F7081A0547
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 May 2014 12:06:25 +1000 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Sat, 24 May 2014 12:06:25 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 2F3B32CE8047
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 May 2014 12:06:22 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4O1igGU59375674
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 May 2014 11:44:43 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4O26Lc3014768
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 May 2014 12:06:21 +1000
Date: Sat, 24 May 2014 12:06:21 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v6 2/3] drivers/vfio: EEH support for VFIO PCI device
Message-ID: <20140524020620.GB4900@shangw>
References: <1400747034-15045-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1400747034-15045-3-git-send-email-gwshan@linux.vnet.ibm.com>
 <1400814653.3289.428.camel@ul30vt.home>
 <20140523043722.GA11572@shangw>
 <1400855399.3289.450.camel@ul30vt.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1400855399.3289.450.camel@ul30vt.home>
Cc: aik@ozlabs.ru, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 kvm-ppc@vger.kernel.org, agraf@suse.de, qiudayu@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 23, 2014 at 08:29:59AM -0600, Alex Williamson wrote:
>On Fri, 2014-05-23 at 14:37 +1000, Gavin Shan wrote:
>> On Thu, May 22, 2014 at 09:10:53PM -0600, Alex Williamson wrote:
>> >On Thu, 2014-05-22 at 18:23 +1000, Gavin Shan wrote:

.../...

>No, sorry, I mean how does the user get information about the error?
>The interface we have here is:
>a) find that something bad has happened
>b) kick it into working again
>c) continue
>
>How does the user figure out what happened and if it makes sense to
>attempt to recover?  Where does the user learn that their disk is on
>fire?
>

When 0xFF's returned from config or IO read, user should check the
device (PE)'s state with ioctl command VFIO_EEH_PE_GET_STATE. If the
device (PE) has been put into "frozen" state, It's confirmed the device
("disk" you mentioned) is on fire. User should kick off recovery, which
includes:

- User stops any operatins (config, IO, DMA) on the device because any
  PCI traffic to "frozen" device will be dropped from software or hardware
  level. Also, we don't expect DMA traffic during recovery. Otherwise,
  we will bump into recursive errors and the recovery should fail.
- VFIO_EEH_PE_SET_OPTION to enable I/O path ("DMA" path is still under frozen
  state). EEH_VFIO_PE_CONFIGURE to reconfigure affected PCI bridges and then
  do error log retrieval.
- VFIO_EEH_PE_RESET to reset the affected device (PE). EEH_VFIO_PE_CONFIUGRE
  to restore BARs.
- User resumes the device to start PCI traffic and device is brought to
  funtional state.

.../...

>
>No, I prefer to stay consistent with the rest of the VFIO API and use
>argsz + flags.
>

Here's the recap for previous reply: I have several cases for ioctl().

- ioctl(fd, cmd, NULL):   I needn't any input info.
- ioctl(fd, cmd, &data):  I need input info

For all the cases, should I simply have a data struct to include "argsz+flags"?

For return value from ioctl(), can we simply to have additional field in the
above data struct to carry it? "0" is the information I have to return for
some of the cases.


.../...

>As agraf noted, I'm asking why reset and configure are separate when
>they seem to be used together.
>

Ok. It's the recap: they're 2 separate steps of error recovery as
defined in PAPR spec. Also, they correspond to 2 separate RTAS calls.
So I don't think we can put them together.

Thanks,
Gavin
