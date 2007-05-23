Return-Path: <bhupi.saharan@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.174])
	by ozlabs.org (Postfix) with ESMTP id 0048DDDE07
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 May 2007 06:12:37 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id c2so210909ugf
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 May 2007 13:12:29 -0700 (PDT)
Message-ID: <720399a30705231312k1f81fdb2oc0cf598994cfa1cc@mail.gmail.com>
Date: Wed, 23 May 2007 13:12:28 -0700
From: "Bhupender Saharan" <bhupi.saharan@gmail.com>
To: "Johan Borkhuis" <j.borkhuis@dutchspace.nl>
Subject: Re: Problems with access to PCI on MVME3100
In-Reply-To: <4653E3A3.8020600@dutchspace.nl>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_140880_11498777.1179951148066"
References: <4653E3A3.8020600@dutchspace.nl>
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

------=_Part_140880_11498777.1179951148066
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Johan,

>From the pci log it looks like that BAR registers are not mapped properly by
the BIOS/U-boot. Looks like you have 3 BARS which are asking for memory, But
that are not spaced apart propoerly. Mean physical address difference
between BAR0 and BAR2 shall be 512 Megabyte, but that is not what it is
programmed.

Need to fix up the memory allocation first. then we need to see if the DMA
descriptor are defimed propoerly. As you are saying you are porting the
driver from X-86 to PPC. SO endian coversion is required.....

Regards
Bhupi









On 5/22/07, Johan Borkhuis <j.borkhuis@dutchspace.nl> wrote:
>
> Hello,
>
> I am working on porting a PCI driver from I386-Linux to PPC (MVME-3100).
> The device is a Reflective Memory card (VMIC 5565), and we use a driver
> based on the standard Linux driver, provided by the supplier.
>
> I try to start a DMA transfer (using the DMA engine on the PCI card)
> from user space, but then I get a PCI Error. The following data is
> displayed:
> PCI Error!
> PCI ERROR DETECT REG 0x00000042
> PCI ERROR ADDRESS REG 0x00fffa00
> PCI ERROR EXT ADDRESS REG 0x00000000
> PCI ERROR ATTRIBUTES REG 0x0000c001
> PCI ERROR DATA HIGH REG 0x60010004
> PCI ERROR DATA LOW REG 0x10060020
> PCI STATUS REG 0x0000
> PCI GASKET TIMER REG 0x00003fff
> PCI PCIX TIMER REG 0x01ffffff
>
> Access to the registers from kernel mode is no problem. I did an mmap to
> map the registers into user space, and then access the registers as an
> array of chars or ints. Is there a limitation in access to PCI registers
> from user space on PPC?
>
> When I try to do this in kernel mode I don't get any errors, but the
> transfer is not started. I am not sure if this is a SW problem, or that
> it might be caused by the PCI-PCI bridge.
>
> The code runs perfectly on a I386 platform, and I use read[bwl] and
> write[bwl] to access the registers, so this should fix the endianess
> problems that exist.
>
> Below is the PCI information from the card:
> 01:00.0 Network controller: VMIC: Unknown device 5565 (rev 01)
>        Subsystem: PLX Technology, Inc.: Unknown device 9656
>        Flags: 66Mhz, medium devsel, IRQ 52
>        Memory at 00000000dfeffe00 (32-bit, non-prefetchable) [size=512]
>        I/O ports at e0ffff00 [size=256]
>        Memory at 00000000dfeffdc0 (32-bit, non-prefetchable) [size=64]
>        Memory at 00000000d8000000 (32-bit, non-prefetchable) [size=64M]
>        Capabilities: [40] Power Management version 2
>        Capabilities: [48] #00 [0080]
>
> Kind regards,
>     Johan Borkhuis
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>

------=_Part_140880_11498777.1179951148066
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Johan,<br><br>From the pci log it looks like that BAR registers are not mapped properly by the BIOS/U-boot. Looks like you have 3 BARS which are asking for memory, But that are not spaced apart propoerly. Mean physical address difference between BAR0 and BAR2 shall be 512 Megabyte, but that is not what it is programmed.
<br><br>Need to fix up the memory allocation first. then we need to see if the DMA descriptor are defimed propoerly. As you are saying you are porting the driver from X-86 to PPC. SO endian coversion is required.....<br><br>
Regards<br>Bhupi<br><br><br><br><br><br><br><br><br><br><div><span class="gmail_quote">On 5/22/07, <b class="gmail_sendername">Johan Borkhuis</b> &lt;<a href="mailto:j.borkhuis@dutchspace.nl">j.borkhuis@dutchspace.nl</a>&gt; wrote:
</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hello,<br><br>I am working on porting a PCI driver from I386-Linux to PPC (MVME-3100).
<br>The device is a Reflective Memory card (VMIC 5565), and we use a driver<br>based on the standard Linux driver, provided by the supplier.<br><br>I try to start a DMA transfer (using the DMA engine on the PCI card)<br>from user space, but then I get a PCI Error. The following data is
<br>displayed:<br>PCI Error!<br>PCI ERROR DETECT REG 0x00000042<br>PCI ERROR ADDRESS REG 0x00fffa00<br>PCI ERROR EXT ADDRESS REG 0x00000000<br>PCI ERROR ATTRIBUTES REG 0x0000c001<br>PCI ERROR DATA HIGH REG 0x60010004<br>PCI ERROR DATA LOW REG 0x10060020
<br>PCI STATUS REG 0x0000<br>PCI GASKET TIMER REG 0x00003fff<br>PCI PCIX TIMER REG 0x01ffffff<br><br>Access to the registers from kernel mode is no problem. I did an mmap to<br>map the registers into user space, and then access the registers as an
<br>array of chars or ints. Is there a limitation in access to PCI registers<br>from user space on PPC?<br><br>When I try to do this in kernel mode I don&#39;t get any errors, but the<br>transfer is not started. I am not sure if this is a SW problem, or that
<br>it might be caused by the PCI-PCI bridge.<br><br>The code runs perfectly on a I386 platform, and I use read[bwl] and<br>write[bwl] to access the registers, so this should fix the endianess<br>problems that exist.<br><br>
Below is the PCI information from the card:<br>01:00.0 Network controller: VMIC: Unknown device 5565 (rev 01)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Subsystem: PLX Technology, Inc.: Unknown device 9656<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Flags: 66Mhz, medium devsel, IRQ 52<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Memory at 00000000dfeffe00 (32-bit, non-prefetchable) [size=512]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I/O ports at e0ffff00 [size=256]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Memory at 00000000dfeffdc0 (32-bit, non-prefetchable) [size=64]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Memory at 00000000d8000000 (32-bit, non-prefetchable) [size=64M]
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Capabilities: [40] Power Management version 2<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Capabilities: [48] #00 [0080]<br><br>Kind regards,<br>&nbsp;&nbsp;&nbsp;&nbsp;Johan Borkhuis<br><br>_______________________________________________<br>Linuxppc-embedded mailing list
<br><a href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a><br><a href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a><br></blockquote>
</div><br>

------=_Part_140880_11498777.1179951148066--
