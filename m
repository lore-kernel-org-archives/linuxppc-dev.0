Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound4-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 9E50ADDF09
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Feb 2007 03:43:47 +1100 (EST)
Message-ID: <45C8B036.2060802@am.sony.com>
Date: Tue, 06 Feb 2007 08:43:34 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/4] PS3: Fix DMA scatter-gather
References: <45BFD2C2.70000@am.sony.com> <200702061422.26578.arnd@arndb.de>
In-Reply-To: <200702061422.26578.arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> On Wednesday 31 January 2007 00:20, Geoff Levand wrote:
>> @@ -272,10 +272,29 @@ static void ps3_unmap_single(struct devi
>> =EF=BF=BDstatic int ps3_map_sg(struct device *_dev, struct scatterlist=
 *sg, int nents,
>> =EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
enum dma_data_direction direction)
>> =EF=BF=BD{
>> +=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDstruct=
 ps3_system_bus_device *dev =3D to_ps3_system_bus_device(_dev);
>> +=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDint i;
>> +
>> =EF=BF=BD#if defined(CONFIG_PS3_DYNAMIC_DMA)
>> =EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
BUG_ON("do");
>> +=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDreturn=
 -EPERM;
>> +#else
>=20
> Do you still need the #ifdef? Since there is no point executing this,
> would guess you can just as well keep only the other version, right?

I wanted to keep it there in the event someone tries to use a usb device
that needs scatter-gather with CONFIG_PS3_DYNAMIC_DMA=3Dy.  Currently,
CONFIG_PS3_DYNAMIC_DMA=3Dy only supports alloc_coherent and map_single.

I plan to rework the entire CONFIG_PS3_DYNAMIC_DMA to use Ben's fixes for
iommu support, but until then, I think it would be safer to keep this.

-Geoff
