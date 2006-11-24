Return-Path: <glppd-linuxppc64-dev@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 05BF967B52
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Nov 2006 07:05:16 +1100 (EST)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1GngkP-0006Bw-Fq
	for linuxppc-dev@ozlabs.org; Fri, 24 Nov 2006 20:30:09 +0100
Received: from mnhm-590c13b4.pool.einsundeins.de ([89.12.19.180])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Nov 2006 20:30:05 +0100
Received: from deller by mnhm-590c13b4.pool.einsundeins.de with local (Gmexim
	0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Nov 2006 20:30:05 +0100
To: linuxppc-dev@ozlabs.org
From: Helge Deller <deller@gmx.de>
Subject: Re: [PATCH] Fbdev driver for IBM GXT4500P video cards
Date: Fri, 24 Nov 2006 20:13:08 +0100
Message-ID: <ek7g84$93g$1@sea.gmane.org>
References: <17766.24132.505274.631108@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: news <news@sea.gmane.org>
Cc: linux-fbdev-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul,

Paul Mackerras wrote:
> This is an fbdev driver for the IBM GXT4500P display card found in
> some IBM System P (pSeries) machines.  These cards have hardware 2D
> and 3D capabilities, but the driver does not use them; it just exports
> a dumb framebuffer.


You might try to "const"-ify a few static structs and arrays...

Helge


> +/* Indexed by DFA_PIX_* values */
> +static unsigned char watfmt[] = {
> +     WAT_FMT_8BIT, WAT_FMT_16BIT_565, WAT_FMT_16BIT_1555, 0,


> +static unsigned char mdivtab[] = {
> +/* 1 */                    0x3f, 0x00, 0x20, 0x10, 0x28, 0x14, 0x2a, 0x15, 0x0a,


> +static unsigned char ndivtab[] = {
> +/* 2 */                          0x00, 0x80, 0xc0, 0xe0, 0xf0, 0x78, 0xbc, 0x5e,



not sure about those:

> +static struct fb_bitfield eightbits = {0, 8};
> +static struct fb_bitfield nobits = {0, 0};


> +static struct fb_ops gxt4500_ops = {
> +     .owner = THIS_MODULE,


> +static struct pci_device_id gxt4500_pci_tbl[] = {
> +     { PCI_VENDOR_ID_IBM, PCI_DEVICE_ID_IBM_GXT4500P,
> +       PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },


maybe this one:
> +static struct pci_driver gxt4500_driver = {
> +     .name = "gxt4500",

and maybe more ?
