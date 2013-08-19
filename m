Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp03.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CB0592C00A6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 23:44:47 +1000 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 19 Aug 2013 23:33:48 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 9B1582CE804C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 23:44:44 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7JDSesY55836752
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 23:28:40 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r7JDiinJ002913
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 23:44:44 +1000
Message-ID: <5212214A.5050706@linux.vnet.ibm.com>
Date: Mon, 19 Aug 2013 08:44:42 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/8] powerpc/pseries: fix over writing of rtas return
 code in update_dt_node
References: <1376544232-24936-1-git-send-email-tyreld@linux.vnet.ibm.com>
 <1376544232-24936-3-git-send-email-tyreld@linux.vnet.ibm.com>
In-Reply-To: <1376544232-24936-3-git-send-email-tyreld@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/15/2013 12:23 AM, Tyrel Datwyler wrote:
> The rc variable is initially used to store the return code from the
> ibm,update-properties rtas call which returns 0 or 1 on success. A return
> code of 1 indicates that ibm,update-properties must be called again for the
> node. However, the rc variable is overwritten by a call to update_dt_prop
> which returns 0 on success. This results in ibm,update-properties not being
> called again for the given node when the rtas call rc was previously 1.
> 
> Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>

Acked-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

> ---
>  arch/powerpc/platforms/pseries/mobility.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
> index f28abee..aaae85d 100644
> --- a/arch/powerpc/platforms/pseries/mobility.c
> +++ b/arch/powerpc/platforms/pseries/mobility.c
> @@ -130,7 +130,7 @@ static int update_dt_node(u32 phandle, s32 scope)
>  	struct update_props_workarea *upwa;
>  	struct device_node *dn;
>  	struct property *prop = NULL;
> -	int i, rc;
> +	int i, rc, rtas_rc;
>  	char *prop_data;
>  	char *rtas_buf;
>  	int update_properties_token;
> @@ -154,9 +154,9 @@ static int update_dt_node(u32 phandle, s32 scope)
>  	upwa->phandle = phandle;
>  
>  	do {
> -		rc = mobility_rtas_call(update_properties_token, rtas_buf,
> +		rtas_rc = mobility_rtas_call(update_properties_token, rtas_buf,
>  					scope);
> -		if (rc < 0)
> +		if (rtas_rc < 0)
>  			break;
>  
>  		prop_data = rtas_buf + sizeof(*upwa);
> @@ -202,7 +202,7 @@ static int update_dt_node(u32 phandle, s32 scope)
>  				prop_data += vd;
>  			}
>  		}
> -	} while (rc == 1);
> +	} while (rtas_rc == 1);
>  
>  	of_node_put(dn);
>  	kfree(rtas_buf);
> 
