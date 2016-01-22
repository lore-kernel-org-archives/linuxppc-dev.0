Return-Path: <michael.neuling@au.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D15991A03F8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jan 2016 11:38:50 +1100 (AEDT)
Received: from localhost.localdomain (localhost [127.0.0.1])
 by ozlabs.org (Postfix) with ESMTP id 95EFD140297
 for <linuxppc-dev@ozlabs.org>; Fri, 22 Jan 2016 11:38:50 +1100 (AEDT)
Message-ID: <1453423130.4239.51.camel@au.ibm.com>
Subject: Re: [PATCH] cxl: Add cxl_read_adapter_vpd() to the kernel API
From: Michael Neuling <michael.neuling@au.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, ian@ozlabs.au.ibm.com,
 linuxppc-dev@ozlabs.org
Date: Fri, 22 Jan 2016 11:38:50 +1100
In-Reply-To: <56A12814.5080607@linux.vnet.ibm.com>
References: <1453223694-5190-1-git-send-email-fbarrat@linux.vnet.ibm.com>
 <1453256449.28504.56.camel@au.ibm.com>
 <56A12814.5080607@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-01-21 at 19:48 +0100, Frederic Barrat wrote:
>=20
> Le 20/01/2016 03:20, Michael Neuling a =C3=A9crit :
> > The only thing I'm a bit concerned about is are we going to end up
> > duplicating a lot of the linux PCI API, but I guess we are only going
> > to do this for things the papr HCALL interface mimics.
>=20
> There are actually very few operations we can do on the adapter with=20
> hcalls. papr defines 'reset', 'read the VPD' and flashing a new image on=
=20
> the card. So we'll soon run out of APIs to mimic.
>=20
> I guess it means the usage of cxl_get_phys_dev() should be discouraged,=
=20
> since it's going to lead to different behaviors between bare-metal and=
=20
> powerVM guest. Was there another expected use case for a kernel driver=
=20
> other than accessing the VPD?

It was just for VPD.  I figured it was the easiest way to add it. Maybe
it's worth getting rid of it in favour of VPD only.

If you want to remove it I'd be happy, but you'll need to coordinate
with the cxlflash driver.  You can probably just write the patch for
them and then get their ACK on it.

Thanks again.

Mikey
