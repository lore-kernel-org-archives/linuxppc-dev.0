Return-Path: <shailendras@nvidia.com>
Received: from hqemgate16.nvidia.com (hqemgate16.nvidia.com [216.228.121.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vK9pM69hKzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Feb 2017 08:15:23 +1100 (AEDT)
From: Shailendra Singh <shailendras@nvidia.com>
To: Michael Ellerman <mpe@ellerman.id.au>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
CC: "jk@ozlabs.org" <jk@ozlabs.org>, "apopple@au1.ibm.com"
 <apopple@au1.ibm.com>, "balbirs@au1.ibm.com" <balbirs@au1.ibm.com>, "Andy
 Ritger" <ARitger@nvidia.com>, John Hubbard <jhubbard@nvidia.com>, "Sherry
 Cheung" <SCheung@nvidia.com>, Aruna Manjunatha <amanjunatha@nvidia.com>,
 "John McKenna" <jmckenna@nvidia.com>, "david.daney@cavium.com"
 <david.daney@cavium.com>, "robh@kernel.org" <robh@kernel.org>,
 "will.deacon@arm.com" <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>
Subject: RE: [PATCH] powerpc: Fix inconsistent of_node_to_nid EXPORT_SYMBOL
 handling
Date: Thu, 9 Feb 2017 21:15:18 +0000
Message-ID: <8d657fc33be24d45adfd9f92fdfd51b4@HQMAIL101.nvidia.com>
References: <1485989562-16741-1-git-send-email-shailendras@nvidia.com>
 <87poir8slr.fsf@concordia.ellerman.id.au>
In-Reply-To: <87poir8slr.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

>>>Which was merged in May 2006. So the powerpc version has almost 10 yea=
rs precedence.

=20Agreed but keeping the licensing consistent will help drivers making s=
eamless use of it on all architectures.

>>> But I guess it's a pretty boring API. So I'll merge this unless anyon=
e else objects.
Thanks. Appreciate your quick response and help.

Thanks,
Shailendra

-----Original Message-----
From: Michael Ellerman [mailto:mpe@ellerman.id.au]=20
Sent: Thursday, February 09, 2017 4:19 AM
To: Shailendra Singh <shailendras@nvidia.com>; linuxppc-dev@lists.ozlabs.=
org
Cc: jk@ozlabs.org; apopple@au1.ibm.com; balbirs@au1.ibm.com; Andy Ritger =
<ARitger@nvidia.com>; John Hubbard <jhubbard@nvidia.com>; Sherry Cheung <=
SCheung@nvidia.com>; Aruna Manjunatha <amanjunatha@nvidia.com>; John McKe=
nna <jmckenna@nvidia.com>; david.daney@cavium.com; robh@kernel.org; will.=
deacon@arm.com; Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] powerpc: Fix inconsistent of_node_to_nid EXPORT_SYMB=
OL handling

Shailendra Singh <shailendras@nvidia.com> writes:

> The generic implementation of of_node_to_nid is EXPORT_SYMBOL.

True. Added in 298535c00a2c, in April 2016.

> The powerpc implementation added by following commit is EXPORT_SYMBOL_G=
PL.
> commit 953039c8df7b ("[PATCH] powerpc: Allow devices to register with=20
> numa
> topology")

Which was merged in May 2006.

So the powerpc version has almost 10 years precedence.
[Shailendra] - Agreed. Keeping the licensing consistent will help drivers=
=20making use of it on all architectures.

> This creates an inconsistency for of_node_to_nid callers across=20
> architectures.
>
> Update the powerpc implementation to be exported consistently with the =

> generic implementation.

But I guess it's a pretty boring API. So I'll merge this unless anyone el=
se objects.
[Shailendra] - Thanks. Appreciate your quick response.

cheers


> Signed-off-by: Shailendra Singh <shailendras@nvidia.com>
> Reviewed-by: Andy Ritger <aritger@nvidia.com>
> ---
>  arch/powerpc/mm/numa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c index=20
> b1099cb2f393..8aa4ca3c84c9 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -290,7 +290,7 @@ int of_node_to_nid(struct device_node *device)
> =20
>  	return nid;
>  }
> -EXPORT_SYMBOL_GPL(of_node_to_nid);
> +EXPORT_SYMBOL(of_node_to_nid);
> =20
>  static int __init find_min_common_depth(void)  {
> --
> 2.4.11
-------------------------------------------------------------------------=
----------
This email message is for the sole use of the intended recipient(s) and m=
ay contain
confidential information.  Any unauthorized review, use, disclosure or di=
stribution
is prohibited.  If you are not the intended recipient, please contact the=
=20sender by
reply email and destroy all copies of the original message.
-------------------------------------------------------------------------=
----------
