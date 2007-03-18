Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 3AB39DDE33
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Mar 2007 11:22:36 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l2I0MTHB021703
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2007 17:22:29 -0700 (MST)
Received: from Artemis.local (mvp-10-214-72-251.am.freescale.net
	[10.214.72.251])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l2I0MSDF020414
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2007 19:22:29 -0500 (CDT)
Message-ID: <45FC8643.1080807@freescale.com>
Date: Sat, 17 Mar 2007 19:22:27 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 10/17] bootwrapper: Add dt_set_mac_addresses().
References: <20070316172641.GA29709@ld0162-tx32.am.freescale.net>	<20070316172853.GJ29784@ld0162-tx32.am.freescale.net>
	<20070317013159.GH3969@localhost.localdomain>
In-Reply-To: <20070317013159.GH3969@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:

>        while ((addr = va_arg(ap, void *))) {
>                devp = find_node_by_prop_value(NULL,
> linux,network-index",
>                                               &index, sizeof(index));
> 
>                if (devp)
>                       setprop(devp, "local-mac-address", addr, 6);

The problem with this version is that it only updates local-mac-address, 
and only if it already exists.  Scott's version also updates 
mac-address.  Also, in the future, we hope to eliminate *all* MAC 
address entries from the DTS files, and the boot loader and/or 
bootwrapper will add one.
