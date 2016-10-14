Return-Path: <arbab@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3swX1l5J8czDt2y
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Oct 2016 02:43:23 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9EFeKrt031156
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2016 11:43:21 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 262w62fx0n-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2016 11:43:20 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <arbab@linux.vnet.ibm.com>;
 Fri, 14 Oct 2016 09:43:20 -0600
Date: Fri, 14 Oct 2016 10:43:15 -0500
From: Reza Arbab <arbab@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/mm: simplify loop control in
 parse_numa_properties()
References: <1476384330-22654-1-git-send-email-arbab@linux.vnet.ibm.com>
 <87bmynepmf.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <87bmynepmf.fsf@concordia.ellerman.id.au>
Message-Id: <20161014154314.yestsvr2dgufdyvt@arbab-laptop.austin.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 14, 2016 at 11:33:12AM +1100, Michael Ellerman wrote:
>Reza Arbab <arbab@linux.vnet.ibm.com> writes:
>> The flow of the main loop in parse_numa_properties() is overly
>> complicated. Simplify it to be less confusing and easier to read.
>> No functional change.
>
>I think you're right, but it's not obvious from the diff. Please explain
>in more detail why the old and new code is equivalent.

I'm not sure if being this verbose helps, but...

The end of the main loop in parse_numa_properties() looks like this:

	for_each_node_by_type(...) {
		...

		if (!condition) {
			if (--ranges)
				goto new_range;
			else
				continue;
		}

		statement();

		if (--ranges)
			goto new_range;
		/* else
		 *	continue; <- implicit, this is the end of the loop
		 */
	}


The only effect of !condition is to skip execution of statement(). This can be
rewritten in a simpler way:

	for_each_node_by_type(...) {
		...

		if (condition)
			statement();

		if (--ranges)
			goto new_range;
	}

-- 
Reza Arbab
