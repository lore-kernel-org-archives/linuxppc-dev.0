Return-Path: <glppd-linuxppc64-dev@m.gmane.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
 by ozlabs.org (Postfix) with ESMTP id E55161007D5
 for <linuxppc-dev@ozlabs.org>; Sat, 26 Nov 2011 00:55:19 +1100 (EST)
Received: from list by lo.gmane.org with local (Exim 4.69)
 (envelope-from <glppd-linuxppc64-dev@m.gmane.org>)
 id 1RTw0b-00021t-C2
 for linuxppc-dev@ozlabs.org; Fri, 25 Nov 2011 14:40:06 +0100
Received: from 122.167.75.152 ([122.167.75.152])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <linuxppc-dev@ozlabs.org>; Fri, 25 Nov 2011 14:40:05 +0100
Received: from mahesh.j.salgaonkar by 122.167.75.152 with local (Gmexim 0.1
 (Debian)) id 1AlnuQ-0007hv-00
 for <linuxppc-dev@ozlabs.org>; Fri, 25 Nov 2011 14:40:05 +0100
To: linuxppc-dev@ozlabs.org
From: "Mahesh J. Salgaonkar" <mahesh@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v5 1/9] fadump: Add documentation for firmware-assisted
 dump.
Date: Fri, 25 Nov 2011 19:00:50 +0530
Message-ID: <4ECF988A.1090203@linux.vnet.ibm.com>
References: <20111115151145.16533.16384.stgit@mars.in.ibm.com>
 <20111115151334.16533.5790.stgit@mars.in.ibm.com>
 <20111124223410.GB19828@bloggs.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
In-Reply-To: <20111124223410.GB19828@bloggs.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org
Reply-To: mahesh.j.salgaonkar@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/25/2011 04:04 AM, Paul Mackerras wrote:
> On Tue, Nov 15, 2011 at 08:43:34PM +0530, Mahesh J Salgaonkar wrote:
>> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>>
>> Documentation for firmware-assisted dump. This document is based on the
>> original documentation written for phyp assisted dump by Linas Vepstas
>> and Manish Ahuja, with few changes to reflect the current implementation.
>>
>> Change in v3:
>> - Modified the documentation to reflect introdunction of fadump_registered
>>   sysfs file and few minor changes.
>>
>> Change in v2:
>> - Modified the documentation to reflect the change of fadump_region
>>   file under debugfs filesystem.
> 
> In general we don't want the changes between successive versions in
> the patch description; this information should go below the "---"
> line.  The patch description should describe how the patch is now and
> give any information that will be useful to someone looking at the
> resulting git commit later on, but it doesn't need to tell us about
> previous versions of the patch that will never appear in the git
> history.

Sure will do that.

> 
>> +-- Once the dump is copied out, the memory that held the dump
>> +   is immediately available to the running kernel. A further
>> +   reboot isn't required.
> 
> I have a general worry about the system making allocations that are
> intended to be node-local while it is running with restricted memory
> (i.e. after the crash and reboot and before the dump has been written
> out and the dump memory freed).  Those allocations will probably all
> come from one node and thus won't necessarily be on the desired node.
> So, for very large systems with significant NUMA characteristics, it
> may be desirable (though not required) to reboot after taking the
> dump.

I have been working on trying to integrate FADUMP with the kdump
infrastructure on distros, which will modify the existing kernel initrd
to capture the vmcore and release the memory at the very early stage
before the switch_root.

However, by default FADUMP will also reboot after capturing vmcore
unless user specifies 'noreboot' option through kdump configuration file.

> 
> What happens about the NUMA information in the kernel -- all the
> memory sections, etc.?  Do they get set up as normal even though the
> second kernel is booting with only a small amount of memory initially?
> 

In FADUMP case, the booting of second kernel after crash is equivalent
to normal kernel bootup and it boots with the knowledge of entire system
RAM with NUMA information. The memblock structure does contain map for
entire system RAM. We just reserve the memory above the bootmem at the
very early stage in the second kernel, so that it remains untouched.

Thanks,
-Mahesh.
