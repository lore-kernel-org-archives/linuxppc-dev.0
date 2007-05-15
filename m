Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2877FDDED0
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 23:10:25 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4FDAKW2008042
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 09:10:20 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4FDAKMA211054
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 07:10:20 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4FDAK37013746
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 07:10:20 -0600
Subject: Re: [PATCH 3/3] Fixes to allow use of Ebony's flash chips through
	physmap_of
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20070515045415.98889DDED7@ozlabs.org>
References: <20070515045415.98889DDED7@ozlabs.org>
Content-Type: text/plain
Date: Tue, 15 May 2007 08:10:06 -0500
Message-Id: <1179234606.3084.34.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-05-15 at 14:54 +1000, David Gibson wrote:
>  void ebony_init(void *mac0, void *mac1)
> Index: working-2.6/arch/powerpc/boot/dts/ebony.dts
> ===================================================================
> --- working-2.6.orig/arch/powerpc/boot/dts/ebony.dts	2007-05-14 14:45:56.000000000 +1000
> +++ working-2.6/arch/powerpc/boot/dts/ebony.dts	2007-05-14 14:45:58.000000000 +1000
> @@ -176,6 +176,7 @@
>  				fpga@7,0 {
>  					compatible = "Ebony-FPGA";
>  					reg = <7 0 10>;
> +					virtual-reg = <e8300000>;

That's the mapping for OpenBios.  What happens if someone is using
U-Boot?

If the mapping isn't the same, you might want to pass the address from
the individual firmware wrapper parts to ebony_flashsel_fixup similar to
how you've done it for dt_fixup_mac_addresses.

josh
