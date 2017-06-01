Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wdjYK1vk8zDqBQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Jun 2017 20:01:41 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v519xSI5007949
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Jun 2017 06:01:34 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2at85qy4hd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Jun 2017 06:01:33 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Thu, 1 Jun 2017 20:01:30 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v51A1Iet2163164
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Jun 2017 20:01:26 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v51A0j0A018667
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Jun 2017 20:00:47 +1000
Subject: Re: [PATCH v2] powerpc/fadump: return error when fadump registration
 fails
To: Michal Suchanek <msuchanek@suse.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Colin Ian King <colin.king@canonical.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20170527154615.29684-1-msuchanek@suse.de>
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Thu, 1 Jun 2017 15:30:27 +0530
MIME-Version: 1.0
In-Reply-To: <20170527154615.29684-1-msuchanek@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <94a13143-542f-8894-234f-755248f21c77@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Saturday 27 May 2017 09:16 PM, Michal Suchanek wrote:
>   - log an error message when registration fails and no error code listed
>   in the switch is returned
>   - translate the hv error code to posix error code and return it from
>   fw_register
>   - return the posix error code from fw_register to the process writing
>   to sysfs
>   - return EEXIST on re-registration
>   - return success on deregistration when fadump is not registered
>   - return ENODEV when no memory is reserved for fadump
>
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>

With the below change write to /sys/kernel/fadump_registered returns 
error appropriately.

Tested-by: Hari Bathini <hbathini@linux.vnet.ibm.com>

> ---
> v2: fix return in register_fadump()
> ---
>   arch/powerpc/kernel/fadump.c | 24 ++++++++++++++++--------
>   1 file changed, 16 insertions(+), 8 deletions(-)
>
> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
> index 2fa582092d42..83421e0a774b 100644
> --- a/arch/powerpc/kernel/fadump.c
> +++ b/arch/powerpc/kernel/fadump.c
> @@ -398,9 +398,9 @@ static int __init early_fadump_param(char *p)
>   }
>   early_param("fadump", early_fadump_param);
>
> -static void register_fw_dump(struct fadump_mem_struct *fdm)
> +static int register_fw_dump(struct fadump_mem_struct *fdm)
>   {
> -	int rc;
> +	int rc, err;
>   	unsigned int wait_time;
>
>   	pr_debug("Registering for firmware-assisted kernel dump...\n");
> @@ -417,7 +417,12 @@ static void register_fw_dump(struct fadump_mem_struct *fdm)
>
>   	} while (wait_time);
>
> +	err = -EIO;
>   	switch (rc) {
> +	default:
> +		printk(KERN_ERR "Failed to register firmware-assisted kernel"
> +			" dump. Unknown Error(%d).\n", rc);
> +		break;
>   	case -1:
>   		printk(KERN_ERR "Failed to register firmware-assisted kernel"
>   			" dump. Hardware Error(%d).\n", rc);
> @@ -425,18 +430,22 @@ static void register_fw_dump(struct fadump_mem_struct *fdm)
>   	case -3:
>   		printk(KERN_ERR "Failed to register firmware-assisted kernel"
>   			" dump. Parameter Error(%d).\n", rc);
> +		err = -EINVAL;
>   		break;
>   	case -9:
>   		printk(KERN_ERR "firmware-assisted kernel dump is already "
>   			" registered.");
>   		fw_dump.dump_registered = 1;
> +		err = -EEXIST;
>   		break;
>   	case 0:
>   		printk(KERN_INFO "firmware-assisted kernel dump registration"
>   			" is successful\n");
>   		fw_dump.dump_registered = 1;
> +		err = 0;
>   		break;
>   	}
> +	return err;
>   }
>
>   void crash_fadump(struct pt_regs *regs, const char *str)
> @@ -977,7 +986,7 @@ static unsigned long init_fadump_header(unsigned long addr)
>   	return addr;
>   }
>
> -static void register_fadump(void)
> +static int register_fadump(void)
>   {
>   	unsigned long addr;
>   	void *vaddr;
> @@ -987,7 +996,7 @@ static void register_fadump(void)
>   	 * assisted dump.
>   	 */
>   	if (!fw_dump.reserve_dump_area_size)
> -		return;
> +		return -ENODEV;
>
>   	fadump_setup_crash_memory_ranges();
>
> @@ -1000,7 +1009,7 @@ static void register_fadump(void)
>   	fadump_create_elfcore_headers(vaddr);
>
>   	/* register the future kernel dump with firmware. */
> -	register_fw_dump(&fdm);
> +	return register_fw_dump(&fdm);
>   }
>
>   static int fadump_unregister_dump(struct fadump_mem_struct *fdm)
> @@ -1182,7 +1191,6 @@ static ssize_t fadump_register_store(struct kobject *kobj,
>   	switch (buf[0]) {
>   	case '0':
>   		if (fw_dump.dump_registered == 0) {
> -			ret = -EINVAL;
>   			goto unlock_out;
>   		}
>   		/* Un-register Firmware-assisted dump */
> @@ -1190,11 +1198,11 @@ static ssize_t fadump_register_store(struct kobject *kobj,
>   		break;
>   	case '1':
>   		if (fw_dump.dump_registered == 1) {
> -			ret = -EINVAL;
> +			ret = -EEXIST;
>   			goto unlock_out;
>   		}
>   		/* Register Firmware-assisted dump */
> -		register_fadump();
> +		ret = register_fadump();
>   		break;
>   	default:
>   		ret = -EINVAL;
