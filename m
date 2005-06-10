Return-Path: <tnt@246tNt.com>
Received: from outmx002.isp.belgacom.be (outmx002.isp.belgacom.be
	[195.238.3.52]) by ozlabs.org (Postfix) with ESMTP id 85BA5679F1
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Jun 2005 00:09:27 +1000 (EST)
Received: from outmx002.isp.belgacom.be (localhost [127.0.0.1])
	by outmx002.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id j5AE9Hp2004891
	for <linuxppc-embedded@ozlabs.org>; Fri, 10 Jun 2005 16:09:18 +0200
	(envelope-from <tnt@246tNt.com>)
Message-ID: <42A99F1C.50104@246tNt.com>
Date: Fri, 10 Jun 2005 16:09:32 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Grant Likely <glikely@gmail.com>
References: <528646bc05060907544d58da41@mail.gmail.com>	
	<02ea73261175dc6bfb99047e73395fb1@freescale.com>
	<528646bc050609114857191ca7@mail.gmail.com>
In-Reply-To: <528646bc050609114857191ca7@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC52xx: sysfs failure on adding new device driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Grant

> In the mean time, here's another option:  Leave
> arch/ppc/syslib/mpc52xx_devices.c alone, but modify the table in the
> board setup code to assign specific drivers to the PSC devices before
> the table is parsed by the platform bus.  This has the added advantage
> of eliminating the need for mpc52xx_match_psc_function() and it's
> cousins.

> +	/* Assign driver names to PSC devices */
> +	ppc_sys_platform_devices[MPC52xx_PSC1].name = "mpc52xx-psc.uart";
> +	ppc_sys_platform_devices[MPC52xx_PSC2].name = "mpc52xx-psc.uart";
> +	ppc_sys_platform_devices[MPC52xx_PSC3].name = "mpc52xx-psc.spi";

Yes, I kinda like that. That maybe the cleanest way, just 1 line of code 
per device and when no subfn is assigned, nothing is loaded.

I don't really like messing manually with the ppc_sys_platform 
"internals" outside of the ppc_sys code, but maybe creating a call like

ppc_sys_assign_subfn(MPC52xx_PSC1,"uart");


and place it in the ppc_sys code so that other platforms havin such 
"multi usage" device all have an uniform way of handling that. Galak ?



	Sylvain
