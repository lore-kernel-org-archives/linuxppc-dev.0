Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 86C5CDDF37
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Oct 2007 00:49:29 +1000 (EST)
Message-ID: <47025A72.10404@freescale.com>
Date: Tue, 02 Oct 2007 09:49:22 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] cpm: Describe multi-user ram in its own device node.
References: <20070928190616.GB20213@loki.buserror.net>
	<20070929003005.59afc2a0@kernel.crashing.org>
	<08C0C9CB-C958-4B95-81B8-D0677CBA4399@kernel.crashing.org>
	<20070929104917.1585737e@kernel.crashing.org>
	<1B684498-FC47-4F01-A72E-DD27B259613A@kernel.crashing.org>
	<47011BED.8020206@freescale.com>
	<AD243886-65DE-4285-ADD3-1D4C5ABA2E3C@kernel.crashing.org>
In-Reply-To: <AD243886-65DE-4285-ADD3-1D4C5ABA2E3C@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: PowerPC dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> 
> On Oct 1, 2007, at 11:10 AM, Scott Wood wrote:
> 
>> Kumar Gala wrote:
>>> On Sep 29, 2007, at 1:49 AM, Vitaly Bordug wrote:
>>>> cpms have dpram, qe has muram. these two are the same stuff in fact. 
>>>> Or you are asking about have QE stuff utilize such a binding at the 
>>>> same pass?
>>> I was asking about both these things.
>>
>> As stated in the commit message, QE can use this; it just needs a 
>> compatible entry in the data node.
> 
> can some one look at that.

Scott's proposal says this:

muram@0 {
	#address-cells = <1>;
	#size-cells = <1>;
	ranges = <0 0 10000>;

	data@0 {
		compatible = "fsl,cpm-muram-data";
		reg = <0 2000 9800 800>;
	};

Currently, the QE has this:

muram@10000 {
	device_type = "muram";
	ranges = <0 00010000 0000c000>;

	data-only@0{
		reg = <0 c000>;
	};
};

The code to process this node is qe_muram_init() in 
arch/powerpc/sysdev/qe_lib/qe.c.

	if ((np = of_find_node_by_name(NULL, "data-only")) != NULL) {
		address = *of_get_address(np, 0, &size, &flags);
		of_node_put(np);
		rh_attach_region(&qe_muram_info,
			(void *)address, (int)size);
	}

I think it would be trivial to modify this code to look for a Scott-style 
muram node.  Heck, it could be modified to look for both, and so we'll 
maintain compatibility.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
