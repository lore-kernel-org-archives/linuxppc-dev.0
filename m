Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B23CD2C0098
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2014 15:54:08 +1100 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Tue, 25 Feb 2014 10:24:04 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 8C0133940058
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2014 10:24:00 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1P4rkLN8651084
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2014 10:23:46 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1P4rxCK026513
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2014 10:24:00 +0530
Message-ID: <530C21E6.5020106@linux.vnet.ibm.com>
Date: Tue, 25 Feb 2014 10:23:58 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Cody P Schafer <cody@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Olof Johansson <olof@lixom.net>,
 Paul Gortmaker <paul.gortmaker@windriver.com>,
 Wang Dongsheng <dongsheng.wang@freescale.com>
Subject: Re: [PATCH] powerpc: warn users of smt-snooze-delay that the API
 isn't there anymore
References: <1393028074-26797-1-git-send-email-cody@linux.vnet.ibm.com>
In-Reply-To: <1393028074-26797-1-git-send-email-cody@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Saturday 22 February 2014 05:44 AM, Cody P Schafer wrote:
> /sys/devices/system/cpu/cpu*/smt-snooze-delay was converted into a NOP
> in commit 3fa8cad82b94d0bed002571bd246f2299ffc876b, and now does
> nothing. Add a pr_warn() to convince any users that they should stop
> using it.
> 
> The commit message from the removing commit notes that this
> functionality should move into the cpuidle driver, essentially by

Would prefer to cleanup the code since the functionality is moved,
instead of adding to it.

> adjusting target_residency to the specified value. At the moment,
> target_residency is not exposed by cpuidle's sysfs, so there isn't a
> drop in replacement for this.
> 
> Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
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
