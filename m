Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41fn1K0r3KzF14s
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2018 16:42:29 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/mobility: Fix node detach/rename problem
In-Reply-To: <9cd25a93-6c71-728c-e9bf-a16f80ef5655@linux.vnet.ibm.com>
References: <c2fba52a-baac-25fb-c26b-c84b25c3178c@linux.vnet.ibm.com>
 <9cd25a93-6c71-728c-e9bf-a16f80ef5655@linux.vnet.ibm.com>
Date: Tue, 31 Jul 2018 16:42:28 +1000
Message-ID: <871sbjj48b.fsf@concordia.ellerman.id.au>
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
> On 07/29/2018 06:11 AM, Michael Bringmann wrote:
>> During LPAR migration, the content of the device tree/sysfs may
>> be updated including deletion and replacement of nodes in the
>> tree.  When nodes are added to the internal node structures, they
>> are appended in FIFO order to a list of nodes maintained by the
>> OF code APIs.  When nodes are removed from the device tree, they
>> are marked OF_DETACHED, but not actually deleted from the system
>> to allow for pointers cached elsewhere in the kernel.  The order
>> and content of the entries in the list of nodes is not altered,
>> though.
>> 
>> During LPAR migration some common nodes are deleted and re-added
>> e.g. "ibm,platform-facilities".  If a node is re-added to the OF
>> node lists, the of_attach_node function checks to make sure that
>> the name + ibm,phandle of the to-be-added data is unique.  As the
>> previous copy of a re-added node is not modified beyond the addition
>> of a bit flag, the code (1) finds the old copy, (2) prints a WARNING
>> notice to the console, (3) renames the to-be-added node to avoid
>> filename collisions within a directory, and (3) adds entries to
>> the sysfs/kernfs.
>
> So, this patch actually just band aids over the real problem. This is
> a long standing problem with several PFO drivers leaking references.
> The issue here is that, during the device tree update that follows a
> migration. the update of the ibm,platform-facilities node and friends
> below are always deleted and re-added on the destination lpar and
> subsequently the leaked references prevent the devices nodes from
> every actually being properly cleaned up after detach. Thus, leading
> to the issue you are observing.

Leaking references shouldn't affect the node being detached from the
tree though.

See of_detach_node() calling __of_detach_node(), none of that depends on
the refcount.

It's only the actual freeing of the node, in of_node_release() that is
prevented by leaked reference counts.

So I agree we need to do a better job with the reference counting, but I
don't see how it is causing the problem here.

cheers
