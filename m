Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id EF19C67C0C
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Nov 2006 08:36:08 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Hoang-Nam Ngyuen <hnguyen@linux.vnet.ibm.com>
Subject: Re: [PATCH 2.6.19 1/4] ehca: assure 4k alignment for firmware control
	block in 64k page mode
Date: Mon, 6 Nov 2006 22:35:28 +0100
References: <200611062226.44939.hnguyen@linux.vnet.ibm.com>
In-Reply-To: <200611062226.44939.hnguyen@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200611062235.28667.arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
	linuxppc-dev@ozlabs.org, raisch@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 06 November 2006 22:26, Hoang-Nam Ngyuen wrote:
> -=A0=A0=A0=A0=A0=A0=A0rblock =3D kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
> +=A0=A0=A0=A0=A0=A0=A0rblock =3D (struct hipz_query_hca*)ehca_alloc_fw_ct=
rlblock();

> =A0
> -=A0=A0=A0=A0=A0=A0=A0rblock =3D kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
> +=A0=A0=A0=A0=A0=A0=A0rblock =3D (struct hipz_query_port*)ehca_alloc_fw_c=
trlblock();

The point Heiko made in his comment is that with ehca_alloc_fw_ctrlblock
returning a void*, you can (and _should_) remove the casts to other
pointer types.

	Arnd <><
