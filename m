Return-Path: <pantelis.antoniou@konsulko.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 03C921A0339
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jun 2014 18:33:29 +1000 (EST)
Received: from mail-we0-f180.google.com (mail-we0-f180.google.com
 [74.125.82.180])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 32B9D140087
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Jun 2014 18:33:27 +1000 (EST)
Received: by mail-we0-f180.google.com with SMTP id x48so1956634wes.25
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Jun 2014 01:33:23 -0700 (PDT)
Subject: Re: OF_DYNAMIC node lifecycle
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=us-ascii
From: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
In-Reply-To: <CACxGe6tsXuLZT=h8S0yRPRPy6Hqz1xkX8G+ViY0cxEUuxZ1dsw@mail.gmail.com>
Date: Thu, 19 Jun 2014 11:33:20 +0300
Message-Id: <43898B58-2EA7-42B5-A17A-27F16F2618A6@konsulko.com>
References: <CACxGe6tsXuLZT=h8S0yRPRPy6Hqz1xkX8G+ViY0cxEUuxZ1dsw@mail.gmail.com>
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

CCing Thomas Gleixner & Steven Rostedt, since they might have a few
ideas...

On Jun 18, 2014, at 11:07 PM, Grant Likely wrote:

> Hi Nathan and Tyrel,
> 
> I'm looking into lifecycle issues on nodes modified by OF_DYNAMIC, and
> I'm hoping you can help me. Right now, pseries seems to be the only
> user of OF_DYNAMIC, but making OF_DYNAMIC work has a huge impact on
> the entire kernel because it requires all DT code to manage reference
> counting with iterating over nodes. Most users simply get it wrong.
> Pantelis did some investigation and found that the reference counts on
> a running kernel are all over the place. I have my doubts that any
> code really gets it right.
> 
> The problem is that users need to know when it is appropriate to call
> of_node_get()/of_node_put(). All list traversals that exit early need
> an extra call to of_node_put(), and code that is searching for a node
> in the tree and holding a reference to it needs to call of_node_get().
> 

In hindsight it appears that drivers just can't get the lifecycle right.
So we need to simplify things.

> I've got a few pseries questions:
> - What are the changes being requested by pseries firmware? Is it only
> CPUs and memory nodes, or does it manipulate things all over the tree?
> - How frequent are the changes? How many changes would be likely over
> the runtime of the system?
> - Are you able to verify that removed nodes are actually able to be
> freed correctly? Do you have any testcases for node removal?
> 
> I'm thinking very seriously about changing the locking semantics of DT
> code entirely so that most users never have to worry about
> of_node_get/put at all. If the DT code is switched to use rcu
> primitives for tree iteration (which also means making DT code use
> list_head, something I'm already investigating), then instead of
> trying to figure out of_node_get/put rules, callers could use
> rcu_read_lock()/rcu_read_unlock() to protect the region that is
> searching over nodes, and only call of_node_get() if the node pointer
> is needed outside the rcu read-side lock.
> 
> I'd really like to be rid of the node reference counting entirely, but
> I can't figure out a way of doing that safely, so I'd settle for
> making it a lot easier to get correct.
> 

Since we're going about changing things, how about that devtree_lock?

We're using a raw_spinlock and we're always taking the lock with
interrupts disabled.

If we're going to make DT changes frequently during normal runtime
and not only during boot time, those are bad for any kind of real-time
performance.

So the question is, do we really have code that access the live tree
during atomic sections? Is that something we want? Enforcing this
will make our lives easier, and we'll get the change to replace
that spinlock with a mutex.

 
> Thoughts?
> 
> g.

Regards

-- Pantelis
