Return-Path: <kamezawa.hiroyu@jp.fujitsu.com>
Received: from fgwmail7.fujitsu.co.jp (fgwmail7.fujitsu.co.jp [192.51.44.37])
	by ozlabs.org (Postfix) with ESMTP id 27C35B70AE
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  5 Oct 2010 16:24:13 +1100 (EST)
Received: from m3.gw.fujitsu.co.jp ([10.0.50.73])
	by fgwmail7.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	o955OC9t020563 for <linuxppc-dev@lists.ozlabs.org> (envelope-from
	kamezawa.hiroyu@jp.fujitsu.com); Tue, 5 Oct 2010 14:24:13 +0900
Received: from smail (m3 [127.0.0.1])
	by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 440B445DE56
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  5 Oct 2010 14:24:12 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
	by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 2524845DE52
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  5 Oct 2010 14:24:12 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 076A51DB803F
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  5 Oct 2010 14:24:12 +0900 (JST)
Received: from m106.s.css.fujitsu.com (m106.s.css.fujitsu.com [10.249.87.106])
	by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id A9BC41DB803C
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  5 Oct 2010 14:24:11 +0900 (JST)
Date: Tue, 5 Oct 2010 14:18:52 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Nathan Fontenot <nfont@austin.ibm.com>
Subject: Re: [PATCH 9/9] v3 Update memory hotplug documentation
Message-Id: <20101005141852.66a6e85a.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <4CA62A7D.8030905@austin.ibm.com>
References: <4CA62700.7010809@austin.ibm.com> <4CA62A7D.8030905@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Greg KH <greg@kroah.com>, steiner@sgi.com, linux-kernel@vger.kernel.org,
	Dave Hansen <dave@linux.vnet.ibm.com>, linux-mm@kvack.org,
	Robin Holt <holt@sgi.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 01 Oct 2010 13:37:49 -0500
Nathan Fontenot <nfont@austin.ibm.com> wrote:

> Update the memory hotplug documentation to reflect the new behaviors of
> memory blocks reflected in sysfs.
> 
> Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
> 
Reviewed-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Thank you for your patient work!.



> ---
>  Documentation/memory-hotplug.txt |   47 +++++++++++++++++++++++++--------------
>  1 file changed, 31 insertions(+), 16 deletions(-)
> 
> Index: linux-next/Documentation/memory-hotplug.txt
> ===================================================================
> --- linux-next.orig/Documentation/memory-hotplug.txt	2010-09-29 14:56:24.000000000 -0500
> +++ linux-next/Documentation/memory-hotplug.txt	2010-09-30 14:59:47.000000000 -0500
> @@ -126,36 +126,51 @@
>  --------------------------------
>  4 sysfs files for memory hotplug
>  --------------------------------
> -All sections have their device information under /sys/devices/system/memory as
> +All sections have their device information in sysfs.  Each section is part of
> +a memory block under /sys/devices/system/memory as
>  
>  /sys/devices/system/memory/memoryXXX
> -(XXX is section id.)
> +(XXX is the section id.)
>  
> -Now, XXX is defined as start_address_of_section / section_size.
> +Now, XXX is defined as (start_address_of_section / section_size) of the first
> +section contained in the memory block.  The files 'phys_index' and
> +'end_phys_index' under each directory report the beginning and end section id's
> +for the memory block covered by the sysfs directory.  It is expected that all
> +memory sections in this range are present and no memory holes exist in the
> +range. Currently there is no way to determine if there is a memory hole, but
> +the existence of one should not affect the hotplug capabilities of the memory
> +block.
>  
>  For example, assume 1GiB section size. A device for a memory starting at
>  0x100000000 is /sys/device/system/memory/memory4
>  (0x100000000 / 1Gib = 4)
>  This device covers address range [0x100000000 ... 0x140000000)
>  
> -Under each section, you can see 4 files.
> +Under each section, you can see 4 or 5 files, the end_phys_index file being
> +a recent addition and not present on older kernels.
>  
> -/sys/devices/system/memory/memoryXXX/phys_index
> +/sys/devices/system/memory/memoryXXX/start_phys_index
> +/sys/devices/system/memory/memoryXXX/end_phys_index
>  /sys/devices/system/memory/memoryXXX/phys_device
>  /sys/devices/system/memory/memoryXXX/state
>  /sys/devices/system/memory/memoryXXX/removable
>  
> -'phys_index' : read-only and contains section id, same as XXX.
> -'state'      : read-write
> -               at read:  contains online/offline state of memory.
> -               at write: user can specify "online", "offline" command
> -'phys_device': read-only: designed to show the name of physical memory device.
> -               This is not well implemented now.
> -'removable'  : read-only: contains an integer value indicating
> -               whether the memory section is removable or not
> -               removable.  A value of 1 indicates that the memory
> -               section is removable and a value of 0 indicates that
> -               it is not removable.
> +'phys_index'      : read-only and contains section id of the first section
> +		    in the memory block, same as XXX.
> +'end_phys_index'  : read-only and contains section id of the last section
> +		    in the memory block.
> +'state'           : read-write
> +                    at read:  contains online/offline state of memory.
> +                    at write: user can specify "online", "offline" command
> +                    which will be performed on al sections in the block.
> +'phys_device'     : read-only: designed to show the name of physical memory
> +                    device.  This is not well implemented now.
> +'removable'       : read-only: contains an integer value indicating
> +                    whether the memory block is removable or not
> +                    removable.  A value of 1 indicates that the memory
> +                    block is removable and a value of 0 indicates that
> +                    it is not removable. A memory block is removable only if
> +                    every section in the block is removable.
>  
>  NOTE:
>    These directories/files appear after physical memory hotplug phase.
> 
> 
> 
