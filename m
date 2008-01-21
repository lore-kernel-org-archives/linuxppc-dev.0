Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.246])
	by ozlabs.org (Postfix) with ESMTP id 8DE58DE18D
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Jan 2008 04:16:45 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so492622anc.78
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 21 Jan 2008 09:16:44 -0800 (PST)
Message-ID: <fa686aa40801210916g6c645e1cq21b2106da75db157@mail.gmail.com>
Date: Mon, 21 Jan 2008 10:16:44 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: greenlean <jmgomez@atc.ugr.es>
Subject: Re: Generated xilinx linux 2.6 image sections
In-Reply-To: <14997109.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <14997109.post@talk.nabble.com>
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

On 1/21/08, greenlean <jmgomez@atc.ugr.es> wrote:
>
> Hi all,
>
> I'm trying to boot the 2.6 xilinx kernel downloaded from their git server in
> the XUPV2P board I'm really having troubles (I can't see anything in the
> minicom console terminal). I'm not seeing anything, neither the ucompressing
> kernel string nor the prompt with the memory addresses that kernel prompt at
> first time, so I have started to distrust of anything.
>
> When I download the kernel using xmd, I see:
>
> XMD% dow imagen_UART16550_ml300.elf
>         section, .text: 0x00400000-0x0040387b
>         section, .data: 0x00404000-0x004e6fff
>         section, .bss: 0x004e7000-0x004e919f
> Downloaded Program imagen_UART16550_ml300.elf
> Setting PC with Program Start Address 0x00400000
>
<snip>
> I suppossed this is because the image kernel is compressed, but despite
> beeing compressed it should have a boot section or something similar ???
> It's right that the kernel start address is set to the 0x00400000??
>
> Or does the section .text  contains all the kernel code to uncompresse the
> code of the kernel??

Yes; what you're seeing is the sections for the boot wrapper; not for
the kernel itself.  The bootwrapper carries a compressed kernel image
as it's payload (notice how large the .data section is?).  To see the
sections on the kernel proper, use readelf on the vmlinux file in the
kernel tree.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
