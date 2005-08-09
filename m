Return-Path: <bgholikh@cisco.com>
Received: from sj-iport-2.cisco.com (sj-iport-2-in.cisco.com [171.71.176.71])
	by ozlabs.org (Postfix) with ESMTP id F2D3A67FF8
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Aug 2005 03:18:40 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C59D06.60822727"
Date: Tue, 9 Aug 2005 10:18:36 -0700
Message-ID: <F795765B112E7344AF36AA91127964158494FC@xmb-sjc-212.amer.cisco.com>
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

------_=_NextPart_001_01C59D06.60822727
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Kumar,
I am using Linux 2.6.11, u-boot 1.1.2.
I see failure in pci_enable_device with message:=20
"PCI: Device 0000:02:01.0 not available because of resource collisions"=20

I have attached three files:
lspci_output.txt: out put of the "lspci -v"
proc_pci.txt: output of the "cat /proc/pci"
u-boot.txt: output of the "pci command at u-boot"

Any help greatly appreciated,
Bizhan
-----Original Message-----
From: Kumar Gala [mailto:kumar.gala@freescale.com]=20
Sent: Monday, August 08, 2005 1:34 PM
To: Bizhan Gholikhamseh (bgholikh)
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: pci_enable_device fails on MPC8541

Bizhan,

A few questions:

1. what kernel version are you using on these boards:
2. can you do an lspci -v on the boards

- kumar

On Aug 8, 2005, at 1:12 PM, Bizhan Gholikhamseh \(((bgholikh\))) wrote:

> Hi All,
> I am using two evaluation board from freescale, 8540ADS and MPC8541.=20
> The same PCI driver is being compiled and loaded on both platforms.=20
> The same PCI driver (developed by me) for DSP board compiled and=20
> loaded on both platforms.
>
> When I type: "insmod C6415.ko" on 8541 board, I get the following
> error:
> "PCI: Device 0000:02:01.0 not available because of resource=20
> collisions"
> This messages is because of the execution of the generic PCI Linux
> command:
> "pci_enable_device(pdev)"
> The same API has no problem on 8540ADS.
>
>
>> From UBOOT I can see my device is on bus 3:
>>
> =3D> pci 3
> Scanning PCI devices on bus 3
> BusDev FUN    VendorID    DeviceID    Device Class    Sub-Class
> ----------------------------------------------------------------------
> --
> --------------------
> 03.01.00            0x104c    0xa106        .........
>
> Any idea why the insmod fails on one board and not on the other one?
>
> Many thanks in advance,
> Bizhan
>
> <ATT2118305.txt>
>

------_=_NextPart_001_01C59D06.60822727
Content-Type: text/plain;
	name="lspci_output.txt"
Content-Transfer-Encoding: base64
Content-Description: lspci_output.txt
Content-Disposition: attachment;
	filename="lspci_output.txt"

IyBsc3BjaSAtdgowMDoxMS4wIENsYXNzIDA2MDQ6IDEwZTM6MDUxMwogICAgICAgIEZsYWdzOiBi
dXMgbWFzdGVyLCA2Nk1oeiwgbWVkaXVtIGRldnNlbCwgbGF0ZW5jeSAxMjgKICAgICAgICBNZW1v
cnkgYXQgOWZmZmYwMDAgKDMyLWJpdCwgbm9uLXByZWZldGNoYWJsZSkKICAgICAgICBCdXM6IHBy
aW1hcnk9MDAsIHNlY29uZGFyeT0wMSwgc3Vib3JkaW5hdGU9MDEsIHNlYy1sYXRlbmN5PTI1NQog
ICAgICAgIE1lbW9yeSBiZWhpbmQgYnJpZGdlOiA5ZmUwMDAwMC05ZmVmZmZmZgogICAgICAgIFBy
ZWZldGNoYWJsZSBtZW1vcnkgYmVoaW5kIGJyaWRnZTogMDAwMDAwMDA5ZmQwMDAwMC0wMDAwMDAw
MDlmZDAwMDAwCgowMDoxNS4wIENsYXNzIDA2MDQ6IDEwNGM6YWMyOCAocmV2IDAyKQogICAgICAg
IEZsYWdzOiBidXMgbWFzdGVyLCBtZWRpdW0gZGV2c2VsLCBsYXRlbmN5IDEyOAogICAgICAgIEJ1
czogcHJpbWFyeT0wMCwgc2Vjb25kYXJ5PTAyLCBzdWJvcmRpbmF0ZT0wMiwgc2VjLWxhdGVuY3k9
MjI2CiAgICAgICAgTWVtb3J5IGJlaGluZCBicmlkZ2U6IDlmMDAwMDAwLTlmY2ZmZmZmCiAgICAg
ICAgUHJlZmV0Y2hhYmxlIG1lbW9yeSBiZWhpbmQgYnJpZGdlOiAwMDAwMDAwMDllZjAwMDAwLTAw
MDAwMDAwOWVmMDAwMDAKICAgICAgICBTZWNvbmRhcnkgc3RhdHVzOiBTRVJSCgowMTowMi4wIENs
YXNzIDA2MDE6IDExMDY6MDY4NiAocmV2IDQwKQogICAgICAgIEZsYWdzOiBidXMgbWFzdGVyLCBz
dGVwcGluZywgbWVkaXVtIGRldnNlbCwgbGF0ZW5jeSAwLCBJUlEgOTgKICAgICAgICBDYXBhYmls
aXRpZXM6IFtjMF0gUG93ZXIgTWFuYWdlbWVudCB2ZXJzaW9uIDIKCjAxOjAyLjEgQ2xhc3MgMDEw
MTogMTEwNjowNTcxIChyZXYgMDYpIChwcm9nLWlmIDhhKQogICAgICAgIEZsYWdzOiBzdGVwcGlu
ZywgbWVkaXVtIGRldnNlbCwgSVJRIDk4CiAgICAgICAgSS9PIHBvcnRzIGF0IGNjMDAKICAgICAg
ICBDYXBhYmlsaXRpZXM6IFtjMF0gUG93ZXIgTWFuYWdlbWVudCB2ZXJzaW9uIDIKCjAxOjAyLjIg
Q2xhc3MgMGMwMzogMTEwNjozMDM4IChyZXYgMWQpCiAgICAgICAgU3Vic3lzdGVtOiAwOTI1OjEy
MzQKICAgICAgICBGbGFnczogYnVzIG1hc3RlciwgbWVkaXVtIGRldnNlbCwgbGF0ZW5jeSAxMjgs
IElSUSA5NwogICAgICAgIEkvTyBwb3J0cyBhdCBmZmUwCiAgICAgICAgQ2FwYWJpbGl0aWVzOiBb
ODBdIFBvd2VyIE1hbmFnZW1lbnQgdmVyc2lvbiAyCgowMTowMi4zIENsYXNzIDBjMDM6IDExMDY6
MzAzOCAocmV2IDFkKQogICAgICAgIFN1YnN5c3RlbTogMDkyNToxMjM0CiAgICAgICAgRmxhZ3M6
IGJ1cyBtYXN0ZXIsIG1lZGl1bSBkZXZzZWwsIGxhdGVuY3kgMTI4LCBJUlEgOTcKICAgICAgICBJ
L08gcG9ydHMgYXQgZmZjMAogICAgICAgIENhcGFiaWxpdGllczogWzgwXSBQb3dlciBNYW5hZ2Vt
ZW50IHZlcnNpb24gMgoKMDE6MDIuNCBDbGFzcyAwMDAwOiAxMTA2OjMwNTcgKHJldiA0MCkKICAg
ICAgICBGbGFnczogbWVkaXVtIGRldnNlbCwgSVJRIDk4CiAgICAgICAgQ2FwYWJpbGl0aWVzOiBb
NjhdIFBvd2VyIE1hbmFnZW1lbnQgdmVyc2lvbiAyCgowMTowMi41IENsYXNzIDA0MDE6IDExMDY6
MzA1OCAocmV2IDUwKQogICAgICAgIEZsYWdzOiBtZWRpdW0gZGV2c2VsLCBJUlEgOTYKICAgICAg
ICBJL08gcG9ydHMgYXQgZmUwMAogICAgICAgIEkvTyBwb3J0cyBhdCBmZGZjCiAgICAgICAgSS9P
IHBvcnRzIGF0IGZkZjgKICAgICAgICBDYXBhYmlsaXRpZXM6IFtjMF0gUG93ZXIgTWFuYWdlbWVu
dCB2ZXJzaW9uIDIKCjAxOjAyLjYgQ2xhc3MgMDc4MDogMTEwNjozMDY4IChyZXYgMzApCiAgICAg
ICAgRmxhZ3M6IG1lZGl1bSBkZXZzZWwsIElSUSA5NgogICAgICAgIEkvTyBwb3J0cyBhdCBmYzAw
CiAgICAgICAgQ2FwYWJpbGl0aWVzOiBbZDBdIFBvd2VyIE1hbmFnZW1lbnQgdmVyc2lvbiAyCgow
MjowMS4wIENsYXNzIDAwMDA6IDEwNGM6YTEwNiAocmV2IDAxKQogICAgICAgIEZsYWdzOiBidXMg
bWFzdGVyLCBtZWRpdW0gZGV2c2VsLCBsYXRlbmN5IDEyOCwgSVJRIDk2CiAgICAgICAgTWVtb3J5
IGF0IDlmODAwMDAwICgzMi1iaXQsIHByZWZldGNoYWJsZSkKICAgICAgICBNZW1vcnkgYXQgOWYw
MDAwMDAgKDMyLWJpdCwgbm9uLXByZWZldGNoYWJsZSkKICAgICAgICBJL08gcG9ydHMgYXQgPGln
bm9yZWQ+CiAgICAgICAgQ2FwYWJpbGl0aWVzOiBbNDBdIFBvd2VyIE1hbmFnZW1lbnQgdmVyc2lv
biAyCg==

------_=_NextPart_001_01C59D06.60822727
Content-Type: text/plain;
	name="proc_pci.txt"
Content-Transfer-Encoding: base64
Content-Description: proc_pci.txt
Content-Disposition: attachment;
	filename="proc_pci.txt"

IyBjYXQgL3Byb2MvcGNpClBDSSBkZXZpY2VzIGZvdW5kOgogIEJ1cyAgMCwgZGV2aWNlICAxNywg
ZnVuY3Rpb24gIDA6CiAgICBQQ0kgYnJpZGdlOiBQQ0kgZGV2aWNlIDEwZTM6MDUxMyAoVHVuZHJh
IFNlbWljb25kdWN0b3IgQ29ycC4pIChyZXYgMCkuCiAgICAgIElSUSA5Ni4KICAgICAgTWFzdGVy
IENhcGFibGUuICBMYXRlbmN5PTEyOC4KICAgICAgTm9uLXByZWZldGNoYWJsZSAzMiBiaXQgbWVt
b3J5IGF0IDB4OWZmZmYwMDAgWzB4OWZmZmZmZmZdLgogIEJ1cyAgMCwgZGV2aWNlICAyMSwgZnVu
Y3Rpb24gIDA6CiAgICBQQ0kgYnJpZGdlOiBUZXhhcyBJbnN0cnVtZW50cyBQQ0kyMDUwIFBDSS10
by1QQ0kgQnJpZGdlIChyZXYgMikuCiAgICAgIElSUSA5OS4KICAgICAgTWFzdGVyIENhcGFibGUu
ICBMYXRlbmN5PTEyOC4gIE1heCBMYXQ9NC4KICBCdXMgIDEsIGRldmljZSAgIDIsIGZ1bmN0aW9u
ICAwOgogICAgSVNBIGJyaWRnZTogVklBIFRlY2hub2xvZ2llcywgSW5jLiBWVDgyQzY4NiBbQXBv
bGxvIFN1cGVyIFNvdXRoXSAocmV2IDY0KS4KICAgICAgSVJRIDk4LgogIEJ1cyAgMSwgZGV2aWNl
ICAgMiwgZnVuY3Rpb24gIDE6CiAgICBJREUgaW50ZXJmYWNlOiBWSUEgVGVjaG5vbG9naWVzLCBJ
bmMuIFZUODJDNTg2QS9CL1ZUODJDNjg2L0EvQi9WVDgyM3gvQS9DIFBJUEMgQnVzIE1hc3QuICAg
ICAgSVJRIDk4LgogICAgICBJL08gYXQgMHhjYzAwIFsweGNjMGZdLgogIEJ1cyAgMSwgZGV2aWNl
ICAgMiwgZnVuY3Rpb24gIDI6CiAgICBVU0IgQ29udHJvbGxlcjogVklBIFRlY2hub2xvZ2llcywg
SW5jLiBWVDgyeHh4eHggVUhDSSBVU0IgMS4xIENvbnRyb2xsZXIgKHJldiAyOSkuCiAgICAgIElS
USA5Ny4KICAgICAgTWFzdGVyIENhcGFibGUuICBMYXRlbmN5PTEyOC4KICAgICAgSS9PIGF0IDB4
ZmZlMCBbMHhmZmZmXS4KICBCdXMgIDEsIGRldmljZSAgIDIsIGZ1bmN0aW9uICAzOgogICAgVVNC
IENvbnRyb2xsZXI6IFZJQSBUZWNobm9sb2dpZXMsIEluYy4gVlQ4Mnh4eHh4IFVIQ0kgVVNCIDEu
MSBDb250cm9sbGVyICgjMikgKHJldiAyOSkuCiAgICAgIElSUSA5Ny4KICAgICAgTWFzdGVyIENh
cGFibGUuICBMYXRlbmN5PTEyOC4KICAgICAgSS9PIGF0IDB4ZmZjMCBbMHhmZmRmXS4KICBCdXMg
IDEsIGRldmljZSAgIDIsIGZ1bmN0aW9uICA0OgogICAgTm9uLVZHQSB1bmNsYXNzaWZpZWQgZGV2
aWNlOiBWSUEgVGVjaG5vbG9naWVzLCBJbmMuIFZUODJDNjg2IFtBcG9sbG8gU3VwZXIgQUNQSV0g
KHJldiA2LiAgICAgIElSUSA5OC4KICBCdXMgIDEsIGRldmljZSAgIDIsIGZ1bmN0aW9uICA1Ogog
ICAgTXVsdGltZWRpYSBhdWRpbyBjb250cm9sbGVyOiBWSUEgVGVjaG5vbG9naWVzLCBJbmMuIFZU
ODJDNjg2IEFDOTcgQXVkaW8gQ29udHJvbGxlciAocmV2LiAgICAgIElSUSA5Ni4KICAgICAgSS9P
IGF0IDB4ZmUwMCBbMHhmZWZmXS4KICAgICAgSS9PIGF0IDB4ZmRmYyBbMHhmZGZmXS4KICAgICAg
SS9PIGF0IDB4ZmRmOCBbMHhmZGZiXS4KICBCdXMgIDEsIGRldmljZSAgIDIsIGZ1bmN0aW9uICA2
OgogICAgQ29tbXVuaWNhdGlvbiBjb250cm9sbGVyOiBWSUEgVGVjaG5vbG9naWVzLCBJbmMuIElu
dGVsIDUzNyBbQUM5NyBNb2RlbV0gKHJldiA0OCkuCiAgICAgIElSUSA5Ni4KICAgICAgSS9PIGF0
IDB4ZmMwMCBbMHhmY2ZmXS4KICBCdXMgIDIsIGRldmljZSAgIDEsIGZ1bmN0aW9uICAwOgogICAg
Tm9uLVZHQSB1bmNsYXNzaWZpZWQgZGV2aWNlOiBUZXhhcyBJbnN0cnVtZW50cyBUTVMzMjBDNjIw
NSBGaXhlZCBQb2ludCBEU1AgKHJldiAxKS4KICAgICAgSVJRIDk2LgogICAgICBNYXN0ZXIgQ2Fw
YWJsZS4gIExhdGVuY3k9MTI4LgogICAgICBQcmVmZXRjaGFibGUgMzIgYml0IG1lbW9yeSBhdCAw
eDlmODAwMDAwIFsweDlmYmZmZmZmXS4KICAgICAgTm9uLXByZWZldGNoYWJsZSAzMiBiaXQgbWVt
b3J5IGF0IDB4OWYwMDAwMDAgWzB4OWY3ZmZmZmZdLgogICAgICBJL08gYXQgMHgwIFsweGZdLgoK

------_=_NextPart_001_01C59D06.60822727
Content-Type: text/plain;
	name="u-boot.txt"
Content-Transfer-Encoding: base64
Content-Description: u-boot.txt
Content-Disposition: attachment;
	filename="u-boot.txt"

PT4gcGNpIDMKU2Nhbm5pbmcgUENJIGRldmljZXMgb24gYnVzIDMKQnVzRGV2RnVuICBWZW5kb3JJ
ZCAgIERldmljZUlkICAgRGV2aWNlIENsYXNzICAgICAgIFN1Yi1DbGFzcwpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCjAzLjAxLjAw
ICAgMHgxMDRjICAgICAweGExMDYgICAgIEJ1aWxkIGJlZm9yZSBQQ0kgUmV2Mi4wIDB4MDAKPT4g
cGNpIGhlYWRlciAwMy4wMS4wMAogIHZlbmRvciBJRCA9ICAgICAgICAgICAgICAgICAgIDB4MTA0
YwogIGRldmljZSBJRCA9ICAgICAgICAgICAgICAgICAgIDB4YTEwNgogIGNvbW1hbmQgcmVnaXN0
ZXIgPSAgICAgICAgICAgIDB4MDAwNwogIHN0YXR1cyByZWdpc3RlciA9ICAgICAgICAgICAgIDB4
MDIxMAogIHJldmlzaW9uIElEID0gICAgICAgICAgICAgICAgIDB4MDEKICBjbGFzcyBjb2RlID0g
ICAgICAgICAgICAgICAgICAweDAwIChCdWlsZCBiZWZvcmUgUENJIFJldjIuMCkKICBzdWIgY2xh
c3MgY29kZSA9ICAgICAgICAgICAgICAweDAwCiAgcHJvZ3JhbW1pbmcgaW50ZXJmYWNlID0gICAg
ICAgMHgwMAogIGNhY2hlIGxpbmUgPSAgICAgICAgICAgICAgICAgIDB4MDgKICBsYXRlbmN5IHRp
bWUgPSAgICAgICAgICAgICAgICAweDgwCiAgaGVhZGVyIHR5cGUgPSAgICAgICAgICAgICAgICAg
MHgwMAogIEJJU1QgPSAgICAgICAgICAgICAgICAgICAgICAgIDB4MDAKICBiYXNlIGFkZHJlc3Mg
MCA9ICAgICAgICAgICAgICAweDgxMDAwMDA4CiAgYmFzZSBhZGRyZXNzIDEgPSAgICAgICAgICAg
ICAgMHg4MTgwMDAwMAogIGJhc2UgYWRkcmVzcyAyID0gICAgICAgICAgICAgIDB4ZTIwMDQwMDEK
ICBiYXNlIGFkZHJlc3MgMyA9ICAgICAgICAgICAgICAweDAwMDAwMDAwCiAgYmFzZSBhZGRyZXNz
IDQgPSAgICAgICAgICAgICAgMHgwMDAwMDAwMAogIGJhc2UgYWRkcmVzcyA1ID0gICAgICAgICAg
ICAgIDB4MDAwMDAwMDAKICBjYXJkQnVzIENJUyBwb2ludGVyID0gICAgICAgICAweDAwMDAwMDAw
CiAgc3ViIHN5c3RlbSB2ZW5kb3IgSUQgPSAgICAgICAgMHgwMDAwCiAgc3ViIHN5c3RlbSBJRCA9
ICAgICAgICAgICAgICAgMHgwMDAwCiAgZXhwYW5zaW9uIFJPTSBiYXNlIGFkZHJlc3MgPSAgMHgw
MDAwMDAwMAogIGludGVycnVwdCBsaW5lID0gICAgICAgICAgICAgIDB4NjAKICBpbnRlcnJ1cHQg
cGluID0gICAgICAgICAgICAgICAweDAxCiAgbWluIEdyYW50ID0gICAgICAgICAgICAgICAgICAg
MHgwMAogIG1heCBMYXRlbmN5ID0gICAgICAgICAgICAgICAgIDB4MDAKCg==

------_=_NextPart_001_01C59D06.60822727--
