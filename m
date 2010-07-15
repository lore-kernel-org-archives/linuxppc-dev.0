Return-Path: <msm@freescale.com>
Received: from DB3EHSOBE001.bigfish.com (db3ehsobe001.messaging.microsoft.com
	[213.199.154.139]) by ozlabs.org (Postfix) with ESMTP id F0204B6EED
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 16 Jul 2010 02:54:15 +1000 (EST)
Subject: Re: [PATCH V4] powerpc/prom: Export device tree physical address
	via  proc
From: Matthew McClintock <msm@freescale.com>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <AANLkTikIGXBNU7NQEL7riZYB-BJU3jhxauzGo6XhUF3t@mail.gmail.com>
References: <1279120733-13584-1-git-send-email-msm@freescale.com>
	<AANLkTimiM1Ky7aIYoQ3efhivypV90LFG-BpueuaPaiPf@mail.gmail.com>
	<1279207159.30737.11.camel@localhost>
	<AANLkTikIGXBNU7NQEL7riZYB-BJU3jhxauzGo6XhUF3t@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 15 Jul 2010 11:39:21 -0500
Message-ID: <1279211961.31679.11.camel@localhost>
MIME-Version: 1.0
Cc: Kumar Gala <kumar.gala@freescale.com>, linuxppc-dev@lists.ozlabs.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-07-15 at 10:22 -0600, Grant Likely wrote:
> > Thanks for taking a look. My first thought was to just blow away all
> the
> > memreserve regions and start over. But, there are reserve regions
> for
> > other things that I might not want to blow away. For example, on
> mpc85xx
> > SMP systems we have an additional reserve region for our boot page.
> 
> What is your starting point?  Where does the device tree (and
> memreserve list) come from
> that you're passing to kexec?  My first impression is that if you have
> to scrub the memreserve list, then the source being used to
> obtain the memreserves is either faulty or unsuitable to the task. 

I'm pulling the device tree passed in via u-boot and passing it to
kexec. It is the most complete device tree and requires the least amount
of fixup.

I have to scrub two items, the ramdisk/initrd and the device tree
because upon kexec'ing the kernel we have the ability to pass in new
ramdisk/initrd and device tree. They can also live at different physical
addresses for the second reboot.

The initrd addresses are already exposed, so we can update/remove/reuse
that entry, we just need a way for kexec to determine the current device
tree address so it can replace the correct memreserve region for the
kexec'ing kernels' device tree.

The whole problem comes from repeatedly kexec'ing, we need to make sure
we don't keep losing blobs of memory to reserve regions (so we can't
just blindly add). We also need to make sure we don't lose other
memreserve regions that might be important for other things (so we can't
just blow them all away).

-M
