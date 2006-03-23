Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 6859F679F6
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Mar 2006 17:19:45 +1100 (EST)
Date: Thu, 23 Mar 2006 00:19:04 -0600
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] kdump: Fix for machine checkstop on DMA fault
Message-ID: <20060323061904.GA22439@pb15.lixom.net>
References: <44222462.2030103@us.ibm.com>
	<20060323053854.GA17693@pb15.lixom.net>
	<200603231706.35508.michael@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200603231706.35508.michael@ellerman.id.au>
From: Olof Johansson <olof@lixom.net>
Cc: Milton Miller <miltonm@bga.com>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, Olaf Hering <olh@suse.de>,
	ellerman@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 23, 2006 at 05:06:27PM +1100, Michael Ellerman wrote:
> On Thu, 23 Mar 2006 16:38, Olof Johansson wrote:
> > On Wed, Mar 22, 2006 at 08:30:26PM -0800, Haren Myneni wrote:
> > > Paul, If you are OK with this fix, please send it upstream.
> > >
> > > Thanks
> > > Haren
> > >
> > > - Some machines checkstop on dma protection fault for ongoing DMA left
> > > in the first kernel. Since, we do not shutdown devices before the kdump
> > > boot, let them continue DMA to old kernel space.
> >
> > How is this solved for regular kexec, doesn't the same problem exist
> > there?
> 
> The idea for normal kexec is that the kernel should have shut everything down 
> properly. It's a bug if there are still DMAs going on. Hopefully.

Thanks Michael.

In that case, I have to NACK the original patch.

Out of luck, it'll probably work in most cases, but there's always
the risk of a DMA still going on, the crash kernel remapping an entry,
and getting memory scribbled over.

The crash kernel needs to be even more careful, and instead read out
the entries that are mapped and reserve them. This would require a bit
more plumbing since there's no way to read an entry right now, but it'd
remove that hole.


-Olof
