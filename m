Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40kvF45kMkzF2sF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 May 2018 18:36:40 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4E8Stps065495
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 May 2018 04:36:38 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2hy5sjbdup-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 May 2018 04:36:37 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Mon, 14 May 2018 02:36:37 -0600
Subject: Re: [PATCH] powerpc/perf: Fix memory allocation for core-imc based on
 num_possible_cpus()
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, maddy@linux.vnet.ibm.com, ppaidipe@linux.vnet.ibm.com
References: <1526046222-17842-1-git-send-email-anju@linux.vnet.ibm.com>
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Date: Mon, 14 May 2018 14:06:31 +0530
MIME-Version: 1.0
In-Reply-To: <1526046222-17842-1-git-send-email-anju@linux.vnet.ibm.com>
Content-Type: multipart/alternative;
 boundary="------------9E94C2E843902B21DFD0ABD9"
Message-Id: <fd7cab34-7ae9-f110-9eed-6746ad5b56ce@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------9E94C2E843902B21DFD0ABD9
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit



On Friday 11 May 2018 07:13 PM, Anju T Sudhakar wrote:
> Currently memory is allocated for core-imc based on cpu_present_mask, which has
> bit 'cpu' set iff cpu is populated. We use  (cpu number / threads per core)
> as as array index to access the memory.
> So in a system with guarded cores, since allocation happens based on
> cpu_present_mask, (cpu number / threads per core) bounds the index and leads
> to memory overflow.
>
> The issue is exposed in a guard test.
> The guard test will make some CPU's as un-available to the system during boot
> time as well as at runtime. So when the cpu is unavailable to the system during
> boot time, the memory allocation happens depending on the number of available
> cpus. And when we access the memory using (cpu number / threads per core) as the
> index the system crashes due to memory overflow.
>
> Allocating memory for core-imc based on cpu_possible_mask, which has
> bit 'cpu' set iff cpu is populatable, will fix this issue.
>
> Reported-by: Pridhiviraj Paidipeddi <ppaidipe@linux.vnet.ibm.com>
> Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>

Cc: <stable@vger.kernel.org> # v4.14 +

> ---
>   arch/powerpc/perf/imc-pmu.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
> index d7532e7..75fb23c 100644
> --- a/arch/powerpc/perf/imc-pmu.c
> +++ b/arch/powerpc/perf/imc-pmu.c
> @@ -1146,7 +1146,7 @@ static int init_nest_pmu_ref(void)
>
>   static void cleanup_all_core_imc_memory(void)
>   {
> -	int i, nr_cores = DIV_ROUND_UP(num_present_cpus(), threads_per_core);
> +	int i, nr_cores = DIV_ROUND_UP(num_possible_cpus(), threads_per_core);
>   	struct imc_mem_info *ptr = core_imc_pmu->mem_info;
>   	int size = core_imc_pmu->counter_mem_size;
>
> @@ -1264,7 +1264,7 @@ static int imc_mem_init(struct imc_pmu *pmu_ptr, struct device_node *parent,
>   		if (!pmu_ptr->pmu.name)
>   			return -ENOMEM;
>
> -		nr_cores = DIV_ROUND_UP(num_present_cpus(), threads_per_core);
> +		nr_cores = DIV_ROUND_UP(num_possible_cpus(), threads_per_core);
>   		pmu_ptr->mem_info = kcalloc(nr_cores, sizeof(struct imc_mem_info),
>   								GFP_KERNEL);
>


--------------9E94C2E843902B21DFD0ABD9
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p><br>
    </p>
    <br>
    <div class="moz-cite-prefix">On Friday 11 May 2018 07:13 PM, Anju T
      Sudhakar wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:1526046222-17842-1-git-send-email-anju@linux.vnet.ibm.com">
      <pre wrap="">Currently memory is allocated for core-imc based on cpu_present_mask, which has
bit 'cpu' set iff cpu is populated. We use  (cpu number / threads per core)
as as array index to access the memory.
So in a system with guarded cores, since allocation happens based on
cpu_present_mask, (cpu number / threads per core) bounds the index and leads
to memory overflow.

The issue is exposed in a guard test.
The guard test will make some CPU's as un-available to the system during boot
time as well as at runtime. So when the cpu is unavailable to the system during
boot time, the memory allocation happens depending on the number of available
cpus. And when we access the memory using (cpu number / threads per core) as the
index the system crashes due to memory overflow.

Allocating memory for core-imc based on cpu_possible_mask, which has
bit 'cpu' set iff cpu is populatable, will fix this issue.

Reported-by: Pridhiviraj Paidipeddi <a class="moz-txt-link-rfc2396E" href="mailto:ppaidipe@linux.vnet.ibm.com">&lt;ppaidipe@linux.vnet.ibm.com&gt;</a>
Signed-off-by: Anju T Sudhakar <a class="moz-txt-link-rfc2396E" href="mailto:anju@linux.vnet.ibm.com">&lt;anju@linux.vnet.ibm.com&gt;</a></pre>
    </blockquote>
    <br>
    Cc: <a class="moz-txt-link-rfc2396E"
      href="mailto:stable@vger.kernel.org">&lt;stable@vger.kernel.org&gt;</a>
    # v4.14 +<br>
    <br>
    <blockquote type="cite"
      cite="mid:1526046222-17842-1-git-send-email-anju@linux.vnet.ibm.com">
      <pre wrap="">
---
 arch/powerpc/perf/imc-pmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index d7532e7..75fb23c 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -1146,7 +1146,7 @@ static int init_nest_pmu_ref(void)

 static void cleanup_all_core_imc_memory(void)
 {
-	int i, nr_cores = DIV_ROUND_UP(num_present_cpus(), threads_per_core);
+	int i, nr_cores = DIV_ROUND_UP(num_possible_cpus(), threads_per_core);
 	struct imc_mem_info *ptr = core_imc_pmu-&gt;mem_info;
 	int size = core_imc_pmu-&gt;counter_mem_size;

@@ -1264,7 +1264,7 @@ static int imc_mem_init(struct imc_pmu *pmu_ptr, struct device_node *parent,
 		if (!pmu_ptr-&gt;pmu.name)
 			return -ENOMEM;

-		nr_cores = DIV_ROUND_UP(num_present_cpus(), threads_per_core);
+		nr_cores = DIV_ROUND_UP(num_possible_cpus(), threads_per_core);
 		pmu_ptr-&gt;mem_info = kcalloc(nr_cores, sizeof(struct imc_mem_info),
 								GFP_KERNEL);

</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------9E94C2E843902B21DFD0ABD9--
