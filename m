Return-Path: <nd@bplan-gmbh.de>
Received: from mo-p07-ob.rzone.de (mo-p07-ob.rzone.de [81.169.146.188])
	by ozlabs.org (Postfix) with ESMTP id 6E65B67CE1
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Nov 2006 07:37:31 +1100 (EST)
Date: Wed, 1 Nov 2006 21:37:28 +0100 (MET)
Message-ID: <4549056C.6080503@bplan-gmbh.de>
From: Nicolas DET <nd@bplan-gmbh.de>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] [POWERPC] Move mpc52xx-psc uart driver to of_device from
	platform_device
References: <11623703962380-git-send-email-grant.likely@secretlab.ca>	<11623704061869-git-send-email-grant.likely@secretlab.ca>	<11623704063907-git-send-email-grant.likely@secretlab.ca>	<11623704071131-git-send-email-grant.likely@secretlab.ca>	<1162370407105-git-send-email-grant.likely@secretlab.ca>
	<11623704073308-git-send-email-grant.likely@secretlab.ca>
In-Reply-To: <11623704073308-git-send-email-grant.likely@secretlab.ca>
Content-Type: multipart/mixed; boundary="------------090807000604030002020802"
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------090807000604030002020802
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Grant Likely wrote:
> As part of the transition to arch/powerpc, this patch moves the mpc5200 PSC
> driver over to the OF platform bus infrastructure.
> 
> This patch is not acceptable for mainline as-is because it breaks arch/ppc
> support for the mpc52xx.  More rework is needed to allow it to compile for
> either arch (or alternately, fork the driver)
> 

It has been hard to apply on 2.6.19-rc4 but it seems to perform well.
I add to add some entries in mpc52xx_uart_match[]

In now looks like this:
static struct of_device_id mpc52xx_uart_match[] = {
	{
		.name = "serial",
		.compatible = "mpc52xx-psc",
	},
	{
		.name = "serial",
		.compatible = "mpc52xx-serial",
	},
	{
		.name = "serial",
		.compatible = "mpc5200-psc",
	},
	{
		.name = "serial",
		.compatible = "mpc5200-serial",
	},
	{},
};


By the way, why not using mpc52xx_uart_match[] to also in 
mpc52xx_console_setup() to track down any devices?

Regards,

--------------090807000604030002020802
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


--------------090807000604030002020802--
