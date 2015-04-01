Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3BB6B1A0631
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Apr 2015 15:52:16 +1100 (AEDT)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 1 Apr 2015 10:22:13 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id ECCE6E0045
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Apr 2015 10:24:29 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t314q95941156674
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Apr 2015 10:22:09 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t314q9ej022896
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Apr 2015 10:22:09 +0530
Message-ID: <551B7978.8040502@linux.vnet.ibm.com>
Date: Wed, 01 Apr 2015 10:22:08 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Joel Stanley <joel@jms.id.au>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] kernel/reboot.c: Add orderly_reboot for graceful
 reboot
References: <1427681733-25488-1-git-send-email-joel@jms.id.au>
In-Reply-To: <1427681733-25488-1-git-send-email-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8
Cc: fabf@skynet.be, akpm@linux-foundation.org, rusty@rustcorp.com.au,
 jk@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/30/2015 07:45 AM, Joel Stanley wrote:
> The kernel has orderly_poweroff which allows the kernel to initiate a
> graceful shutdown of userspace, by running /sbin/poweroff. This adds
> orderly_reboot that will cause userspace to shut itself down by calling
> /sbin/reboot.
> 
> This will be used for shutdown initiated by a system controller on
> platforms that do not use ACPI.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  include/linux/reboot.h |  1 +
>  kernel/reboot.c        | 51 +++++++++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 49 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/reboot.h b/include/linux/reboot.h
> index 48bf152..a4ffcd9 100644
> --- a/include/linux/reboot.h
> +++ b/include/linux/reboot.h
> @@ -68,6 +68,7 @@ void ctrl_alt_del(void);
>  extern char poweroff_cmd[POWEROFF_CMD_PATH_LEN];
>  
>  extern int orderly_poweroff(bool force);
> +extern int orderly_reboot(void);
>  
>  /*
>   * Emergency restart, callable from an interrupt handler.
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index a3a9e24..d0aa1ec 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -306,8 +306,9 @@ void ctrl_alt_del(void)
>  }
>  
>  char poweroff_cmd[POWEROFF_CMD_PATH_LEN] = "/sbin/poweroff";
> +char reboot_cmd[POWEROFF_CMD_PATH_LEN] = "/sbin/reboot";

Should not we declare one more REBOOT_CMD_PATH_LEN to make it cleaner.

>  
> -static int __orderly_poweroff(bool force)
> +static int run_cmd(const char *cmd)
>  {
>  	char **argv;
>  	static char *envp[] = {
> @@ -316,8 +317,7 @@ static int __orderly_poweroff(bool force)
>  		NULL
>  	};
>  	int ret;
> -
> -	argv = argv_split(GFP_KERNEL, poweroff_cmd, NULL);
> +	argv = argv_split(GFP_KERNEL, cmd, NULL);
>  	if (argv) {
>  		ret = call_usermodehelper(argv[0], argv, envp, UMH_WAIT_EXEC);
>  		argv_free(argv);
> @@ -325,8 +325,33 @@ static int __orderly_poweroff(bool force)
>  		ret = -ENOMEM;
>  	}
>  
> +	return ret;
> +}
> +
> +static int __orderly_reboot(void)
> +{
> +	int ret;
> +
> +	ret = run_cmd(reboot_cmd);
> +
> +	if (ret) {
> +		pr_warn("Failed to start orderly reboot: forcing the issue\n");
> +		emergency_sync();
> +		kernel_restart(NULL);
> +	}
> +
> +	return ret;
> +}
> +
> +static int __orderly_poweroff(bool force)
> +{
> +	int ret;
> +
> +	ret = run_cmd(reboot_cmd);

Would it be poweroff_cmd instead of reboot_cmd ? Dont see poweroff_cmd getting used.
