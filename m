Return-Path: <darrick.wong@oracle.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rVpbB3v4VzDqpd
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 02:23:18 +1000 (AEST)
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rVpb971W3z9t17
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Jun 2016 02:23:17 +1000 (AEST)
Date: Thu, 16 Jun 2016 09:23:03 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Subject: Re: kernel bug in "Drop WIMG in favour of new constants"?
Message-ID: <20160616162303.GA7573@birch.djwong.org>
References: <20160616043340.GB22590@birch.djwong.org>
 <1466054627.5400.5.camel@ellerman.id.au>
 <20160616055746.GC22590@birch.djwong.org>
 <8737oda1lt.fsf@skywalker.in.ibm.com>
 <87ziql8l93.fsf@skywalker.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87ziql8l93.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 16, 2016 at 04:16:00PM +0530, Aneesh Kumar K.V wrote:
> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:
> 
> > "Darrick J. Wong" <darrick.wong@oracle.com> writes:
> >
> >> On Thu, Jun 16, 2016 at 03:23:47PM +1000, Michael Ellerman wrote:
> >>> On Wed, 2016-06-15 at 21:33 -0700, Darrick J. Wong wrote:
> >>> 
> >>> > Hi Aneesh,
> >>> > 
> >>> > I noticed when trying out 4.7-rc3 on qemu-2.5 that the kernel no longer
> >>> > boots.  4.6 booted just fine, so I bisected the kernel to the commit
> >>> > 30bda41aba4efb2370c97e2cbe7385de93ccc372, which is "powerpc/mm: Drop WIMG in
> >>> > favour of new constants".  The changelog suggests that the KVM changes need
> >>> > closer review, and here's an actual crash:
> >>> > 
> >>> > (I can send libvirt's machine xml, .config, and full dmesg if that helps.)
> >>> 
> >>> Yes please.
> >>> 
> >>> I'm successfully booting 4.7-rc's on qemu (2.5.0 (Debian 1:2.5+dfsg-5ubuntu10.1)).
> >>
> >> Ok, see attached.  I also sent along the dpkg --status output for qemu
> >> and qemu-slof; looks like we're running the same Ubuntu packages...
> >>
> >> ...my host kernel is 4.6.0 on x64.
> >
> > So this is Qemu TCG mode right ? I will try some test and update later.
> >
> 
> I am able to reproduce this with
> 
> qemu-system-ppc64 -kernel vmlinux -machine
> type=pseries,usb=off -smp 1 -m 1G  -vga none -nographic    -device
> usb-ehci -device usb-kbd -device usb-mouse
> 
> Looks like enabling usb device is the issue.

<nod> Unfortunately, libvirt cleverly reinstalls the usb configuration
if I delete all the usb lines from the xml file.  I don't need USB, I'm
merely the stuckee. ;)

--D

> 
> -aneesh
> 
