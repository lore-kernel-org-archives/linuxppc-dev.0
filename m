Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 15E6F679EB
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Mar 2006 16:23:16 +1100 (EST)
In-Reply-To: <20060328161431.18517.82573.stgit@vitb.ru.mvista.com>
References: <20060328161431.18517.82573.stgit@vitb.ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <bed6c40abe7664da7506270a46611d00@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Subject: Re: [PATCH] powerpc: Add FSL CPM2 device tree node documentation
Date: Thu, 30 Mar 2006 00:05:38 -0500
To: Vitaly Bordug <vbordug@ru.mvista.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 28, 2006, at 11:14 AM, Vitaly Bordug wrote:

> Updated the documentation to include the initial description of the 
> CPM2
> device that are used on PQII and PQIII families.

I haven't followed the device tree development in detail, but when
looking at this the only question that comes to mind is wondering
what this really does to help me.  None of the information provided
here is variable nor configurable .... except I guess for the internal
register base address (IMMR), which for some reason has turned
into a variable which hasn't changed since I did the first kernel port.
About the only thing that is variable, which is the two different bank
addresses of the CPM memory that affects the configuration of
the FCCs in Ethernet mode, isn't reflected here in any way.

> +		brg@119f0 {
> +			device_type = "brg";
> +			model = "BRG1";
> +			reg = <119f0>;
> +			linux,phandle = <775>;
> +		};

Why?  We already know it's at this address offset.

> +
> +		cpmux@11b04 {
> +			device_type = "cpmux";
> +			compatible = "fcc";
> +			reg = <11b04>;
> +		};
> +
> +		cpmux@11b08 {
> +			device_type = "cpmux";
> +			compatible = "scc";
> +			reg = <11b08>;
> +		};

I don't understand the value of these either.

> +
> +		scc@11a20 {
> +			device_type = "serial";
> +			compatible = "cpm_uart";
> +			model = "SCC1";
> +			reg = <11a20 100>;
> +			reg_pram = <8000 ff>;
> +			clock_setup = <0x00ffffff 0>;
> +			interrupts = <28 3>;

None of this is variable.  If you know you are using scc1,
you must use certain configuration bits in the cmxscr (the
thing you are calling cpmux).  Why would you want to make
this variable and prone to error?  The driver knows, and
there are no options.  Same for the interrupts that are used.

> +		fcc@11300 {
> +			device_type = "network";
> +			compatible = "fs_enet";
> +			model = "FCC1";
> +			reg = <11300 1f>;
> +			reg_pram = <8400 ff>;
> +			address = [00 00 00 00 00 00];

I'm assuming this is the MAC address, and is probably
the only thing I see of value here.

>     More devices will be defined as this spec matures.

I just don't understand the value of this.  Will you explain
it for me?

Thanks.


	-- Dan
