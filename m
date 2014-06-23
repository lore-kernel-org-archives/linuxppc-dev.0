Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F1FF1A0177
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jun 2014 01:00:02 +1000 (EST)
Received: from mail-we0-f176.google.com (mail-we0-f176.google.com
 [74.125.82.176])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F06EC14007C
 for <linuxppc-dev@ozlabs.org>; Tue, 24 Jun 2014 01:00:00 +1000 (EST)
Received: by mail-we0-f176.google.com with SMTP id u56so7037251wes.21
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Jun 2014 07:59:56 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@linaro.org>
Subject: Re: OF_DYNAMIC node lifecycle
To: Nathan Fontenot <nfont@austin.ibm.com>, Tyrel Datwyler
 <tyreld@linux.vnet.ibm.com>
In-Reply-To: <53A30117.3010100@austin.ibm.com>
References: <CACxGe6tsXuLZT=h8S0yRPRPy6Hqz1xkX8G+ViY0cxEUuxZ1dsw@mail.gmail.com>
 <53A30117.3010100@austin.ibm.com>
Date: Mon, 23 Jun 2014 15:48:06 +0100
Message-Id: <20140623144806.1348EC40A60@trevor.secretlab.ca>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 19 Jun 2014 10:26:15 -0500, Nathan Fontenot <nfont@austin.ibm.com> wrote:
> On 06/18/2014 03:07 PM, Grant Likely wrote:
> > Hi Nathan and Tyrel,
> > 
> > I'm looking into lifecycle issues on nodes modified by OF_DYNAMIC, and
> > I'm hoping you can help me. Right now, pseries seems to be the only
> > user of OF_DYNAMIC, but making OF_DYNAMIC work has a huge impact on
> > the entire kernel because it requires all DT code to manage reference
> > counting with iterating over nodes. Most users simply get it wrong.
> > Pantelis did some investigation and found that the reference counts on
> > a running kernel are all over the place. I have my doubts that any
> > code really gets it right.
> > 
> > The problem is that users need to know when it is appropriate to call
> > of_node_get()/of_node_put(). All list traversals that exit early need
> > an extra call to of_node_put(), and code that is searching for a node
> > in the tree and holding a reference to it needs to call of_node_get().
> > 
> > I've got a few pseries questions:
> > - What are the changes being requested by pseries firmware? Is it only
> > CPUs and memory nodes, or does it manipulate things all over the tree?
> 
> The short answer, everything.

:-)

> For pseries the two big actions that can change the device tree are
> adding/removing resources and partition migration.
> 
> The most frequent updates to the device tree happen during resource
> (cpu, memory, and pci/phb) add and remove. During this process we add
> and remove the node and its properties from the device tree.
> - For memory on newer systems this just involves updating the
>   ibm,dynamic-reconfiguration-memory/ibm,dynamic-memory property. Older
>   firmware levels add and remove the memroy@XXX nodes and their properties.
> - For cpus the cpus/PowerPC,POWERXXXX nodes and its properties are added
>   or removed
> - For pci/phb the pci@XXXXX nodes and properties are added/removed.
> 
> The less frequent operation of live partition migration (and suspend/resume)
> can update just about anything in the device tree. When this occurs and the
> systems starts after being migrated (or waking up after a suspend) we make
> a call to firmware to get updates to the device tree for the new hardware
> we are running on.
>  
> > - How frequent are the changes? How many changes would be likely over
> > the runtime of the system?
> 
> This can happen frequently.

Thanks, that is exactly the information that I want. I'm not so much
concerned with the addition or removal of nodes/properties, which is
actually pretty easy to handle. It is the lifecycle of allocations on
dynamic nodes that causes heartburn.

> > - Are you able to verify that removed nodes are actually able to be
> > freed correctly? Do you have any testcases for node removal?
> 
> I have always tested this by doing resource add/remove, usually cpu and memory
> since it is the easiest.

Is that just testing the functionality, or do you have tests that check
if the memory gets freed?

> > I'm thinking very seriously about changing the locking semantics of DT
> > code entirely so that most users never have to worry about
> > of_node_get/put at all. If the DT code is switched to use rcu
> > primitives for tree iteration (which also means making DT code use
> > list_head, something I'm already investigating), then instead of
> > trying to figure out of_node_get/put rules, callers could use
> > rcu_read_lock()/rcu_read_unlock() to protect the region that is
> > searching over nodes, and only call of_node_get() if the node pointer
> > is needed outside the rcu read-side lock.
> > 
> 
> This sounds good. I like just taking the rcu lock around accessing the DT.
> Do we have many places where DT node pointers are held that require
> keeping the of_node_get/put calls? If this did exist perhaps we could
> update those places to look up the DT node every time instead of
> holding on to the pointer. We could just get rid of the reference counting
> altogether then.

There are a few, but I would be happy to restrict reference counting to
only those locations. Most places will decode the DT data, and then
throw away the reference. We /might/ even be able to do rcu_lock/unlock
around the entire probe path which would make it transparent to all
device drivers.

> > I'd really like to be rid of the node reference counting entirely, but
> > I can't figure out a way of doing that safely, so I'd settle for
> > making it a lot easier to get correct.
> > 
> 
> heh! I have often thought about adding reference counting to device tree
> properties.

You horrible, horrible man.

> I don't really want to but there are some properties that can
> get updated frequently (namely the one mentioned above for memory) that
> can also get pretty big, especially on systems with a lot of memory. We
> never free the memory for old versions of a device tree property. This is
> a pretty minor issue though and probably best suited for a separate
> discussion after resolving this. 

We might be able to do some in-place modification of properties if the
size of the property doesn't change. That still leaves some nasty
lifecycle issues that need to be resolved though. It would require
swapping back and forth between memory for an old copy of the property
and a new one. Yes, this should be a separate discussion.

> 
> Other than pseries, who else does dynamic device tree updating? Are we the
> only ones?

Right now you're the only ones. Pantelis has a series that adds bulk
changes to the device tree which are also removable (called overlays). I
also have a GSoC student working on the selftest code which will
dynamically add testcase data to the tree.

g.
