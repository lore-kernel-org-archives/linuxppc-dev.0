Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wnRvB3twszDqL0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 10:13:58 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5E0DQnq122585
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 20:13:55 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b2tc8r2x6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 20:13:55 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 13 Jun 2017 18:13:54 -0600
Date: Tue, 13 Jun 2017 17:13:50 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 7/8] powerpc/perf/hv-24x7: Support v2 of the hypervisor API
References: <1496350947-30951-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1496350947-30951-8-git-send-email-bauerman@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1496350947-30951-8-git-send-email-bauerman@linux.vnet.ibm.com>
Message-Id: <20170614001350.GB12998@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thiago Jung Bauermann [bauerman@linux.vnet.ibm.com] wrote:
> POWER9 introduces a new version of the hypervisor API to access the 24x7
> perf counters. The new version changed some of the structures used for
> requests and results.
> 
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> ---
>  arch/powerpc/perf/hv-24x7.c            | 145 +++++++++++++++++++++++++++------
>  arch/powerpc/perf/hv-24x7.h            |  59 ++++++++++++--
>  arch/powerpc/platforms/pseries/Kconfig |   2 +-
>  3 files changed, 173 insertions(+), 33 deletions(-)
> 
> diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
> index 043cbc78be98..95c44f1d2fd2 100644
> --- a/arch/powerpc/perf/hv-24x7.c
> +++ b/arch/powerpc/perf/hv-24x7.c
> @@ -18,6 +18,7 @@
>  #include <linux/slab.h>
>  #include <linux/vmalloc.h>
> 
> +#include <asm/cputhreads.h>
>  #include <asm/firmware.h>
>  #include <asm/hvcall.h>
>  #include <asm/io.h>
> @@ -27,6 +28,9 @@
>  #include "hv-24x7-catalog.h"
>  #include "hv-common.h"
> 
> +/* Version of the 24x7 hypervisor API that we should use in this machine. */
> +static int interface_version;
> +
>  static bool domain_is_valid(unsigned domain)
>  {
>  	switch (domain) {
> @@ -74,7 +78,11 @@ static const char *domain_name(unsigned domain)
> 
>  static bool catalog_entry_domain_is_valid(unsigned domain)
>  {
> -	return is_physical_domain(domain);
> +	/* POWER8 doesn't support virtual domains. */
> +	if (interface_version == 1)
> +		return is_physical_domain(domain);
> +	else
> +		return domain_is_valid(domain);
>  }
> 
>  /*
> @@ -166,9 +174,12 @@ DEFINE_PER_CPU(struct hv_24x7_hw, hv_24x7_hw);
>  DEFINE_PER_CPU(char, hv_24x7_reqb[H24x7_DATA_BUFFER_SIZE]) __aligned(4096);
>  DEFINE_PER_CPU(char, hv_24x7_resb[H24x7_DATA_BUFFER_SIZE]) __aligned(4096);
> 
> -#define MAX_NUM_REQUESTS	((H24x7_DATA_BUFFER_SIZE -		       \
> +#define MAX_NUM_REQUESTS_V1	((H24x7_DATA_BUFFER_SIZE -		       \
> +					sizeof(struct hv_24x7_request_buffer)) \
> +					/ H24x7_REQUEST_SIZE_V1)
> +#define MAX_NUM_REQUESTS_V2	((H24x7_DATA_BUFFER_SIZE -		       \
>  					sizeof(struct hv_24x7_request_buffer)) \
> -					/ sizeof(struct hv_24x7_request))
> +					/ H24x7_REQUEST_SIZE_V2)

Nit: Can we define MAX_NUM_REQUESTS(version) - with a version parameter ? It
will...
> 
>  static char *event_name(struct hv_24x7_event_data *ev, int *len)
>  {
> @@ -1052,7 +1063,7 @@ static void init_24x7_request(struct hv_24x7_request_buffer *request_buffer,
>  	memset(request_buffer, 0, H24x7_DATA_BUFFER_SIZE);
>  	memset(result_buffer, 0, H24x7_DATA_BUFFER_SIZE);
> 
> -	request_buffer->interface_version = HV_24X7_IF_VERSION_CURRENT;
> +	request_buffer->interface_version = interface_version;
>  	/* memset above set request_buffer->num_requests to 0 */
>  }
> 
> @@ -1077,7 +1088,7 @@ static int make_24x7_request(struct hv_24x7_request_buffer *request_buffer,
>  	if (ret) {
>  		struct hv_24x7_request *req;
> 
> -		req = &request_buffer->requests[0];
> +		req = request_buffer->requests;
>  		pr_notice_ratelimited("hcall failed: [%d %#x %#x %d] => ret 0x%lx (%ld) detail=0x%x failing ix=%x\n",
>  				      req->performance_domain, req->data_offset,
>  				      req->starting_ix, req->starting_lpar_ix,
> @@ -1101,9 +1112,13 @@ static int add_event_to_24x7_request(struct perf_event *event,
>  {
>  	u16 idx;
>  	int i;
> +	size_t req_size;
>  	struct hv_24x7_request *req;
> 
> -	if (request_buffer->num_requests >= MAX_NUM_REQUESTS) {
> +	if ((request_buffer->interface_version == 1
> +	     && request_buffer->num_requests >= MAX_NUM_REQUESTS_V1)
> +	    || (request_buffer->interface_version > 1
> +		&& request_buffer->num_requests >= MAX_NUM_REQUESTS_V2)) {
>  		pr_devel("Too many requests for 24x7 HCALL %d\n",

...simplify this check to

	if (request->buffer->num_requests >= MAX_NUM_REQUESTS(version))

>  				request_buffer->num_requests);
>  		return -EINVAL;
> @@ -1120,8 +1135,11 @@ static int add_event_to_24x7_request(struct perf_event *event,
>  		idx = event_get_vcpu(event);
>  	}
> 
> +	req_size = request_buffer->interface_version == 1 ?
> +			   H24x7_REQUEST_SIZE_V1 : H24x7_REQUEST_SIZE_V2;
> +

Maybe similarly, with H24x7_REQUEST_SIZE(version) ?

>  	i = request_buffer->num_requests++;
> -	req = &request_buffer->requests[i];
> +	req = (void *) request_buffer->requests + i * req_size;
> 
>  	req->performance_domain = event_get_domain(event);
>  	req->data_size = cpu_to_be16(8);
> @@ -1131,14 +1149,97 @@ static int add_event_to_24x7_request(struct perf_event *event,
>  	req->starting_ix = cpu_to_be16(idx);
>  	req->max_ix = cpu_to_be16(1);
> 
> +	if (request_buffer->interface_version > 1 &&
> +	    req->performance_domain != HV_PERF_DOMAIN_PHYS_CHIP) {
> +		req->starting_thread_group_ix = idx % 2;
> +		req->max_num_thread_groups = 1;
> +	}
> +
>  	return 0;
>  }
> 
> +/**
> + * get_count_from_result - get event count from the given result
> + *
> + * @event:	Event associated with @res.
> + * @resb:	Result buffer containing @res.
> + * @res:	Result to work on.
> + * @countp:	Output variable containing the event count.
> + * @next:	Optional output variable pointing to the next result in @resb.
> + */
> +static int get_count_from_result(struct perf_event *event,
> +				 struct hv_24x7_data_result_buffer *resb,
> +				 struct hv_24x7_result *res, u64 *countp,
> +				 struct hv_24x7_result **next)
> +{
> +	u16 num_elements = be16_to_cpu(res->num_elements_returned);
> +	u16 data_size = be16_to_cpu(res->result_element_data_size);
> +	unsigned int data_offset;
> +	void *element_data;
> +	int ret = 0;
> +
> +	/*
> +	 * We can bail out early if the result is empty.
> +	 */
> +	if (!num_elements) {
> +		pr_debug("Result of request %hhu is empty, nothing to do\n",
> +			 res->result_ix);
> +
> +		if (next)
> +			*next = (struct hv_24x7_result *) res->elements;
> +
> +		return -ENODATA;
> +	}
> +
> +	/*
> +	 * This code assumes that a result has only one element.
> +	 */
> +	if (num_elements != 1) {
> +		pr_debug("Error: result of request %hhu has %hu elements\n",
> +			 res->result_ix, num_elements);

Could this happen due to an user request or would this indicate a bug
in the way we submitted the request (perf should submit separate request
for each lpar/index - we set ->max_ix and ->max_num_lpars to cpu_be16(1).

Minor inconsistency with proceeding, is that if the next element passes,
this return code is lost/over written. IOW, h_24x7_event_commit_txn()'s
return value depends on the last element we process, even if intermediate
ones encounter an error.

> +
> +		if (!next)
> +			return -ENOTSUPP;
> +
> +		/*
> +		 * We still need to go through the motions so that we can return
> +		 * a pointer to the next result.
> +		 */
> +		ret = -ENOTSUPP;
> +	}
> +
> +	if (data_size != sizeof(u64)) {
> +		pr_debug("Error: result of request %hhu has data of %hu bytes\n",
> +			 res->result_ix, data_size);
> +
> +		if (!next)
> +			return -ENOTSUPP;
> +
> +		ret = -ENOTSUPP;
> +	}
> +
> +	if (resb->interface_version == 1)
> +		data_offset = offsetof(struct hv_24x7_result_element_v1,
> +				       element_data);
> +	else
> +		data_offset = offsetof(struct hv_24x7_result_element_v2,
> +				       element_data);
> +
> +	element_data = res->elements + data_offset;
> +
> +	if (!ret)
> +		*countp = be64_to_cpu(*((u64 *) element_data));
> +
> +	/* The next result is after the result element. */
> +	if (next)
> +		*next = element_data + data_size;
> +
> +	return ret;
> +}
> +
>  static int single_24x7_request(struct perf_event *event, u64 *count)
>  {
>  	int ret;
> -	u16 num_elements;
> -	struct hv_24x7_result *result;
>  	struct hv_24x7_request_buffer *request_buffer;
>  	struct hv_24x7_data_result_buffer *result_buffer;
> 
> @@ -1158,14 +1259,9 @@ static int single_24x7_request(struct perf_event *event, u64 *count)
>  	if (ret)
>  		goto out;
> 
> -	result = result_buffer->results;
> -
> -	/* This code assumes that a result has only one element. */
> -	num_elements = be16_to_cpu(result->num_elements_returned);
> -	WARN_ON_ONCE(num_elements != 1);
> -
>  	/* process result from hcall */
> -	*count = be64_to_cpu(result->elements[0].element_data[0]);
> +	ret = get_count_from_result(event, result_buffer,
> +				    result_buffer->results, count, NULL);
> 
>  out:
>  	put_cpu_var(hv_24x7_reqb);
> @@ -1425,16 +1521,13 @@ static int h_24x7_event_commit_txn(struct pmu *pmu)
>  	for (i = 0, res = result_buffer->results;
>  	     i < result_buffer->num_results; i++, res = next_res) {
>  		struct perf_event *event = h24x7hw->events[res->result_ix];
> -		u16 num_elements = be16_to_cpu(res->num_elements_returned);
> -		u16 data_size = be16_to_cpu(res->result_element_data_size);
> 
> -		/* This code assumes that a result has only one element. */
> -		WARN_ON_ONCE(num_elements != 1);
> +		ret = get_count_from_result(event, result_buffer, res, &count,
> +					    &next_res);
> +		if (ret)
> +			continue;
> 
> -		count = be64_to_cpu(res->elements[0].element_data[0]);
>  		update_event_count(event, count);
> -
> -		next_res = (void *) res->elements[0].element_data + data_size;
>  	}
> 
>  	put_cpu_var(hv_24x7_hw);
> @@ -1486,6 +1579,12 @@ static int hv_24x7_init(void)
>  		return -ENODEV;
>  	}
> 
> +	/* POWER8 only supports v1, while POWER9 only supports v2. */
> +	if (cpu_has_feature(CPU_FTR_ARCH_300))
> +		interface_version = 2;
> +	else
> +		interface_version = 1;
> +
>  	hret = hv_perf_caps_get(&caps);
>  	if (hret) {
>  		pr_debug("could not obtain capabilities, not enabling, rc=%ld\n",
> diff --git a/arch/powerpc/perf/hv-24x7.h b/arch/powerpc/perf/hv-24x7.h
> index b95909400b2a..149af6e9538f 100644
> --- a/arch/powerpc/perf/hv-24x7.h
> +++ b/arch/powerpc/perf/hv-24x7.h
> @@ -10,6 +10,9 @@ enum hv_perf_domains {
>  	HV_PERF_DOMAIN_MAX,
>  };
> 
> +#define H24x7_REQUEST_SIZE_V1	16
> +#define H24x7_REQUEST_SIZE_V2	32
> +
>  struct hv_24x7_request {
>  	/* PHYSICAL domains require enabling via phyp/hmc. */
>  	__u8 performance_domain;
> @@ -42,19 +45,47 @@ struct hv_24x7_request {
>  	/* chip, core, or virtual processor based on @performance_domain */
>  	__be16 starting_ix;
>  	__be16 max_ix;
> +
> +	/* The following fields were added in v2 of the 24x7 interface. */
> +
> +	__u8 starting_thread_group_ix;
> +
> +	/* -1 means all thread groups starting at @starting_thread_group_ix */
> +	__u8 max_num_thread_groups;
> +
> +	__u8 reserved2[0xE];
>  } __packed;
> 
>  struct hv_24x7_request_buffer {
>  	/* 0 - ? */
>  	/* 1 - ? */
> -#define HV_24X7_IF_VERSION_CURRENT 0x01
>  	__u8 interface_version;
>  	__u8 num_requests;
>  	__u8 reserved[0xE];
> -	struct hv_24x7_request requests[1];
> +	struct hv_24x7_request requests[];
> +} __packed;
> +
> +struct hv_24x7_result_element_v1 {
> +	__be16 lpar_ix;
> +
> +	/*
> +	 * represents the core, chip, or virtual processor based on the
> +	 * request's @performance_domain
> +	 */
> +	__be16 domain_ix;
> +
> +	/* -1 if @performance_domain does not refer to a virtual processor */
> +	__be32 lpar_cfg_instance_id;
> +
> +	/* size = @result_element_data_size of containing result. */
> +	__u64 element_data[];
>  } __packed;
> 
> -struct hv_24x7_result_element {
> +/*
> + * We need a separate struct for v2 because the offset of @element_data changed
> + * between versions.
> + */
> +struct hv_24x7_result_element_v2 {
>  	__be16 lpar_ix;
> 
>  	/*
> @@ -66,8 +97,12 @@ struct hv_24x7_result_element {
>  	/* -1 if @performance_domain does not refer to a virtual processor */
>  	__be32 lpar_cfg_instance_id;
> 
> +	__u8 thread_group_ix;
> +
> +	__u8 reserved[7];
> +
>  	/* size = @result_element_data_size of containing result. */
> -	__u64 element_data[1];
> +	__u64 element_data[];
>  } __packed;
> 
>  struct hv_24x7_result {
> @@ -94,10 +129,16 @@ struct hv_24x7_result {
>  	__be16 result_element_data_size;
>  	__u8 reserved[0x2];
> 
> -	/* WARNING: only valid for first result element due to variable sizes
> -	 *          of result elements */
> -	/* struct hv_24x7_result_element[@num_elements_returned] */
> -	struct hv_24x7_result_element elements[1];
> +	/*
> +	 * Either
> +	 *	struct hv_24x7_result_element_v1[@num_elements_returned]
> +	 * or
> +	 *	struct hv_24x7_result_element_v2[@num_elements_returned]
> +	 *
> +	 * depending on the interface_version field of the
> +	 * struct hv_24x7_data_result_buffer containing this result.
> +	 */
> +	char elements[];
>  } __packed;
> 
>  struct hv_24x7_data_result_buffer {
> @@ -113,7 +154,7 @@ struct hv_24x7_data_result_buffer {
>  	__u8 reserved2[0x8];
>  	/* WARNING: only valid for the first result due to variable sizes of
>  	 *	    results */
> -	struct hv_24x7_result results[1]; /* [@num_results] */
> +	struct hv_24x7_result results[]; /* [@num_results] */
>  } __packed;
> 
>  #endif
> diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
> index 913c54e23eea..3a6dfd14f64b 100644
> --- a/arch/powerpc/platforms/pseries/Kconfig
> +++ b/arch/powerpc/platforms/pseries/Kconfig
> @@ -124,7 +124,7 @@ config HV_PERF_CTRS
>  	  Enable access to hypervisor supplied counters in perf. Currently,
>  	  this enables code that uses the hcall GetPerfCounterInfo and 24x7
>  	  interfaces to retrieve counters. GPCI exists on Power 6 and later
> -	  systems. 24x7 is available on Power 8 systems.
> +	  systems. 24x7 is available on Power 8 and later systems.
> 
>            If unsure, select Y.
> 
> -- 
> 2.7.4
