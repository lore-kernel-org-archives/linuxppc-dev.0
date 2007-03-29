Return-Path: <kkboyanov@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.170])
	by ozlabs.org (Postfix) with ESMTP id BB1F0DDEB9
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Mar 2007 20:13:58 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so434381ugf
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Mar 2007 03:13:56 -0700 (PDT)
Message-ID: <929bf310703290313o234a47f9gbf9c5083fc23e45e@mail.gmail.com>
Date: Thu, 29 Mar 2007 12:13:55 +0200
From: "Konstantin Boyanov" <kkboyanov@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Reading and writing from/to VME device
In-Reply-To: <460A3BBC.5060002@in2p3.fr>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_47097_10184318.1175163235824"
References: <821B2170E9E7F04FA38DF7EC21DE4871088C81DA@VCAEXCH01.hq.corp.viasat.com>
	<460A3BBC.5060002@in2p3.fr>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_47097_10184318.1175163235824
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi again,

Thank you once again for presenting the VME world to me :)

>Looks like you're reading something.  Address 0x10100000 is larger than
>a 24 bit address.  Perhaps you should be using A32 transfers instead of
>A24?

No, no, I need to do A16 access, thats the only way to read the control
registers. Form here comes also my confusion - I thought that when I'm
reading CS/CSR register I need to do it in CSR address space. So no
algorithms for geographical location of boards are needed in my case I
guess.
Actually the base address of CSR on the board is 0xA000 (10100000 is the
first byte of the address selection in inary, shame on me :( ). But when I
try to configure it with outWinCfgADC.zlatedAddrL = 0xA000, when I run the
programm I get an errno 29 (Invalid argument) from ioctl(). In fact if I set
the xlatedAddrL to some value smaller that 0x10000 I get this error. Here's
my most recent configuration:

    outWinCfgADC.windowNbr           = 0;
    outWinCfgADC.windowEnable      = 1;
    outWinCfgADC.wrPostEnable      = 0;
    outWinCfgADC.userAccessType  = VME_SUPER;
    outWinCfgADC.dataAccessType  = VME_DATA;
    outWinCfgADC.windowSizeL       = 0x10000;
    outWinCfgADC.xferProtocol         = VME_SCT;
    outWinCfgADC.addrSpace           = VME_A16;
    outWinCfgADC.maxDataWidth     = VME_D16;
    outWinCfgADC.xlatedAddrL         = 0x10000000;

I think that 0x10000 for window size is big enough to encompass the whole
A16 addressable space. With the 0x10000000 xlatedAddr I get no errors and
read the desired registers when I increment this address to 0x1000A000. But
nevertheless it seems strange to me that the device does not accept
xlatedAddr lower that 0x10000. Maybe its due to the configuration of the VME
controller?

Best regards,
Konstantin

------=_Part_47097_10184318.1175163235824
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi again,<br><br>Thank you once again for presenting the VME world to me :)<br><br>&gt;Looks like you&#39;re reading something. &nbsp;Address 0x10100000 is larger than<br>&gt;a 24 bit address. &nbsp;Perhaps you should be using A32 transfers instead of
<br>&gt;A24?<br><br>No, no, I need to do A16 access, thats the only way to read the control registers. Form here comes also my confusion - I thought that when I&#39;m reading CS/CSR register I need to do it in CSR address space. So no algorithms for geographical location of boards are needed in my case I guess.
<br>Actually the base address of CSR on the board is 0xA000 (10100000 is the first byte of the address selection in inary, shame on me :( ). But when I try to configure it with outWinCfgADC.zlatedAddrL = 0xA000, when I run the programm I get an errno 29 (Invalid argument) from ioctl(). In fact if I set the xlatedAddrL to some value smaller that 0x10000 I get this error. Here&#39;s my most recent configuration:
<br><br>&nbsp;&nbsp;&nbsp; outWinCfgADC.windowNbr&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp; = 0;<br>&nbsp;&nbsp;&nbsp; outWinCfgADC.windowEnable&nbsp; &nbsp; &nbsp; = 1;<br>&nbsp;&nbsp;&nbsp; outWinCfgADC.wrPostEnable &nbsp;&nbsp; &nbsp; = 0;<br>&nbsp;&nbsp;&nbsp; outWinCfgADC.userAccessType&nbsp; = VME_SUPER;<br>&nbsp;&nbsp;&nbsp; outWinCfgADC.dataAccessType&nbsp; = VME_DATA;
<br>&nbsp;&nbsp;&nbsp; outWinCfgADC.windowSizeL&nbsp; &nbsp; &nbsp;&nbsp; = 0x10000;<br>&nbsp;&nbsp;&nbsp; outWinCfgADC.xferProtocol&nbsp; &nbsp; &nbsp; &nbsp;&nbsp; = VME_SCT;<br>&nbsp;&nbsp;&nbsp; outWinCfgADC.addrSpace &nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; = VME_A16;<br>&nbsp;&nbsp;&nbsp; outWinCfgADC.maxDataWidth &nbsp;&nbsp;&nbsp; = VME_D16;<br>&nbsp;&nbsp;&nbsp; outWinCfgADC.xlatedAddrL
&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; = 0x10000000;<br><br>I think that 0x10000 for window size is big enough to encompass the whole A16 addressable space. With the 0x10000000 xlatedAddr I get no errors and read the desired registers when I increment this address to 0x1000A000. But nevertheless it seems strange to me that the device does not accept xlatedAddr lower that 0x10000. Maybe its due to the configuration of the VME controller?
<br><br>Best regards,<br>Konstantin<br>

------=_Part_47097_10184318.1175163235824--
