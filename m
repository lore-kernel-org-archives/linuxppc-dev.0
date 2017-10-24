Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yLmmN0Dj6zDqZ3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Oct 2017 19:34:59 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9O8Ycw0136620
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Oct 2017 04:34:57 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dt0dhey0m-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Oct 2017 04:34:56 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Tue, 24 Oct 2017 02:34:55 -0600
Subject: Re: [PATCH] powerpc/perf: Fix IMC allocation routine
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <20171019194133.27485-1-gpiccoli@linux.vnet.ibm.com>
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Date: Tue, 24 Oct 2017 14:04:49 +0530
MIME-Version: 1.0
In-Reply-To: <20171019194133.27485-1-gpiccoli@linux.vnet.ibm.com>
Content-Type: multipart/alternative;
 boundary="------------E6405BBCE3DBD5FE87689334"
Message-Id: <5d035de1-309b-3b3c-bbcb-9e28ae9422e3@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------E6405BBCE3DBD5FE87689334
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Guilherme,

Nice catch.

On Friday 20 October 2017 01:11 AM, Guilherme G. Piccoli wrote:
> When setting nr_cpus=1, we observed a crash in IMC code during boot
> due to a missing allocation: basically, IMC code is taking the number
> of threads into account in imc_mem_init() and if we manually set
> nr_cpus for a value that is not multiple of the number of threads per
> core, an integer division in that function will discard the decimal
> portion, leading IMC to not allocate one mem_info struct. This causes
> a NULL pointer dereference later, on is_core_imc_mem_inited().
>
> This patch just rounds that division up, fixing the bug.
>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
Acked-by:  Anju T Sudhakar <anju@linux.vnet.ibm.com>
> ---
> Anju, looks good to you? Tested in P9 with latest FW available.
>
>   arch/powerpc/perf/imc-pmu.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
> index 88126245881b..92ae5de0bbac 100644
> --- a/arch/powerpc/perf/imc-pmu.c
> +++ b/arch/powerpc/perf/imc-pmu.c
> @@ -1104,7 +1104,7 @@ static int init_nest_pmu_ref(void)
>
>   static void cleanup_all_core_imc_memory(void)
>   {
> -	int i, nr_cores = num_present_cpus() / threads_per_core;
> +	int i, nr_cores = DIV_ROUND_UP(num_present_cpus(), threads_per_core);
>   	struct imc_mem_info *ptr = core_imc_pmu->mem_info;
>   	int size = core_imc_pmu->counter_mem_size;
>
> @@ -1212,7 +1212,7 @@ static int imc_mem_init(struct imc_pmu *pmu_ptr, struct device_node *parent,
>   		if (!pmu_ptr->pmu.name)
>   			return -ENOMEM;
>
> -		nr_cores = num_present_cpus() / threads_per_core;
> +		nr_cores = DIV_ROUND_UP(num_present_cpus(), threads_per_core);
>   		pmu_ptr->mem_info = kcalloc(nr_cores, sizeof(struct imc_mem_info),
>   								GFP_KERNEL);
>

Thanks,
Anju

--------------E6405BBCE3DBD5FE87689334
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>Hi Guilherme,</p>
    Nice catch.<br>
    <br>
    <div class="moz-cite-prefix">On Friday 20 October 2017 01:11 AM,
      Guilherme G. Piccoli wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20171019194133.27485-1-gpiccoli@linux.vnet.ibm.com">
      <pre wrap="">When setting nr_cpus=1, we observed a crash in IMC code during boot
due to a missing allocation: basically, IMC code is taking the number
of threads into account in imc_mem_init() and if we manually set
nr_cpus for a value that is not multiple of the number of threads per
core, an integer division in that function will discard the decimal
portion, leading IMC to not allocate one mem_info struct. This causes
a NULL pointer dereference later, on is_core_imc_mem_inited().

This patch just rounds that division up, fixing the bug.

Signed-off-by: Guilherme G. Piccoli <a class="moz-txt-link-rfc2396E" href="mailto:gpiccoli@linux.vnet.ibm.com">&lt;gpiccoli@linux.vnet.ibm.com&gt;</a></pre>
    </blockquote>
    Acked-by:  Anju T Sudhakar <a class="moz-txt-link-rfc2396E"
      href="mailto:anju@linux.vnet.ibm.com">&lt;anju@linux.vnet.ibm.com&gt;</a>
    <blockquote type="cite"
      cite="mid:20171019194133.27485-1-gpiccoli@linux.vnet.ibm.com">
      <pre wrap="">
---
Anju, looks good to you? Tested in P9 with latest FW available.

 arch/powerpc/perf/imc-pmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index 88126245881b..92ae5de0bbac 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -1104,7 +1104,7 @@ static int init_nest_pmu_ref(void)

 static void cleanup_all_core_imc_memory(void)
 {
-	int i, nr_cores = num_present_cpus() / threads_per_core;
+	int i, nr_cores = DIV_ROUND_UP(num_present_cpus(), threads_per_core);
 	struct imc_mem_info *ptr = core_imc_pmu-&gt;mem_info;
 	int size = core_imc_pmu-&gt;counter_mem_size;

@@ -1212,7 +1212,7 @@ static int imc_mem_init(struct imc_pmu *pmu_ptr, struct device_node *parent,
 		if (!pmu_ptr-&gt;pmu.name)
 			return -ENOMEM;

-		nr_cores = num_present_cpus() / threads_per_core;
+		nr_cores = DIV_ROUND_UP(num_present_cpus(), threads_per_core);
 		pmu_ptr-&gt;mem_info = kcalloc(nr_cores, sizeof(struct imc_mem_info),
 								GFP_KERNEL);

</pre>
    </blockquote>
    <br>
    Thanks,<br>
    Anju<br>
  </body>
</html>

--------------E6405BBCE3DBD5FE87689334--
