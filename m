Return-Path: <tpepper@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.175])
	by ozlabs.org (Postfix) with ESMTP id DB1DD67B69
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Aug 2006 15:40:58 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id e2so76747ugf
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Aug 2006 22:40:55 -0700 (PDT)
Message-ID: <eada2a070608292240l21794824v4f127c0ae4b4758f@mail.gmail.com>
Date: Tue, 29 Aug 2006 22:40:54 -0700
From: "Tim Pepper" <lnxninja@us.ibm.com>
Sender: tpepper@gmail.com
To: "Christoph Lameter" <clameter@sgi.com>
Subject: Re: libnuma interleaving oddness
In-Reply-To: <Pine.LNX.4.64.0608292123230.23009@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20060829231545.GY5195@us.ibm.com>
	<Pine.LNX.4.64.0608291655160.22397@schroedinger.engr.sgi.com>
	<20060830002110.GZ5195@us.ibm.com> <20060830022621.GA5195@us.ibm.com>
	<Pine.LNX.4.64.0608292123230.23009@schroedinger.engr.sgi.com>
Cc: linuxppc-dev@ozlabs.org, Nishanth Aravamudan <nacc@us.ibm.com>, ak@suse.de,
	linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 8/29/06, Christoph Lameter <clameter@sgi.com> wrote:
> On Tue, 29 Aug 2006, Nishanth Aravamudan wrote:
>
> > If I use the default hugepage-aligned hugepage-backed malloc
> > replacement, I get the following in /proc/pid/numa_maps (excerpt):
> >
> > 20000000 interleave=0-7 file=/libhugetlbfs/libhugetlbfs.tmp.3JbO7R\040(deleted) huge dirty=1 N0=1
> > 21000000 interleave=0-7 file=/libhugetlbfs/libhugetlbfs.tmp.3JbO7R\040(deleted) huge dirty=1 N0=1
> > ...
> > 37000000 interleave=0-7 file=/libhugetlbfs/libhugetlbfs.tmp.3JbO7R\040(deleted) huge dirty=1 N0=1
> > 38000000 interleave=0-7 file=/libhugetlbfs/libhugetlbfs.tmp.3JbO7R\040(deleted) huge dirty=1 N0=1
>
> Is this with nodemask set to [0]?

The above is with a nodemask of 0-7.  Just removing node 0 from the mask causes
interleaving to start as below:

> > If I change the nodemask to 1-7, I get:
> >
> > 20000000 interleave=1-7 file=/libhugetlbfs/libhugetlbfs.tmp.Eh9Bmp\040(deleted) huge dirty=1 N1=1
> > 21000000 interleave=1-7 file=/libhugetlbfs/libhugetlbfs.tmp.Eh9Bmp\040(deleted) huge dirty=1 N2=1
> > 22000000 interleave=1-7 file=/libhugetlbfs/libhugetlbfs.tmp.Eh9Bmp\040(deleted) huge dirty=1 N3=1
> > 23000000 interleave=1-7 file=/libhugetlbfs/libhugetlbfs.tmp.Eh9Bmp\040(deleted) huge dirty=1 N4=1
> > 24000000 interleave=1-7 file=/libhugetlbfs/libhugetlbfs.tmp.Eh9Bmp\040(deleted) huge dirty=1 N5=1
> > 25000000 interleave=1-7 file=/libhugetlbfs/libhugetlbfs.tmp.Eh9Bmp\040(deleted) huge dirty=1 N6=1
> > 26000000 interleave=1-7 file=/libhugetlbfs/libhugetlbfs.tmp.Eh9Bmp\040(deleted) huge dirty=1 N7=1
> > ...
> > 35000000 interleave=1-7 file=/libhugetlbfs/libhugetlbfs.tmp.Eh9Bmp\040(deleted) huge dirty=1 N1=1
> > 36000000 interleave=1-7 file=/libhugetlbfs/libhugetlbfs.tmp.Eh9Bmp\040(deleted) huge dirty=1 N2=1
> > 37000000 interleave=1-7 file=/libhugetlbfs/libhugetlbfs.tmp.Eh9Bmp\040(deleted) huge dirty=1 N3=1
> > 38000000 interleave=1-7 file=/libhugetlbfs/libhugetlbfs.tmp.Eh9Bmp\040(deleted) huge dirty=1 N4=1
>
> So interleave has an effect.
>
> Are you using cpusets? Or are you only using memory policies? What is the
> default policy of the task you are running?

Just memory policies with the default task policy...really simple
code.  The current incantation basically does setup in the form of:
        numa_available();
        nodemask_zero(&nodemask);
        for (i = 0; i <= maxnode; i++)
                nodemask_set(&nodemask, i);
and then creates mmaps followed by:
        numa_interleave_memory(p, size, &nodemask);
        mlock(p, size)
        munlock(p, size);
to get the page faulted in.

> Hmm... Strange. Interleaving should continue after the last one....

That's what we thought...good to know we're not crazy.  We've spent a
lot of time looking at libnuma and the userspace side of things trying
to figure out if we were somehow passing an invalid nodemask into the
kernel, but we've pretty well convinced ourselves that is not the
case.  The kernel side of things (eg: sys_mbind() codepath) isn't
exactly obvious...code inspection's been a bit gruelling...need to do
kernel side probing to see what codepaths we're actually hitting.

An interesting additional point:  Nish's code originally wasn't using
libnuma and I wrote a simple little mmapping test program using
libnuma to compare results (thinking userspace issue).  My code worked
fine.  He rewrote to use libnuma and I rewrote to not use libnuma
thinking we'd find the problem in between.  Yet my code still gets
interleaving and his does not.  The only real difference between our
code is that mine basically does:
        mmap(...many hugepages...)
and Nish's effectively is doing:
        foreach(1..n) { mmap(...many/n hugepages...)}
if that pseudocode makes sense.  As above, when he changes his mmap to
grab more than one hugepage of memory at a time he starts seeing
interleaving.


Tim
