Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41gbSg3HwkzDqDQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Aug 2018 00:35:31 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/mobility: Fix node detach/rename problem
In-Reply-To: <8bf95369-2625-146a-34d4-d051322e06ff@linux.vnet.ibm.com>
References: <c2fba52a-baac-25fb-c26b-c84b25c3178c@linux.vnet.ibm.com>
 <9cd25a93-6c71-728c-e9bf-a16f80ef5655@linux.vnet.ibm.com>
 <871sbjj48b.fsf@concordia.ellerman.id.au>
 <8bf95369-2625-146a-34d4-d051322e06ff@linux.vnet.ibm.com>
Date: Thu, 02 Aug 2018 00:35:29 +1000
Message-ID: <87a7q6f93i.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Tyrel Datwyler <tyreld@linux.vnet.ibm.com> writes:
> On 07/30/2018 11:42 PM, Michael Ellerman wrote:
>> Tyrel Datwyler <tyreld@linux.vnet.ibm.com> writes:
>>> On 07/29/2018 06:11 AM, Michael Bringmann wrote:
>>>> During LPAR migration, the content of the device tree/sysfs may
>>>> be updated including deletion and replacement of nodes in the
>>>> tree.  When nodes are added to the internal node structures, they
>>>> are appended in FIFO order to a list of nodes maintained by the
>>>> OF code APIs.  When nodes are removed from the device tree, they
>>>> are marked OF_DETACHED, but not actually deleted from the system
>>>> to allow for pointers cached elsewhere in the kernel.  The order
>>>> and content of the entries in the list of nodes is not altered,
>>>> though.
>>>>
>>>> During LPAR migration some common nodes are deleted and re-added
>>>> e.g. "ibm,platform-facilities".  If a node is re-added to the OF
>>>> node lists, the of_attach_node function checks to make sure that
>>>> the name + ibm,phandle of the to-be-added data is unique.  As the
>>>> previous copy of a re-added node is not modified beyond the addition
>>>> of a bit flag, the code (1) finds the old copy, (2) prints a WARNING
>>>> notice to the console, (3) renames the to-be-added node to avoid
>>>> filename collisions within a directory, and (3) adds entries to
>>>> the sysfs/kernfs.
>>>
>>> So, this patch actually just band aids over the real problem. This is
>>> a long standing problem with several PFO drivers leaking references.
>>> The issue here is that, during the device tree update that follows a
>>> migration. the update of the ibm,platform-facilities node and friends
>>> below are always deleted and re-added on the destination lpar and
>>> subsequently the leaked references prevent the devices nodes from
>>> every actually being properly cleaned up after detach. Thus, leading
>>> to the issue you are observing.
>
> So, it was the end of the day, and I kind of glossed over the issue
> Michael was trying to address with an issue that I remembered that had
> been around for awhile.

Sure, I know that feeling :)

>> Leaking references shouldn't affect the node being detached from the
>> tree though.
>
> No, but it does prevent it from being freed from sysfs which leads to
> the sysfs entry renaming that happens when another node with the same
> name is attached.

OK.

>> See of_detach_node() calling __of_detach_node(), none of that depends on
>> the refcount.
>> 
>> It's only the actual freeing of the node, in of_node_release() that is
>> prevented by leaked reference counts.
>
> Right, but if we did refcount correctly there is the new problem that
> the node is freed and now the phandle cache points at freed memory in
> the case were no invalidation is done.

Yeah that's bad.

I guess no one is supposed to lookup that phandle anymore, but it's
super fragile.

>> So I agree we need to do a better job with the reference counting, but I
>> don't see how it is causing the problem here
>
> Now in regards to the phandle caching somehow I missed that code going
> into OF earlier this year. That should have had at least some
> discussion from our side based on the fact that it is built on dtc
> compiler assumption that there are a set number of phandles that are
> allocated starting at 1..n such that they are monotonically
> increasing. That has a nice fixed size with O(1) lookup time. Phyp
> doesn't guarantee any sort of niceness with nicely ordered phandles.
> From what I've seen there are a subset of phandles that decrease from
> (-1) monotonically, and then there are a bunch of random values for
> cpus and IOAs. Thinking on it might not be that big of a deal as we
> just end up in the case where we have a phandle collision one makes it
> into the cache and is optimized while the other doesn't. On another
> note, they clearly hit a similar issue during overlay attach and
> remove, and as Rob pointed out their solution to handle it is a full
> cache invalidation followed by rescanning the whole tree to rebuild
> it. Seeing as our dynamic lifecycle is node by node this definitely
> adds some overhead.

Yeah I also should have noticed it going in, but despite being
subscribed to the devicetree list I didn't spot it in the flood.

AIUI the 1..n assumption is not about correctness but if our phandles
violate that we may not be getting any benefit.

Anyway yeah lots of things to look at tomorrow :)

cheers
