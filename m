To: v.sudeep@exgate.tek.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PCI daughter card with USB on a 405GP
MIME-Version: 1.0
Message-ID: <OF6D7DDE3A.96D4D60C-ONC1256E43.005A36B4-C1256E43.005D9DE3@se.wavetek.com>
From: "Laurent Mohin" <laurent.mohin@acterna.com>
Date: Mon, 23 Feb 2004 18:01:08 +0100
Content-Type: multipart/mixed; boundary="=_mixed 005D9DDFC1256E43_="
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--=_mixed 005D9DDFC1256E43_=
Content-Type: text/plain; charset="us-ascii"

Hello,

The pci_assign_bus_resource function checks that your PCI board is able to answer to Memory space and
IO space cycles (PCI:pci_assign_resource: type_mask must match<3>).
Because this check doesn't match, it is unable to map any memory ressource
for your PCI board and thus generate an exception when the ohci driver is
launched.

In your case, I would suspect an hardware problem with your PCI adaptors
on the Walnut board (I used to have a problem with a graphic daughter card
on it and it was due to the lack of one of PCI power supply).

You can check this by deactivating the usb driver in Linux and let the
board booting without any exception. At the prompt try the command : lspci
-xx and check wether the configuration registers of your board are OK or
not.

Hope this helps,

Laurent





v.sudeep@exgate.tek.com
Sent by: owner-linuxppc-embedded@lists.linuxppc.org
23/02/04 17:11


        To:     linuxppc-embedded@lists.linuxppc.org
        cc:
        Subject:        PCI daughter card with USB on a 405GP


Hi Everyone !!!

I am finding it a bit difficult to overcome a problem related to the PCI
daughter card with USB on my 405GP IBM Walnut board. If anyone can help
me,
I would be greatful to them.

My problem is as follows....
I want to install a USB printer on my 405GP board. Unfortunately the 405GP
does not have a USB port. So I am trying to use a PCI daughter card with
USB. I tried using two different cards  - OPTi 82c861 and ALi M5273. In
both
cases it seems to have some problems in booting up. i.e when the kernel is
probing the pci bus, some errors seem to happen. I snooped the kernel code
and identified as to when the error is being thrown out but am not sure
what
exactly is wrong and how I can set it right.

This error occurs in :
                 file            - ./drivers/pci/setup-res.c
                 function - pci_assign_bus_resource
                 line            - if ((res->flags ^ r->flags) &
type_mask)
                                                 continue;

This results in a kernel panic.  I am not sure of how I could go around
this
problem. Any suggestions on how to get the USB card up will be greatly
appreciated.

And thanks in advance.


Note:

1.               Our setup over here is as follows:
                                 Host Machine : Intel x86 having Red Hat 9
installed
                                 Target Board : IBM Walnut board - 405GP
with PowerPC
processor
                                 Cross-Compiler: MonteVista Hard Hat Linux
2.0  for the
ibm-walnut board

2.               Also attaching a file containing all the messages that
the kernel
pattered out.

 <<booting-up-messages>>

- S u d e e p    V
Don't change horses in mid stream.




 <<booting-up.messages>>



--=_mixed 005D9DDFC1256E43_=
Content-Type: application/octet-stream; name="booting-up-messages"
Content-Disposition: attachment; filename="booting-up-messages"
Content-Transfer-Encoding: base64

RW50cnkgcG9pbnQgYXQgMHg0MDAwMDAgLi4uCi0tLS0tLS0tLS0gIHByb2dyZXNzOiAgMHgyMDAg
aWQgbWFjaCgpOiBkb25lCkxpbnV4IHZlcnNpb24gMi40LjJfaGhsMjAgKHJvb3RAY29zbW9zKSAo
Z2NjIHZlcnNpb24gMi45NS4zIDIwMDEwMzE1IChyZWxlYXNlL01vbnRhVmlzdGEpKSAjMzQKLS0t
LS0tLS0tLSAgcHJvZ3Jlc3M6ICAweDNlYWIgc2V0dXBfYXJjaDogZW50ZXIKLS0tLS0tLS0tLSAg
cHJvZ3Jlc3M6ICAweDNlYWIgc2V0dXBfYXJjaDogYm9vdG1lbQotLS0tLS0tLS0tICBwcm9ncmVz
czogIDB4M2VhYiBhcmNoOiBleGl0Ck9uIG5vZGUgMCB0b3RhbHBhZ2VzOiA4MTkyCnpvbmUoMCk6
IDgxOTIgcGFnZXMuCnpvbmUoMSk6IDAgcGFnZXMuCnpvbmUoMik6IDAgcGFnZXMuCktlcm5lbCBj
b21tYW5kIGxpbmU6IApDYWxpYnJhdGluZyBkZWxheSBsb29wLi4uIDE5OS40NyBCb2dvTUlQUwpN
ZW1vcnk6IDMwNDIwayBhdmFpbGFibGUgKDExMjRrIGtlcm5lbCBjb2RlLCA0NDBrIGRhdGEsIDE3
NmsgaW5pdCwgMGsgaGlnaG1lbSkKRGVudHJ5LWNhY2hlIGhhc2ggdGFibGUgZW50cmllczogNDA5
NiAob3JkZXI6IDMsIDMyNzY4IGJ5dGVzKQpCdWZmZXItY2FjaGUgaGFzaCB0YWJsZSBlbnRyaWVz
OiAxMDI0IChvcmRlcjogMCwgNDA5NiBieXRlcykKUGFnZS1jYWNoZSBoYXNoIHRhYmxlIGVudHJp
ZXM6IDgxOTIgKG9yZGVyOiAzLCAzMjc2OCBieXRlcykKSW5vZGUtY2FjaGUgaGFzaCB0YWJsZSBl
bnRyaWVzOiAyMDQ4IChvcmRlcjogMiwgMTYzODQgYnl0ZXMpClBPU0lYIGNvbmZvcm1hbmNlIHRl
c3RpbmcgYnkgVU5JRklYClBDSTogUHJvYmluZyBQQ0kgaGFyZHdhcmUKUENJOnBjaV9hc3NpZ25f
cmVzb3VyY2U6IHR5cGVfbWFzayBtdXN0IG1hdGNoPDM+UENJOiBFcnJvciB3aGlsZSB1cGRhdGlu
ZyByZWdpb24gMDA6MDQuMC8wICgxKQotLS0tLS0tLS0tICBwcm9ncmVzczogIDB4ZmZmZiAgICAg
ICAgICAgICAgCkxpbnV4IE5FVDQuMCBmb3IgTGludXggMi40CkJhc2VkIHVwb24gU3dhbnNlYSBV
bml2ZXJzaXR5IENvbXB1dGVyIFNvY2lldHkgTkVUMy4wMzkKU3RhcnRpbmcga3N3YXBkIHYxLjgK
cHR5OiAyNTYgVW5peDk4IHB0eXMgY29uZmlndXJlZApibG9jazogcXVldWVkIHNlY3RvcnMgbWF4
L2xvdyAyMDExN2tCLzY3MDVrQiwgNjQgc2xvdHMgcGVyIHF1ZXVlClJBTURJU0sgZHJpdmVyIGlu
aXRpYWxpemVkOiAxNiBSQU0gZGlza3Mgb2YgNDA5Nksgc2l6ZSAxMDI0IGJsb2Nrc2l6ZQpwaHkg
c3BlZWQgcmVhZCBmYWlsZWQgCnBoeSBkdXBsZXggcmVhZCBmYWlsZWQgCjw1PmV0aDA6IFBQQzQw
NSBFTUFDIDEwIE1icyBIYWxmIGR1cGxleCBNQUMgMDA6MDQ6YWM6ZTM6MTA6OTIKbG9vcDogbG9h
ZGVkIChtYXggOCBkZXZpY2VzKQpTZXJpYWwgZHJpdmVyIHZlcnNpb24gNS4wMiAoMjAwMC0wOC0w
OSkgd2l0aCBNQU5ZX1BPUlRTIFNIQVJFX0lSUSBTRVJJQUxfUENJIGVuYWJsZWQKdHR5UzAwIGF0
IDB4MDAwMCAoaXJxID0gMCkgaXMgYSAxNjU1MEEKdHR5UzAxIGF0IDB4MDAwMCAoaXJxID0gMSkg
aXMgYSAxNjU1MEEKUFBQIGdlbmVyaWMgZHJpdmVyIHZlcnNpb24gMi40LjEKdXNiLmM6IHJlZ2lz
dGVyZWQgbmV3IGRyaXZlciB1c2JkZXZmcwp1c2IuYzogcmVnaXN0ZXJlZCBuZXcgZHJpdmVyIGh1
YgpQQ0k6IEVuYWJsaW5nIGRldmljZSAwMDowNC4wICgwMDAwIC0+IDAwMDIpCnVzYi1vaGNpLmM6
IFVTQiBPSENJIGF0IG1lbWJhc2UgMHhjMzAwMDAwMCwgSVJRIDMxCnVzYi1vaGNpLmM6IHVzYi0w
MDowNC4wLCBPUFRpIEluYy4gODJDODYxCk1hY2hpbmUgQ2hlY2s6IFBMQjAgICAgICAgIGJlYXI9
IDB4MTAwMDAwMDQgYWNyPSAgIDB4MDAwMDAwMDAgYmVzcj0gIDB4MGMwMDAwMDAKTWFjaGluZSBD
aGVjazogUExCMCB0byBPUEIgYmVhcj0gMHgwMjAwMDAyMCBiZXNyMD0gMHgwMDAwMDAwMCBiZXNy
MT0gMHgwMDAwMDAwMApEYXRhIE1hY2hpbmUgQ2hlY2sgaW4ga2VybmVsIG1vZGUuCk9vcHM6IG1h
Y2hpbmUgY2hlY2ssIHNpZzogNwpOSVA6IEMwMEM1NTk4IFhFUjogMjAwMDAwMDAgTFI6IEMwMTZD
NTE4IFNQOiBDMDI3OURGMCBSRUdTOiBjMDI3OWQzMCBUUkFQOiAwMjAwCk1TUjogMDAwMDkwMzAg
RUU6IDEgUFI6IDAgRlA6IDAgTUU6IDEgSVIvRFI6IDExClRBU0sgPSBjMDI3ODAwMFsxXSAnc3dh
cHBlcicgTGFzdCBzeXNjYWxsOiAxMjAgCmxhc3QgbWF0aCAwMDAwMDAwMCBsYXN0IGFsdGl2ZWMg
MDAwMDAwMDAKUExCMDogYmVhcj0gMHgwMjAwMDAyMCBhY3I9ICAgMHgwMDAwMDAwMCBiZXNyPSAg
MHgwYzAwMDAwMApQTEIwIHRvIE9QQjogYmVhcj0gMHgxMDAwMDAwNCBiZXNyMD0gMHgwMDAwMDAw
MCBiZXNyMT0gMHgwMDAwMDAwMAoKR1BSMDA6IDAwMDAwMDAwIEMwMjc5REYwIEMwMjc4MDAwIEMw
MkVBMDAwIDAwMDAxMDMwIDAwMDAwMDAwIEMwMkVFOTA4IDAwMDAwMDAwIApHUFIwODogQzAyRUUw
NDAgRUVDMDAwMDAgQzAxQzAwMDAgQzMwMDAwMDAgODQwMDAwMjIgMzAwMDAwMDAgMDAwQzA4MDQg
MDAwMDAwMDAgCkdQUjE2OiAwMDAwMDAwMCBGRkZFMjFBRCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAw
MTAzMiAwMDI3OUQyMCAwMDAwMDAwMCBDMDAwMjk4MCAKR1BSMjQ6IDAwMDAwMDAwIDAwMDAwMDFF
IDAwMDAwMDFGIEMwMkVBMDAwIEMwMjcwNDAwIEMzMDAwMDAwIDAwMDAwMDMyIEMwMkVBMDAwIApD
YWxsIGJhY2t0cmFjZTogCkMwMEI1MjgwIEMwMTZDNTE4IEMwMTZDNzA4IEMwMEI0N0YwIEMwMEI0
ODg0IEMwMTZDNzUwIEMwMTYxODEwIApDMDE2MThCNCBDMDAwMjRGOCBDMDAwNTA2NCAKS2VybmVs
IHBhbmljOiBBdHRlbXB0ZWQgdG8ga2lsbCBpbml0IQpSZWJvb3RpbmcgaW4gMTgwIHNlY29uZHMu
LgoK
--=_mixed 005D9DDFC1256E43_=
Content-Type: application/octet-stream; name="booting-up.messages"
Content-Disposition: attachment; filename="booting-up.messages"
Content-Transfer-Encoding: base64

RW50cnkgcG9pbnQgYXQgMHg0MDAwMDAgLi4uCi0tLS0tLS0tLS0gIHByb2dyZXNzOiAgMHgyMDAg
aWQgbWFjaCgpOiBkb25lCkxpbnV4IHZlcnNpb24gMi40LjJfaGhsMjAgKHJvb3RAY29zbW9zKSAo
Z2NjIHZlcnNpb24gMi45NS4zIDIwMDEwMzE1IChyZWxlYXNlL01vbnRhVmlzdGEpKSAjMzQKLS0t
LS0tLS0tLSAgcHJvZ3Jlc3M6ICAweDNlYWIgc2V0dXBfYXJjaDogZW50ZXIKLS0tLS0tLS0tLSAg
cHJvZ3Jlc3M6ICAweDNlYWIgc2V0dXBfYXJjaDogYm9vdG1lbQotLS0tLS0tLS0tICBwcm9ncmVz
czogIDB4M2VhYiBhcmNoOiBleGl0Ck9uIG5vZGUgMCB0b3RhbHBhZ2VzOiA4MTkyCnpvbmUoMCk6
IDgxOTIgcGFnZXMuCnpvbmUoMSk6IDAgcGFnZXMuCnpvbmUoMik6IDAgcGFnZXMuCktlcm5lbCBj
b21tYW5kIGxpbmU6IApDYWxpYnJhdGluZyBkZWxheSBsb29wLi4uIDE5OS40NyBCb2dvTUlQUwpN
ZW1vcnk6IDMwNDIwayBhdmFpbGFibGUgKDExMjRrIGtlcm5lbCBjb2RlLCA0NDBrIGRhdGEsIDE3
NmsgaW5pdCwgMGsgaGlnaG1lbSkKRGVudHJ5LWNhY2hlIGhhc2ggdGFibGUgZW50cmllczogNDA5
NiAob3JkZXI6IDMsIDMyNzY4IGJ5dGVzKQpCdWZmZXItY2FjaGUgaGFzaCB0YWJsZSBlbnRyaWVz
OiAxMDI0IChvcmRlcjogMCwgNDA5NiBieXRlcykKUGFnZS1jYWNoZSBoYXNoIHRhYmxlIGVudHJp
ZXM6IDgxOTIgKG9yZGVyOiAzLCAzMjc2OCBieXRlcykKSW5vZGUtY2FjaGUgaGFzaCB0YWJsZSBl
bnRyaWVzOiAyMDQ4IChvcmRlcjogMiwgMTYzODQgYnl0ZXMpClBPU0lYIGNvbmZvcm1hbmNlIHRl
c3RpbmcgYnkgVU5JRklYClBDSTogUHJvYmluZyBQQ0kgaGFyZHdhcmUKUENJOnBjaV9hc3NpZ25f
cmVzb3VyY2U6IHR5cGVfbWFzayBtdXN0IG1hdGNoPDM+UENJOiBFcnJvciB3aGlsZSB1cGRhdGlu
ZyByZWdpb24gMDA6MDQuMC8wICgxKQotLS0tLS0tLS0tICBwcm9ncmVzczogIDB4ZmZmZiAgICAg
ICAgICAgICAgCkxpbnV4IE5FVDQuMCBmb3IgTGludXggMi40CkJhc2VkIHVwb24gU3dhbnNlYSBV
bml2ZXJzaXR5IENvbXB1dGVyIFNvY2lldHkgTkVUMy4wMzkKU3RhcnRpbmcga3N3YXBkIHYxLjgK
cHR5OiAyNTYgVW5peDk4IHB0eXMgY29uZmlndXJlZApibG9jazogcXVldWVkIHNlY3RvcnMgbWF4
L2xvdyAyMDExN2tCLzY3MDVrQiwgNjQgc2xvdHMgcGVyIHF1ZXVlClJBTURJU0sgZHJpdmVyIGlu
aXRpYWxpemVkOiAxNiBSQU0gZGlza3Mgb2YgNDA5Nksgc2l6ZSAxMDI0IGJsb2Nrc2l6ZQpwaHkg
c3BlZWQgcmVhZCBmYWlsZWQgCnBoeSBkdXBsZXggcmVhZCBmYWlsZWQgCjw1PmV0aDA6IFBQQzQw
NSBFTUFDIDEwIE1icyBIYWxmIGR1cGxleCBNQUMgMDA6MDQ6YWM6ZTM6MTA6OTIKbG9vcDogbG9h
ZGVkIChtYXggOCBkZXZpY2VzKQpTZXJpYWwgZHJpdmVyIHZlcnNpb24gNS4wMiAoMjAwMC0wOC0w
OSkgd2l0aCBNQU5ZX1BPUlRTIFNIQVJFX0lSUSBTRVJJQUxfUENJIGVuYWJsZWQKdHR5UzAwIGF0
IDB4MDAwMCAoaXJxID0gMCkgaXMgYSAxNjU1MEEKdHR5UzAxIGF0IDB4MDAwMCAoaXJxID0gMSkg
aXMgYSAxNjU1MEEKUFBQIGdlbmVyaWMgZHJpdmVyIHZlcnNpb24gMi40LjEKdXNiLmM6IHJlZ2lz
dGVyZWQgbmV3IGRyaXZlciB1c2JkZXZmcwp1c2IuYzogcmVnaXN0ZXJlZCBuZXcgZHJpdmVyIGh1
YgpQQ0k6IEVuYWJsaW5nIGRldmljZSAwMDowNC4wICgwMDAwIC0+IDAwMDIpCnVzYi1vaGNpLmM6
IFVTQiBPSENJIGF0IG1lbWJhc2UgMHhjMzAwMDAwMCwgSVJRIDMxCnVzYi1vaGNpLmM6IHVzYi0w
MDowNC4wLCBPUFRpIEluYy4gODJDODYxCk1hY2hpbmUgQ2hlY2s6IFBMQjAgICAgICAgIGJlYXI9
IDB4MTAwMDAwMDQgYWNyPSAgIDB4MDAwMDAwMDAgYmVzcj0gIDB4MGMwMDAwMDAKTWFjaGluZSBD
aGVjazogUExCMCB0byBPUEIgYmVhcj0gMHgwMjAwMDAyMCBiZXNyMD0gMHgwMDAwMDAwMCBiZXNy
MT0gMHgwMDAwMDAwMApEYXRhIE1hY2hpbmUgQ2hlY2sgaW4ga2VybmVsIG1vZGUuCk9vcHM6IG1h
Y2hpbmUgY2hlY2ssIHNpZzogNwpOSVA6IEMwMEM1NTk4IFhFUjogMjAwMDAwMDAgTFI6IEMwMTZD
NTE4IFNQOiBDMDI3OURGMCBSRUdTOiBjMDI3OWQzMCBUUkFQOiAwMjAwCk1TUjogMDAwMDkwMzAg
RUU6IDEgUFI6IDAgRlA6IDAgTUU6IDEgSVIvRFI6IDExClRBU0sgPSBjMDI3ODAwMFsxXSAnc3dh
cHBlcicgTGFzdCBzeXNjYWxsOiAxMjAgCmxhc3QgbWF0aCAwMDAwMDAwMCBsYXN0IGFsdGl2ZWMg
MDAwMDAwMDAKUExCMDogYmVhcj0gMHgwMjAwMDAyMCBhY3I9ICAgMHgwMDAwMDAwMCBiZXNyPSAg
MHgwYzAwMDAwMApQTEIwIHRvIE9QQjogYmVhcj0gMHgxMDAwMDAwNCBiZXNyMD0gMHgwMDAwMDAw
MCBiZXNyMT0gMHgwMDAwMDAwMAoKR1BSMDA6IDAwMDAwMDAwIEMwMjc5REYwIEMwMjc4MDAwIEMw
MkVBMDAwIDAwMDAxMDMwIDAwMDAwMDAwIEMwMkVFOTA4IDAwMDAwMDAwIApHUFIwODogQzAyRUUw
NDAgRUVDMDAwMDAgQzAxQzAwMDAgQzMwMDAwMDAgODQwMDAwMjIgMzAwMDAwMDAgMDAwQzA4MDQg
MDAwMDAwMDAgCkdQUjE2OiAwMDAwMDAwMCBGRkZFMjFBRCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAw
MTAzMiAwMDI3OUQyMCAwMDAwMDAwMCBDMDAwMjk4MCAKR1BSMjQ6IDAwMDAwMDAwIDAwMDAwMDFF
IDAwMDAwMDFGIEMwMkVBMDAwIEMwMjcwNDAwIEMzMDAwMDAwIDAwMDAwMDMyIEMwMkVBMDAwIApD
YWxsIGJhY2t0cmFjZTogCkMwMEI1MjgwIEMwMTZDNTE4IEMwMTZDNzA4IEMwMEI0N0YwIEMwMEI0
ODg0IEMwMTZDNzUwIEMwMTYxODEwIApDMDE2MThCNCBDMDAwMjRGOCBDMDAwNTA2NCAKS2VybmVs
IHBhbmljOiBBdHRlbXB0ZWQgdG8ga2lsbCBpbml0IQpSZWJvb3RpbmcgaW4gMTgwIHNlY29uZHMu
LgoK
--=_mixed 005D9DDFC1256E43_=--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
