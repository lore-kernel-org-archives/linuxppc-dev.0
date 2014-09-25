Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B74DB1A019F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Sep 2014 08:35:20 +1000 (EST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Thu, 25 Sep 2014 16:35:17 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 459533E40030
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 16:35:15 -0600 (MDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8PMZFvx55836706
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Sep 2014 00:35:15 +0200
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 s8PMdlEK004755
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 16:39:48 -0600
Message-ID: <542498A2.2070209@linux.vnet.ibm.com>
Date: Thu, 25 Sep 2014 15:35:14 -0700
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Cyril Bur <cyril.bur@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 1/3] drivers/of: add of_changeset_apply_locked
References: <1411627290-20302-1-git-send-email-cyril.bur@au1.ibm.com>
 <1411627290-20302-2-git-send-email-cyril.bur@au1.ibm.com>
In-Reply-To: <1411627290-20302-2-git-send-email-cyril.bur@au1.ibm.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/24/2014 11:41 PM, Cyril Bur wrote:
> Due to the requirement of of_changesets that of_changeset_apply be called
> holding the of_mutex and that the of_mutex cannot be accessed nicely outside
> the of code, added a wrapper which grabs the lock and called
> of_changeset_apply.
> 
> Signed-off-by: Cyril Bur <cyril.bur@au1.ibm.com>
> ---
>  drivers/of/dynamic.c | 11 +++++++++++
>  include/linux/of.h   |  1 +
>  2 files changed, 12 insertions(+)

This patch needs to go through Grant Likely and the device tree list.
When unsure scripts/get_maintainer.pl can help point the way.

-Tyrel

> 
> diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
> index 54fecc4..cbff2a2 100644
> --- a/drivers/of/dynamic.c
> +++ b/drivers/of/dynamic.c
> @@ -542,6 +542,17 @@ void of_changeset_destroy(struct of_changeset *ocs)
>  		__of_changeset_entry_destroy(ce);
>  }
>  
> +int of_changeset_apply_locked(struct of_changeset *ocs)
> +{
> +	int ret;
> +
> +	mutex_lock(&of_mutex);
> +	ret = of_changeset_apply(ocs);
> +	mutex_unlock(&of_mutex);
> +
> +	return ret;
> +}
> +
>  /**
>   * of_changeset_apply - Applies a changeset
>   *
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 6c4363b..f5c48fa 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -827,6 +827,7 @@ struct of_changeset {
>  extern void of_changeset_init(struct of_changeset *ocs);
>  extern void of_changeset_destroy(struct of_changeset *ocs);
>  extern int of_changeset_apply(struct of_changeset *ocs);
> +extern int of_changeset_apply_locked(struct of_changeset *ocs);
>  extern int of_changeset_revert(struct of_changeset *ocs);
>  extern int of_changeset_action(struct of_changeset *ocs,
>  		unsigned long action, struct device_node *np,
> 
