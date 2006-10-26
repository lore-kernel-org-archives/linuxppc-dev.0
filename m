Return-Path: <nd@bplan-gmbh.de>
Received: from mo-p07-ob.rzone.de (mo-p07-ob.rzone.de [81.169.146.190])
	by ozlabs.org (Postfix) with ESMTP id 4E15E67D34
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Oct 2006 21:17:19 +1000 (EST)
Date: Thu, 26 Oct 2006 13:17:16 +0200 (MEST)
Message-ID: <454098AD.1080400@bplan-gmbh.de>
From: Nicolas DET <nd@bplan-gmbh.de>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] General CHRP/MPC5K2 platform support patch
References: <453FB582.20802@bplan-gmbh.de>	
	<17727.56923.634981.723647@cargo.ozlabs.ibm.com>
	<528646bc0610251541s21bb45f1t6fc911778d5084@mail.gmail.com>
In-Reply-To: <528646bc0610251541s21bb45f1t6fc911778d5084@mail.gmail.com>
Content-Type: multipart/mixed; boundary="------------060602060107090804010204"
Cc: akpm@osdl.org, sl@bplan-gmbh.de, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, linuxppc-embedded@ozlabs.org,
	sha@pengutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------060602060107090804010204
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Paul Mackerras wrote:
 > Nicolas DET writes:
 >
 >>  	if (machine && strncmp(machine, "Pegasos", 7) == 0) {
 >>  		_chrp_type = _CHRP_Pegasos;
 >> +	} else if (machine && strncmp(machine, "EFIKA5K2", 8) == 0) {
 >> +		_chrp_type =_CHRP_E5K2;
 >
 > This whole _chrp_type thing, and having to do different things based
 > on the root-node model property, is really only a workaround for
 > older machines with inadequate device trees.  Decisions about things
 > like which interrupt controller driver(s) to instantiate should be
 > taken based on properties in the appropriate device-tree nodes, for
 > instance the model and compatible properties in the node(s) for the
 > interrupt controller(s).  In fact I'd like to get rid of _chrp_type
 > completely.
 >

I remove this part of the patch which is only cosmetic (good CHRP name).

 >> diff -uprN a/include/asm-ppc/mpc52xx.h b/include/asm-ppc/mpc52xx.h
 >> --- a/include/asm-ppc/mpc52xx.h	2006-10-25 19:07:48.000000000 +0200
 >> +++ b/include/asm-ppc/mpc52xx.h	2006-10-25 19:11:55.000000000 +0200
 >> @@ -119,7 +119,7 @@ enum ppc_sys_devices {
 >>  #define MPC52xx_SDMA_IRQ_NUM	17
 >>  #define MPC52xx_PERP_IRQ_NUM	23
 >>
 >> -#define MPC52xx_CRIT_IRQ_BASE	1
 >> +#define MPC52xx_CRIT_IRQ_BASE	0
 >
 > What is this going to do to other 52xx users?
 >

IRQ 0 may cause issue in earlier kernel as far as I understood. New one, 
using the new IRQ stuff, just works (at least works great here).

This is a revert change from:
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=e21b9f2e9a580ce7375ec58953c1bb19aabe0db4
Regards,

--------------060602060107090804010204
Content-Type: text/x-vcard; charset=utf-8;
 name="nd.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="nd.vcf"

begin:vcard
fn:Nicolas DET ( bplan GmbH )
n:DET;Nicolas
org:bplan GmbH
adr:;;;;;;Germany
email;internet:nd@bplan-gmbh.de
title:Software Entwicklung
tel;work:+49 6171 9187 - 31
x-mozilla-html:FALSE
url:http://www.bplan-gmbh.de
version:2.1
end:vcard


--------------060602060107090804010204--
