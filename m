Return-Path: <kryn@in2p3.fr>
Received: from postfix1-g20.free.fr (postfix1-g20.free.fr [212.27.60.42])
	by ozlabs.org (Postfix) with ESMTP id CA45DDDE46
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 Mar 2007 19:25:30 +1000 (EST)
Received: from smtp4-g19.free.fr (smtp4-g19.free.fr [212.27.42.30])
	by postfix1-g20.free.fr (Postfix) with ESMTP id D4E2FC634A8
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 Mar 2007 11:25:24 +0200 (CEST)
Received: from [192.168.0.1] (unknown [81.56.175.251])
	by smtp4-g19.free.fr (Postfix) with ESMTP id 9C7C4690F1
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 Mar 2007 11:24:53 +0200 (CEST)
Message-ID: <460CD765.2060905@in2p3.fr>
Date: Fri, 30 Mar 2007 11:24:53 +0200
From: Didier Kryn <kryn@in2p3.fr>
MIME-Version: 1.0
CC: linuxppc-embedded@ozlabs.org
Subject: Re: Reading and writing from/to VME device
References: <821B2170E9E7F04FA38DF7EC21DE4871088C81DA@VCAEXCH01.hq.corp.viasat.com>	<460A3BBC.5060002@in2p3.fr>
	<929bf310703290313o234a47f9gbf9c5083fc23e45e@mail.gmail.com>
In-Reply-To: <929bf310703290313o234a47f9gbf9c5083fc23e45e@mail.gmail.com>
Content-Type: multipart/alternative;
	boundary="------------010208040402000507060904"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------010208040402000507060904
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

    Konstantin, Martin,

    First, I am not sure that our discussion is in the scope of the 
list, but the others didn't complain still...

    I gave a look at the VITA publications about the CR/CSR.

    CR/CSR was introduced in the VME64 standard. These registers are 
dedicated to inform the user of the board's identity and capabilities 
and perform some settings. they belong to a space different of the 
"logical" address spaces (A16/A24/A32/A64). The base address of the 
"logical" address spaces was traditionally set by hexadecimal switches. 
VME64 allows to set it by writing registers in the CR/CSR space. 
Obviously, this should not relocate the CR/CSR space itself. VME64 does 
not specify how the base address of the CR/CSR space is set.

    VME64 was a transitional standard and this uncertainty has been 
solved by VME64x which specifies that this base address is coded on the 
backplane connectors this is what makes it a "geographical" address 
space (a term derived from FastBus). It allows an application to 
discover which board is present in which slot. For this to work, you 
should have a VME64x crate and a VME64x board, with the new connector 
type for P1 and P2.

    To allow the use of CR/CSR in non-VME64x devices and/or crates, the 
CR/CSR base address can sometimes be set by switches (not the same 
switches as the other spaces). According to what Konstantin is saying, 
his board also maps the CR/CSR to the A16 address space, which seems 
strange to me. Have you an online documentation of the board?

    Now, for the ioctl problem, Konstantin, did you try to set 
xlatedAddrL to zero. The Tsio148, and therefore the driver, enforce 
alignment on  rather big blocks and maybe misalignment is the cause of 
the "invalid argument" error. I see no reason not to map the entire A16, 
A24 or CR/CSR spaces. For the others, of course, you are limited by the 
size of the cpu's address space.

    I will eventually try to reproduce your ioctl problem next week. 
Hopping you will solve it before :-) .

    Best regards. Didier

Konstantin Boyanov said:
> Hi again,
>
> Thank you once again for presenting the VME world to me :)
>
> >Looks like you're reading something.  Address 0x10100000 is larger than
> >a 24 bit address.  Perhaps you should be using A32 transfers instead of
> >A24?
>
> No, no, I need to do A16 access, thats the only way to read the 
> control registers. Form here comes also my confusion - I thought that 
> when I'm reading CS/CSR register I need to do it in CSR address space. 
> So no algorithms for geographical location of boards are needed in my 
> case I guess.
> Actually the base address of CSR on the board is 0xA000 (10100000 is 
> the first byte of the address selection in inary, shame on me :( ). 
> But when I try to configure it with outWinCfgADC.zlatedAddrL = 0xA000, 
> when I run the programm I get an errno 29 (Invalid argument) from 
> ioctl(). In fact if I set the xlatedAddrL to some value smaller that 
> 0x10000 I get this error. Here's my most recent configuration:
>
>     outWinCfgADC.windowNbr           = 0;
>     outWinCfgADC.windowEnable      = 1;
>     outWinCfgADC.wrPostEnable      = 0;
>     outWinCfgADC.userAccessType  = VME_SUPER;
>     outWinCfgADC.dataAccessType  = VME_DATA;
>     outWinCfgADC.windowSizeL       = 0x10000;
>     outWinCfgADC.xferProtocol         = VME_SCT;
>     outWinCfgADC.addrSpace           = VME_A16;
>     outWinCfgADC.maxDataWidth     = VME_D16;
>     outWinCfgADC.xlatedAddrL          = 0x10000000;
>
> I think that 0x10000 for window size is big enough to encompass the 
> whole A16 addressable space. With the 0x10000000 xlatedAddr I get no 
> errors and read the desired registers when I increment this address to 
> 0x1000A000. But nevertheless it seems strange to me that the device 
> does not accept xlatedAddr lower that 0x10000. Maybe its due to the 
> configuration of the VME controller?
>
> Best regards,
> Konstantin
> ------------------------------------------------------------------------
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded


--------------010208040402000507060904
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
&nbsp;&nbsp;&nbsp; Konstantin, Martin,<br>
<br>
&nbsp;&nbsp;&nbsp; First, I am not sure that our discussion is in the scope of the
list, but the others didn't complain still...<br>
<br>
&nbsp;&nbsp;&nbsp; I gave a look at the VITA publications about the CR/CSR.<br>
<br>
&nbsp;&nbsp;&nbsp; CR/CSR was introduced in the VME64 standard. These registers are
dedicated to inform the user of the board's identity and capabilities
and perform some settings. they belong to a space different of the
"logical" address spaces (A16/A24/A32/A64). The base address of the
"logical" address spaces was traditionally set by hexadecimal switches.
VME64 allows to set it by writing registers in the CR/CSR space.
Obviously, this should not relocate the CR/CSR space itself. VME64 does
not specify how the base address of the CR/CSR space is set.<br>
<br>
&nbsp;&nbsp;&nbsp; VME64 was a transitional standard and this uncertainty has been
solved by VME64x which specifies that this base address is coded on the
backplane connectors this is what makes it a "geographical" address
space (a term derived from FastBus). It allows an application to
discover which board is present in which slot. For this to work, you
should have a VME64x crate and a VME64x board, with the new connector
type for P1 and P2.<br>
<br>
&nbsp;&nbsp;&nbsp; To allow the use of CR/CSR in non-VME64x devices and/or crates, the
CR/CSR base address can sometimes be set by switches (not the same
switches as the other spaces). According to what Konstantin is saying,
his board also maps the CR/CSR to the A16 address space, which seems
strange to me. Have you an online documentation of the board?<br>
<br>
&nbsp;&nbsp;&nbsp; Now, for the ioctl problem, Konstantin, did you try to set
xlatedAddrL to zero. The Tsio148, and therefore the driver, enforce
alignment on&nbsp; rather big blocks and maybe misalignment is the cause of
the "invalid argument" error. I see no reason not to map the entire
A16, A24 or CR/CSR spaces. For the others, of course, you are limited
by the size of the cpu's address space.<br>
<br>
&nbsp;&nbsp;&nbsp; I will eventually try to reproduce your ioctl problem next week.
Hopping you will solve it before<span class="moz-smiley-s1"><span> :-) </span></span>.<br>
<br>
&nbsp;&nbsp;&nbsp; Best regards. Didier<br>
<br>
Konstantin Boyanov said:
<blockquote
 cite="mid929bf310703290313o234a47f9gbf9c5083fc23e45e@mail.gmail.com"
 type="cite">Hi again,<br>
  <br>
Thank you once again for presenting the VME world to me :)<br>
  <br>
&gt;Looks like you're reading something. &nbsp;Address 0x10100000 is larger
than<br>
&gt;a 24 bit address. &nbsp;Perhaps you should be using A32 transfers
instead of
  <br>
&gt;A24?<br>
  <br>
No, no, I need to do A16 access, thats the only way to read the control
registers. Form here comes also my confusion - I thought that when I'm
reading CS/CSR register I need to do it in CSR address space. So no
algorithms for geographical location of boards are needed in my case I
guess.
  <br>
Actually the base address of CSR on the board is 0xA000 (10100000 is
the first byte of the address selection in inary, shame on me :( ). But
when I try to configure it with outWinCfgADC.zlatedAddrL = 0xA000, when
I run the programm I get an errno 29 (Invalid argument) from ioctl().
In fact if I set the xlatedAddrL to some value smaller that 0x10000 I
get this error. Here's my most recent configuration:
  <br>
  <br>
&nbsp;&nbsp;&nbsp; outWinCfgADC.windowNbr&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp; = 0;<br>
&nbsp;&nbsp;&nbsp; outWinCfgADC.windowEnable&nbsp; &nbsp; &nbsp; = 1;<br>
&nbsp;&nbsp;&nbsp; outWinCfgADC.wrPostEnable &nbsp;&nbsp; &nbsp; = 0;<br>
&nbsp;&nbsp;&nbsp; outWinCfgADC.userAccessType&nbsp; = VME_SUPER;<br>
&nbsp;&nbsp;&nbsp; outWinCfgADC.dataAccessType&nbsp; = VME_DATA;
  <br>
&nbsp;&nbsp;&nbsp; outWinCfgADC.windowSizeL&nbsp; &nbsp; &nbsp;&nbsp; = 0x10000;<br>
&nbsp;&nbsp;&nbsp; outWinCfgADC.xferProtocol&nbsp; &nbsp; &nbsp; &nbsp;&nbsp; = VME_SCT;<br>
&nbsp;&nbsp;&nbsp; outWinCfgADC.addrSpace &nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; = VME_A16;<br>
&nbsp;&nbsp;&nbsp; outWinCfgADC.maxDataWidth &nbsp;&nbsp;&nbsp; = VME_D16;<br>
&nbsp;&nbsp;&nbsp; outWinCfgADC.xlatedAddrL
&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; = 0x10000000;<br>
  <br>
I think that 0x10000 for window size is big enough to encompass the
whole A16 addressable space. With the 0x10000000 xlatedAddr I get no
errors and read the desired registers when I increment this address to
0x1000A000. But nevertheless it seems strange to me that the device
does not accept xlatedAddr lower that 0x10000. Maybe its due to the
configuration of the VME controller?
  <br>
  <br>
Best regards,<br>
Konstantin<br>
  <pre wrap="">
<hr size="4" width="90%">
_______________________________________________
Linuxppc-embedded mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a>
<a class="moz-txt-link-freetext" href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a></pre>
</blockquote>
<br>
</body>
</html>

--------------010208040402000507060904--
