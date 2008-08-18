Return-Path: <mohan@in.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A1512DE4F3
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 03:20:52 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m7IHKhqb011174
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Aug 2008 13:20:43 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m7IHJUeD237960
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Aug 2008 13:19:30 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m7IHJUcD004745
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Aug 2008 13:19:30 -0400
Message-ID: <48A9AF1D.5050700@in.ibm.com>
Date: Mon, 18 Aug 2008 22:49:25 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 0/5] Relocatable 64-bit kernel using linker PIE support
References: <18594.14443.340604.693747@cargo.ozlabs.ibm.com>
In-Reply-To: <18594.14443.340604.693747@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul,

I can't boot zImage with your patches. I'm getting the following error 
message from prom_init.c

Error: You can't boot a kdump kernel from OF!

This is due to the check:
if (PHYSICAL_START > 0)
             prom_panic("Error: You can't boot a kdump kernel from OF!\n");

where PHYSICAL_START is kernstart_addr, and this variable needs to be 
referred through RELOC macro

But even after commenting the above check, I am not able to boot zImage.

<snip boot message>

Building dt structure...
Device tree strings 0x0000000002ce4000 -> 0×0000000002ce5034
Device tree struct 0×0000000002ce6000 -> 0×0000000002cf0000
Calling quiesce …
returning from prom_init

<snip>

and the system hangs

It has CONFIG_RELOCATABLE set, (CONFIG_CRASH_DUMP is not set).

I even tried booting zImage through netboot, it also fails at the same 
place.

If you need, I can give the .config I use.

Regards,
Mohan.

Paul Mackerras wrote:
> The following series of patches implement support for a relocatable
> kernel by building it as a position-independent executable (PIE).
> When the linker is given the -pie flag, it creates an executable that
> contains dynamic relocations which can be used to relocate the image
> at boot time for any desired base address.  This patch series adds a
> CONFIG_RELOCATABLE config option for 64-bit which links the kernel
> with -pie and arranges to process the relocations in early boot.
> 
> With the first 4 patches applied, a relocatable kernel will still copy
> itself down to real address 0.  The last patch changes things so that
> a relocatable kernel will run wherever it was loaded.  This last patch
> is pretty much just a proof of concept since it doesn't do anything to
> ensure appropriate alignment of the base address (the base address
> needs to be 16kB aligned).  We probably want to work out whether we
> are a kdump kernel and run in-place if so, or copy down to 0 if not.
> 
> Paul.
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
