Return-Path: <tlfalcon@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2AADD1A0182
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Sep 2014 01:14:38 +1000 (EST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tlfalcon@linux.vnet.ibm.com>;
 Mon, 8 Sep 2014 09:14:34 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 94CBD19D803F
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Sep 2014 09:14:19 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s88FEWRx23527588
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Sep 2014 17:14:32 +0200
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s88FEWIk018609
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Sep 2014 09:14:32 -0600
Received: from dhcp-9-41-106-149.austin.ibm.com (sig-9-65-81-151.mts.ibm.com
 [9.65.81.151])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 s88FESTN018269
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Sep 2014 09:14:29 -0600
Message-ID: <540DC7D3.60603@linux.vnet.ibm.com>
Date: Mon, 08 Sep 2014 10:14:27 -0500
From: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] pseries: Fix endianness in cpu hotplug and hotremove
References: <1409944146-6813-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
 <540DB82D.9070403@linux.vnet.ibm.com>
In-Reply-To: <540DB82D.9070403@linux.vnet.ibm.com>
Content-Type: multipart/alternative;
 boundary="------------070503040505080703090708"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------070503040505080703090708
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I guess we were both working on it independently.  I had made the 
changes to hotplug a cpu a few weeks ago, but was blocked on removing a 
cpu.  Last week I realized what was blocking me and fixed cpu removal, 
so I sent the patch along.  Since Bharata has already submitted a patch 
that will handle hotplugging, I'll resubmit this with only the changes 
needed to remove a cpu.

Tom

On 09/08/2014 09:07 AM, Nathan Fontenot wrote:
> It looks like you have a lot of the same changes as the patch Bharata
> sent out last week. Including the one issue I saw in Bharata's patch
> below.
>
> On 09/05/2014 02:09 PM, Thomas Falcon wrote:
>> This patch attempts to ensure that all values are in the proper
>> endianness format when both hotadding and hotremoving cpus.
>>
>> Signed-off-by: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
>> ---
>>   arch/powerpc/platforms/pseries/dlpar.c       | 56 ++++++++++++++--------------
>>   arch/powerpc/platforms/pseries/hotplug-cpu.c | 20 +++++-----
>>   2 files changed, 38 insertions(+), 38 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
>> index a2450b8..c1d7e40 100644
>> --- a/arch/powerpc/platforms/pseries/dlpar.c
>> +++ b/arch/powerpc/platforms/pseries/dlpar.c
>> @@ -24,11 +24,11 @@
>>   #include <asm/rtas.h>
>>   
>>   struct cc_workarea {
>> -	u32	drc_index;
>> -	u32	zero;
>> -	u32	name_offset;
>> -	u32	prop_length;
>> -	u32	prop_offset;
>> +	__be32	drc_index;
>> +	__be32	zero;
>> +	__be32	name_offset;
>> +	__be32	prop_length;
>> +	__be32	prop_offset;
>>   };
>>   
>>   void dlpar_free_cc_property(struct property *prop)
>> @@ -48,11 +48,11 @@ static struct property *dlpar_parse_cc_property(struct cc_workarea *ccwa)
>>   	if (!prop)
>>   		return NULL;
>>   
>> -	name = (char *)ccwa + ccwa->name_offset;
>> +	name = (char *)ccwa + be32_to_cpu(ccwa->name_offset);
>>   	prop->name = kstrdup(name, GFP_KERNEL);
>>   
>> -	prop->length = ccwa->prop_length;
>> -	value = (char *)ccwa + ccwa->prop_offset;
>> +	prop->length = be32_to_cpu(ccwa->prop_length);
>> +	value = (char *)ccwa + be32_to_cpu(ccwa->prop_offset);
>>   	prop->value = kmemdup(value, prop->length, GFP_KERNEL);
>>   	if (!prop->value) {
>>   		dlpar_free_cc_property(prop);
>> @@ -78,7 +78,7 @@ static struct device_node *dlpar_parse_cc_node(struct cc_workarea *ccwa,
>>   	if (!dn)
>>   		return NULL;
>>   
>> -	name = (char *)ccwa + ccwa->name_offset;
>> +	name = (char *)ccwa + be32_to_cpu(ccwa->name_offset);
>>   	dn->full_name = kasprintf(GFP_KERNEL, "%s/%s", path, name);
>>   	if (!dn->full_name) {
>>   		kfree(dn);
>> @@ -148,7 +148,7 @@ struct device_node *dlpar_configure_connector(u32 drc_index,
>>   		return NULL;
>>   
>>   	ccwa = (struct cc_workarea *)&data_buf[0];
>> -	ccwa->drc_index = drc_index;
>> +	ccwa->drc_index = cpu_to_be32(drc_index);
> This will break partition migration.
>
> The drc index valued passed into dlpar_configure_connector() from the migration
> path, pseries_devicetree_update(), is already in BE format.
>
> -Nathan
>
>>   	ccwa->zero = 0;
>>   
>>   	do {
>> @@ -363,10 +363,10 @@ static int dlpar_online_cpu(struct device_node *dn)
>>   	int rc = 0;
>>   	unsigned int cpu;
>>   	int len, nthreads, i;
>> -	const u32 *intserv;
>> +	const __be32 *intserv_be;
>>   
>> -	intserv = of_get_property(dn, "ibm,ppc-interrupt-server#s", &len);
>> -	if (!intserv)
>> +	intserv_be = of_get_property(dn, "ibm,ppc-interrupt-server#s", &len);
>> +	if (!intserv_be)
>>   		return -EINVAL;
>>   
>>   	nthreads = len / sizeof(u32);
>> @@ -374,7 +374,7 @@ static int dlpar_online_cpu(struct device_node *dn)
>>   	cpu_maps_update_begin();
>>   	for (i = 0; i < nthreads; i++) {
>>   		for_each_present_cpu(cpu) {
>> -			if (get_hard_smp_processor_id(cpu) != intserv[i])
>> +			if (get_hard_smp_processor_id(cpu) != be32_to_cpu(intserv_be[i]))
>>   				continue;
>>   			BUG_ON(get_cpu_current_state(cpu)
>>   					!= CPU_STATE_OFFLINE);
>> @@ -388,7 +388,7 @@ static int dlpar_online_cpu(struct device_node *dn)
>>   		}
>>   		if (cpu == num_possible_cpus())
>>   			printk(KERN_WARNING "Could not find cpu to online "
>> -			       "with physical id 0x%x\n", intserv[i]);
>> +			       "with physical id 0x%x\n", be32_to_cpu(intserv_be[i]));
>>   	}
>>   	cpu_maps_update_done();
>>   
>> @@ -442,18 +442,17 @@ static int dlpar_offline_cpu(struct device_node *dn)
>>   	int rc = 0;
>>   	unsigned int cpu;
>>   	int len, nthreads, i;
>> -	const u32 *intserv;
>> +	const __be32 *intserv_be;
>>   
>> -	intserv = of_get_property(dn, "ibm,ppc-interrupt-server#s", &len);
>> -	if (!intserv)
>> +	intserv_be = of_get_property(dn, "ibm,ppc-interrupt-server#s", &len);
>> +	if (!intserv_be)
>>   		return -EINVAL;
>>   
>>   	nthreads = len / sizeof(u32);
>> -
>>   	cpu_maps_update_begin();
>>   	for (i = 0; i < nthreads; i++) {
>>   		for_each_present_cpu(cpu) {
>> -			if (get_hard_smp_processor_id(cpu) != intserv[i])
>> +			if (get_hard_smp_processor_id(cpu) != be32_to_cpu(intserv_be[i]))
>>   				continue;
>>   
>>   			if (get_cpu_current_state(cpu) == CPU_STATE_OFFLINE)
>> @@ -469,20 +468,19 @@ static int dlpar_offline_cpu(struct device_node *dn)
>>   				break;
>>   
>>   			}
>> -
>>   			/*
>>   			 * The cpu is in CPU_STATE_INACTIVE.
>>   			 * Upgrade it's state to CPU_STATE_OFFLINE.
>>   			 */
>>   			set_preferred_offline_state(cpu, CPU_STATE_OFFLINE);
>> -			BUG_ON(plpar_hcall_norets(H_PROD, intserv[i])
>> +			BUG_ON(plpar_hcall_norets(H_PROD, be32_to_cpu(intserv_be[i]))
>>   								!= H_SUCCESS);
>>   			__cpu_die(cpu);
>>   			break;
>>   		}
>>   		if (cpu == num_possible_cpus())
>>   			printk(KERN_WARNING "Could not find cpu to offline "
>> -			       "with physical id 0x%x\n", intserv[i]);
>> +			       "with physical id 0x%x\n", be32_to_cpu(intserv_be[i]));
>>   	}
>>   	cpu_maps_update_done();
>>   
>> @@ -494,26 +492,28 @@ out:
>>   static ssize_t dlpar_cpu_release(const char *buf, size_t count)
>>   {
>>   	struct device_node *dn;
>> -	const u32 *drc_index;
>> +	const __be32 *drc_index_be;
>> +	u32 drc_index;
>>   	int rc;
>>   
>>   	dn = of_find_node_by_path(buf);
>>   	if (!dn)
>>   		return -EINVAL;
>>   
>> -	drc_index = of_get_property(dn, "ibm,my-drc-index", NULL);
>> -	if (!drc_index) {
>> +	drc_index_be = of_get_property(dn, "ibm,my-drc-index", NULL);
>> +	if (!drc_index_be) {
>>   		of_node_put(dn);
>>   		return -EINVAL;
>>   	}
>>   
>> +	drc_index = be32_to_cpup(drc_index_be);
>>   	rc = dlpar_offline_cpu(dn);
>>   	if (rc) {
>>   		of_node_put(dn);
>>   		return -EINVAL;
>>   	}
>>   
>> -	rc = dlpar_release_drc(*drc_index);
>> +	rc = dlpar_release_drc(drc_index);
>>   	if (rc) {
>>   		of_node_put(dn);
>>   		return rc;
>> @@ -521,7 +521,7 @@ static ssize_t dlpar_cpu_release(const char *buf, size_t count)
>>   
>>   	rc = dlpar_detach_node(dn);
>>   	if (rc) {
>> -		dlpar_acquire_drc(*drc_index);
>> +		dlpar_acquire_drc(drc_index);
>>   		return rc;
>>   	}
>>   
>> diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
>> index 20d6297..fc9c2cd 100644
>> --- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
>> +++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
>> @@ -90,7 +90,7 @@ static void rtas_stop_self(void)
>>   {
>>   	static struct rtas_args args = {
>>   		.nargs = 0,
>> -		.nret = 1,
>> +		.nret = cpu_to_be32(1),
>>   		.rets = &args.args[0],
>>   	};
>>   
>> @@ -247,10 +247,10 @@ static int pseries_add_processor(struct device_node *np)
>>   	unsigned int cpu;
>>   	cpumask_var_t candidate_mask, tmp;
>>   	int err = -ENOSPC, len, nthreads, i;
>> -	const u32 *intserv;
>> +	const __be32 *intserv_be;
>>   
>> -	intserv = of_get_property(np, "ibm,ppc-interrupt-server#s", &len);
>> -	if (!intserv)
>> +	intserv_be = of_get_property(np, "ibm,ppc-interrupt-server#s", &len);
>> +	if (!intserv_be)
>>   		return 0;
>>   
>>   	zalloc_cpumask_var(&candidate_mask, GFP_KERNEL);
>> @@ -293,7 +293,7 @@ static int pseries_add_processor(struct device_node *np)
>>   	for_each_cpu(cpu, tmp) {
>>   		BUG_ON(cpu_present(cpu));
>>   		set_cpu_present(cpu, true);
>> -		set_hard_smp_processor_id(cpu, *intserv++);
>> +		set_hard_smp_processor_id(cpu, be32_to_cpu(*intserv_be++));
>>   	}
>>   	err = 0;
>>   out_unlock:
>> @@ -312,10 +312,10 @@ static void pseries_remove_processor(struct device_node *np)
>>   {
>>   	unsigned int cpu;
>>   	int len, nthreads, i;
>> -	const u32 *intserv;
>> +	const __be32 *intserv_be;
>>   
>> -	intserv = of_get_property(np, "ibm,ppc-interrupt-server#s", &len);
>> -	if (!intserv)
>> +	intserv_be = of_get_property(np, "ibm,ppc-interrupt-server#s", &len);
>> +	if (!intserv_be)
>>   		return;
>>   
>>   	nthreads = len / sizeof(u32);
>> @@ -323,7 +323,7 @@ static void pseries_remove_processor(struct device_node *np)
>>   	cpu_maps_update_begin();
>>   	for (i = 0; i < nthreads; i++) {
>>   		for_each_present_cpu(cpu) {
>> -			if (get_hard_smp_processor_id(cpu) != intserv[i])
>> +			if (get_hard_smp_processor_id(cpu) != be32_to_cpu(intserv_be[i]))
>>   				continue;
>>   			BUG_ON(cpu_online(cpu));
>>   			set_cpu_present(cpu, false);
>> @@ -332,7 +332,7 @@ static void pseries_remove_processor(struct device_node *np)
>>   		}
>>   		if (cpu >= nr_cpu_ids)
>>   			printk(KERN_WARNING "Could not find cpu to remove "
>> -			       "with physical id 0x%x\n", intserv[i]);
>> +			       "with physical id 0x%x\n", be32_to_cpu(intserv_be[i]));
>>   	}
>>   	cpu_maps_update_done();
>>   }
>>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

-- 


--------------070503040505080703090708
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <font size="-1"><tt>I guess we were both working on it
        independently.  I had made the changes to hotplug a cpu a few
        weeks ago, but was blocked on removing a cpu.  Last week I
        realized what was blocking me and fixed cpu removal, so I sent
        the patch along.  Since Bharata has already submitted a patch
        that will handle hotplugging, I'll resubmit this with only the
        changes needed to remove a cpu.  <br>
        <br>
        Tom<br>
        <br>
      </tt></font>
    <div class="moz-cite-prefix">On 09/08/2014 09:07 AM, Nathan Fontenot
      wrote:<br>
    </div>
    <blockquote cite="mid:540DB82D.9070403@linux.vnet.ibm.com"
      type="cite">
      <pre wrap="">It looks like you have a lot of the same changes as the patch Bharata
sent out last week. Including the one issue I saw in Bharata's patch
below.

On 09/05/2014 02:09 PM, Thomas Falcon wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">This patch attempts to ensure that all values are in the proper
endianness format when both hotadding and hotremoving cpus.

Signed-off-by: Thomas Falcon <a class="moz-txt-link-rfc2396E" href="mailto:tlfalcon@linux.vnet.ibm.com">&lt;tlfalcon@linux.vnet.ibm.com&gt;</a>
---
 arch/powerpc/platforms/pseries/dlpar.c       | 56 ++++++++++++++--------------
 arch/powerpc/platforms/pseries/hotplug-cpu.c | 20 +++++-----
 2 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index a2450b8..c1d7e40 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -24,11 +24,11 @@
 #include &lt;asm/rtas.h&gt;
 
 struct cc_workarea {
-	u32	drc_index;
-	u32	zero;
-	u32	name_offset;
-	u32	prop_length;
-	u32	prop_offset;
+	__be32	drc_index;
+	__be32	zero;
+	__be32	name_offset;
+	__be32	prop_length;
+	__be32	prop_offset;
 };
 
 void dlpar_free_cc_property(struct property *prop)
@@ -48,11 +48,11 @@ static struct property *dlpar_parse_cc_property(struct cc_workarea *ccwa)
 	if (!prop)
 		return NULL;
 
-	name = (char *)ccwa + ccwa-&gt;name_offset;
+	name = (char *)ccwa + be32_to_cpu(ccwa-&gt;name_offset);
 	prop-&gt;name = kstrdup(name, GFP_KERNEL);
 
-	prop-&gt;length = ccwa-&gt;prop_length;
-	value = (char *)ccwa + ccwa-&gt;prop_offset;
+	prop-&gt;length = be32_to_cpu(ccwa-&gt;prop_length);
+	value = (char *)ccwa + be32_to_cpu(ccwa-&gt;prop_offset);
 	prop-&gt;value = kmemdup(value, prop-&gt;length, GFP_KERNEL);
 	if (!prop-&gt;value) {
 		dlpar_free_cc_property(prop);
@@ -78,7 +78,7 @@ static struct device_node *dlpar_parse_cc_node(struct cc_workarea *ccwa,
 	if (!dn)
 		return NULL;
 
-	name = (char *)ccwa + ccwa-&gt;name_offset;
+	name = (char *)ccwa + be32_to_cpu(ccwa-&gt;name_offset);
 	dn-&gt;full_name = kasprintf(GFP_KERNEL, "%s/%s", path, name);
 	if (!dn-&gt;full_name) {
 		kfree(dn);
@@ -148,7 +148,7 @@ struct device_node *dlpar_configure_connector(u32 drc_index,
 		return NULL;
 
 	ccwa = (struct cc_workarea *)&amp;data_buf[0];
-	ccwa-&gt;drc_index = drc_index;
+	ccwa-&gt;drc_index = cpu_to_be32(drc_index);
</pre>
      </blockquote>
      <pre wrap="">
This will break partition migration.

The drc index valued passed into dlpar_configure_connector() from the migration
path, pseries_devicetree_update(), is already in BE format.

-Nathan

</pre>
      <blockquote type="cite">
        <pre wrap=""> 	ccwa-&gt;zero = 0;
 
 	do {
@@ -363,10 +363,10 @@ static int dlpar_online_cpu(struct device_node *dn)
 	int rc = 0;
 	unsigned int cpu;
 	int len, nthreads, i;
-	const u32 *intserv;
+	const __be32 *intserv_be;
 
-	intserv = of_get_property(dn, "ibm,ppc-interrupt-server#s", &amp;len);
-	if (!intserv)
+	intserv_be = of_get_property(dn, "ibm,ppc-interrupt-server#s", &amp;len);
+	if (!intserv_be)
 		return -EINVAL;
 
 	nthreads = len / sizeof(u32);
@@ -374,7 +374,7 @@ static int dlpar_online_cpu(struct device_node *dn)
 	cpu_maps_update_begin();
 	for (i = 0; i &lt; nthreads; i++) {
 		for_each_present_cpu(cpu) {
-			if (get_hard_smp_processor_id(cpu) != intserv[i])
+			if (get_hard_smp_processor_id(cpu) != be32_to_cpu(intserv_be[i]))
 				continue;
 			BUG_ON(get_cpu_current_state(cpu)
 					!= CPU_STATE_OFFLINE);
@@ -388,7 +388,7 @@ static int dlpar_online_cpu(struct device_node *dn)
 		}
 		if (cpu == num_possible_cpus())
 			printk(KERN_WARNING "Could not find cpu to online "
-			       "with physical id 0x%x\n", intserv[i]);
+			       "with physical id 0x%x\n", be32_to_cpu(intserv_be[i]));
 	}
 	cpu_maps_update_done();
 
@@ -442,18 +442,17 @@ static int dlpar_offline_cpu(struct device_node *dn)
 	int rc = 0;
 	unsigned int cpu;
 	int len, nthreads, i;
-	const u32 *intserv;
+	const __be32 *intserv_be;
 
-	intserv = of_get_property(dn, "ibm,ppc-interrupt-server#s", &amp;len);
-	if (!intserv)
+	intserv_be = of_get_property(dn, "ibm,ppc-interrupt-server#s", &amp;len);
+	if (!intserv_be)
 		return -EINVAL;
 
 	nthreads = len / sizeof(u32);
-
 	cpu_maps_update_begin();
 	for (i = 0; i &lt; nthreads; i++) {
 		for_each_present_cpu(cpu) {
-			if (get_hard_smp_processor_id(cpu) != intserv[i])
+			if (get_hard_smp_processor_id(cpu) != be32_to_cpu(intserv_be[i]))
 				continue;
 
 			if (get_cpu_current_state(cpu) == CPU_STATE_OFFLINE)
@@ -469,20 +468,19 @@ static int dlpar_offline_cpu(struct device_node *dn)
 				break;
 
 			}
-
 			/*
 			 * The cpu is in CPU_STATE_INACTIVE.
 			 * Upgrade it's state to CPU_STATE_OFFLINE.
 			 */
 			set_preferred_offline_state(cpu, CPU_STATE_OFFLINE);
-			BUG_ON(plpar_hcall_norets(H_PROD, intserv[i])
+			BUG_ON(plpar_hcall_norets(H_PROD, be32_to_cpu(intserv_be[i]))
 								!= H_SUCCESS);
 			__cpu_die(cpu);
 			break;
 		}
 		if (cpu == num_possible_cpus())
 			printk(KERN_WARNING "Could not find cpu to offline "
-			       "with physical id 0x%x\n", intserv[i]);
+			       "with physical id 0x%x\n", be32_to_cpu(intserv_be[i]));
 	}
 	cpu_maps_update_done();
 
@@ -494,26 +492,28 @@ out:
 static ssize_t dlpar_cpu_release(const char *buf, size_t count)
 {
 	struct device_node *dn;
-	const u32 *drc_index;
+	const __be32 *drc_index_be;
+	u32 drc_index;
 	int rc;
 
 	dn = of_find_node_by_path(buf);
 	if (!dn)
 		return -EINVAL;
 
-	drc_index = of_get_property(dn, "ibm,my-drc-index", NULL);
-	if (!drc_index) {
+	drc_index_be = of_get_property(dn, "ibm,my-drc-index", NULL);
+	if (!drc_index_be) {
 		of_node_put(dn);
 		return -EINVAL;
 	}
 
+	drc_index = be32_to_cpup(drc_index_be);
 	rc = dlpar_offline_cpu(dn);
 	if (rc) {
 		of_node_put(dn);
 		return -EINVAL;
 	}
 
-	rc = dlpar_release_drc(*drc_index);
+	rc = dlpar_release_drc(drc_index);
 	if (rc) {
 		of_node_put(dn);
 		return rc;
@@ -521,7 +521,7 @@ static ssize_t dlpar_cpu_release(const char *buf, size_t count)
 
 	rc = dlpar_detach_node(dn);
 	if (rc) {
-		dlpar_acquire_drc(*drc_index);
+		dlpar_acquire_drc(drc_index);
 		return rc;
 	}
 
diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index 20d6297..fc9c2cd 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -90,7 +90,7 @@ static void rtas_stop_self(void)
 {
 	static struct rtas_args args = {
 		.nargs = 0,
-		.nret = 1,
+		.nret = cpu_to_be32(1),
 		.rets = &amp;args.args[0],
 	};
 
@@ -247,10 +247,10 @@ static int pseries_add_processor(struct device_node *np)
 	unsigned int cpu;
 	cpumask_var_t candidate_mask, tmp;
 	int err = -ENOSPC, len, nthreads, i;
-	const u32 *intserv;
+	const __be32 *intserv_be;
 
-	intserv = of_get_property(np, "ibm,ppc-interrupt-server#s", &amp;len);
-	if (!intserv)
+	intserv_be = of_get_property(np, "ibm,ppc-interrupt-server#s", &amp;len);
+	if (!intserv_be)
 		return 0;
 
 	zalloc_cpumask_var(&amp;candidate_mask, GFP_KERNEL);
@@ -293,7 +293,7 @@ static int pseries_add_processor(struct device_node *np)
 	for_each_cpu(cpu, tmp) {
 		BUG_ON(cpu_present(cpu));
 		set_cpu_present(cpu, true);
-		set_hard_smp_processor_id(cpu, *intserv++);
+		set_hard_smp_processor_id(cpu, be32_to_cpu(*intserv_be++));
 	}
 	err = 0;
 out_unlock:
@@ -312,10 +312,10 @@ static void pseries_remove_processor(struct device_node *np)
 {
 	unsigned int cpu;
 	int len, nthreads, i;
-	const u32 *intserv;
+	const __be32 *intserv_be;
 
-	intserv = of_get_property(np, "ibm,ppc-interrupt-server#s", &amp;len);
-	if (!intserv)
+	intserv_be = of_get_property(np, "ibm,ppc-interrupt-server#s", &amp;len);
+	if (!intserv_be)
 		return;
 
 	nthreads = len / sizeof(u32);
@@ -323,7 +323,7 @@ static void pseries_remove_processor(struct device_node *np)
 	cpu_maps_update_begin();
 	for (i = 0; i &lt; nthreads; i++) {
 		for_each_present_cpu(cpu) {
-			if (get_hard_smp_processor_id(cpu) != intserv[i])
+			if (get_hard_smp_processor_id(cpu) != be32_to_cpu(intserv_be[i]))
 				continue;
 			BUG_ON(cpu_online(cpu));
 			set_cpu_present(cpu, false);
@@ -332,7 +332,7 @@ static void pseries_remove_processor(struct device_node *np)
 		}
 		if (cpu &gt;= nr_cpu_ids)
 			printk(KERN_WARNING "Could not find cpu to remove "
-			       "with physical id 0x%x\n", intserv[i]);
+			       "with physical id 0x%x\n", be32_to_cpu(intserv_be[i]));
 	}
 	cpu_maps_update_done();
 }

</pre>
      </blockquote>
      <pre wrap="">
_______________________________________________
Linuxppc-dev mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Linuxppc-dev@lists.ozlabs.org">Linuxppc-dev@lists.ozlabs.org</a>
<a class="moz-txt-link-freetext" href="https://lists.ozlabs.org/listinfo/linuxppc-dev">https://lists.ozlabs.org/listinfo/linuxppc-dev</a></pre>
    </blockquote>
    <br>
    <pre class="moz-signature" cols="72">-- 

</pre>
  </body>
</html>

--------------070503040505080703090708--
