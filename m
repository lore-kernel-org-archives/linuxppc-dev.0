Return-Path: <jchapman@katalix.com>
Received: from ptb-relay03.plus.net (ptb-relay03.plus.net [212.159.14.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 450E267A67
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 Mar 2005 08:31:29 +1100 (EST)
Message-ID: <42238DAC.2030202@katalix.com>
Date: Mon, 28 Feb 2005 21:31:24 +0000
From: James Chapman <jchapman@katalix.com>
MIME-Version: 1.0
To: "Mark A. Greer" <mgreer@mvista.com>
References: <42235B0A.3070302@katalix.com> <422384CA.6090004@mvista.com>
In-Reply-To: <422384CA.6090004@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 2.6.11-rc4] ppc: add support for Radstone ppc7d boards
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Mark,

Thanks for reviewing my patch.

Mark A. Greer wrote:

>  >  diff -Nru a/arch/ppc/platforms/radstone_ppc7d.c 
> b/arch/ppc/platforms/radstone_ppc7d.c
>  > +void __init ppc7d_setup_peripherals(void)
> 
>  > +       val32 = mv64x60_read(&bh, MV64x60_PCI1_PCI_DECODE_CNTL);
>  > +       val32 &= ~(1 << 3);
>  > +       mv64x60_write(&bh, MV64x60_PCI1_PCI_DECODE_CNTL, val32);
> 
> Bit 3 is already cleared by the core code.

Oh ok. I'll remove it.

>  > +       /* Setup P2P for PCI#0 */
>  > +       val32 = mv64x60_read(&bh, MV64x60_PCI0_P2P_CONFIG);
>  > +       val32 &= ~(0x00ffffff);
>  > +       val32 |= ((bh.hose_a->first_busno & 0xff) << 16);
> etc.
> 
> Do you really use the P2P bridge?  Unless I missed something, I think it 
> remains disabled.  You shouldn't need it unless you have PCI devices on 
> one hose directly accessing PCI devices on the other hose.  The P2P 
> stuff seems complicated & unnecessary.

It was a feature that the Radstone folk wanted to allow, although they
had no application for it at the time. I can probably just remove that
code for now - if they ever do want to add that support, it would be
a separate patch.

I'll retest with the above code removed and submit a new patch.

-- 
James Chapman
PGP key : http://www.katalix.com/~jchapman/pgpkey.txt
