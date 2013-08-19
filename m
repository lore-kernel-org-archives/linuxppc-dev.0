Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp03.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B20832C00A6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 23:43:51 +1000 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 19 Aug 2013 23:32:52 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id DBADB2CE804D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 23:43:48 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7JDRiFm55836696
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 23:27:44 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r7JDhmS9002281
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 23:43:48 +1000
Message-ID: <52122111.6010909@linux.vnet.ibm.com>
Date: Mon, 19 Aug 2013 08:43:45 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/8] powerpc/pseries: fix creation of loop in device node
 property list
References: <1376544232-24936-1-git-send-email-tyreld@linux.vnet.ibm.com>
 <1376544232-24936-2-git-send-email-tyreld@linux.vnet.ibm.com>
In-Reply-To: <1376544232-24936-2-git-send-email-tyreld@linux.vnet.ibm.com>
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
> The update_dt_prop helper function fails to set the IN/OUT parameter prop to
> NULL after a complete property has been parsed from the work area returned by
> the ibm,update-properties rtas function. This results in the property list of
> the device node being updated is corrupted and becomes a loop since the same
> property structure is used repeatedly.
> 
> Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>

Acked-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

> ---
>  arch/powerpc/platforms/pseries/mobility.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
> index 3d01eee..f28abee 100644
> --- a/arch/powerpc/platforms/pseries/mobility.c
> +++ b/arch/powerpc/platforms/pseries/mobility.c
> @@ -119,7 +119,7 @@ static int update_dt_property(struct device_node *dn, struct property **prop,
>  
>  	if (!more) {
>  		of_update_property(dn, new_prop);
> -		new_prop = NULL;
> +		*prop = NULL;
>  	}
>  
>  	return 0;
> 
