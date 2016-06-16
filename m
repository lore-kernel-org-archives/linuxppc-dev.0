Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rVg694pB3zDqnR
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2016 20:46:09 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rVg6869bKz9t1j
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Jun 2016 20:46:08 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5GAcrQ0074619
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Jun 2016 06:46:06 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23kqt1xsy7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Jun 2016 06:46:05 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 16 Jun 2016 04:46:05 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: "Darrick J. Wong" <darrick.wong@oracle.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: kernel bug in "Drop WIMG in favour of new constants"?
In-Reply-To: <8737oda1lt.fsf@skywalker.in.ibm.com>
References: <20160616043340.GB22590@birch.djwong.org>
 <1466054627.5400.5.camel@ellerman.id.au>
 <20160616055746.GC22590@birch.djwong.org>
 <8737oda1lt.fsf@skywalker.in.ibm.com>
Date: Thu, 16 Jun 2016 16:16:00 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87ziql8l93.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> "Darrick J. Wong" <darrick.wong@oracle.com> writes:
>
>> On Thu, Jun 16, 2016 at 03:23:47PM +1000, Michael Ellerman wrote:
>>> On Wed, 2016-06-15 at 21:33 -0700, Darrick J. Wong wrote:
>>> 
>>> > Hi Aneesh,
>>> > 
>>> > I noticed when trying out 4.7-rc3 on qemu-2.5 that the kernel no longer
>>> > boots.  4.6 booted just fine, so I bisected the kernel to the commit
>>> > 30bda41aba4efb2370c97e2cbe7385de93ccc372, which is "powerpc/mm: Drop WIMG in
>>> > favour of new constants".  The changelog suggests that the KVM changes need
>>> > closer review, and here's an actual crash:
>>> > 
>>> > (I can send libvirt's machine xml, .config, and full dmesg if that helps.)
>>> 
>>> Yes please.
>>> 
>>> I'm successfully booting 4.7-rc's on qemu (2.5.0 (Debian 1:2.5+dfsg-5ubuntu10.1)).
>>
>> Ok, see attached.  I also sent along the dpkg --status output for qemu
>> and qemu-slof; looks like we're running the same Ubuntu packages...
>>
>> ...my host kernel is 4.6.0 on x64.
>
> So this is Qemu TCG mode right ? I will try some test and update later.
>

I am able to reproduce this with

qemu-system-ppc64 -kernel vmlinux -machine
type=pseries,usb=off -smp 1 -m 1G  -vga none -nographic    -device
usb-ehci -device usb-kbd -device usb-mouse

Looks like enabling usb device is the issue.

-aneesh
