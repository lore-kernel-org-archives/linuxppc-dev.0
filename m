Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 08D76B7E3E
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2010 02:45:21 +1100 (EST)
Date: Wed, 27 Jan 2010 16:45:19 +0100
From: Anatolij Gustschin <agust@denx.de>
To: Jan Andersson <jan@gaisler.com>
Subject: Re: [PATCH 5/8 v2] powerpc/mpc5121: add USB host support
Message-ID: <20100127164519.4124580c@wker>
In-Reply-To: <4B60333C.9040806@gaisler.com>
References: <1264594052-20317-1-git-send-email-agust@denx.de>
	<1264594052-20317-6-git-send-email-agust@denx.de>
	<4B60333C.9040806@gaisler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-usb@vger.kernel.org, wd@denx.de, dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 27 Jan 2010 13:36:12 +0100
Jan Andersson <jan@gaisler.com> wrote:

> Anatolij Gustschin wrote:
> > @@ -259,6 +305,11 @@ static int ehci_fsl_setup(struct usb_hcd *hcd)
> >  {
> >  	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
> >  	int retval;
> > +	struct fsl_usb2_platform_data *pdata;
> > +
> > +	pdata = hcd->self.controller->platform_data;
> > +	ehci->big_endian_desc = pdata->big_endian_desc;
> > +	ehci->big_endian_mmio = pdata->big_endian_mmio;
> 
> I recently posted some questions to linux-usb@vger about big_endian_mmio 
> and the definition of the HC_LENGTH and HC_VERSION macros. The thread 
> can be found here: http://marc.info/?l=linux-usb&m=126441448626924&w=2
> 
> The EHCI specification defines the CAPLENGTH register as an 8-bit 
> register at byte offset 0 and HCIVERSION as a 16-bit register at byte 
> offset 2. Performing a 32-bit read on a big endian system should 
> therefore results in the following organisation (MSB .. LSB):
> CAPLENGTH : RESERVED : HCIVERSION
> 
> The macros for reading CAPLENGTH and HCIVERSION (defined in 
> include/linux/usb/ehci-def.h) look like:
> 
> #define HC_LENGTH(p)		(((p)>>00)&0x00ff)	/* bits 7:0 */
> #define HC_VERSION(p)		(((p)>>16)&0xffff)	/* bits 31:16 */
> 
> That is, they select the registers as they were organized within the 
> word according to little endian. Is this not a problem for your 
> controller/driver?

On this controller the CAPLENGTH register is an 8-bit regiser at
byte offset 3 and HCIVERSION register is a 16-bit register at
byte offset 0. Performing a 32-bit read results in:
HCIVERSION : RESERVED : CAPLENGTH

So it is not a problem for the driver.

Best regards,
Anatolij
