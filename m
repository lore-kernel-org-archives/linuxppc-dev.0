Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out4.electric.net (smtp-out4.electric.net
 [192.162.216.184])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xHW4D6DgvzDqmv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 20:07:08 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Rob Herring' <robh@kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
CC: Frank Rowand <frowand.list@gmail.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>
Subject: RE: [PATCH 3/4] powerpc: pseries: only store the device node
 basename in full_name
Date: Wed, 26 Jul 2017 10:07:01 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD00419B2@AcuExch.aculab.com>
References: <20170725214427.25768-1-robh@kernel.org>
 <20170725214427.25768-4-robh@kernel.org>
In-Reply-To: <20170725214427.25768-4-robh@kernel.org>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Rob Herring
> Sent: 25 July 2017 22:44
> With dependencies on full_name containing the entire device node path
> removed, stop storing the full_name in nodes created by
> dlpar_configure_connector() and pSeries_reconfig_add_node().
...
>	dn =3D kzalloc(sizeof(*dn), GFP_KERNEL);
> 	if (!dn)
> 		return NULL;
>=20
> 	name =3D (char *)ccwa + be32_to_cpu(ccwa->name_offset);
> -	dn->full_name =3D kasprintf(GFP_KERNEL, "%s/%s", path, name);
> +	dn->full_name =3D kasprintf(GFP_KERNEL, "%s", name);

Isn't this just strdup()?
Perhaps you should rename full_name to name - since it is no longer 'full'?

Maybe you could do a single malloc() for both 'dn' and the name?

	David
