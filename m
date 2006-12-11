Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C992867BAC
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Dec 2006 14:41:25 +1100 (EST)
In-Reply-To: <1165648490.1103.117.camel@localhost.localdomain>
References: <20061208190758.6cee088f.kim.phillips@freescale.com>
	<1165648490.1103.117.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <91EF8E0D-06BC-47FD-89E6-6350430946F9@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: consolidate mpc83xx platform files
Date: Sun, 10 Dec 2006 21:41:24 -0600
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 9, 2006, at 1:14 AM, Benjamin Herrenschmidt wrote:

> On Fri, 2006-12-08 at 19:07 -0600, Kim Phillips wrote:
>> Eliminate code redundancy.  mpc83[246]x_{mds,itx,sys,pb} files merged
>> into a single setup.c.  machine_probe, instead of using the model  
>> property,
>> checks the compatible property for "MPC83xx" (dts files updated  
>> appropriately).
>> This patch also utilizes of_platform_bus_probe() in lieu of manually
>> calling of_platform_device_create for each ucc_geth device.
>>
>> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>

Nack on the patch.

> I am not completely certain this is the right approach.
>
> While factoring code is good, I think that every single board should
> have it's own ppc_md, though you can definitely provide "common"
> functions for mpc83xx that can optinally be used by those different
> boards.
>
> Maybe put all the freescale ones in one file if you want...
>
> The rationale here is that while your approach is fine for your eval
> boards, I don't think it's good for embedded customers. They may want
> more complex platforms, with their own directory even if they have  
> a lot
> of custom stuff on the board while still possibly picking some of your
> "common" code (and their board shouldn't match your overly generic
> probe() implementation).
>
> Cheers,
> Ben.

I'm with Ben on this.  I think consolidating the code that is common  
is fine, but we should have a define_machine() per board.  You can  
put them all in one mpc83xx/fsl.c

- k 
