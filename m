Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id 215522C007C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 19:12:23 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 02762-09 for <linuxppc-dev@lists.ozlabs.org>;
 Wed, 26 Jun 2013 10:12:19 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Subject: RE: [PATCH 3/6] powerpc/powernv: Replace variables with flags
Date: Wed, 26 Jun 2013 10:12:16 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B72A6@saturn3.aculab.com>
In-Reply-To: <1372210688-12214-4-git-send-email-shangw@linux.vnet.ibm.com>
References: <1372210688-12214-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1372210688-12214-4-git-send-email-shangw@linux.vnet.ibm.com>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Gavin Shan" <shangw@linux.vnet.ibm.com>, <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> We have 2 fields in "struct pnv_phb" to trace the states. The patch
> replace the fields with one and introduces flags for that. The patch
> doesn't impact the logic.

What is the benefit of this change?

...
> +
> +#define PNV_EEH_STATE_ENABLED	(1 << 0)	/* EEH enabled	*/
> +#define PNV_EEH_STATE_REMOVED	(1 << 1)	/* PHB removed	*/
> +
>  #endif /* CONFIG_EEH */
>=20
>  struct pnv_phb {
> @@ -92,8 +96,7 @@ struct pnv_phb {
>=20
>  #ifdef CONFIG_EEH
>  	struct pnv_eeh_ops	*eeh_ops;
> -	int			eeh_enabled;
> -	int			removed;
> +	int			eeh_state;
>  #endif
>=20
>  #ifdef CONFIG_DEBUG_FS

All I can see is that it possibly reduces a structure by 4 bytes
while adding extra code.
(On 64 bit systems there might be a 4 byte pad added.)

	David
