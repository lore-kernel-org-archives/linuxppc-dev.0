Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 294B71A021C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 20:18:34 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 3/3] leds/powernv: Add driver for PowerNV platform
Date: Tue, 28 Apr 2015 12:18:22 +0200
Message-ID: <5316346.zPr516JNgQ@wuerfel>
In-Reply-To: <20150428101008.26912.38735.stgit@localhost.localdomain>
References: <20150428100535.26912.29607.stgit@localhost.localdomain>
 <20150428101008.26912.38735.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: stewart@linux.vnet.ibm.com, j.anaszewski81@gmail.com, cooloney@gmail.com,
 Vasant Hegde <hegdevasant@linux.vnet.ibm.com>, rpurdie@rpsys.net,
 linux-leds@vger.kernel.org, khandual@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 28 April 2015 15:40:35 Vasant Hegde wrote:
> +++ b/Documentation/devicetree/bindings/leds/leds-powernv.txt
> @@ -0,0 +1,29 @@
> +Device Tree binding for LEDs on IBM Power Systems
> +-------------------------------------------------
> +
> +The 'led' node under '/ibm,opal' lists service indicators available in the
> +system and their capabilities.
> +
> +led {
> +       compatible = "ibm,opal-v3-led";
> +       phandle = <0x1000006b>;
> +       linux,phandle = <0x1000006b>;
> +       led-mode = "lightpath";
> +
> +       U78C9.001.RST0027-P1-C1 {
> +               led-types = "identify", "fault";
> +               led-loc = "descendent";
> +               phandle = <0x1000006f>;
> +               linux,phandle = <0x1000006f>;
> +       };
> +       ...
> +       ...
> +};

We normally don't list the 'phandle' or 'linux,phandle' properties in the binding
description.

> +
> +Each node under 'led' node describes location code of FRU/Enclosure.
> +
> +The properties under each node:
> +
> +  led-types : Supported LED types (attention/identify/fault).
> +
> +  led-loc   : enclosure/descendent(FRU) location code.
> 

Could you use the standard 'label' property for this?

	Arnd
