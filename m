Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp03.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 40A822C0130
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 23:46:25 +1000 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 19 Aug 2013 23:35:26 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 88511357804E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 23:46:22 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7JDURYa62914686
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 23:30:27 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r7JDkLuQ004494
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 23:46:22 +1000
Message-ID: <521221AB.8080905@linux.vnet.ibm.com>
Date: Mon, 19 Aug 2013 08:46:19 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/8] powerpc/pseries: pack update_props_workarea to map
 correctly to rtas buffer header
References: <1376544232-24936-1-git-send-email-tyreld@linux.vnet.ibm.com>
 <1376544232-24936-4-git-send-email-tyreld@linux.vnet.ibm.com>
In-Reply-To: <1376544232-24936-4-git-send-email-tyreld@linux.vnet.ibm.com>
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
> The work area buffer returned by the ibm,update-properties rtas call contains
> 20 bytes of header information prior to the property value descriptor data.
> Currently update_dt_node tries to advance over this header using sizeof(upwa).
> The update_props_workarea struct contains 20 bytes worth of fields, that map
> to the relevant header data, but the sizeof the structure is 24 bytes due to
> 4 bytes of padding at the end of the structure. Packing the structure ensures
> that we don't advance too far over the rtas buffer.
> 
> Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>

Acked-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

> ---
>  arch/powerpc/platforms/pseries/mobility.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
> index aaae85d..023e354 100644
> --- a/arch/powerpc/platforms/pseries/mobility.c
> +++ b/arch/powerpc/platforms/pseries/mobility.c
> @@ -28,7 +28,7 @@ struct update_props_workarea {
>  	u32 state;
>  	u64 reserved;
>  	u32 nprops;
> -};
> +} __packed;
>  
>  #define NODE_ACTION_MASK	0xff000000
>  #define NODE_COUNT_MASK		0x00ffffff
> 
