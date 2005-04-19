Return-Path: <scop@digitel.com.br>
Received: from hermes.digitel.com.br (hermes.digitel.com.br [200.198.105.36])
	by ozlabs.org (Postfix) with ESMTP id 990F467A6B
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Apr 2005 13:25:44 +1000 (EST)
Received: from [10.10.10.4] by hermes.digitel.com.br (GMS
	9.01.3158/NU1492.00.9f6ce814) with ESMTP id awgfmbaa for
	linuxppc-embedded@ozlabs.org; Tue, 19 Apr 2005 00:16:25 -0200
Content-Type: text/plain;
  charset="iso-8859-1"
From: Ricardo Scop <scop@digitel.com.br>
To: "Atit_Shah" <Atit_Shah@satyam.com>,
	<linuxppc-embedded@ozlabs.org>
Date: Tue, 19 Apr 2005 00:14:09 -0300
References: <D8595042F3765A4285B848A78A2C2ED1027748@bsdmsg002.corp.satyam.ad>
In-Reply-To: <D8595042F3765A4285B848A78A2C2ED1027748@bsdmsg002.corp.satyam.ad>
MIME-Version: 1.0
Message-Id: <200504190014.09256.scop@digitel.com.br>
Subject: Re: Impact of change n port size
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Atit,

On Monday 18 April 2005 01:31, Atit_Shah wrote:
> Hi All,
>
> =09I have a kernel image which works perfectly for my reference
> board. When I try to port the same image on my board I seem to be facin=
g
> problems.=20
Like what?

> The only difference I see between the reference board and my
> board is the port size and capacity of RAM.
And hw design, board layout, ...

> =09I have taken care of sending the right value for the RAM size
> through BD_INFO. Would there be and where all would the change be, if
> any, in the kernel code OR when I make the kernel image ie through "mak=
e
> menuconfig" / "menu xconfig" required to be made for port size of RAM?
Well, if you're using PPCBoot or U-Boot to boot Linux, what you've done w=
ould=20
be enough.

OTOH, as you have a new hardware design you should check the SDRAM contro=
ller=20
initialization in the bootloader code. It may be sligthly wrong, so the=20
bootloader runs but the OS doesn't, because Linux really stresses out RAM=
=20
operation in burst mode. (BTW, this is a FAQ, if appliable).

> =09Out of curiosity what would be the change required for different
> FLASH port size again on the kernel side.
Look for the MTD parameters in the kernel compilation options.

HTH,

--=20
Ricardo Scop.

        \|/
    ___ -*-
   (@ @)/|\
  /  V  \|  R SCOP Consult.
 /(     )\  Linux-based communications
--^^---^^+------------------------------
rscop@matrix.com.br
+55 51 999-36-777
Porto Alegre, RS - BRazil
