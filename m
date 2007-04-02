Return-Path: <kryn@in2p3.fr>
Received: from ccimap.in2p3.fr (ccimap.in2p3.fr [134.158.69.6])
	by ozlabs.org (Postfix) with ESMTP id 21512DDF1A
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  2 Apr 2007 19:15:15 +1000 (EST)
Message-ID: <4610C999.5080405@in2p3.fr>
Date: Mon, 02 Apr 2007 11:15:05 +0200
From: Didier Kryn <kryn@in2p3.fr>
MIME-Version: 1.0
Subject: Re: Reading and writing from/to VME device
References: <821B2170E9E7F04FA38DF7EC21DE4871088C81DA@VCAEXCH01.hq.corp.viasat.com>	<460A3BBC.5060002@in2p3.fr>	<929bf310703290313o234a47f9gbf9c5083fc23e45e@mail.gmail.com>
	<460CD765.2060905@in2p3.fr>
In-Reply-To: <460CD765.2060905@in2p3.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Konstantin Boyanov <kkboyanov@gmail.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

    Konstantin, I reproduced your ioctl() problem with the attached=20
program. The conclusion is that the only valid size and base parameters=20
for A16 are windowSizeL=3D0x10000 and xlatedAddrL=3D0. This means the A16=
=20
space can only be mapped as a whole. What you observed with =20
xlatedAddrL=3D0x10100000 is that the ioctl(), gently masks the irrelevant=
=20
high order bits.

    Best regards.
    Didier

Didier Kryn a =E9crit :
>
>
>     Now, for the ioctl problem, Konstantin, did you try to set=20
> xlatedAddrL to zero. The Tsio148, and therefore the driver, enforce=20
> alignment on  rather big blocks and maybe misalignment is the cause of =

> the "invalid argument" error. I see no reason not to map the entire=20
> A16, A24 or CR/CSR spaces. For the others, of course, you are limited=20
> by the size of the cpu's address space.
>
>     I will eventually try to reproduce your ioctl problem next week.=20
> Hopping you will solve it before :-) .
>
>     Best regards. Didier
>
> Konstantin Boyanov said:
>> Hi again,
>>
>> Thank you once again for presenting the VME world to me :)
>>
>> >Looks like you're reading something.  Address 0x10100000 is larger th=
an
>> >a 24 bit address.  Perhaps you should be using A32 transfers instead =
of
>> >A24?
>>
>> No, no, I need to do A16 access, thats the only way to read the=20
>> control registers. Form here comes also my confusion - I thought that =

>> when I'm reading CS/CSR register I need to do it in CSR address=20
>> space. So no algorithms for geographical location of boards are=20
>> needed in my case I guess.
>> Actually the base address of CSR on the board is 0xA000 (10100000 is=20
>> the first byte of the address selection in inary, shame on me :( ).=20
>> But when I try to configure it with outWinCfgADC.zlatedAddrL =3D=20
>> 0xA000, when I run the programm I get an errno 29 (Invalid argument)=20
>> from ioctl(). In fact if I set the xlatedAddrL to some value smaller=20
>> that 0x10000 I get this error. Here's my most recent configuration:
>>
>>     outWinCfgADC.windowNbr           =3D 0;
>>     outWinCfgADC.windowEnable      =3D 1;
>>     outWinCfgADC.wrPostEnable      =3D 0;
>>     outWinCfgADC.userAccessType  =3D VME_SUPER;
>>     outWinCfgADC.dataAccessType  =3D VME_DATA;
>>     outWinCfgADC.windowSizeL       =3D 0x10000;
>>     outWinCfgADC.xferProtocol         =3D VME_SCT;
>>     outWinCfgADC.addrSpace           =3D VME_A16;
>>     outWinCfgADC.maxDataWidth     =3D VME_D16;
>>     outWinCfgADC.xlatedAddrL          =3D 0x10000000;
>>
>> I think that 0x10000 for window size is big enough to encompass the=20
>> whole A16 addressable space. With the 0x10000000 xlatedAddr I get no=20
>> errors and read the desired registers when I increment this address=20
>> to 0x1000A000. But nevertheless it seems strange to me that the=20
>> device does not accept xlatedAddr lower that 0x10000. Maybe its due=20
>> to the configuration of the VME controller?
>>
>
