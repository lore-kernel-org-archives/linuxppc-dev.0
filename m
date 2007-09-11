Return-Path: <thomas.fiksel@jena-optronik.de>
Received: from mailgw.jena-optronik.de (mailgw.jena-optronik.de [217.17.200.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mailgw.jena-optronik.de",
	Issuer "Reiner Pohl" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 3E0FCDDE36
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Sep 2007 19:16:30 +1000 (EST)
Received: from julia.jena-optronik.de (julia.jena-optronik.de [172.16.0.19])
	by mailgw.jena-optronik.de (8.13.4+Sun/8.13.4) with ESMTP id
	l8B97ZXR018163 for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Sep 2007 11:07:35 +0200 (CEST)
Received: from hermes.jena-optronik.de (hermes [172.16.0.8])
	by julia.jena-optronik.de (Postfix) with ESMTP id 7787E216E4
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Sep 2007 11:07:34 +0200 (CEST)
Received: from hermes.jena-optronik.de (localhost.localdomain [127.0.0.1])
	by hermes.jena-optronik.de (8.13.8/8.13.8) with ESMTP id l8B97YF7009232
	for <linuxppc-embedded@ozlabs.org>; Tue, 11 Sep 2007 11:07:34 +0200
Date: Tue, 11 Sep 2007 11:07:29 +0200
From: "Dr. Thomas Fiksel" <thomas.fiksel@jena-optronik.de>
To: Linuxppc Mailing list <linuxppc-embedded@ozlabs.org>
Message-ID: <46E65AD1.9030906@jena-optronik.de>
Subject: Lite5200B and Carmine Board PCI problem
MIME-Version: 1.0
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=sha1; boundary="----720D901CB390EB06C1109E85902BE973"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is an S/MIME signed message

------720D901CB390EB06C1109E85902BE973
Content-Type: text/plain;
 	charset="US-ASCII";
 	format="flowed"
Content-Disposition: inline

Hi Linuxppc-embedded,

I'm trying to run a Fujitsu Carmine Evaluation Board MB86297-EB01 on a 
Freescale Lite5200B board.
With a 'standard' Linux kernel 2.4 or 2.6 there are problems while 
allocating/maping of the PCI memory space. The Carmine board requires 2 
PCI IO space segments of 256 byte each, 1 PCI memory space segment of 
256 MByte and 1 PCI memory space segment of 64 MByte.

The U-Boot and kernel log shows :

Scanning PCI devices on bus 0
BusDevFun  VendorId   DeviceId   Device Class       Sub-Class
_____________________________________________________________
00.18.00   0x10cf     0x202b     Display controller      0x80
00.1a.00   0x1057     0x5809     Bridge device           0x80
...
PCI: Probing PCI hardware
...
PCI:00:18.0 Resource 0 [00000000-000000ff] is unassigned
PCI:00:18.0 Resource 1 [00000000-000000ff] is unassigned
PCI:00:18.0 Resource 2 [00000000-0fffffff] is unassigned
PCI:00:18.0 Resource 3 [00000000-03ffffff] is unassigned
PCI:00:1a.0 Resource 0 [00000000-0003ffff] is unassigned
PCI:00:1a.0 Resource 1 [00000000-3fffffff] is unassigned
PCI: bridge rsrc 50000000..50ffffff (100), parent c015debc, resource 
c027f038
PCI: bridge rsrc 40000000..4fffffff (200), parent c015ded8, resource 
c027f054
PCI: moved device 00:18.0 resource 0 (101) to 50000000
   got res[50000000:500000ff] for resource 0 of PCI device 10cf:202b
PCI: moved device 00:18.0 resource 1 (101) to 50000400
   got res[50000400:500004ff] for resource 1 of PCI device 10cf:202b
PCI: moved device 00:18.0 resource 2 (1208) to 40000000
   got res[40000000:4fffffff] for resource 2 of PCI device 10cf:202b
PCI: Failed to allocate resource 3(50000000-4fffffff) for 00:18.0


Because the PCI bridge shows only 256 MByte available memory area it is 
clear that the PCI memory space segment of 64 MByte (resource 3) is not 
allocated/mapped.

I tried to change the constants MPC5xxx_PCI_MEM_START and 
MPC5xxx_PCI_MEM_END constants (and other constants) in the related *.h 
file for arch/ppc/kernel/mpc5xxx_pci.c, recompiled the kernel and run it 
again.

Now the U-Boot and kernel log shows :

Scanning PCI devices on bus 0
BusDevFun  VendorId   DeviceId   Device Class       Sub-Class
_____________________________________________________________
00.18.00   0x10cf     0x202b     Display controller      0x80
00.1a.00   0x1057     0x5809     Bridge device           0x80
...
PCI: Probing PCI hardware
...
PCI:00:18.0 Resource 0 [00000000-000000ff] is unassigned
PCI:00:18.0 Resource 1 [00000000-000000ff] is unassigned
PCI:00:18.0 Resource 2 [00000000-0fffffff] is unassigned
PCI:00:18.0 Resource 3 [00000000-03ffffff] is unassigned
PCI:00:1a.0 Resource 0 [00000000-0003ffff] is unassigned
PCI:00:1a.0 Resource 1 [00000000-3fffffff] is unassigned
PCI: bridge rsrc 60000000..60ffffff (100), parent c015debc, resource 
c027f038
PCI: bridge rsrc 40000000..5fffffff (200), parent c015ded8, resource 
c027f054
PCI: moved device 00:18.0 resource 0 (101) to 60000000
   got res[60000000:600000ff] for resource 0 of PCI device 10cf:202b
PCI: moved device 00:18.0 resource 1 (101) to 60000400
   got res[60000400:600004ff] for resource 1 of PCI device 10cf:202b
PCI: moved device 00:18.0 resource 2 (1208) to 40000000
   got res[40000000:4fffffff] for resource 2 of PCI device 10cf:202b
PCI: moved device 00:18.0 resource 3 (1208) to 50000000
   got res[50000000:53ffffff] for resource 3 of PCI device 10cf:202b


The PCI bridge shows now a creater area and both PCI memory space 
segments of 256 Mbyte and 64 Mbyte are mapped.

But in case if I have a simple read or write acces to the register of 
Carmine (which are located in the 64 Mbyte segment in adress region 
above 0x50000000) the kernel gives the oops :

MB86290: fb_init called.
MB86290: initialize called.
Oops: kernel access of bad area, sig: 11
NIP: C00C2630 XER: 00000000 LR: C0004F3C SP: C0549D80 REGS: c0549cd0 
TRAP: 0300    Not tainted
MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 00000020, DSISR: 20000000
TASK = c0548000[1] 'swapper' Last syscall: 120
last math 00000000 last altivec 00000000
GPR00: C0004F3C C0549D80 C0548000 00000000 C01B788C C0549E10 C014CA74 
F0000C00
GPR08: F0001200 00000000 C0170000 00000020 C0190000 1008D5C4 0FFBA000 
00000000
GPR16: 00000000 00000001 FFFFFFFF 007FFF00 00001032 00549E00 00000000 
C0003E40
GPR24: C0004FA4 00000000 C0546420 C016EF20 C0549E10 C01B788C 24000000 
C0546420
Call backtrace:
00009032 C0004F3C C0005000 C0003E40 C0004840 C00049B8 C00C2C14
C017ED7C C017E008 C017A140 C01725F4 C0172640 C0003970 C0006318
Kernel panic: Aiee, killing interrupt handler!

(Please note, the register access in the MB86290 driver code is still 
directed to the new register locations of the Carmine)


Therefore my questions:

It is allowed to increase the PCI bridge memory area by th simple change 
of MPC5xxx_PCI_MEM_START and MPC5xxx_PCI_MEM_END (and related constants)?

Or there are technical/hardware restrictions that this area can only be 
256 MByte?

If not, must be changed other constants in the kernel configuration the 
increase the PCI bridge memory area?

There are known problems to plug the Carmine board in the Lite5200B board?

All jumpers on both boards are in default settings.

TIA

Thomas Fiksel



------720D901CB390EB06C1109E85902BE973
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

MIIHrgYJKoZIhvcNAQcCoIIHnzCCB5sCAQExCzAJBgUrDgMCGgUAMAsGCSqGSIb3
DQEHAaCCBZ4wggWaMIIEgqADAgECAgIulDANBgkqhkiG9w0BAQUFADB4MQswCQYD
VQQGEwJERTErMCkGA1UEChMiVC1TeXN0ZW1zIEVudGVycHJpc2UgU2VydmljZXMg
R21iSDEmMCQGA1UECxMdVHJ1c3QgQ2VudGVyIERldXRzY2hlIFRlbGVrb20xFDAS
BgNVBAMTC01haWxQYXNzIENBMB4XDTA3MDMxOTE1MzY0M1oXDTEwMDMxOTIzNTkw
MFowgb8xCzAJBgNVBAYTAkRFMRswGQYDVQQKExJKZW5hLU9wdHJvbmlrIEdtYkgx
FTATBgNVBAsTDGplbm9wdGlrLmNvbTEaMBgGA1UECxMRamVuYS5qZW5vcHRpay5j
b20xGTAXBgNVBAsTEEplbmEtT3B0cm9uaWsuMDcxFjAUBgNVBAMTDVRob21hcyBG
aWtzZWwxLTArBgkqhkiG9w0BCQEWHnRob21hcy5maWtzZWxAamVuYS1vcHRyb25p
ay5kZTCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEAzBjw4BYxTlqAEmjw/9X0
C811T+G755JkuXVR/6UD2ZG5I8gyiRZvHm3GrKiJg6gmCQu7HeTrVETAAhS6y+vN
dSCk3HEi2GGy8NnyJMChawYNQsssam/a9mYwKmLF2UCFXD8kbcQ4LJCa/buBfDDk
xKHuCb4C8YKO4VTCfzNor5MCAwEAAaOCAmgwggJkMB8GA1UdIwQYMBaAFCnKJvSU
hSoroHKCSoSpHLt80Nr7MA4GA1UdDwEB/wQEAwIFoDAdBgNVHQ4EFgQUpKAdl8NJ
A2IRkr8/usEf3Vbx+sswZQYDVR0gBF4wXDBaBgkrBgEEAb1HDQswTTBLBggrBgEF
BQcCARY/aHR0cDovL3d3d2NhLnRlbGVzZWMuZGUvY2FzZXJ2aWNlL01haWxQYXNz
L0Rva3VtZW50ZS9pbmRleC5odG1sMCkGA1UdEQQiMCCBHnRob21hcy5maWtzZWxA
amVuYS1vcHRyb25pay5kZTCCARIGA1UdHwSCAQkwggEFMIGkoIGhoIGehoGbbGRh
cDovL2xkYXAudC1tYWlscGFzcy5kZS9jbj1NYWlsUGFzcyUyMENBLG91PVRydXN0
JTIwQ2VudGVyJTIwRGV1dHNjaGUlMjBUZWxla29tLG89VC1TeXN0ZW1zJTIwRW50
ZXJwcmlzZSUyMFNlcnZpY2VzJTIwR21iSCxjPURFP0NlcnRpZmljYXRlUmV2b2Nh
dGlvbkxpc3QwXKBaoFiGVmh0dHA6Ly93d3djYS50ZWxlc2VjLmRlL2NnaS1iaW4v
Y2FzZXJ2aWNlL01haWxQYXNzL2FmX0Rvd25sb2FkQ1JMLmNybD9jbj1NYWlsUGFz
cyUyMENBMF8GCCsGAQUFBwEBBFMwUTBPBggrBgEFBQcwAYZDaHR0cDovL3d3d2Nh
LnRlbGVzZWMuZGUvY2dpLWJpbi9jYXNlcnZpY2UvTWFpbFBhc3Mvb2NzcF9yZXF1
ZXN0LmNnaTAJBgNVHRMEAjAAMA0GCSqGSIb3DQEBBQUAA4IBAQAAVV6TkkXWnCHs
MdPEiWkSjDxDZZfop+p36ArmfIl+3iUR8hPMeWyCOzc/zXitkYQ6mU0OtAfUkKEt
G0c3O4gJjDhO5+bF2kU40BqPgv6w4u7Nmkq9ucBf+Jf3vrm+43Fx2/g8EJ0q/uU9
nO8sPkA1TWEE8tp4a6jE/EyYihyBl18RYnviwslTYEfewm9PVqdrS6dJs0bYoe9D
Z3QcAqaY4ByTlXBHsWYqQTiAf3VyFd787ZxzDWpriHLhcBMXtkazqclH6WZzCI+v
MYTBgMji3O8ilM9PYByP711fQVcj2gm5V7JrNc/53RNGIG4+wajkfe1ssJEZdTTL
laW3GpqHMYIB2DCCAdQCAQEwfjB4MQswCQYDVQQGEwJERTErMCkGA1UEChMiVC1T
eXN0ZW1zIEVudGVycHJpc2UgU2VydmljZXMgR21iSDEmMCQGA1UECxMdVHJ1c3Qg
Q2VudGVyIERldXRzY2hlIFRlbGVrb20xFDASBgNVBAMTC01haWxQYXNzIENBAgIu
lDAJBgUrDgMCGgUAoIGxMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTA3MDkxMTA5MDczNVowIwYJKoZIhvcNAQkEMRYEFDBGp2wB08lJ
Obpep4g2ujOTy36XMFIGCSqGSIb3DQEJDzFFMEMwCgYIKoZIhvcNAwcwDgYIKoZI
hvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEo
MA0GCSqGSIb3DQEBAQUABIGAOPAGS/j4RMawPPLktn8K9Up96/DHrvAMMHiI+eeU
n7QRGyNLSb/knR4tLUX6qcUc7r7Ys1fz8ZSfYA09RKogRNe9OPD9cA98PSYmgT2z
V8v2SwhX7e2OozNbHIKYsXCtXjcIdGoNHyYHjEnOz1qhfzA3jQV7SGb0fKenxBRl
EJY=

------720D901CB390EB06C1109E85902BE973--
