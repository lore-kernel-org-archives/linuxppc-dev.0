Return-Path: <bhupi.saharan@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.174])
	by ozlabs.org (Postfix) with ESMTP id CA147DDE0A
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 02:33:01 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k40so148577ugc
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 09:33:00 -0700 (PDT)
Message-ID: <720399a30707110932n5a4ddb33u552f5b01921f34b5@mail.gmail.com>
Date: Wed, 11 Jul 2007 09:32:59 -0700
From: "Bhupender Saharan" <bhupi.saharan@gmail.com>
To: "Nicolas Mederle" <mederle_nicolas@yahoo.fr>
Subject: Re: PageFault when I write in the Serial registers, MMU ?
In-Reply-To: <4694F9BD.4090406@yahoo.fr>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_6220_32915590.1184171579967"
References: <4694F9BD.4090406@yahoo.fr>
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_6220_32915590.1184171579967
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

You could call *io_block_mapping* function from your setup.c file that will
add the entry into MMU.

regards
Bhupi





On 7/11/07, Nicolas Mederle <mederle_nicolas@yahoo.fr> wrote:
>
> Hi,
>
>    I am porting linux on a custom board equipped with a PPC750, and I
> will like to have some advices on the MMU. I used the powerpc arch, and
> I built my device tree.
>    I will like to know in which files we can configure the
> authorizations access for the I/O registers. When I use the function
> md_ppc.progress, I have a data access fault. I modified the head. S
> files, for add the BAT config. But I think that it is not correct, and
> that it is possible to do it elsewhere (platform_init?). Moreover the
> kernel modify the MMU config, it removes the BATs, and configures the
> Registers Segments. So, must I remake the configuration? Or is it
> possible to indicate, at the beginning, which space is reserved for I/O?
>    I studied several patch (sandpoint, PrPMC2800) but none configures
> really the MMU for I/O registers. In the same way, I read several books,
> but I am not able to have information that I seek, therefore I am really
> blocked. I warmly thank you for the assistance which you will be able to
> bring to me.
>
>    Mapping :     0x0000 0000    ->  0x0FFF FFFF   :   RAM
>                         0x2000 0000   ->   0x201F FFFF   :   ASIC (
> UART, DMA, GPIO, PIC...)
>                         0x8000 0000   ->   0x8FFF FFFF   :   PCI
>                         0xF000 0000   ->   0xFFFF FFFF   :   Flash
>    The kernel is load at 0x0, an the system is a Run In Memory.
> Currently, I don't use the flash.
>
>
> Best regards,
> Nicolas MEDERLE
>
> --
> Cordialement,
>
> Nicolas MEDERLE.
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>

------=_Part_6220_32915590.1184171579967
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi,</div>
<div>&nbsp;</div>
<div>You could call <strong>io_block_mapping</strong> function from your setup.c file that will add the entry into MMU.</div>
<div>&nbsp;</div>
<div>regards</div>
<div>Bhupi</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div><br><br>&nbsp;</div>
<div><span class="gmail_quote">On 7/11/07, <b class="gmail_sendername">Nicolas Mederle</b> &lt;<a href="mailto:mederle_nicolas@yahoo.fr">mederle_nicolas@yahoo.fr</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Hi,<br><br>&nbsp;&nbsp; I am porting linux on a custom board equipped with a PPC750, and I<br>will like to have some advices on the MMU. I used the powerpc arch, and
<br>I built my device tree.<br>&nbsp;&nbsp; I will like to know in which files we can configure the<br>authorizations access for the I/O registers. When I use the function<br>md_ppc.progress, I have a data access fault. I modified the head. S
<br>files, for add the BAT config. But I think that it is not correct, and<br>that it is possible to do it elsewhere (platform_init?). Moreover the<br>kernel modify the MMU config, it removes the BATs, and configures the<br>
Registers Segments. So, must I remake the configuration? Or is it<br>possible to indicate, at the beginning, which space is reserved for I/O?<br>&nbsp;&nbsp; I studied several patch (sandpoint, PrPMC2800) but none configures<br>really the MMU for I/O registers. In the same way, I read several books,
<br>but I am not able to have information that I seek, therefore I am really<br>blocked. I warmly thank you for the assistance which you will be able to<br>bring to me.<br><br>&nbsp;&nbsp; Mapping :&nbsp;&nbsp;&nbsp;&nbsp; 0x0000 0000&nbsp;&nbsp;&nbsp;&nbsp;-&gt;&nbsp;&nbsp;0x0FFF FFFF&nbsp;&nbsp; :&nbsp;&nbsp; RAM
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0x2000 0000&nbsp;&nbsp; -&gt;&nbsp;&nbsp; 0x201F FFFF&nbsp;&nbsp; :&nbsp;&nbsp; ASIC (<br>UART, DMA, GPIO, PIC...)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0x8000 0000&nbsp;&nbsp; -&gt;&nbsp;&nbsp; 0x8FFF FFFF&nbsp;&nbsp; :&nbsp;&nbsp; PCI<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0xF000 0000&nbsp;&nbsp; -&gt;&nbsp;&nbsp; 0xFFFF FFFF&nbsp;&nbsp; :&nbsp;&nbsp; Flash
<br>&nbsp;&nbsp; The kernel is load at 0x0, an the system is a Run In Memory.<br>Currently, I don&#39;t use the flash.<br><br><br>Best regards,<br>Nicolas MEDERLE<br><br>--<br>Cordialement,<br><br>Nicolas MEDERLE.<br><br>_______________________________________________
<br>Linuxppc-embedded mailing list<br><a href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a><br><a href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded
</a><br></blockquote></div><br>

------=_Part_6220_32915590.1184171579967--
