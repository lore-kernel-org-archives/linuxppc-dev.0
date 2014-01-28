Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A4F602C00B2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jan 2014 06:44:50 +1100 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Wed, 29 Jan 2014 01:14:47 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id B61C51258053
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jan 2014 01:16:27 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0SJihsA50004160
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jan 2014 01:14:43 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0SJih4n013161
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jan 2014 01:14:43 +0530
Message-ID: <52E808A7.7090006@linux.vnet.ibm.com>
Date: Tue, 28 Jan 2014 13:44:39 -0600
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 1/3] powerpc/pseries: Device tree should only be updated
 once after suspend/migrate
References: <1390420717-23907-1-git-send-email-tyreld@linux.vnet.ibm.com>
 <1390420717-23907-2-git-send-email-tyreld@linux.vnet.ibm.com>
In-Reply-To: <1390420717-23907-2-git-send-email-tyreld@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/22/2014 01:58 PM, Tyrel Datwyler wrote:
> From: Haren Myneni <hbabu@us.ibm.com>
> 
> From: Haren Myneni <hbabu@us.ibm.com>
> 
> The current code makes rtas calls for update-nodes, activate-firmware and then
> update-nodes again. The FW provides the same data for both update-nodes calls.
> As a result a proc entry exists error is reported for the second update while
> adding device nodes.
> 
> This patch makes a single rtas call for update-nodes after activating the FW.
> It also add rtas_busy delay for the activate-firmware rtas call.
> 
> Signed-off-by: Haren Myneni <hbabu@us.ibm.com>
> Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>

Acked-by: Nathan fontenot <nfont@linux.vnet.ibm.com>

> ---
>  arch/powerpc/platforms/pseries/mobility.c | 26 ++++++++++----------------
>  1 file changed, 10 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
> index cde4e0a..bde7eba 100644
> --- a/arch/powerpc/platforms/pseries/mobility.c
> +++ b/arch/powerpc/platforms/pseries/mobility.c
> @@ -290,13 +290,6 @@ void post_mobility_fixup(void)
>  	int rc;
>  	int activate_fw_token;
> 
> -	rc = pseries_devicetree_update(MIGRATION_SCOPE);
> -	if (rc) {
> -		printk(KERN_ERR "Initial post-mobility device tree update "
> -		       "failed: %d\n", rc);
> -		return;
> -	}
> -
>  	activate_fw_token = rtas_token("ibm,activate-firmware");
>  	if (activate_fw_token == RTAS_UNKNOWN_SERVICE) {
>  		printk(KERN_ERR "Could not make post-mobility "
> @@ -304,16 +297,17 @@ void post_mobility_fixup(void)
>  		return;
>  	}
> 
> -	rc = rtas_call(activate_fw_token, 0, 1, NULL);
> -	if (!rc) {
> -		rc = pseries_devicetree_update(MIGRATION_SCOPE);
> -		if (rc)
> -			printk(KERN_ERR "Secondary post-mobility device tree "
> -			       "update failed: %d\n", rc);
> -	} else {
> +	do {
> +		rc = rtas_call(activate_fw_token, 0, 1, NULL);
> +	} while (rtas_busy_delay(rc));
> +
> +	if (rc)
>  		printk(KERN_ERR "Post-mobility activate-fw failed: %d\n", rc);
> -		return;
> -	}
> +
> +	rc = pseries_devicetree_update(MIGRATION_SCOPE);
> +	if (rc)
> +		printk(KERN_ERR "Post-mobility device tree update "
> +			"failed: %d\n", rc);
> 
>  	return;
>  }
> 
