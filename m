Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp07.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 459822C00A6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 23:48:29 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 19 Aug 2013 23:35:03 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id E35EE2BB0051
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 23:48:25 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7JDmErB38666470
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 23:48:14 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r7JDmPUt017095
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 23:48:25 +1000
Message-ID: <52122227.6040904@linux.vnet.ibm.com>
Date: Mon, 19 Aug 2013 08:48:23 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Subject: Re: [PATCH 4/8] powerpc/pseries: fix parsing of initial node path
 in update_dt_node
References: <1376544232-24936-1-git-send-email-tyreld@linux.vnet.ibm.com>
 <1376544232-24936-5-git-send-email-tyreld@linux.vnet.ibm.com>
In-Reply-To: <1376544232-24936-5-git-send-email-tyreld@linux.vnet.ibm.com>
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
> On the first call to ibm,update-properties for a node the first property
> returned is the full node path. Currently this is not parsed correctly by the
> update_dt_node function. Commit 2e9b7b0 attempted to fix this, but was
> incorrect as it made a wrong assumption about the layout of the first
> property in the work area. Further, if ibm,update-properties must be called
> multiple times for the same node this special property should only be skipped
> after the initial call. The first property descriptor returned consists of
> the property name, property value length, and property value. The property
> name is an empty string, property length is encoded in 4 byte integer, and
> the property value is the node path.
> 
> Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>

Acked-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

> ---
>  arch/powerpc/platforms/pseries/mobility.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
> index 023e354..ed5426f 100644
> --- a/arch/powerpc/platforms/pseries/mobility.c
> +++ b/arch/powerpc/platforms/pseries/mobility.c
> @@ -161,18 +161,19 @@ static int update_dt_node(u32 phandle, s32 scope)
>  
>  		prop_data = rtas_buf + sizeof(*upwa);
>  
> -		/* The first element of the buffer is the path of the node
> -		 * being updated in the form of a 8 byte string length
> -		 * followed by the string. Skip past this to get to the
> -		 * properties being updated.
> +		/* On the first call to ibm,update-properties for a node the
> +		 * the first property value descriptor contains an empty
> +		 * property name, the property value length encoded as u32,
> +		 * and the property value is the node path being updated.
>  		 */
> -		vd = *prop_data++;
> -		prop_data += vd;
> +		if (*prop_data == 0) {
> +			prop_data++;
> +			vd = *(u32 *)prop_data;
> +			prop_data += vd + sizeof(vd);
> +			upwa->nprops--;
> +		}
>  
> -		/* The path we skipped over is counted as one of the elements
> -		 * returned so start counting at one.
> -		 */
> -		for (i = 1; i < upwa->nprops; i++) {
> +		for (i = 0; i < upwa->nprops; i++) {
>  			char *prop_name;
>  
>  			prop_name = prop_data;
> 
