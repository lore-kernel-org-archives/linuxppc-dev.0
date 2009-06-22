Return-Path: <brking@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id DB49DB7167
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Jun 2009 02:11:48 +1000 (EST)
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6B72CDDD04
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Jun 2009 02:11:47 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5MGAFwK015098
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Jun 2009 10:10:15 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5MGBW5u044094
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Jun 2009 10:11:33 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5MGBVji003742
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Jun 2009 10:11:32 -0600
Message-ID: <4A3FAD31.2060703@linux.vnet.ibm.com>
Date: Mon, 22 Jun 2009 11:11:29 -0500
From: Brian King <brking@linux.vnet.ibm.com>
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: Boot failure on the powerstation with 2.6.30 latest
References: <1245683801.6901.8.camel@mulgrave.site>
In-Reply-To: <1245683801.6901.8.camel@mulgrave.site>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

James,

I was running into a similar hang on one of my Power boxes as well.
Reverting c868d550115b9ccc0027c67265b9520790f05601 allowed by system
to boot. It looks like that patch injected a bug where we can end up
waiting on an uninitialized mutex:

[c0000000009f3c30] c00000000052c7dc .mutex_lock+0x34/0x50
[c0000000009f3cb0] c00000000008b190 .get_online_cpus+0x3c/0x74
[c0000000009f3d40] c000000000146cd0 .kmem_cache_create+0xcc/0x548
[c0000000009f3e50] c000000000032ae0 .pgtable_cache_init+0x28/0x6c
[c0000000009f3ee0] c000000000780960 .start_kernel+0x1ec/0x520
[c0000000009f3f90] c0000000000083d8 .start_here_common+0x1c/0x44

The mutex gets initialized in cpu_hotplug_init, which doesn't get called until
after pgtable_cache_init.

-Brian

James Bottomley wrote:
> 2.6.30-rc8 worked fine ... unless this is a known problem, I suppose I
> can begin bisecting.
> 
> The boot log of the hang is:
> 
> Please wait, loading kernel...
>    Elf64 kernel loaded...
> Loading ramdisk...
> ramdisk loaded at 02500000, size: 8280 Kbytes
> OF stdout device is: /ht/isa@8/serial@2f8
> Preparing to boot Linux version 2.6.30 (jejb@claymoor) (gcc version 4.3.3 (Debian 4.3.3-10) ) #1 SMP Mon Jun 22 09:59:35 CDT 2009
> command line: root=/dev/sda3 ro console=ttyS0,19200n1 
> memory layout at init:
>   alloc_bottom : 0000000002d16000
>   alloc_top    : 0000000030000000
>   alloc_top_hi : 0000000080000000
>   rmo_top      : 0000000030000000
>   ram_top      : 0000000080000000
> instantiating rtas at 0x000000002fff5000... done
> boot cpu hw idx 0000000000000000
> starting cpu hw idx 0000000000000001... done
> starting cpu hw idx 0000000000000002... done
> starting cpu hw idx 0000000000000003... done
> copying OF device tree...
> Building dt strings...
> Building dt structure...
> Device tree strings 0x0000000003117000 -> 0x0000000003117640
> Device tree struct  0x0000000003118000 -> 0x000000000311b000
> Calling quiesce...
> returning from prom_init
> 
> So it looks like some type of early boot failure or handoff in head_64
> 
> James
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev


-- 
Brian King
Linux on Power Virtualization
IBM Linux Technology Center
