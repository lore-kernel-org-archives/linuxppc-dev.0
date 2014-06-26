Return-Path: <nfont@austin.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BDC3F1A0013
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jun 2014 05:59:39 +1000 (EST)
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F064114007C
 for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2014 05:59:38 +1000 (EST)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <nfont@austin.ibm.com>;
 Thu, 26 Jun 2014 13:59:37 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 5C89F19D8039
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2014 13:59:26 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp07028.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5QJwBSK8782264
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2014 21:58:11 +0200
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5QJxX6A022739
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2014 13:59:35 -0600
Message-ID: <53AC7BA3.5030909@austin.ibm.com>
Date: Thu, 26 Jun 2014 14:59:31 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@linaro.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Subject: Re: OF_DYNAMIC node lifecycle
References: <CACxGe6tsXuLZT=h8S0yRPRPy6Hqz1xkX8G+ViY0cxEUuxZ1dsw@mail.gmail.com>	<43898B58-2EA7-42B5-A17A-27F16F2618A6@konsulko.com>	<20140623145844.DA6A3C40AE5@trevor.secretlab.ca>	<53A9DA69.1040101@austin.ibm.com>
 <20140625202216.16A8AC40AE6@trevor.secretlab.ca>
In-Reply-To: <20140625202216.16A8AC40AE6@trevor.secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1
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

On 06/25/2014 03:22 PM, Grant Likely wrote:
> On Tue, 24 Jun 2014 15:07:05 -0500, Nathan Fontenot <nfont@austin.ibm.com> wrote:
>> On 06/23/2014 09:58 AM, Grant Likely wrote:
>>> On Thu, 19 Jun 2014 11:33:20 +0300, Pantelis Antoniou <pantelis.antoniou@konsulko.com> wrote:
>>>> Hi Grant,
>>>>
>>>> CCing Thomas Gleixner & Steven Rostedt, since they might have a few
>>>> ideas...
>>>>
>>>> On Jun 18, 2014, at 11:07 PM, Grant Likely wrote:
>>>>
>>>>> Hi Nathan and Tyrel,
>>>>>
>>>>> I'm looking into lifecycle issues on nodes modified by OF_DYNAMIC, and
>>>>> I'm hoping you can help me. Right now, pseries seems to be the only
>>>>> user of OF_DYNAMIC, but making OF_DYNAMIC work has a huge impact on
>>>>> the entire kernel because it requires all DT code to manage reference
>>>>> counting with iterating over nodes. Most users simply get it wrong.
>>>>> Pantelis did some investigation and found that the reference counts on
>>>>> a running kernel are all over the place. I have my doubts that any
>>>>> code really gets it right.
>>>>>
>>>>> The problem is that users need to know when it is appropriate to call
>>>>> of_node_get()/of_node_put(). All list traversals that exit early need
>>>>> an extra call to of_node_put(), and code that is searching for a node
>>>>> in the tree and holding a reference to it needs to call of_node_get().
>>>>>
>>>>
>>>> In hindsight it appears that drivers just can't get the lifecycle right.
>>>> So we need to simplify things.
>>>>
>>>>> I've got a few pseries questions:
>>>>> - What are the changes being requested by pseries firmware? Is it only
>>>>> CPUs and memory nodes, or does it manipulate things all over the tree?
>>>>> - How frequent are the changes? How many changes would be likely over
>>>>> the runtime of the system?
>>>>> - Are you able to verify that removed nodes are actually able to be
>>>>> freed correctly? Do you have any testcases for node removal?
>>>>>
>>>>> I'm thinking very seriously about changing the locking semantics of DT
>>>>> code entirely so that most users never have to worry about
>>>>> of_node_get/put at all. If the DT code is switched to use rcu
>>>>> primitives for tree iteration (which also means making DT code use
>>>>> list_head, something I'm already investigating), then instead of
>>>>> trying to figure out of_node_get/put rules, callers could use
>>>>> rcu_read_lock()/rcu_read_unlock() to protect the region that is
>>>>> searching over nodes, and only call of_node_get() if the node pointer
>>>>> is needed outside the rcu read-side lock.
>>>>>
>>>>> I'd really like to be rid of the node reference counting entirely, but
>>>>> I can't figure out a way of doing that safely, so I'd settle for
>>>>> making it a lot easier to get correct.
>>>>>
>>>>
>>>> Since we're going about changing things, how about that devtree_lock?
>>>
>>> I believe rcu would pretty much eliminate the devtree_lock entirely. All
>>> modifiers would need to grab a mutex to ensure there is only one writer
>>> at any given time, but readers would have free reign to parse the tree
>>> however they like.
>>>
>>> DT writers would have to follow some strict rules about how to handle
>>> nodes that are removed (ie. don't modify or of_node_put() them until
>>> after rcu is syncronized), but the number of writers is very small and
>>> we have control of all of them.
>>>
>>>> We're using a raw_spinlock and we're always taking the lock with
>>>> interrupts disabled.
>>>>
>>>> If we're going to make DT changes frequently during normal runtime
>>>> and not only during boot time, those are bad for any kind of real-time
>>>> performance.
>>>>
>>>> So the question is, do we really have code that access the live tree
>>>> during atomic sections?  Is that something we want? Enforcing this
>>>> will make our lives easier, and we'll get the change to replace
>>>> that spinlock with a mutex.
>>>
>>> Yes, I believe the powerpc CPU hotplug code accesses the DT in atomic
>>> sections. I cannot put my finger on the exact code however. Nathan might
>>> know better. But, if I'm right, the whole problem goes away with RCU.
>>
>> I went back through the cpu hotplug code. we do update the DT during cpu
>> hotplug but I don't see it happening during atomic sections.
>>
>> The code is in arch/powerpc/platforms/pseries/dlpar.c
> 
> Great, thanks,
> 
> By the way, notifiers currently get sent before any updates are applied
> to the tree. I want to change it so that the notifier gets sent
> afterwards. Does that work for you? I've looked through all the users
> and aside from a stupid block of code in arch/powerpc/kernel/prom.c
> which does things that should be done by of_attach_node(), it looks like
> everything should be fine.

This would affect property updates. When doing a property update the
notifier passes a pointer to a struct containing a device node
pointer and a pointer to the new device node property.

I know specifically in memory property updates we grab the current version
of the device tree property and compare it to the 'new' version that 
was passed to us.

If you want to do the DT update before calling the notifier that should be
fine for the memory update code and would only require very minimal
updates.

It does look like OF_RECONFIG_UPDATE_PROPERTY is used in a couple of other
places that would need to be investigated.

-Nathan 
