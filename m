Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 98FE01400F4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Apr 2014 18:10:48 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Tue, 22 Apr 2014 18:10:43 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 422B43578047
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Apr 2014 18:10:42 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3M7neEP50921528
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Apr 2014 17:49:41 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3M8Ae6V005628
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Apr 2014 18:10:41 +1000
Message-ID: <535623FE.3030702@linux.vnet.ibm.com>
Date: Tue, 22 Apr 2014 13:40:38 +0530
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>, benh@kernel.crashing.org,
 paulus@samba.org, stewart@linux.vnet.ibm.com
Subject: Re: [PATCH 4/6] powerpc/powernv: Fix little endian issues in OPAL
 error log code
References: <1398142887-24109-1-git-send-email-anton@samba.org>
 <1398142887-24109-4-git-send-email-anton@samba.org>
In-Reply-To: <1398142887-24109-4-git-send-email-anton@samba.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/22/2014 10:31 AM, Anton Blanchard wrote:
> Fix little endian issues with the OPAL error log code.
>
> Signed-off-by: Anton Blanchard <anton@samba.org>
> Reviewed-by: Stewart Smith <stewart@linux.vnet.ibm.com>
> ---
>   arch/powerpc/include/asm/opal.h            | 2 +-
>   arch/powerpc/platforms/powernv/opal-elog.c | 9 ++++++++-
>   2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
> index cb7d52e..1a752ac 100644
> --- a/arch/powerpc/include/asm/opal.h
> +++ b/arch/powerpc/include/asm/opal.h
> @@ -859,7 +859,7 @@ int64_t opal_lpc_read(uint32_t chip_id, enum OpalLPCAddressType addr_type,
>   		      uint32_t addr, __be32 *data, uint32_t sz);
>
>   int64_t opal_read_elog(uint64_t buffer, uint64_t size, uint64_t log_id);
> -int64_t opal_get_elog_size(uint64_t *log_id, uint64_t *size, uint64_t *elog_type);
> +int64_t opal_get_elog_size(__be64 *log_id, __be64 *size, __be64 *elog_type);
>   int64_t opal_write_elog(uint64_t buffer, uint64_t size, uint64_t offset);
>   int64_t opal_send_ack_elog(uint64_t log_id);
>   void opal_resend_pending_logs(void);
> diff --git a/arch/powerpc/platforms/powernv/opal-elog.c b/arch/powerpc/platforms/powernv/opal-elog.c
> index 7e3821e..10268c4 100644
> --- a/arch/powerpc/platforms/powernv/opal-elog.c
> +++ b/arch/powerpc/platforms/powernv/opal-elog.c
> @@ -238,18 +238,25 @@ static struct elog_obj *create_elog_obj(uint64_t id, size_t size, uint64_t type)
>
>   static void elog_work_fn(struct work_struct *work)
>   {
> +	__be64 size;
> +	__be64 id;
> +	__be64 type;
>   	uint64_t elog_size;
>   	uint64_t log_id;
>   	uint64_t elog_type;
>   	int rc;
>   	char name[2+16+1];
>
> -	rc = opal_get_elog_size(&log_id, &elog_size, &elog_type);
> +	rc = opal_get_elog_size(&id, &size, &type);
>   	if (rc != OPAL_SUCCESS) {
>   		pr_err("ELOG: Opal log read failed\n");
>   		return;
>   	}
>
> +	elog_size = be64_to_cpu(size);
> +	log_id = be64_to_cpu(id);

Anton,

Shouldn't we covert Log ID back to BE format in ACK function (elog_ack_store() ) ?

Rest looks good.

-Vasant

> +	elog_type = be64_to_cpu(type);
> +
>   	BUG_ON(elog_size > OPAL_MAX_ERRLOG_SIZE);
>
>   	if (elog_size >= OPAL_MAX_ERRLOG_SIZE)
>
