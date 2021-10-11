Return-Path: <SRS0=o3RY=O7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A36D1C433F5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Oct 2021 11:45:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0FA860E05
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Oct 2021 11:45:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B0FA860E05
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HScSB2pTpz3053
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Oct 2021 22:45:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=PZ/QHbWB;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HScRT5ykMz2xsr
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Oct 2021 22:45:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=PZ/QHbWB; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4HScRR643mz4xR9;
 Mon, 11 Oct 2021 22:45:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
 s=201909; t=1633952708;
 bh=IjhMIjzKBBboUXog9iqPZXcpuN4N7iT1KpGd5Afe8NI=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=PZ/QHbWBx5NyghaIV0Nufql4K5adtNiuWzHIp6oFIN05tuUJz18nHCUXmy31vl+IN
 bPd8ta2t6RO2FyiJp+3p5rnyl4AWZ2USPx9WG4mhRuhMRCkSKwQboadnoa6YoEoCnY
 YTy4l7cwDKRsTFjxb7+FJMhX+cdMU3VHFktkLiUJeGFoXbVz9lX6DmEQK3cHsUy8ni
 6WvrPZ/bNDXginnyN5NmNvQI2LwvKGM5VqgvEZyLcNwj6f8tojlstqDaOlmDX/hBFI
 SSJggRR7+w/Y5Y7PyZszANWg+CGJNdTzJ98hLnaShHuVQzsdoiTxszaHnrqgYHHKX/
 /Z+geOUULwbEQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 3/3] powerpc/numa: Fill distance_lookup_table for
 offline nodes
In-Reply-To: <20210923175748.GC2004@linux.vnet.ibm.com>
References: <20210821102535.169643-1-srikar@linux.vnet.ibm.com>
 <20210821102535.169643-4-srikar@linux.vnet.ibm.com>
 <875yvsba4q.fsf@mpe.ellerman.id.au>
 <20210901102206.GO21942@linux.vnet.ibm.com>
 <871r5fmth6.fsf@mpe.ellerman.id.au>
 <20210923175748.GC2004@linux.vnet.ibm.com>
Date: Mon, 11 Oct 2021 22:45:04 +1100
Message-ID: <87pmsbn5tr.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Nathan Lynch <nathanl@linux.ibm.com>,
 Gautham R Shenoy <ego@linux.vnet.ibm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 kernel test robot <lkp@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Geetika Moolchandani <Geetika.Moolchandani1@ibm.com>,
 Valentin Schneider <valentin.schneider@arm.com>,
 Laurent Dufour <ldufour@linux.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Ingo Molnar <mingo@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Srikar Dronamraju <srikar@linux.vnet.ibm.com> writes:
> * Michael Ellerman <mpe@ellerman.id.au> [2021-09-23 21:17:25]:
>
>> Srikar Dronamraju <srikar@linux.vnet.ibm.com> writes:
>> > * Michael Ellerman <mpe@ellerman.id.au> [2021-08-26 23:36:53]:
>> >
>> >> Srikar Dronamraju <srikar@linux.vnet.ibm.com> writes:
>> >> > Scheduler expects unique number of node distances to be available at
>> >> > boot.
>> ...
>> >
>> >> > Fake the offline node's distance_lookup_table entries so that all
>> >> > possible node distances are updated.
>> >>
>> >> Does this work if we have a single node offline at boot?
>> >>
>> >
>> > It should.
>> >
>> >> Say we start with:
>> >>
>> >> node distances:
>> >> node   0   1
>> >>   0:  10  20
>> >>   1:  20  10
>> >>
>> >> And node 2 is offline at boot. We can only initialise that nodes entries
>> >> in the distance_lookup_table:
>> >>
>> >> 		while (i--)
>> >> 			distance_lookup_table[node][i] = node;
>> >>
>> >> By filling them all with 2 that causes node_distance(2, X) to return the
>> >> maximum distance for all other nodes X, because we won't break out of
>> >> the loop in __node_distance():
>> >>
>> >> 	for (i = 0; i < distance_ref_points_depth; i++) {
>> >> 		if (distance_lookup_table[a][i] == distance_lookup_table[b][i])
>> >> 			break;
>> >>
>> >> 		/* Double the distance for each NUMA level */
>> >> 		distance *= 2;
>> >> 	}
>> >>
>> >> If distance_ref_points_depth was 4 we'd return 160.
>> >
>> > As you already know, distance 10, 20, .. are defined by Powerpc, form1
>> > affinity. PAPR doesn't define actual distances, it only provides us the
>> > associativity. If there are distance_ref_points_depth is 4,
>> > (distance_ref_points_depth doesn't take local distance into consideration)
>> > 10, 20, 40, 80, 160.
>> >
>> >>
>> >> That'd leave us with 3 unique distances at boot, 10, 20, 160.
>> >>
>> >
>> > So if there are unique distances, then the distances as per the current
>> > code has to be 10, 20, 40, 80.. I dont see a way in which we have a break in
>> > the series. like having 160 without 80.
>>
>> I'm confused what you mean there.
>
> At the outset, if we have a better probable solution, do let me know, I am
> willing to try that too.

I don't have one in mind no, I'm just trying to satisfy myself that this
solution will work in all cases we're likely to encounter.

>> If we have a node that's offline at boot then we get 160 for that node,
>> that's just the result of having no info for it, so we never break out
>> of the for loop.
>>
>> So if we have two nodes, one hop apart, and then an offline node we get
>> 10, 20, 160.
>>
>> Or if you're using depth = 3 then it's 10, 20, 80.
>
> My understanding is as below:
>
> device-tree provides the max hops by way of
> ibm,associativity-reference-points. This is mapped to
> distance_ref_points_depth in Linux-powerpc.
>
> Now Linux-powerpc encodes hops as (dis-regarding local distance) 20, 40, 80,
> 160, 320 ...
> So if the distance_ref_points_depth is 3, then the hops are 20, 40, 80.
>
> Do you disagree?

I'm not sure. You didn't really address my point.

You said that we can't have 160 without 80 (for depth = 4).

I gave an example where we could see a gap in the used distance values,
ie. 10, 20, 80 for a depth of 3.

Which is not to say that distance 40 doesn't exist in that scenario,
rather that it's not used by any node.


>> >> But when node 2 comes online it might introduce more than 1 new distance
>> >> value, eg. it could be that the actual distances are:
>> >>
>> >> node distances:
>> >> node   0   1   2
>> >>   0:  10  20  40
>> >>   1:  20  10  80
>> >>   2:  40  80  10
>> >>
>> >> ie. we now have 4 distances, 10, 20, 40, 80.
>> >>
>> >> What am I missing?
>> >
>> > As I said above, I am not sure how we can have a break in the series.
>> > If distance_ref_points_depth is 3, the distances has to be 10,20,40,80 as
>> > atleast for form1 affinity.
>>
>> I agree for depth 3 we have to see 10, 20, 40, 80. But nothing
>> guarantees we see each value (other than 10).
>
> The hop distances are not from the device-tree, the device-tree only gives
> us the max hops possible. Linux-powerpc is actually hard-coding the
> distances which each hop distance being 2x the previous.

Yes. I guess I was sloppy to say "see each value", I didn't mean we see
those values directly in the device-tree.

> So we may not see any nodes at a particular hop, but we know maximum hops.
> And if distance_ref_points_depth is 3, then hops are 20, 40, 80 only.

OK, so we agree that "we may not see any nodes at a particular hop".

Which is what I was trying to say above.

>> We can have two nodes one hop apart, so we have 10 and 20, then a third
>> node is added 3 hops away, so we get 10, 20, 80.
>>
>
>> The real problem is that the third node could be 3 hops from node 0
>> and 2 hops from node 1, and so the addition of the third node causes
>> two new distance values (40 & 80) to be required.
>
> So here the max hops as given by device-tree is 3. So we know that we are
> looking for max-distance of 80 by way of distance_ref_points_depth.
>
> Even if the 3rd node was at 4 hops, we would already know the max distance
> of 160, by way of distance_ref_points_depth.

I agree we know that the max value is, and therefore the total number of
possible distance values.

But I think there are topologies where we can not represent all the
possible distances in the distance table.

> However in the most unlikely scenarios where the number of possible
> nodes are less than the distance_ref_points_depth(aka max hops) +
> there are CPUless/memoryless nodes we may not have initialized to the
> right distances.

OK, so I think you're saying you agree that there are situations where
we might not be able to represent all the distances.

But you say that's an "unlikely scenario", why is it unlikely?

If you can convince me it's 100% unlikely then maybe we can forget about
it :)

>> I think maybe what you're saying is that in practice we don't see setups
>> like that. But I don't know if I'm happy with a solution that doesn't
>> work in the general case, and relies on the particular properties of our
>> current set of systems.
>
> But our current set of systems are having a problem (Systems can likely
> crash on adding a CPU to a node.)

Yes I agree that's bad, but also we don't want to merge a solution (and
presumably backport it everywhere) if it doesn't work for some cases.

> The only other way I can think of is the previous approach were we ask
> scheduler hook which tells how many unique node distances are
> possible. But then it was stuck down because, we didnt want to add a
> hook just for one arch.

OK.

> However isn't this is much much better than the current situation we are in?
> i.e This is not going to cause any regression for the other setups.

Yes that's true. But equally if we can find a 100% solution that would
save us having to fix the same issue again in future.

>> Possibly we just need to detect that case and WARN about it. The only
>> problem is we won't know until the system is already up and running, ie.
>> we can't know at boot that the onlining of the third node will cause 2
>> new distance values to be added.
>
> Yes, We should be able to detect this very easily.
> At the end of the function (v2 or v3) if cur_depth != max_depth then we
> havent initialized all possible node distances.

The only issue is what do we do when we detect that case?

We can't BUG/panic, because we don't know for sure that the offline
nodes will cause new distance values to be needed. So the system might
be completely fine, all we know is it might not be. If we print a scary
warning we'll end up with bugs filed for that.

cheers
