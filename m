Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2437A1A0779
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 06:06:04 +1000 (AEST)
Received: from /spool/local
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Thu, 13 Aug 2015 16:06:02 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 3974338C8052
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2015 16:05:58 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7DK5wiS56950916
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2015 20:05:58 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7DK5vV3019442
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2015 16:05:57 -0400
Date: Thu, 13 Aug 2015 13:04:28 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org
Subject: Re: [PATCH 09/10] Define PERF_PMU_TXN_READ interface
Message-ID: <20150813200428.GA19057@us.ibm.com>
References: <1437975638-789-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1437975638-789-10-git-send-email-sukadev@linux.vnet.ibm.com>
 <20150806121029.GQ19282@twins.programming.kicks-ass.net>
 <20150812041400.GA28426@us.ibm.com>
 <20150812084545.GR16853@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150812084545.GR16853@twins.programming.kicks-ass.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Peter Zijlstra [peterz@infradead.org] wrote:
| On Tue, Aug 11, 2015 at 09:14:00PM -0700, Sukadev Bhattiprolu wrote:
| > | +static void __perf_read_group_add(struct perf_event *leader, u64 read_format, u64 *values)
| > |  {
| > | +	struct perf_event *sub;
| > | +	int n = 1; /* skip @nr */
| > 
| > This n = 1 is to skip over the values[0] = 1 + nr_siblings in the
| > caller.
| > 
| > Anyway, in __perf_read_group_add() we always start with n = 1, however
| > ...
| > | 
| > | +	perf_event_read(leader, true);
| > | +
| > | +	/*
| > | +	 * Since we co-schedule groups, {enabled,running} times of siblings
| > | +	 * will be identical to those of the leader, so we only publish one
| > | +	 * set.
| > | +	 */
| > | +	if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED) {
| > | +		values[n++] += leader->total_time_enabled +
| > | +			atomic64_read(leader->child_total_time_enabled);
| 
| Note how this is an in-place addition,

Ah, yes, Sorry I missed that. It make sense now and my tests seem to
be running fine.

| 
| > | +	}
| > | 
| > | +	if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING) {
| > | +		values[n++] += leader->total_time_running +
| > | +			atomic64_read(leader->child_total_time_running);
| 
| and here,
| 
| > | +	}
| > | 
| > | +	/*
| > | +	 * Write {count,id} tuples for every sibling.
| > | +	 */
| > | +	values[n++] += perf_event_count(leader);
| 
| and here,
| 
| 
| > |  	if (read_format & PERF_FORMAT_ID)
| > |  		values[n++] = primary_event_id(leader);
| 
| and this will always assign the same value.
| 
| > | +	list_for_each_entry(sub, &leader->sibling_list, group_entry) {
| > | +		values[n++] += perf_event_count(sub);
| > | +		if (read_format & PERF_FORMAT_ID)
| > | +			values[n++] = primary_event_id(sub);
| 
| Same for these, therefore,
| 
| > | +	}
| > | +}
| > | 
| > | +static int perf_read_group(struct perf_event *event,
| > | +				   u64 read_format, char __user *buf)
| > | +{
| > | +	struct perf_event *leader = event->group_leader, *child;
| > | +	struct perf_event_context *ctx = leader->ctx;
| > | +	int ret = leader->read_size;

One other question, We return leader->read_size but allocate/copy_to_user
the sibling's event->read_size. We consistently use read_format from the
'event' being read, rather than its 'group_leader', so we are ok in terms
of what we copy into values[] for each event in the group.

But, can the leader's read_format (and hence its read_size) differ from
its sibling's read_size? If so, in the current code, we return the event's
read_size but in the new code, we return the leader's read_size.

| > | +	u64 *values;
| > | 
| > | +	lockdep_assert_held(&ctx->mutex);
| > | 
| > | +	values = kzalloc(event->read_size);
| > | +	if (!values)
| > | +		return -ENOMEM;
| > | 
| > | +	values[0] = 1 + leader->nr_siblings;
| > | 
| > | +	/*
| > | +	 * By locking the child_mutex of the leader we effectively
| > | +	 * lock the child list of all siblings.. XXX explain how.
| > | +	 */
| > | +	mutex_lock(&leader->child_mutex);
| > | 
| > | +	__perf_read_group_add(leader, read_format, values);
| > 
| > ... we don't copy_to_user() here,
| > 
| > | +	list_for_each_entry(child, &leader->child_list, child_list)
| > | +		__perf_read_group_add(child, read_format, values);
| > 
| > so won't we overwrite the values[], if we always start at n = 1
| > in __perf_read_group_add()?
| 
| yes and no, we have to re-iterate the same values for each child as they
| all have the same group, but we add the time and count fields, we do not
| overwrite. The _add() suffix was supposed to be a hint ;-)
| 
| > | +	mutex_unlock(&leader->child_mutex);
| > | +
| > | +	if (copy_to_user(buf, values, event->read_size))
| > | +		ret = -EFAULT;
| > | +
| > | +	kfree(values);
| > | 
| > |  	return ret;
| > |  }
| 
| Where previously we would iterate the group and for each member
| iterate/sum all the child values together before copying the value out,
| we now, because we need to read groups together, need to first iterate
| the child list and sum whole groups.
