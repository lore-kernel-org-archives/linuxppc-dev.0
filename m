Return-Path: <zhongjiang@huawei.com>
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41qL1S6TfwzF0Qs
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Aug 2018 14:57:16 +1000 (AEST)
Message-ID: <5B726124.5030308@huawei.com>
Date: Tue, 14 Aug 2018 12:57:08 +0800
From: zhong jiang <zhongjiang@huawei.com>
MIME-Version: 1.0
To: Joe Perches <golf@perches.com>
CC: <tony.luck@intel.com>, <fenghua.yu@intel.com>, <benh@kernel.crashing.org>,
 <paulus@samba.org>, <mpe@ellerman.id.au>, <oleg@redhat.com>,
 <rppt@linux.vnet.ibm.com>, <dhowells@redhat.com>,
 <akpm@linux-foundation.org>, <viro@zeniv.linux.org.uk>,
 <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 1/2] ia64: Use ARRAY_SIZE to replace its implementation
References: <1534214814-9043-1-git-send-email-zhongjiang@huawei.com>
 <1534214814-9043-2-git-send-email-zhongjiang@huawei.com>
 <81ae2b1b7ea395217dbf3494457a232bdfdc79c5.camel@perches.com>
In-Reply-To: <81ae2b1b7ea395217dbf3494457a232bdfdc79c5.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2018/8/14 12:45, Joe Perches wrote:
> On Tue, 2018-08-14 at 10:46 +0800, zhong jiang wrote:
>> We prefer to ARRAY_SIZE rather than duplicating its implementation.
>> So just replace it.
> []
>> diff --git a/arch/ia64/kernel/perfmon.c b/arch/ia64/kernel/perfmon.c
> []
>> @@ -4645,7 +4645,7 @@ static char *pfmfs_dname(struct dentry *dentry, char *buffer, int buflen)
>>  /* 32 */PFM_CMD(pfm_write_ibrs, PFM_CMD_PCLRWS, PFM_CMD_ARG_MANY, pfarg_dbreg_t, NULL),
>>  /* 33 */PFM_CMD(pfm_write_dbrs, PFM_CMD_PCLRWS, PFM_CMD_ARG_MANY, pfarg_dbreg_t, NULL)
>>  };
>> -#define PFM_CMD_COUNT	(sizeof(pfm_cmd_tab)/sizeof(pfm_cmd_desc_t))
>> +#define PFM_CMD_COUNT	ARRAY_SIZE(pfm_cmd_tab)
> Better would be to remove the #define altogether and change
> the one place where it's used to ARRAY_SIZE(...)
> ---
>  arch/ia64/kernel/perfmon.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/ia64/kernel/perfmon.c b/arch/ia64/kernel/perfmon.c
> index a9d4dc6c0427..08ece2c7b6e1 100644
> --- a/arch/ia64/kernel/perfmon.c
> +++ b/arch/ia64/kernel/perfmon.c
> @@ -4645,7 +4645,6 @@ static pfm_cmd_desc_t pfm_cmd_tab[]={
>  /* 32 */PFM_CMD(pfm_write_ibrs, PFM_CMD_PCLRWS, PFM_CMD_ARG_MANY, pfarg_dbreg_t, NULL),
>  /* 33 */PFM_CMD(pfm_write_dbrs, PFM_CMD_PCLRWS, PFM_CMD_ARG_MANY, pfarg_dbreg_t, NULL)
>  };
> -#define PFM_CMD_COUNT	(sizeof(pfm_cmd_tab)/sizeof(pfm_cmd_desc_t))
>  
>  static int
>  pfm_check_task_state(pfm_context_t *ctx, int cmd, unsigned long flags)
> @@ -4770,7 +4769,7 @@ sys_perfmonctl (int fd, int cmd, void __user *arg, int count)
>  	 */
>  	if (unlikely(pmu_conf == NULL)) return -ENOSYS;
>  
> -	if (unlikely(cmd < 0 || cmd >= PFM_CMD_COUNT)) {
> +	if (unlikely(cmd < 0 || cmd >= ARRAY_SIZE(pfm_cmd_tab)) {
>  		DPRINT(("invalid cmd=%d\n", cmd));
>  		return -EINVAL;
>  	}
>
>
> .
>
 Thank you for suggestion.  That's indeed better if just one palce use it.  I will repost in v2.

 Sincerely,
zhong jiang
