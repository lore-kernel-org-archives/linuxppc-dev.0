Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id 9816DDDE4A
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Feb 2007 00:22:38 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 3/4] PS3: Fix DMA scatter-gather
Date: Tue, 6 Feb 2007 14:22:26 +0100
References: <45BFD2C2.70000@am.sony.com>
In-Reply-To: <45BFD2C2.70000@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702061422.26578.arnd@arndb.de>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 31 January 2007 00:20, Geoff Levand wrote:
> @@ -272,10 +272,29 @@ static void ps3_unmap_single(struct devi
> =A0static int ps3_map_sg(struct device *_dev, struct scatterlist *sg, int=
 nents,
> =A0=A0=A0=A0=A0=A0=A0=A0enum dma_data_direction direction)
> =A0{
> +=A0=A0=A0=A0=A0=A0=A0struct ps3_system_bus_device *dev =3D to_ps3_system=
_bus_device(_dev);
> +=A0=A0=A0=A0=A0=A0=A0int i;
> +
> =A0#if defined(CONFIG_PS3_DYNAMIC_DMA)
> =A0=A0=A0=A0=A0=A0=A0=A0BUG_ON("do");
> +=A0=A0=A0=A0=A0=A0=A0return -EPERM;
> +#else

Do you still need the #ifdef? Since there is no point executing this,
would guess you can just as well keep only the other version, right?

	Arnd <><
