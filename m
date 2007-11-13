Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.241])
	by ozlabs.org (Postfix) with ESMTP id EFB3EDDEE7
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Nov 2007 04:16:56 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id d23so290847and
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Nov 2007 09:16:54 -0800 (PST)
Message-ID: <fa686aa40711130916k232fc7cfjac1d08b3b266fb48@mail.gmail.com>
Date: Tue, 13 Nov 2007 10:16:54 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Sri nava kala devi Valteti, TLS-Chennai" <srinavakalav@hcl.in>
Subject: Re: MPC5200B - Mapping Micrel Ethernet Controller Chip
In-Reply-To: <66E8AEE9980BB44CA5FCAD39EBA56AC602D89B6B@CHN-HCLT-EVS02.HCLT.CORP.HCL.IN>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <66E8AEE9980BB44CA5FCAD39EBA56AC602D89B6B@CHN-HCLT-EVS02.HCLT.CORP.HCL.IN>
Cc: "Prakash Palanisamy, TLS-Chennai" <prakashp@hcl.in>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 11/13/07, Sri nava kala devi Valteti, TLS-Chennai
<srinavakalav@hcl.in> wrote:
>
> Hi
> Thank you for your response.
> > Are you *sure* it's mapped at physical address 0xe0000000? (ie. have
> >you verified that you can access the device registers via u-boot or a
> >debugger?)
>
> Yes, We have accessed the Micrel chip via U-boot setting (Micrel Chips
> Base addres) 0xE0000000 to the CS1 Start address Register.
> The LP_CS1 pin is configured to access the chip in U-boot.
>
>
> LINUX:
> We also probed the CS1 signal and found some noise in the signal (but
> wasn't any kind of pulse). It might not be the actual Chip Select pulse.
> But in U-Boot, we are getting proper Chip Select pulse.

Most likely, something in the board setup routine (in Linux) is
fiddling with the CS settings (which it should not do).  If you u-boot
has it working, then it *should* just carry over to working in Linux.

>
> LINUX:
> The MBAR is mapped to default 0xF0000000 value. The BAT 2 settings in
> the "mpc52xx_set_bat" function, is set to map the 0xf0000000 area.
> Do we need to perform any similar BAT settings or any other settings to
> access the IO Device mapped at 0xE0000000 ?

No.  u-boot should be responsible for configuring the CS pins.  Once
the kernel takes over, you should only need to call ioremap() to get
access to the device.

mpc52xx_set_bat?  You must be using arch/ppc (which is depreciated).
Can you move up to a more recent kernel and use arch/powerpc instead?

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
