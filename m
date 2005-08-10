Return-Path: <bgholikh@cisco.com>
Received: from sj-iport-2.cisco.com (sj-iport-2-in.cisco.com [171.71.176.71])
	by ozlabs.org (Postfix) with ESMTP id 9867267EE3
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 Aug 2005 06:38:19 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C59DEB.6BE7DF11"
Date: Wed, 10 Aug 2005 13:38:10 -0700
Message-ID: <F795765B112E7344AF36AA911279641584950C@xmb-sjc-212.amer.cisco.com>
From: "Bizhan Gholikhamseh \(bgholikh\)" <bgholikh@cisco.com>
To: "Kumar Gala" <kumar.gala@freescale.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: pci_enable_device fails on MPC8541
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

------_=_NextPart_001_01C59DEB.6BE7DF11
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

HI Kumar,
I have attached the /proc/ioports and /proc/iomem for 8541E.
Also the CONFIG_ 85XX_PCI2 is set to yes.

Freescale does not support 2.6.13 so I am not able to update to that
version yet.

Thanks,
Bizhan

-----Original Message-----
From: Kumar Gala [mailto:kumar.gala@freescale.com]=20
Sent: Wednesday, August 10, 2005 12:11 PM
To: Bizhan Gholikhamseh (bgholikh)
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: pci_enable_device fails on MPC8541

No problem.  I'm hunting around the problem, but trying to figure out
exactly where the bug is.  What's a little odd is that in 2.6.11 we =20
should have excluded all the devices that are on the VIA chipset.  =20
However, in the logs you sent me we see those devices. Part of the
problem is that your TI DSP has its own P2P bridge on it.  Therefor the
bus numbers for the devices start changing around a bit.

What is CONFIG_85xx_PCI2 set to in your .config?

Can you send me the output of the following on the 8555 CDS:
cat /proc/ioports
cat /proc/iomem

Also, if you feel daring, grab the latest 2.6.13-rc6 kernel and build it
for 8555 CDS and see what happens.

Oh, is this card something standard or a custom thing?  The issue of =20
having a card with P2P bridge on it has come up more than once.  =20
However, I'm not sure of any standard PC PCI cards do this (at least
none of the simple cards we have do).  I'd like to see if we can find
something that we could start testing with.

thanks

- kumar

On Aug 10, 2005, at 1:03 PM, Bizhan Gholikhamseh \(((bgholikh\))) wrote:

> Kumar,
> Sorry it took a while. I have attached the 8540 PCI boot log and=20
> /proc/pci. Also I found out the functions you mentioned are not used=20
> in my environment.
>
> Thanks,
> Bizhan
>
> -----Original Message-----
> From: Kumar Gala [mailto:kumar.gala@freescale.com]
> Sent: Wednesday, August 10, 2005 9:06 AM
> To: Bizhan Gholikhamseh (bgholikh)
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: pci_enable_device fails on MPC8541
>
> It would be extremely helpful to get the output from the work MPC8540=20
> for lspci and cat /proc/pci.
>
> Also, I forget if 2.6.11 has CDS VIA support, but if it does you can=20
> try disabling it by commenting out the calls to:
> mpc85xx_cds_enable_via() & mpc85xx_cds_fixup_via() in arch/ppc/syslib/

> ppc85xx_setup.c and see what happens.
>
> - k
>
> On Aug 10, 2005, at 10:58 AM, Bizhan Gholikhamseh \\((bgholikh\\))
> wrote:
>
>
>>  <<pci_boot.pdf>> Kumar,
>> We do not support or care about VIA IDE controller. I have enabled=20
>> the
>>
>
>
>> DEBUG flag and attached the debug messages during boot. This is for=20
>> 8541E.
>> Regards,
>> Bizhan
>>
>> -----Original Message-----
>> From: Kumar Gala [mailto:kumar.gala@freescale.com]
>> Sent: Tuesday, August 09, 2005 4:11 PM
>> To: Bizhan Gholikhamseh (bgholikh)
>> Cc: linuxppc-embedded@ozlabs.org
>> Subject: Re: pci_enable_device fails on MPC8541
>>
>> Do you need support for the VIA IDE controller?  I'm not sure if that

>> is causing you issues.
>>
>> Also, can you try enabling DEBUG in arch/ppc/kernel/pci.c and send a=20
>> boot log.  I'm trying to figure out what is causing the resource=20
>> conflict.  It appears that the memory resource is reasonable, but=20
>> there could be possible conflict on the IO resource side.
>>
>> Also, if you can send logs of the same thing from the working 8540=20
>> ADS
>>
>
>
>> that would be helpful.
>>
>> - kumar
>>
>> On Aug 9, 2005, at 12:18 PM, Bizhan Gholikhamseh \(((bgholikh\)))
>> wrote:
>>
>>
>>
>>> Hi Kumar,
>>> I am using Linux 2.6.11, u-boot 1.1.2.
>>> I see failure in pci_enable_device with message:
>>> "PCI: Device 0000:02:01.0 not available because of resource=20
>>> collisions"
>>>
>>> I have attached three files:
>>> lspci_output.txt: out put of the "lspci -v"
>>> proc_pci.txt: output of the "cat /proc/pci"
>>> u-boot.txt: output of the "pci command at u-boot"
>>>
>>> Any help greatly appreciated,
>>> Bizhan
>>> -----Original Message-----
>>> From: Kumar Gala [mailto:kumar.gala@freescale.com]
>>> Sent: Monday, August 08, 2005 1:34 PM
>>> To: Bizhan Gholikhamseh (bgholikh)
>>> Cc: linuxppc-embedded@ozlabs.org
>>> Subject: Re: pci_enable_device fails on MPC8541
>>>
>>> Bizhan,
>>>
>>> A few questions:
>>>
>>> 1. what kernel version are you using on these boards:
>>> 2. can you do an lspci -v on the boards
>>>
>>> - kumar
>>>
>>> On Aug 8, 2005, at 1:12 PM, Bizhan Gholikhamseh \(((bgholikh\)))
>>> wrote:
>>>
>>>
>>>
>>>
>>>> Hi All,
>>>> I am using two evaluation board from freescale, 8540ADS and=20
>>>> MPC8541.
>>>> The same PCI driver is being compiled and loaded on both platforms.
>>>> The same PCI driver (developed by me) for DSP board compiled and=20
>>>> loaded on both platforms.
>>>>
>>>> When I type: "insmod C6415.ko" on 8541 board, I get the following
>>>> error:
>>>> "PCI: Device 0000:02:01.0 not available because of resource=20
>>>> collisions"
>>>> This messages is because of the execution of the generic PCI Linux
>>>> command:
>>>> "pci_enable_device(pdev)"
>>>> The same API has no problem on 8540ADS.
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>> From UBOOT I can see my device is on bus 3:
>>>>>
>>>>>
>>>>>
>>>>>
>>>> =3D> pci 3
>>>> Scanning PCI devices on bus 3
>>>> BusDev FUN    VendorID    DeviceID    Device Class    Sub-Class
>>>> -------------------------------------------------------------------
>>>> -
>>>>
>
>
>>>> -
>>>>
>>>>
>>
>>
>>
>>>> -
>>>> --
>>>> --------------------
>>>> 03.01.00            0x104c    0xa106        .........
>>>>
>>>> Any idea why the insmod fails on one board and not on the other=20
>>>> one?
>>>>
>>>> Many thanks in advance,
>>>> Bizhan
>>>>
>>>> <ATT2118305.txt>
>>>>
>>>>
>>>> <lspci_output.txt>
>>>> <proc_pci.txt>
>>>> <u-boot.txt>
>>>>
>>>>
>>>
>>>
>>> <pci_boot.txt>
>>> <pci_boot.pdf>
>>>
>>
>>
>> <pci_boot_8540.txt>
>> <proc_pci_8540.txt>
>

------_=_NextPart_001_01C59DEB.6BE7DF11
Content-Type: text/plain;
	name="proc_ioports_iomem.txt"
Content-Transfer-Encoding: base64
Content-Description: proc_ioports_iomem.txt
Content-Disposition: attachment;
	filename="proc_ioports_iomem.txt"

IyBjYXQgL3Byb2MvaW9wb3J0cwowMDAwMDAwMC0wMGZmZmZmZiA6IFBDSTEgaG9zdCBicmlkZ2UK
ICAwMDAwMDAwMC0wMDAwZmZmZiA6IFBDSSBCdXMgIzAyCiAgICAwMDAwMDAwMC0wMDAwZmZmZiA6
IFBDSSBCdXMgIzAxCiAgICAgIDAwMDAwMDIwLTAwMDAwMDIxIDogODI1OSAobWFzdGVyKQogICAg
ICAwMDAwMDA2MC0wMDAwMDA2ZiA6IGk4MDQyCiAgICAgIDAwMDAwMGEwLTAwMDAwMGExIDogODI1
OSAoc2xhdmUpCiAgICAgIDAwMDAwNGQwLTAwMDAwNGQxIDogODI1OSBlZGdlIGNvbnRyb2wKICAg
ICAgMDAwMGNjMDAtMDAwMGNjMGYgOiAwMDAwOjAxOjAyLjEKICAgICAgMDAwMGZjMDAtMDAwMGZj
ZmYgOiAwMDAwOjAxOjAyLjYKICAgICAgMDAwMGZkZjgtMDAwMGZkZmIgOiAwMDAwOjAxOjAyLjUK
ICAgICAgMDAwMGZkZmMtMDAwMGZkZmYgOiAwMDAwOjAxOjAyLjUKICAgICAgMDAwMGZlMDAtMDAw
MGZlZmYgOiAwMDAwOjAxOjAyLjUKICAgICAgMDAwMGZmYzAtMDAwMGZmZGYgOiAwMDAwOjAxOjAy
LjMKICAgICAgMDAwMGZmZTAtMDAwMGZmZmYgOiAwMDAwOjAxOjAyLjIKMDEwMDAwMDAtMDFmZmZm
ZmYgOiBQQ0kyIGhvc3QgYnJpZGdlCiMgY2F0IC9wcm9jL2lvbWVtCjgwMDAwMDAwLTlmZmZmZmZm
IDogUENJMSBob3N0IGJyaWRnZQogIDllZjAwMDAwLTllZmZmZmZmIDogUENJIEJ1cyAjMDIKICA5
ZjAwMDAwMC05ZmNmZmZmZiA6IFBDSSBCdXMgIzAyCiAgICA5ZjAwMDAwMC05ZjdmZmZmZiA6IDAw
MDA6MDI6MDEuMAogICAgOWY4MDAwMDAtOWZiZmZmZmYgOiAwMDAwOjAyOjAxLjAKICA5ZmQwMDAw
MC05ZmRmZmZmZiA6IFBDSSBCdXMgIzAxCiAgOWZlMDAwMDAtOWZlZmZmZmYgOiBQQ0kgQnVzICMw
MQogIDlmZmZmMDAwLTlmZmZmZmZmIDogMDAwMDowMDoxMS4wCmEwMDAwMDAwLWJmZmZmZmZmIDog
UENJMiBob3N0IGJyaWRnZQplMDAwMzAwMC1lMDAwM2ZmZiA6IGZzbC1pMmMxCmUwMDA0NTAwLWUw
MDA0NTA3IDogc2VyaWFsCmUwMDA0NjAwLWUwMDA0NjA3IDogc2VyaWFsCmUwMDIxMTAwLWUwMDIx
MTdmIDogZnNsLWRtYTAKZTAwMjExODAtZTAwMjExZmYgOiBmc2wtZG1hMQplMDAyMTIwMC1lMDAy
MTI3ZiA6IGZzbC1kbWEyCmUwMDIxMjgwLWUwMDIxMmZmIDogZnNsLWRtYTMKZTAwMjQwMDAtZTAw
MjRmZmYgOiBmc2wtZ2lhbmZhcjEKZTAwMjUwMDAtZTAwMjVmZmYgOiBmc2wtZ2lhbmZhcjIKZTAw
MzAwMDAtZTAwM2ZmZmYgOiBmc2wtc2VjMjEKZTAwOTEzMDAtZTAwOTEzMWYgOiBmc2wtY3BtLWZj
YzEKZTAwOTEzMjAtZTAwOTEzM2YgOiBmc2wtY3BtLWZjYzIKZTAwOTEzODAtZTAwOTEzOWYgOiBm
c2wtY3BtLWZjYzEKZTAwOTEzYTAtZTAwOTEzY2YgOiBmc2wtY3BtLWZjYzIKZTAwOTE4NjAtZTAw
OTE4YmYgOiBmc2wtY3BtLWkyYzEKZTAwOTFhYTAtZTAwOTFhZmYgOiBmc2wtY3BtLXNwaTEKZTAw
ZTEwMDAtZTAwZTFmZmYgOiBmc2wtcGVyZm1vbjEKCg==

------_=_NextPart_001_01C59DEB.6BE7DF11--
