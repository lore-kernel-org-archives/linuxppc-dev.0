Return-Path: <bgholikh@cisco.com>
Received: from sj-iport-4.cisco.com (sj-iport-4.cisco.com [171.68.10.86])
	by ozlabs.org (Postfix) with ESMTP id ED15267FF9
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 Aug 2005 04:03:33 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C59DD5.C78825A3"
Date: Wed, 10 Aug 2005 11:03:15 -0700
Message-ID: <F795765B112E7344AF36AA911279641584950A@xmb-sjc-212.amer.cisco.com>
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

------_=_NextPart_001_01C59DD5.C78825A3
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Kumar,
Sorry it took a while. I have attached the 8540 PCI boot log and
/proc/pci. Also I found out the functions you mentioned are not used in
my environment.

Thanks,
Bizhan=20

-----Original Message-----
From: Kumar Gala [mailto:kumar.gala@freescale.com]=20
Sent: Wednesday, August 10, 2005 9:06 AM
To: Bizhan Gholikhamseh (bgholikh)
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: pci_enable_device fails on MPC8541

It would be extremely helpful to get the output from the work MPC8540
for lspci and cat /proc/pci.

Also, I forget if 2.6.11 has CDS VIA support, but if it does you can try
disabling it by commenting out the calls to:
mpc85xx_cds_enable_via() & mpc85xx_cds_fixup_via() in arch/ppc/syslib/
ppc85xx_setup.c and see what happens.

- k

On Aug 10, 2005, at 10:58 AM, Bizhan Gholikhamseh \\((bgholikh\\))
wrote:

>  <<pci_boot.pdf>> Kumar,
> We do not support or care about VIA IDE controller. I have enabled the

> DEBUG flag and attached the debug messages during boot. This is for=20
> 8541E.
> Regards,
> Bizhan
>
> -----Original Message-----
> From: Kumar Gala [mailto:kumar.gala@freescale.com]
> Sent: Tuesday, August 09, 2005 4:11 PM
> To: Bizhan Gholikhamseh (bgholikh)
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: pci_enable_device fails on MPC8541
>
> Do you need support for the VIA IDE controller?  I'm not sure if that=20
> is causing you issues.
>
> Also, can you try enabling DEBUG in arch/ppc/kernel/pci.c and send a=20
> boot log.  I'm trying to figure out what is causing the resource=20
> conflict.  It appears that the memory resource is reasonable, but=20
> there could be possible conflict on the IO resource side.
>
> Also, if you can send logs of the same thing from the working 8540 ADS

> that would be helpful.
>
> - kumar
>
> On Aug 9, 2005, at 12:18 PM, Bizhan Gholikhamseh \(((bgholikh\)))
> wrote:
>
>
>> Hi Kumar,
>> I am using Linux 2.6.11, u-boot 1.1.2.
>> I see failure in pci_enable_device with message:
>> "PCI: Device 0000:02:01.0 not available because of resource
>> collisions"
>>
>> I have attached three files:
>> lspci_output.txt: out put of the "lspci -v"
>> proc_pci.txt: output of the "cat /proc/pci"
>> u-boot.txt: output of the "pci command at u-boot"
>>
>> Any help greatly appreciated,
>> Bizhan
>> -----Original Message-----
>> From: Kumar Gala [mailto:kumar.gala@freescale.com]
>> Sent: Monday, August 08, 2005 1:34 PM
>> To: Bizhan Gholikhamseh (bgholikh)
>> Cc: linuxppc-embedded@ozlabs.org
>> Subject: Re: pci_enable_device fails on MPC8541
>>
>> Bizhan,
>>
>> A few questions:
>>
>> 1. what kernel version are you using on these boards:
>> 2. can you do an lspci -v on the boards
>>
>> - kumar
>>
>> On Aug 8, 2005, at 1:12 PM, Bizhan Gholikhamseh \(((bgholikh\)))
>> wrote:
>>
>>
>>
>>> Hi All,
>>> I am using two evaluation board from freescale, 8540ADS and MPC8541.
>>> The same PCI driver is being compiled and loaded on both platforms.
>>> The same PCI driver (developed by me) for DSP board compiled and
>>> loaded on both platforms.
>>>
>>> When I type: "insmod C6415.ko" on 8541 board, I get the following
>>> error:
>>> "PCI: Device 0000:02:01.0 not available because of resource
>>> collisions"
>>> This messages is because of the execution of the generic PCI Linux
>>> command:
>>> "pci_enable_device(pdev)"
>>> The same API has no problem on 8540ADS.
>>>
>>>
>>>
>>>
>>>> From UBOOT I can see my device is on bus 3:
>>>>
>>>>
>>>>
>>> =3D> pci 3
>>> Scanning PCI devices on bus 3
>>> BusDev FUN    VendorID    DeviceID    Device Class    Sub-Class
>>> --------------------------------------------------------------------

>>> -
>>>
>
>
>>> -
>>> --
>>> --------------------
>>> 03.01.00            0x104c    0xa106        .........
>>>
>>> Any idea why the insmod fails on one board and not on the other one?
>>>
>>> Many thanks in advance,
>>> Bizhan
>>>
>>> <ATT2118305.txt>
>>>
>>>
>>> <lspci_output.txt>
>>> <proc_pci.txt>
>>> <u-boot.txt>
>>>
>>
>>
>> <pci_boot.txt>
>> <pci_boot.pdf>
>

------_=_NextPart_001_01C59DD5.C78825A3
Content-Type: text/plain;
	name="pci_boot_8540.txt"
Content-Transfer-Encoding: base64
Content-Description: pci_boot_8540.txt
Content-Disposition: attachment;
	filename="pci_boot_8540.txt"

UENJOiBQcm9iaW5nIFBDSSBoYXJkd2FyZQpQQ0k6IGJyaWRnZSByc3JjIDAuLmZmZmZmZiAoMTAw
KSwgcGFyZW50IGMwMjAzODE4ClBDSTogYnJpZGdlIHJzcmMgODAwMDAwMDAuLjlmZmZmZmZmICgy
MDApLCBwYXJlbnQgYzAyMDM3ZmMKUENJOiBicmlkZ2UgcnNyYyBmZmYwMDAuLmZmZmZmZiAoMTAx
KSwgcGFyZW50IGMwMjkzMDM4ClBDSTogYnJpZGdlIHJzcmMgOWYwMDAwMDAuLjlmZmZmZmZmICgy
MDApLCBwYXJlbnQgYzAyOTMwNTQKUENJOiBicmlkZ2UgcnNyYyA5ZWYwMDAwMC4uOWVmZmZmZmYg
KDEyMDEpLCBwYXJlbnQgYzAyOTMwNTQKUENJOjAwMDA6MDE6MDEuMDogUmVzb3VyY2UgMDogOWZj
MDAwMDAtOWZmZmZmZmYgKGY9MTIwOCkKUENJOjAwMDA6MDE6MDEuMDogUmVzb3VyY2UgMTogOWYw
MDAwMDAtOWY3ZmZmZmYgKGY9MjAwKQpQQ0k6MDAwMDowMTowMS4wOiBSZXNvdXJjZSAyOiAwMGZm
ZmZmMC0wMGZmZmZmZiAoZj0xMDEpCgoKCgo=

------_=_NextPart_001_01C59DD5.C78825A3
Content-Type: text/plain;
	name="proc_pci_8540.txt"
Content-Transfer-Encoding: base64
Content-Description: proc_pci_8540.txt
Content-Disposition: attachment;
	filename="proc_pci_8540.txt"

CiMgY2F0IC9wcm9jL3BjaQoKUENJIGRldmljZXMgZm91bmQ6CiAgQnVzICAwLCBkZXZpY2UgIDIx
LCBmdW5jdGlvbiAgMDoKICAgIFBDSSBicmlkZ2U6IFRleGFzIEluc3RydW1lbnRzIFBDSTIwNTAg
UENJLXRvLVBDSSBCcmlkZ2UgKHJldiAyKS4KICAgICAgSVJRIDk4LgogICAgICBNYXN0ZXIgQ2Fw
YWJsZS4gIExhdGVuY3k9MTI4LgogIEJ1cyAgMSwgZGV2aWNlICAgMSwgZnVuY3Rpb24gIDA6CiAg
ICBOb24tVkdBIHVuY2xhc3NpZmllZCBkZXZpY2U6IFRleGFzIEluc3RydW1lbnRzIFRNUzMyMEM2
MjA1IEZpeGVkIFBvaW50IERTUCAocmV2IDEpLiAgICAgIElSUSA5OS4KICAgICAgTWFzdGVyIENh
cGFibGUuICBMYXRlbmN5PTEyOC4KICAgICAgUHJlZmV0Y2hhYmxlIDMyIGJpdCBtZW1vcnkgYXQg
MHg5ZmMwMDAwMCBbMHg5ZmZmZmZmZl0uCiAgICAgIE5vbi1wcmVmZXRjaGFibGUgMzIgYml0IG1l
bW9yeSBhdCAweDlmMDAwMDAwIFsweDlmN2ZmZmZmXS4KICAgICAgSS9PIGF0IDB4ZmZmZmYwIFsw
eGZmZmZmZl0uCgo=

------_=_NextPart_001_01C59DD5.C78825A3--
