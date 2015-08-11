Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0113.outbound.protection.outlook.com [157.56.111.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 078A51A039F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2015 12:29:44 +1000 (AEST)
Message-ID: <1439260166.4099.14.camel@freescale.com>
Subject: Re: using general IRQs
From: Scott Wood <scottwood@freescale.com>
To: Ran Shalit <ranshalit@gmail.com>
CC: <linuxppc-dev@lists.ozlabs.org>
Date: Mon, 10 Aug 2015 21:29:26 -0500
In-Reply-To: <CAJ2oMhJVqph9vb=Q-vbzRRygT+s3wvtm9nVNJ9TLcB_6iQCVcA@mail.gmail.com>
References: <CAJ2oMhLX18merCHtge0oOQ2DSQ8BE1Zd=dAuPWzyTRNmr-DLiA@mail.gmail.com>
 <CAJ2oMhJVqph9vb=Q-vbzRRygT+s3wvtm9nVNJ9TLcB_6iQCVcA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-08-10 at 13:40 +0300, Ran Shalit wrote:
> On Mon, Aug 10, 2015 at 10:48 AM, Ran Shalit <ranshalit@gmail.com> wrote:
> > Hello,
> > 
> > MPC8349 has general IRQ numbered 0-7,
> > It is required to bind these IRQs with some routine , i.e. they are
> > not used with any specific driver.
> > 
> > - Should they be configured as gpios in device tree so that we can use
> > the gpio as irq in linux ? Is there any example ?
> > - After configuration, can the gpios be used in linux using the
> > standard /sys/class/gpio ?
> > 
> > Regards,
> > Ran

What do you mean by "general IRQ"?  Do you mean external IRQs?

> I am trying to use only IRQ4, so I have tried to configure it as
> following in device tree:
> 
> device tree:
> 
>   intc@0{
>  compatible = "intc";
>  #address-cells = <1>;
>  #size-cells = <0>;
>  reg = <0 0x1000>;
>  interrupts = <4 0x8>;
>   };
> 
> But I don't see IRQ4 listed in the interrupt list:
> # cat /proc/interrupts

/proc/interrupts shows virtual interrupts, which do not necessarily 
correspond to anything in the device tree.  In particular, virtual interrupts 
under 16 are reserved for ISA interrupts, and thus any mpic interrupts in 
that range will be remapped.

Additionally, putting an interrupt in the device tree does not make it show 
up in /proc/interrupts.  Only interrupts for which a driver has registered a 
handler will show up in /proc/interrupts.

-Scott
