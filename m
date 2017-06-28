Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wycGz2LgvzDr4J
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 08:02:51 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5SLxEu6014745
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 18:02:48 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2bcj536bw8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 18:02:48 -0400
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Wed, 28 Jun 2017 19:02:46 -0300
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay04.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5SM2hxV3146234
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 19:02:43 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5SJ2hHM009612
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 16:02:44 -0300
References: <1496350947-30951-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <87injhd2h2.fsf@concordia.ellerman.id.au>
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/8] Support for 24x7 hcall interface version 2
In-reply-to: <87injhd2h2.fsf@concordia.ellerman.id.au>
Date: Wed, 28 Jun 2017 19:02:38 -0300
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87efu3db41.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Michael Ellerman <mpe@ellerman.id.au> writes:
> Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:
>> The hypervisor interface to access 24x7 performance counters (which collect
>> performance information from system power on to system power off) has been
>> extended in POWER9 adding new fields to the request and result element
>> structures.
>>
>> Also, results for some domains now return more than one result element and
>> those need to be added to get a total count.
>>
>> The first two patches fix bugs in the existing code. The following 4
>> patches are code improvements and the last two finally implement support
>> for the changes in POWER9 described above.
>>
>> POWER8 systems only support version 1 of the interface, while POWER9
>> systems only support version 2. I tested these patches on POWER8 to verify
>> that there are no regressions, and also on POWER9 DD1.
>
> Where is version 2 documented?

Only in an internal specification.

> And what happens when we boot on a POWER9 in POWER8 compatibility mode?

It will still use version 2 of the API, and still require aggregation of
result elements. Does this mean that hv_24x7_init should check
cur_cpu_spec->oprofile_cpu_type for "ppc64/power9" instead of
cpu_has_feature(CPU_FTR_ARCH_300)?

There were a couple of comments from Suka which still needed resolving:

Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com> writes:
> Thiago Jung Bauermann [bauerman@linux.vnet.ibm.com] wrote:
>> +/**
>> + * get_count_from_result - get event count from the given result
>> + *
>> + * @event:	Event associated with @res.
>> + * @resb:	Result buffer containing @res.
>> + * @res:	Result to work on.
>> + * @countp:	Output variable containing the event count.
>> + * @next:	Optional output variable pointing to the next result in @resb.
>> + */
>> +static int get_count_from_result(struct perf_event *event,
>> +				 struct hv_24x7_data_result_buffer *resb,
>> +				 struct hv_24x7_result *res, u64 *countp,
>> +				 struct hv_24x7_result **next)
>> +{
>> +	u16 num_elements = be16_to_cpu(res->num_elements_returned);
>> +	u16 data_size = be16_to_cpu(res->result_element_data_size);
>> +	unsigned int data_offset;
>> +	void *element_data;
>> +	int ret = 0;
>> +
>> +	/*
>> +	 * We can bail out early if the result is empty.
>> +	 */
>> +	if (!num_elements) {
>> +		pr_debug("Result of request %hhu is empty, nothing to do\n",
>> +			 res->result_ix);
>> +
>> +		if (next)
>> +			*next = (struct hv_24x7_result *) res->elements;
>> +
>> +		return -ENODATA;
>> +	}
>> +
>> +	/*
>> +	 * This code assumes that a result has only one element.
>> +	 */
>> +	if (num_elements != 1) {
>> +		pr_debug("Error: result of request %hhu has %hu elements\n",
>> +			 res->result_ix, num_elements);
>
> Could this happen due to an user request or would this indicate a bug
> in the way we submitted the request (perf should submit separate request
> for each lpar/index - we set ->max_ix and ->max_num_lpars to cpu_be16(1).

By specifying 1 as the maximum for the smallest resource we're
requesting, we guarantee one element per result. Since that's what we
do this would indeed be a bug. For v2 (which I'll send shortly) I
changed the message above to a pr_err, and changed the returned error to
-EIO instead of -ENOTSUPP.

> Minor inconsistency with proceeding, is that if the next element passes,
> this return code is lost/over written. IOW, h_24x7_event_commit_txn()'s
> return value depends on the last element we process, even if intermediate
> ones encounter an error.

For v2, I changed h_24x7_event_commit_txn to break out of the loop if
there's an error in any processed result. Also, since in that case @next
isn't used anymore, get_count_from_result will exit early instead of
going through the motions.

>> +
>> +		if (!next)
>> +			return -ENOTSUPP;
>> +
>> +		/*
>> +		 * We still need to go through the motions so that we can return
>> +		 * a pointer to the next result.
>> +		 */
>> +		ret = -ENOTSUPP;
>> +	}
>> +
>> +	if (data_size != sizeof(u64)) {
>> +		pr_debug("Error: result of request %hhu has data of %hu bytes\n",
>> +			 res->result_ix, data_size);
>> +
>> +		if (!next)
>> +			return -ENOTSUPP;
>> +
>> +		ret = -ENOTSUPP;
>> +	}
>> +
>> +	if (resb->interface_version == 1)
>> +		data_offset = offsetof(struct hv_24x7_result_element_v1,
>> +				       element_data);
>> +	else
>> +		data_offset = offsetof(struct hv_24x7_result_element_v2,
>> +				       element_data);
>> +
>> +	element_data = res->elements + data_offset;
>> +
>> +	if (!ret)
>> +		*countp = be64_to_cpu(*((u64 *) element_data));
>> +
>> +	/* The next result is after the result element. */
>> +	if (next)
>> +		*next = element_data + data_size;
>> +
>> +	return ret;
>> +}
>> +
>>  static int single_24x7_request(struct perf_event *event, u64 *count)
>>  {
>>  	int ret;
>> -	u16 num_elements;
>> -	struct hv_24x7_result *result;
>>  	struct hv_24x7_request_buffer *request_buffer;
>>  	struct hv_24x7_data_result_buffer *result_buffer;
>> 
>> @@ -1158,14 +1259,9 @@ static int single_24x7_request(struct perf_event *event, u64 *count)
>>  	if (ret)
>>  		goto out;
>> 
>> -	result = result_buffer->results;
>> -
>> -	/* This code assumes that a result has only one element. */
>> -	num_elements = be16_to_cpu(result->num_elements_returned);
>> -	WARN_ON_ONCE(num_elements != 1);
>> -
>>  	/* process result from hcall */
>> -	*count = be64_to_cpu(result->elements[0].element_data[0]);
>> +	ret = get_count_from_result(event, result_buffer,
>> +				    result_buffer->results, count, NULL);
>> 
>>  out:
>>  	put_cpu_var(hv_24x7_reqb);
>> @@ -1425,16 +1521,13 @@ static int h_24x7_event_commit_txn(struct pmu *pmu)
>>  	for (i = 0, res = result_buffer->results;
>>  	     i < result_buffer->num_results; i++, res = next_res) {
>>  		struct perf_event *event = h24x7hw->events[res->result_ix];
>> -		u16 num_elements = be16_to_cpu(res->num_elements_returned);
>> -		u16 data_size = be16_to_cpu(res->result_element_data_size);
>> 
>> -		/* This code assumes that a result has only one element. */
>> -		WARN_ON_ONCE(num_elements != 1);
>> +		ret = get_count_from_result(event, result_buffer, res, &count,
>> +					    &next_res);
>> +		if (ret)
>> +			continue;
>> 
>> -		count = be64_to_cpu(res->elements[0].element_data[0]);
>>  		update_event_count(event, count);
>> -
>> -		next_res = (void *) res->elements[0].element_data + data_size;
>>  	}
>> 
>>  	put_cpu_var(hv_24x7_hw);

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
