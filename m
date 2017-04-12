Return-Path: <srs0=0bou=3u=linux.vnet.ibm.com=hbathini@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3Fsh0QtczDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 06:30:16 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3w3Fsg6z1Lz8vNt
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 06:30:15 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3w3Fsg4H4Tz9sNH
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Apr 2017 06:30:15 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3CKSaxf128936
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Apr 2017 16:30:08 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29ssdkdc4r-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Apr 2017 16:30:08 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Thu, 13 Apr 2017 06:30:05 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3CKTt7T50331748
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Apr 2017 06:30:03 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3CKTUJm032739
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Apr 2017 06:29:31 +1000
Subject: Re: [PATCH v2 1/2] fadump: reduce memory consumption for capture
 kernel
To: Michael Ellerman <mpe@ellerman.id.au>
References: <148647105867.9464.16492047069430229118.stgit@hbathini.in.ibm.com>
 <878tnd7zim.fsf@concordia.ellerman.id.au>
 <d50dfb98-68ac-0135-8e65-560aec1d752e@linux.vnet.ibm.com>
 <87efx4gwk2.fsf@concordia.ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Thu, 13 Apr 2017 01:59:13 +0530
MIME-Version: 1.0
In-Reply-To: <87efx4gwk2.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <e1377bf8-e574-6ffa-6b63-3748a01dcdfa@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Friday 07 April 2017 07:16 PM, Michael Ellerman wrote:
> Hari Bathini <hbathini@linux.vnet.ibm.com> writes:
>> On Friday 07 April 2017 07:24 AM, Michael Ellerman wrote:
>>> My preference would be that the fadump kernel "just works". If it's
>>> using too much memory then the fadump kernel should do whatever it needs
>>> to use less memory, eg. shrinking nr_cpu_ids etc.
>>> Do we actually know *why* the fadump kernel is running out of memory?
>>> Obviously large numbers of CPUs is one of the main drivers (lots of
>>> stacks required). But other than that what is causing the memory
>>> pressure? I would like some data on that before we proceed.
>> Almost the same amount of memory in comparison with the memory
>> required to boot the production kernel but that is unwarranted for fadump
>> (dump capture) kernel.
> That's not data! :)
>
> The dump kernel is booted with *much* less memory than the production
> kernel (that's the whole issue!) and so it doesn't need to create struct
> pages for all that memory, which means it should need less memory.
>
> The vfs caches are also sized based on the available memory, so they
> should also shrink in the dump kernel.
>
> I want some actual numbers on what's driving the memory usage.
>
> I tried some of these parameters to see how much memory they would save:

Hi Michael,

Tried to get data to show parameters like numa=off & cgroup_disable=memory
matter too but parameter nr_cpus=1 is making parameters like numa=off,
cgroup_disable=memory insignificant. Also, these parameters not using much
of early memory reservations is making quantification of memory saved for
each of them that much more difficult. But I would still like to argue that
passing additional parameters to fadump is better than enforcing nr_cpus=1
in the kernel for:

   a) With makedumpfile tool supporting multi-threading it would make sense
      to leave the choice of how many CPUs to have, to the user.

   b) Parameters like udev.children-max=2 can help to reduce the number of
      parallel executed events bringing down the memory pressure on fadump
      kernel (when it is booted with more than one CPU).

   c) Ease of maintainability is better (considering any new kernel features
      with some memory to save or stability to gain on disabling, possible
      platform supports) with append approach over enforcing these 
parameters
      in the kernel.

   d) It would give user the flexibility to disable unwanted kernel features
      in fadump kernel (numa=off, cgroup_disable=memory). For every feature
      enabled in the production kernel, fadump kernel will have the 
choice to
      opt out of it, provided there is such cmdline option.

>> So, if parameters like
>> cgroup_disable=memory,
> 0 bytes saved.
>
>> transparent_hugepages=never,
> 0 bytes saved.
>
>> numa=off,
> 64KB saved.
>
>> nr_cpus=1,
> 3MB saved (vs 16 CPUs)
>

Hmmm... On a system with single core and 8GB memory, fadump kernel captures
dump successfully with 272MB passing nr_cpus=1 while it needed 320MB (+48MB)
to do the same without nr_cpus=1. So, while the early reservations saved 
is only a
couple of megabytes, it rubs off further in the boot process to reduce 
memory
consumption by nearly 50MB :)

> Now maybe on your system those do save memory for some reason, but
> please prove it to me. Otherwise I'm inclined to merge:
>
> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
> index 8ff0dd4e77a7..03f1f253c372 100644
> --- a/arch/powerpc/kernel/fadump.c
> +++ b/arch/powerpc/kernel/fadump.c
> @@ -79,8 +79,10 @@ int __init early_init_dt_scan_fw_dump(unsigned long node,
>   	 * dump data waiting for us.
>   	 */
>   	fdm_active = of_get_flat_dt_prop(node, "ibm,kernel-dump", NULL);
> -	if (fdm_active)
> +	if (fdm_active) {
>   		fw_dump.dump_active = 1;
> +		nr_cpu_ids = 1;
> +	}
>
>   	/* Get the sizes required to store dump data for the firmware provided
>   	 * dump sections.
>
>

Based on your suggestion, I am thinking of something like the below:

--
powerpc/fadump: reduce memory consumption for capture kernel

With fadump (dump capture) kernel booting like a regular kernel, it almost
needs the same amount of memory to boot as the production kernel, which is
unwarranted for a dump capture kernel. But with no option to disable some
of the unnecessary subsystems in fadump kernel, that much memory is wasted
on fadump, depriving the production kernel of that memory.

Introduce kernel parameter 'fadump_append=' that would take regular kernel
parameters as a comma separated list, to be enforced when fadump is active.
This 'fadump_append=' parameter can be leveraged to pass parameters like
nr_cpus=1, cgroup_disable=memory and numa=off, to disable unwarranted
resources/subsystems.

Also, ensure the log "Firmware-assisted dump is active" is printed early
in the boot process to put the subsequent fadump messages in context.

Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---
  arch/powerpc/kernel/fadump.c |   41 
++++++++++++++++++++++++++++++++++++++---
  1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index e013f8f..c4d4663 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -79,8 +79,10 @@ int __init early_init_dt_scan_fw_dump(unsigned long node,
       * dump data waiting for us.
       */
      fdm_active = of_get_flat_dt_prop(node, "ibm,kernel-dump", NULL);
-    if (fdm_active)
+    if (fdm_active) {
+        pr_info("Firmware-assisted dump is active.\n");
          fw_dump.dump_active = 1;
+    }

      /* Get the sizes required to store dump data for the firmware provided
       * dump sections.
@@ -263,8 +265,12 @@ int __init fadump_reserve_mem(void)
  {
      unsigned long base, size, memory_boundary;

-    if (!fw_dump.fadump_enabled)
+    if (!fw_dump.fadump_enabled) {
+        if (fw_dump.dump_active)
+            pr_warn("Firmware-assisted dump was active but kernel"
+                " booted with fadump disabled!\n");
          return 0;
+    }

      if (!fw_dump.fadump_supported) {
          printk(KERN_INFO "Firmware-assisted dump is not supported on"
@@ -304,7 +310,6 @@ int __init fadump_reserve_mem(void)
          memory_boundary = memblock_end_of_DRAM();

      if (fw_dump.dump_active) {
-        printk(KERN_INFO "Firmware-assisted dump is active.\n");
          /*
           * If last boot has crashed then reserve all the memory
           * above boot_memory_size so that we don't touch it until
@@ -359,6 +364,36 @@ static int __init early_fadump_param(char *p)
  }
  early_param("fadump", early_fadump_param);

+static void __init parse_fadump_append_params(const char *p)
+{
+    static char fadump_cmdline[COMMAND_LINE_SIZE] __initdata;
+    char *token;
+
+    strlcpy(fadump_cmdline, p, COMMAND_LINE_SIZE);
+    token = strchr(fadump_cmdline, ',');
+    while (token) {
+        *token = ' ';
+        token = strchr(token, ',');
+    }
+
+    pr_info("enforcing additional parameters (%s) passed through "
+        "'fadump_append=' parameter\n", fadump_cmdline);
+    parse_early_options(fadump_cmdline);
+}
+
+/* Look for fadump_append= cmdline option. */
+static int __init early_fadump_append_param(char *p)
+{
+    if (!p)
+        return 1;
+
+    if (fw_dump.dump_active)
+        parse_fadump_append_params(p);
+
+    return 0;
+}
+early_param("fadump_append", early_fadump_append_param);
+
  static void register_fw_dump(struct fadump_mem_struct *fdm)
  {
      int rc;


Thanks
Hari
