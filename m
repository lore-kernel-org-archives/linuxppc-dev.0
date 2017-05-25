Return-Path: <jikos@kernel.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wYNjM5bCqzDqjL
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 May 2017 19:08:39 +1000 (AEST)
Date: Thu, 25 May 2017 11:08:32 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 sachinp <sachinp@linux.vnet.ibm.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, mpe <mpe@ellerman.id.au>
Subject: Re: [linux-next] PPC Lpar fail to boot with error hid: module
 verification failed: signature and/or required key missing - tainting
 kernel
In-Reply-To: <1495700957.9020.43.camel@abdul.in.ibm.com>
Message-ID: <alpine.LSU.2.20.1705251106220.26873@cbobk.fhfr.pm>
References: <1495700957.9020.43.camel@abdul.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 25 May 2017, Abdul Haleem wrote:

> Hi,
> 
> Test : boot
> Machine : Power 8 PowerVM LPAR
> Kernel version : 4.12.0-rc2-next-20170524
> Toolchain : gcc version 5.2.1
> Config : attached
> 
> next-20170517 was last good version where we did not see the failure.
> from next-20170519 to today's next-20170524, we see the problem
> everyday.
> 
> Kernels fails to boot on PowerVM LPAR with these errors;
> 
> Freeing unused kernel memory: 4416K
> This architecture does not have kernel memory protection.
> Loading, please wait...
> mount: mounting udev on /dev failed: Device or resource busy
> W: devtmpfs not available, falling back to tmpfs for /dev
> starting version 222
> Begin: Loading essential drivers ... done.
> Begin: Running /scripts/init-premount ... done.
> Begin: Mounting root file system ... Begin:
> Running /scripts/local-top ... done.
> chvt: can't open console
> Gave up waiting for root device.  Common problems:
>  - Boot args (cat /proc/cmdline)
>    - Check rootdelay= (did the system wait long enough?)
>    - Check root= (did the system wait for the right device?)
>  - Missing modules (cat /proc/modules; ls /dev)
> chvt: can't open console
> ALERT!  /dev/disk/by-uuid/3aee8de3-5b8f-4a89-9e89-108efe213983 does not
> exist.  Dropping to a shell!

Seems like the by-uuid node for your harddrive containing rootfs didn't 
show up.

The EBUSY from mount(/dev) seems like the biggest suspect.

These:

> hid: module verification failed: signature and/or required key missing -
> tainting kernel
> hidraw: raw HID events driver (C) Jiri Kosina
> usbcore: registered new interface driver usbhid
> usbhid: USB HID core driver

are for sure unrelated.

Please focus on figuring out why mounting /dev doesn't succeed.

-- 
Jiri Kosina
SUSE Labs
