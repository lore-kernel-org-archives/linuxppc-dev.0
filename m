Return-Path: <pbadari@us.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E22E6DDEAB
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Nov 2007 02:27:56 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9VFRru1003967
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 11:27:53 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9VFGDlw112324
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 09:27:52 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9VF6qil011672
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 09:06:54 -0600
Subject: Re: [RFC] hotplug memory remove - walk_memory_resource for ppc64
From: Badari Pulavarty <pbadari@us.ibm.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20071031142846.aef9c545.kamezawa.hiroyu@jp.fujitsu.com>
References: <1191346196.6106.20.camel@dyn9047017100.beaverton.ibm.com>
	<18178.52359.953289.638736@cargo.ozlabs.ibm.com>
	<1193771951.8904.22.camel@dyn9047017100.beaverton.ibm.com>
	<20071031142846.aef9c545.kamezawa.hiroyu@jp.fujitsu.com>
Content-Type: text/plain
Date: Wed, 31 Oct 2007 08:10:12 -0800
Message-Id: <1193847012.17412.10.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, anton@au1.ibm.com,
	Paul Mackerras <paulus@samba.org>, linux-mm <linux-mm@kvack.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-10-31 at 14:28 +0900, KAMEZAWA Hiroyuki wrote:
> On Tue, 30 Oct 2007 11:19:11 -0800
> Badari Pulavarty <pbadari@us.ibm.com> wrote:
> 
> > Hi KAME,
> > 
> > As I mentioned while ago, ppc64 does not export information about
> > "system RAM" in /proc/iomem. Looking at the code and usage
> > scenerios I am not sure what its really serving. Could you 
> > explain what its purpose & how the range can be invalid ?
> > 
> Hm, I added walk_memory_resource() for hot-add, at first.
> 
> Size of memory section is fixed and just depend on architecture, but
> any machine can have any memory-hole within continuous memory-section-size
> range of physical memory. Then we have to detect which page can be
> target of online_page() and which are leaved as Reserved.
> 
> ioresource was good structure for remembering "which memory is conventional
> memory" and i386/x86_64/ia64 registered conventional memory as "System RAM",
> when I posted patch. (just say "System Ram" is not for memory hotplug.)
> 
> I used walk_memory_resource() again in memory hotremove.

Agreed. On PPC64, within a memblock represented in /sysfs are pretty
small (16MB) and there can not be any holes. And you can add/remove
memory only on 16MB multiple chunks. 

> 
> (If I rememember correctly, walk_memory_resouce() helps x86_64 memory hot-add.
>  than our ia64 box.
>  In our ia64 box, we do node-hotadd. Section size is 1GiB and it has some
>  "for firmware" area in newly-added node.)

> 
> > At least on ppc64, all the memory ranges we get passed comes from
> > /sysfs memblock information and they are guaranteed to match 
> > device-tree entries. On ppc64, each 16MB chunk has a /sysfs entry
> > and it will be part of the /proc/device-tree entry. Since we do
> > "online" or "offline" to /sysfs entries to add/remove pages - 
> > these ranges are guaranteed to be valid.
> > 
> ok.
> 
> > Since this check is redundant for ppc64, I propose following patch.
> > Is this acceptable ? If some one really really wants, I can code
> > up this to walk lmb or /proc/device-tree and verify the range &
> > adjust the entries for overlap (I don't see how that can happen).
> > 
> ok. If ppc64 guarantees "there is no memory hole in section", please try.
> I have no objection.
> I just would like to ask to add some text to explain
> "ppc64 doesn't need to care memory hole in a section."

Yes. I would like to go with this approach, rather than adding the
information to /proc/iomem (as per Paul's suggestion). If I find
cases where sections (16MB) *could* contain holes -OR- overlaps -
I can easily add code to verify against lmb/proc-device-tree information
easily without affecting arch-neutral code.

Thanks,
Badari
