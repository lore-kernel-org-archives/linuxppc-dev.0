Return-Path: <pantelis.antoniou@konsulko.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 60CFD1A0197
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jun 2014 01:26:15 +1000 (EST)
Received: from mail-wg0-f43.google.com (mail-wg0-f43.google.com [74.125.82.43])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0A5C8140077
 for <linuxppc-dev@ozlabs.org>; Tue, 24 Jun 2014 01:26:12 +1000 (EST)
Received: by mail-wg0-f43.google.com with SMTP id b13so6452370wgh.26
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Jun 2014 08:26:08 -0700 (PDT)
Subject: Re: OF_DYNAMIC node lifecycle
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=us-ascii
From: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
In-Reply-To: <20140623145844.DA6A3C40AE5@trevor.secretlab.ca>
Date: Mon, 23 Jun 2014 18:26:04 +0300
Message-Id: <5213060A-74FB-4CD6-BF1C-4B7DCA98BE51@konsulko.com>
References: <CACxGe6tsXuLZT=h8S0yRPRPy6Hqz1xkX8G+ViY0cxEUuxZ1dsw@mail.gmail.com>
 <43898B58-2EA7-42B5-A17A-27F16F2618A6@konsulko.com>
 <20140623145844.DA6A3C40AE5@trevor.secretlab.ca>
To: Grant Likely <grant.likely@linaro.org>
Cc: devicetree@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Grant,

On Jun 23, 2014, at 5:58 PM, Grant Likely wrote:

> On Thu, 19 Jun 2014 11:33:20 +0300, Pantelis Antoniou =
<pantelis.antoniou@konsulko.com> wrote:
>> Hi Grant,
>>=20
>> CCing Thomas Gleixner & Steven Rostedt, since they might have a few
>> ideas...
>>=20
>> On Jun 18, 2014, at 11:07 PM, Grant Likely wrote:
>>=20
>>> Hi Nathan and Tyrel,
>>>=20
>>> I'm looking into lifecycle issues on nodes modified by OF_DYNAMIC, =
and
>>> I'm hoping you can help me. Right now, pseries seems to be the only
>>> user of OF_DYNAMIC, but making OF_DYNAMIC work has a huge impact on
>>> the entire kernel because it requires all DT code to manage =
reference
>>> counting with iterating over nodes. Most users simply get it wrong.
>>> Pantelis did some investigation and found that the reference counts =
on
>>> a running kernel are all over the place. I have my doubts that any
>>> code really gets it right.
>>>=20
>>> The problem is that users need to know when it is appropriate to =
call
>>> of_node_get()/of_node_put(). All list traversals that exit early =
need
>>> an extra call to of_node_put(), and code that is searching for a =
node
>>> in the tree and holding a reference to it needs to call =
of_node_get().
>>>=20
>>=20
>> In hindsight it appears that drivers just can't get the lifecycle =
right.
>> So we need to simplify things.
>>=20
>>> I've got a few pseries questions:
>>> - What are the changes being requested by pseries firmware? Is it =
only
>>> CPUs and memory nodes, or does it manipulate things all over the =
tree?
>>> - How frequent are the changes? How many changes would be likely =
over
>>> the runtime of the system?
>>> - Are you able to verify that removed nodes are actually able to be
>>> freed correctly? Do you have any testcases for node removal?
>>>=20
>>> I'm thinking very seriously about changing the locking semantics of =
DT
>>> code entirely so that most users never have to worry about
>>> of_node_get/put at all. If the DT code is switched to use rcu
>>> primitives for tree iteration (which also means making DT code use
>>> list_head, something I'm already investigating), then instead of
>>> trying to figure out of_node_get/put rules, callers could use
>>> rcu_read_lock()/rcu_read_unlock() to protect the region that is
>>> searching over nodes, and only call of_node_get() if the node =
pointer
>>> is needed outside the rcu read-side lock.
>>>=20
>>> I'd really like to be rid of the node reference counting entirely, =
but
>>> I can't figure out a way of doing that safely, so I'd settle for
>>> making it a lot easier to get correct.
>>>=20
>>=20
>> Since we're going about changing things, how about that devtree_lock?
>=20
> I believe rcu would pretty much eliminate the devtree_lock entirely. =
All
> modifiers would need to grab a mutex to ensure there is only one =
writer
> at any given time, but readers would have free reign to parse the tree
> however they like.
>=20
> DT writers would have to follow some strict rules about how to handle
> nodes that are removed (ie. don't modify or of_node_put() them until
> after rcu is syncronized), but the number of writers is very small and
> we have control of all of them.
>=20

There's one final nitpick with transactions; we might need another=20
node/property flag marking the 'in-progress' state so that
can be skipped by iterators, but in general this looks good.

>> We're using a raw_spinlock and we're always taking the lock with
>> interrupts disabled.
>>=20
>> If we're going to make DT changes frequently during normal runtime
>> and not only during boot time, those are bad for any kind of =
real-time
>> performance.
>>=20
>> So the question is, do we really have code that access the live tree
>> during atomic sections?  Is that something we want? Enforcing this
>> will make our lives easier, and we'll get the change to replace
>> that spinlock with a mutex.
>=20
> Yes, I believe the powerpc CPU hotplug code accesses the DT in atomic
> sections. I cannot put my finger on the exact code however. Nathan =
might
> know better. But, if I'm right, the whole problem goes away with RCU.
>=20

This is just bad. Why would you need to that?

> The design with RCU is to switch struct device_node and struct =
property
> to use list_head and/or hlist_head with the _rcu accessors. They allow
> items to be removed from a list without syncronizing with readers. =
Right
> now we have two lists that need to be modified; the allnodes list and
> the sibling list. I *think* it will be fine for the two list removals =
to
> be non-atomic (there will be a brief period where the node can be =
found
> on one list, but not the other) because it is a transient state =
already
> accounted for in rcu read-side critical region.
>=20

See above about transient states.

> That said, I've also got a design to remove the allnodes list entirely
> and only work with the sibling list. I need to prototype this.
>=20

In my original patchset for the overlays I used a single node as a root
and didn't deal with allnodes at all. So it can definitely can work.

> We'll also need a transition plan to move to RCU. I think the existing
> iterators can be modified to do the rcu locking in-line, but still =
require
> the of_node_get/put stuff (basically, so existing code continue to =
works
> unchanged). Then we can add _rcu versions that drop the need for
> of_node_get/put(). When everything is converted, the old iterators can
> be dropped.
>=20

Eventually yes. We're not close to that yet. I'd be happy if we get the=20=

lifecycle issues fixed right now (with of_node_get/put) and plan ahead.
I am sure we missed a few things, which we will come across.

> g.

Regards

-- Pantelis
