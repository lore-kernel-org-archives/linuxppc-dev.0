Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 91CA514008A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Mar 2014 17:17:25 +1100 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Thu, 27 Mar 2014 16:17:23 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id AA0B82CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Mar 2014 17:17:20 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2R5upqd51970138
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Mar 2014 16:56:51 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2R6HJk7023296
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Mar 2014 17:17:19 +1100
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Anton Blanchard <anton@samba.org>, benh@kernel.crashing.org,
 paulus@samba.org
Subject: Re: [PATCH 4/4] powerpc/powernv: Fix little endian issues OPAL error
 log code
In-Reply-To: <20140327162056.5a57c4c9@kryten>
References: <20140327161849.791432d0@kryten> <20140327162056.5a57c4c9@kryten>
Date: Thu, 27 Mar 2014 17:17:18 +1100
Message-ID: <87ob0supw1.fsf@river.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anton Blanchard <anton@samba.org> writes:
> Fix little endian issues with the OPAL error log code.
>
> Signed-off-by: Anton Blanchard <anton@samba.org>

Reviewed-by: Stewart Smith <stewart@linux.vnet.ibm.com>

Do we also need any magic for the getting of error logs themselves?

You may want to check the md5 of the logs themselves on be and le.

> ---
>
> Index: b/arch/powerpc/platforms/powernv/opal-elog.c
> ===================================================================
> --- a/arch/powerpc/platforms/powernv/opal-elog.c
> +++ b/arch/powerpc/platforms/powernv/opal-elog.c
> @@ -243,18 +243,25 @@ static struct elog_obj *create_elog_obj(
>
>  static void elog_work_fn(struct work_struct *work)
>  {
> +	__be64 size;
> +	__be64 id;
> +	__be64 type;
>  	uint64_t elog_size;
>  	uint64_t log_id;
>  	uint64_t elog_type;
>  	int rc;
>  	char name[2+16+1];
>
> -	rc = opal_get_elog_size(&log_id, &elog_size, &elog_type);
> +	rc = opal_get_elog_size(&id, &size, &type);
>  	if (rc != OPAL_SUCCESS) {
>  		pr_err("ELOG: Opal log read failed\n");
>  		return;
>  	}
>
> +	elog_size = be64_to_cpu(size);
> +	log_id = be64_to_cpu(id);
> +	elog_type = be64_to_cpu(type);
> +
>  	BUG_ON(elog_size > OPAL_MAX_ERRLOG_SIZE);
>
>  	if (elog_size >= OPAL_MAX_ERRLOG_SIZE)
> Index: b/arch/powerpc/include/asm/opal.h
> ===================================================================
> --- a/arch/powerpc/include/asm/opal.h
> +++ b/arch/powerpc/include/asm/opal.h
> @@ -851,7 +851,7 @@ int64_t opal_lpc_read(uint32_t chip_id,
>  		      uint32_t addr, __be32 *data, uint32_t sz);
>
>  int64_t opal_read_elog(uint64_t buffer, uint64_t size, uint64_t log_id);
> -int64_t opal_get_elog_size(uint64_t *log_id, uint64_t *size, uint64_t *elog_type);
> +int64_t opal_get_elog_size(__be64 *log_id, __be64 *size, __be64 *elog_type);
>  int64_t opal_write_elog(uint64_t buffer, uint64_t size, uint64_t offset);
>  int64_t opal_send_ack_elog(uint64_t log_id);
>  void opal_resend_pending_logs(void);
