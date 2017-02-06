Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vHNPB3hKvzDq8g
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Feb 2017 10:05:50 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v16N3mRf088724
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Feb 2017 18:05:48 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28ew5dv508-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Feb 2017 18:05:48 -0500
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Mon, 6 Feb 2017 16:05:47 -0700
Subject: Re: [PATCH] powerpc/pseries: Fix missing of_node_put
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 nfont@linux.vnet.ibm.com, jallen@linux.vnet.ibm.com
References: <20170206213616.3661-1-christophe.jaillet@wanadoo.fr>
Cc: kernel-janitors@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Mon, 6 Feb 2017 15:05:42 -0800
MIME-Version: 1.0
In-Reply-To: <20170206213616.3661-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=windows-1252
Message-Id: <ec50fa3a-1012-805f-2541-1519ef1c0327@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/06/2017 01:36 PM, Christophe JAILLET wrote:
> If 'dlpar_configure_connector()' fails, 'parent_dn' should be released as
> already done in the normal case.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  arch/powerpc/platforms/pseries/mobility.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
> index 5a0c7ba429ce..b8060c182ae2 100644
> --- a/arch/powerpc/platforms/pseries/mobility.c
> +++ b/arch/powerpc/platforms/pseries/mobility.c
> @@ -226,13 +226,16 @@ static int add_dt_node(__be32 parent_phandle, __be32 drc_index)
>  		return -ENOENT;
> 
>  	dn = dlpar_configure_connector(drc_index, parent_dn);

Simpler approach would be to move the of_node_put() call to here
directly after the last use of parent_dn.

-Tyrel

> -	if (!dn)
> -		return -ENOENT;
> +	if (!dn) {
> +		rc = -ENOENT;
> +		goto out;
> +	}
> 
>  	rc = dlpar_attach_node(dn);
>  	if (rc)
>  		dlpar_free_cc_nodes(dn);
> 
> +out:
>  	of_node_put(parent_dn);
>  	return rc;
>  }
> 
