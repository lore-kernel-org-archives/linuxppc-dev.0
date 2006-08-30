Return-Path: <christoph@schroedinger.engr.sgi.com>
Received: from omx2.sgi.com (omx2-ext.sgi.com [192.48.171.19])
	by ozlabs.org (Postfix) with ESMTP id 520E467B66
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Aug 2006 14:27:01 +1000 (EST)
Date: Tue, 29 Aug 2006 21:26:58 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: Re: libnuma interleaving oddness
In-Reply-To: <20060830022621.GA5195@us.ibm.com>
Message-ID: <Pine.LNX.4.64.0608292123230.23009@schroedinger.engr.sgi.com>
References: <20060829231545.GY5195@us.ibm.com>
	<Pine.LNX.4.64.0608291655160.22397@schroedinger.engr.sgi.com>
	<20060830002110.GZ5195@us.ibm.com> <20060830022621.GA5195@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: Christoph Lameter <christoph@schroedinger.engr.sgi.com>
Cc: linux-mm@kvack.org, lnxninja@us.ibm.com, ak@suse.de,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 29 Aug 2006, Nishanth Aravamudan wrote:

> If I use the default hugepage-aligned hugepage-backed malloc
> replacement, I get the following in /proc/pid/numa_maps (excerpt):
> 
> 20000000 interleave=0-7 file=/libhugetlbfs/libhugetlbfs.tmp.3JbO7R\040(deleted) huge dirty=1 N0=1
> 21000000 interleave=0-7 file=/libhugetlbfs/libhugetlbfs.tmp.3JbO7R\040(deleted) huge dirty=1 N0=1
> ...
> 37000000 interleave=0-7 file=/libhugetlbfs/libhugetlbfs.tmp.3JbO7R\040(deleted) huge dirty=1 N0=1
> 38000000 interleave=0-7 file=/libhugetlbfs/libhugetlbfs.tmp.3JbO7R\040(deleted) huge dirty=1 N0=1

Is this with nodemask set to [0]?

> If I change the nodemask to 1-7, I get:
> 
> 20000000 interleave=1-7 file=/libhugetlbfs/libhugetlbfs.tmp.Eh9Bmp\040(deleted) huge dirty=1 N1=1
> 21000000 interleave=1-7 file=/libhugetlbfs/libhugetlbfs.tmp.Eh9Bmp\040(deleted) huge dirty=1 N2=1
> 22000000 interleave=1-7 file=/libhugetlbfs/libhugetlbfs.tmp.Eh9Bmp\040(deleted) huge dirty=1 N3=1
> 23000000 interleave=1-7 file=/libhugetlbfs/libhugetlbfs.tmp.Eh9Bmp\040(deleted) huge dirty=1 N4=1
> 24000000 interleave=1-7 file=/libhugetlbfs/libhugetlbfs.tmp.Eh9Bmp\040(deleted) huge dirty=1 N5=1
> 25000000 interleave=1-7 file=/libhugetlbfs/libhugetlbfs.tmp.Eh9Bmp\040(deleted) huge dirty=1 N6=1
> 26000000 interleave=1-7 file=/libhugetlbfs/libhugetlbfs.tmp.Eh9Bmp\040(deleted) huge dirty=1 N7=1
> ...
> 35000000 interleave=1-7 file=/libhugetlbfs/libhugetlbfs.tmp.Eh9Bmp\040(deleted) huge dirty=1 N1=1
> 36000000 interleave=1-7 file=/libhugetlbfs/libhugetlbfs.tmp.Eh9Bmp\040(deleted) huge dirty=1 N2=1
> 37000000 interleave=1-7 file=/libhugetlbfs/libhugetlbfs.tmp.Eh9Bmp\040(deleted) huge dirty=1 N3=1
> 38000000 interleave=1-7 file=/libhugetlbfs/libhugetlbfs.tmp.Eh9Bmp\040(deleted) huge dirty=1 N4=1

So interleave has an effect.

Are you using cpusets? Or are you only using memory policies? What is the 
default policy of the task you are running?

> If I then change our malloc implementation to (unnecessarily) mmap a
> size aligned to 4 hugepages, rather aligned to a single hugepage, but
> using a nodemask of 0-7, I get:
> 
> 20000000 interleave=0-7 file=/libhugetlbfs/libhugetlbfs.tmp.PFt0xt\040(deleted) huge dirty=4 N0=1 N1=1 N2=1 N3=1
> 24000000 interleave=0-7 file=/libhugetlbfs/libhugetlbfs.tmp.PFt0xt\040(deleted) huge dirty=4 N0=1 N1=1 N2=1 N3=1
> 28000000 interleave=0-7 file=/libhugetlbfs/libhugetlbfs.tmp.PFt0xt\040(deleted) huge dirty=4 N0=1 N1=1 N2=1 N3=1
> 2c000000 interleave=0-7 file=/libhugetlbfs/libhugetlbfs.tmp.PFt0xt\040(deleted) huge dirty=4 N0=1 N1=1 N2=1 N3=1
> 30000000 interleave=0-7 file=/libhugetlbfs/libhugetlbfs.tmp.PFt0xt\040(deleted) huge dirty=4 N0=1 N1=1 N2=1 N3=1
> 34000000 interleave=0-7 file=/libhugetlbfs/libhugetlbfs.tmp.PFt0xt\040(deleted) huge dirty=4 N0=1 N1=1 N2=1 N3=1
> 38000000 interleave=0-7 file=/libhugetlbfs/libhugetlbfs.tmp.PFt0xt\040(deleted) huge dirty=1 mapped=4 N0=1 N1=1 N2=1 N3=1

Hmm... Strange. Interleaving should continue after the last one....
