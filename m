Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 3E8B067C36
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 03:35:23 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 7/16] powerpc: add support for ps3 platform
Date: Thu, 16 Nov 2006 17:35:15 +0100
References: <4554DACB.8060809@am.sony.com>
In-Reply-To: <4554DACB.8060809@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200611161735.16103.arnd@arndb.de>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 10 November 2006 21:02, Geoff Levand wrote:
> +static int __init ps3pf_probe(void)
> +{
> +=A0=A0=A0=A0=A0=A0=A0unsigned long htab_size;
> +
> +=A0=A0=A0=A0=A0=A0=A0pr_debug(" -> %s:%d\n", __func__, __LINE__);
> +
> +=A0=A0=A0=A0=A0=A0=A0powerpc_firmware_features |=3D FW_FEATURE_LPAR;
> +
> +=A0=A0=A0=A0=A0=A0=A0ps3pf_mm_init();
> +=A0=A0=A0=A0=A0=A0=A0ps3pf_mm_vas_create(&htab_size);
> +=A0=A0=A0=A0=A0=A0=A0ps3pf_hpte_init(htab_size);
> +
> +=A0=A0=A0=A0=A0=A0=A0pr_debug(" <- %s:%d\n", __func__, __LINE__);
> +=A0=A0=A0=A0=A0=A0=A0return 1;
> +}
> +

Your probe() function needs to check if you are actually running
on appropriate hardware and return 0 if not.

This currently breaks when booting a multiplatform kernel
on a non-ps3 system.

	Arnd <><
