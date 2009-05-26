Return-Path: <thunderbird2k@gmail.com>
Received: from mail-bw0-f171.google.com (mail-bw0-f171.google.com
	[209.85.218.171]) by ozlabs.org (Postfix) with ESMTP id 0DE6CDDDA5
	for <linuxppc-dev@ozlabs.org>; Tue, 26 May 2009 22:41:15 +1000 (EST)
Received: by bwz19 with SMTP id 19so3763085bwz.9
	for <linuxppc-dev@ozlabs.org>; Tue, 26 May 2009 05:41:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <c8485d470905251347m4e3b7022u4f0324dfc154cfb2@mail.gmail.com>
References: <20090525144023.13016.23071.stgit@localhost.localdomain>
	<c8485d470905251347m4e3b7022u4f0324dfc154cfb2@mail.gmail.com>
Date: Tue, 26 May 2009 14:41:10 +0200
Message-ID: <c8485d470905260541t65e35d86l8c676a2b016c0ff8@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] Series short description
From: Roderick Colenbrander <thunderbird2k@gmail.com>
To: Grant Likely <grant.likely@secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 25, 2009 at 10:47 PM, Roderick Colenbrander
<thunderbird2k@gmail.com> wrote:
> On Mon, May 25, 2009 at 4:41 PM, Grant Likely <grant.likely@secretlab.ca>=
 wrote:
>> Repost of ml510 series. =A0This time against 2.6.30-rc7 and with the .dt=
s
>> file included.
>>
>> g.
>>
>> --
>> Grant Likely, B.Sc. P.Eng.
>> Secret Lab Technologies Ltd.
>>
>
> Thanks, I will check it out tomorrow.
>
> Roderick
>

Hi,

I have tested the ml510 patches. The code works properly but I had to
make a few slight changes to get it functioning. The most important
change was in xilinx_intc driver. For level interrupts the ack command
was removed during the xilinx_intc rewrite which caused a null pointer
derefence in the i8259 cascade code. I have now changed it to:
/* Let xilinx_intc end the interrupt */
desc->chip->mask(irq);
desc->chip->unmask(irq);

This seems to work properly. Further the driver now also has proper
level support, so i think my dts file has some errors. The pci
interrupts (a/b/c/d) are all active low, so they need to be changed to
'3' for the sense level. Further the i8259 is active high which needs
to be set to 2 instead of 3.

Further I have tested the need for the outb to 0x4d0/0x4d1. Removing
those lines causes interrupt timeouts and ide won't function.
Freescale does the same in arch/powerpc/platforms/fsl_uli1575.c (which
is a much newer version of this chipset) in quirk_final_uli1575 but
they are doing it for some more interrupts. I think this code should
be done using a similar quirk in virtex_ml510.c

Roderick
