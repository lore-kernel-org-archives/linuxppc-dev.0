Return-Path: <f.fainelli@gmail.com>
Received: from mail-oi0-x235.google.com (mail-oi0-x235.google.com
 [IPv6:2607:f8b0:4003:c06::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 142CD1A0038
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Sep 2015 06:49:40 +1000 (AEST)
Received: by oiww128 with SMTP id w128so42144009oiw.2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Sep 2015 13:49:38 -0700 (PDT)
Subject: Re: [PATCH 0/7] Phy and mdiobus fixes
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
References: <20150918094625.GB21084@n2100.arm.linux.org.uk>
Cc: devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
 Grant Likely <grant.likely@linaro.org>,
 Iyappan Subramanian <isubramanian@apm.com>, Keyur Chudgar
 <kchudgar@apm.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Li Yang <leoli@freescale.com>, Michal Simek <michal.simek@xilinx.com>,
 netdev@vger.kernel.org, Robert Richter <rric@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
 Sunil Goutham <sgoutham@cavium.com>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <55FDCA5F.9090604@gmail.com>
Date: Sat, 19 Sep 2015 13:49:35 -0700
MIME-Version: 1.0
In-Reply-To: <20150918094625.GB21084@n2100.arm.linux.org.uk>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Le 09/18/15 02:46, Russell King - ARM Linux a écrit :
> Hi,
> 
> While looking at the phy code, I identified a number of weaknesses
> where refcounting on device structures was being leaked, where
> modules could be removed while in-use, and where the fixed-phy could
> end up having unintended consequences caused by incorrect calls to
> fixed_phy_update_state().
> 
> This patch series resolves those issues, some of which were discovered
> with testing on an Armada 388 board.  Not all patches are fully tested,
> particularly the one which touches several network drivers.
> 
> When resolving the struct device refcounting problems, several different
> solutions were considered before settling on the implementation here -
> one of the considerations was to avoid touching many network drivers.
> The solution here is:
> 
> 	phy_attach*() - takes a refcount
> 	phy_detach*() - drops the phy_attach refcount
> 
> Provided drivers always attach and detach their phys, which they should
> already be doing, this should change nothing, even if they leak a refcount.
> 
> 	of_phy_find_device() and of_* functions which use that take
> 	a refcount.  Arrange for this refcount to be dropped once
> 	the phy is attached.
> 
> This is the reason why the previous change is important - we can't drop
> this refcount taken by of_phy_find_device() until something else holds
> a reference on the device.  This resolves the leaked refcount caused by
> using of_phy_connect() or of_phy_attach().
> 
> Even without the above changes, these drivers are leaking by calling
> of_phy_find_device().  These drivers are addressed by adding the
> appropriate release of that refcount.
> 
> The mdiobus code also suffered from the same kind of leak, but thankfully
> this only happened in one place - the mdio-mux code.
> 
> I also found that the try_module_get() in the phy layer code was utterly
> useless: phydev->dev.driver was guaranteed to always be NULL, so
> try_module_get() was always being called with a NULL argument.  I proved
> this with my SFP code, which declares its own MDIO bus - the module use
> count was never incremented irrespective of how I set the MDIO bus up.
> This allowed the MDIO bus code to be removed from the kernel while there
> were still PHYs attached to it.
> 
> One other bug was discovered: while using in-band-status with mvneta, it
> was found that if a real phy is attached with in-band-status enabled,
> and another ethernet interface is using the fixed-phy infrastructure, the
> interface using the fixed-phy infrastructure is configured according to
> the other interface using the in-band-status - which is caused by the
> fixed-phy code not verifying that the phy_device passed in is actually
> a fixed-phy device, rather than a real MDIO phy.
> 
> Lastly, having mdio_bus reversing phy_device_register() internals seems
> like a layering violation - it's trivial to move that code to the phy
> device layer.

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks!
-- 
Florian
