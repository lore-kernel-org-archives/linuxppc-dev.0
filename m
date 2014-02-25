Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 79FA12C00D1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2014 18:59:07 +1100 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Tue, 25 Feb 2014 17:59:06 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id EEEDC2CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2014 18:59:01 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1P7d8x17405838
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2014 18:39:09 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1P7x0wT026400
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2014 18:59:01 +1100
Message-ID: <530C4D57.1030905@linux.vnet.ibm.com>
Date: Tue, 25 Feb 2014 13:29:19 +0530
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Cody P Schafer <cody@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc: warn users of smt-snooze-delay that the API
 isn't there anymore
References: <1393028074-26797-1-git-send-email-cody@linux.vnet.ibm.com>
In-Reply-To: <1393028074-26797-1-git-send-email-cody@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Wang Dongsheng <dongsheng.wang@freescale.com>, linux-kernel@vger.kernel.org,
 Paul Gortmaker <paul.gortmaker@windriver.com>,
 Paul Mackerras <paulus@samba.org>, Olof Johansson <olof@lixom.net>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/22/2014 05:44 AM, Cody P Schafer wrote:
> /sys/devices/system/cpu/cpu*/smt-snooze-delay was converted into a NOP
> in commit 3fa8cad82b94d0bed002571bd246f2299ffc876b, and now does
> nothing. Add a pr_warn() to convince any users that they should stop
> using it.
> 
> The commit message from the removing commit notes that this
> functionality should move into the cpuidle driver, essentially by
> adjusting target_residency to the specified value. At the moment,
> target_residency is not exposed by cpuidle's sysfs, so there isn't a
> drop in replacement for this.
> 
> Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>



smt-snooze-delay was used to delay an entry into NAP state
or disable NAP state completely. This was before we adopted cpuidle
framework for idle state management on powerpc. This is per-cpu based
tunable, where we could have cores with  different target residencies
and idle states.

Now that we have moved towards cpuidle framework, which provides a
better way of idle state management and this framework expects a single
target residency for all the cpus. We can no longer honour
smt-snooze-delay functionality of providing per-cpu target residency.
This was badly broken in the kernel before the patch to clean it up.
By removing this we would honour cpuidle framework through which we
carry out idle state management.

And generic cpuidle framework does not provide the flexibility to change
target residency on the go as there are multiple idle states supported
and trying to change target residency of one state (incorrectly) may
result in undefined behavior.

Also, the second functionality to disable/enable states can be done
using the cpuidle sysfs files. So this is functionality is preserved.

We currently do not use smt-snooze-delay in the kernel.
The sysfs entries needs to  be retained until we do a clean up ppc64_cpu
util that uses these entries to determine SMT,
clean up patch for this has already been posted out by Prerna.
Once, we have the ppc64_cpu changes in, we can look to clean up these
parts from the kernel.

Regards,
Deepthi





> ---
>  arch/powerpc/kernel/sysfs.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
> index 97e1dc9..84097b4 100644
> --- a/arch/powerpc/kernel/sysfs.c
> +++ b/arch/powerpc/kernel/sysfs.c
> @@ -50,6 +50,9 @@ static ssize_t store_smt_snooze_delay(struct device *dev,
>  	if (ret != 1)
>  		return -EINVAL;
>  
> +	pr_warn_ratelimited("%s (%d): /sys/devices/system/cpu/cpu%d/smt-snooze-delay is deprecated and is a NOP\n",
> +		  current->comm, task_pid_nr(current), cpu->dev.id);
> +
>  	per_cpu(smt_snooze_delay, cpu->dev.id) = snooze;
>  	return count;
>  }
> @@ -60,6 +63,9 @@ static ssize_t show_smt_snooze_delay(struct device *dev,
>  {
>  	struct cpu *cpu = container_of(dev, struct cpu, dev);
>  
> +	pr_warn_ratelimited("%s (%d): /sys/devices/system/cpu/cpu%d/smt-snooze-delay is deprecated and is a NOP\n",
> +		  current->comm, task_pid_nr(current), cpu->dev.id);
> +
>  	return sprintf(buf, "%ld\n", per_cpu(smt_snooze_delay, cpu->dev.id));
>  }
>  
> 
