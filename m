Return-Path: <LeoLi@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 20BBE67A6E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 31 Mar 2005 18:22:41 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	j2V8PVkN023706 for <linuxppc-embedded@ozlabs.org>;
	Thu, 31 Mar 2005 01:25:31 -0700 (MST)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id j2V8OIbU014292
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 31 Mar 2005 02:24:19 -0600 (CST)
Message-ID: <9FCDBA58F226D911B202000BDBAD46730117355F@zch01exm40.ap.freescale.net>
From: Li Yang-r58472 <LeoLi@freescale.com>
To: Eugene Surovegin <ebs@ebshome.net>
Date: Thu, 31 Mar 2005 16:22:26 +0800
MIME-Version: 1.0
Content-Type: text/plain
Cc: Linux PPC Embedded list <linuxppc-embedded@ozlabs.org>
Subject: RE: Problem running Linux 2.6.11 on MPC8272ADS
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Good point.
There is also IMMR need to be passed from bootloader to kernel.  We can make more use of the u-boot bd_info mechanism.  But it binds ppc linux to u-boot boot loader.  I don't know if we should make it a porting convention.

Best Regards,
Leo

> -----Original Message-----
> From: Eugene Surovegin [mailto:ebs@ebshome.net]
> Sent: Thursday, March 31, 2005 11:27 AM
> To: Li Yang-r58472
> Cc: Walter L. Wimer III; Gala Kumar K.-galak; Linux PPC Embedded list
> Subject: Re: Problem running Linux 2.6.11 on MPC8272ADS
> 
> On Thu, Mar 31, 2005 at 11:03:00AM +0800, Li Yang-r58472 wrote:
> > Well, it seems to be a historic problem.  Freescale BSP was
> > originally ported from u-boot-1.0.0 and linux-2.4.22.  So the BCSR
> > was freely chosen as 0xf8000000.  Later, we updated them to
> > u-boot-1.1.1 and linux-2.4.26, and make the BCSR consistent to older
> > version.  However the sourceforge u-boot-1.1.1 support for
> > MPC8272ADS
> > was committed by Arabella guys, they chose BCSR mapping to
> > 0xf4500000.  Kumar's MPC8272 support which is in 2.6.11 source was
> > developed using sourceforge u-boot-1.1.1 seemingly.
> >
> > This might brought up a question that if we need a convention or
> > something to define the recommended memory mapping for PowerPC BSPs.
> > As there are different groups of people around the world developing
> > BSPs for PowerPC platforms, and often the communication between them
> > is very limited.
> >
> > For now using kernel and u-boot released from the same vendor is recommended.
> >
> 
> There is trivial solution which will work regardless on which version
> of U-Boot and kernel you are using.
> 
> DO NOT hardcode such stuff in TWO DIFFERENT places, do this only in
> one, in this case it should be firmware (e.g. U-Boot).
> 
> In kernel just read BRx register for that chip select and use this
> address for accesses from the kernel. This is how I do on all my
> board ports.
> 
> No need to establish any artificial conventions on memory map, etc.
> 
> --
> Eugene
