Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 3F47BDDEC5
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 14 Jul 2007 06:27:36 +1000 (EST)
Message-ID: <4697E034.1080501@anagramm.de>
Date: Fri, 13 Jul 2007 22:27:32 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: Vikram Kone <vikramkone@gmail.com>
Subject: Re: Help required for porting ISP1362 usb device driver
References: <003901c7c585$24fe3430$66dd47ab@cisco.com>
In-Reply-To: <003901c7c585$24fe3430$66dd47ab@cisco.com>
Content-Type: multipart/mixed; boundary="------------050100040508010100070309"
Cc: linuxppc-embedded@ozlabs.org
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
--------------050100040508010100070309
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Don't remove the list, use "reply-to-all".

Vikram Kone schrieb:
> Hi Clemens..
> Thanks for replying..
> 
> The problem that I actually have is..
> The documentation that I got with the device and host controller drivers is
> based on kernel 2.6.6 so I'm not sure whther it works for 2.6.22 or not....
> I followed the instructions in that document and was able to compile to
> modules by running 'make' command in the folder. That's all fine. 
> But the problem is....as I said I'm working on the MPC8548 board by free
> scale and as you know its based on power pc architecture.

> I have attched the device driver files that I got from sourceforge.net

You don't need to attach drivers, when they are somewhere in the
web. Linking to it is fine.
I don't have the hardware and such an old kernel.
(I am using the ISP1563 on PCI and that works just fine.)

The driver is not in the kernel tree. There is no real support
for out of kernel drivers, so these drivers just get old and broken.
Contact the driver author mentioned in the code (Marlon Jose Masbad)
and tell him to push the code into the latest kernel.

> What I did was... Unzipped them and copied the folders in
> /usr/src/linux-2.6.10/drivers/usb 

I prefer not riding dead horses. ;-)

> As you can see the two folders that I have got are ISP1362_Device and
> ISP1362_Host
 >
> When I run 'make' in the Device folder I get the following error
> 
> bash-2.05b$ make
> make -C
> /ws/vkone/usb/Vendor/linux-2.6.10/drivers/usb/ISP1362_Device/device/diskemu
> make[1]: Entering directory
> `/auto/wsvkone/usb/Vendor/linux-2.6.10/drivers/usb/ISP1362_Device/device/dis
> kemu'
> make[1]: Nothing to be done for `all'.
> make[1]: Leaving directory
> `/auto/wsvkone/usb/Vendor/linux-2.6.10/drivers/usb/ISP1362_Device/device/dis
> kemu'
> make -C /ws/vkone/usb/Vendor/linux-2.6.10
> M=/ws/vkone/usb/Vendor/linux-2.6.10/drivers/usb/ISP1362_Device
> make[1]: Entering directory `/auto/wsvkone/usb/Vendor/linux-2.6.10'
> Makefile:531: /auto/wsvkone/usb/Vendor/linux-2.6.10/arch/i386/Makefile: No
> such file or directory
> make[1]: *** No rule to make target
> `/auto/wsvkone/usb/Vendor/linux-2.6.10/arch/i386/Makefile'.  Stop.
> make[1]: Leaving directory `/auto/wsvkone/usb/Vendor/linux-2.6.10'
> make: *** [all] Error 2
> bash-2.05b$
> 
> 
> I guess this is due to the 'arch' problem. I mean since there is no i386
> folder in the arch directory I guess its messing up. 
> 
> Can you help me now

Have you tried
$ export ARCH=ppc
or something similar?
(powerpc is current)

On my MPC8540 and the latest tools (than one still on ARCH=ppc), I ran into some crap:

/usr/src/linux-2.6.21.5/drivers/ISP1362_Device/device/devmscd/devmscd.c:35:26: error: linux/config.h: No such file or directory
/usr/src/linux-2.6.21.5/drivers/ISP1362_Device/device/devmscd/devmscd.c:61:25: error: asm/segment.h: No such file or directory

So, well, just out of curiosity, I just killed some of the bad stuff and got it to build... :-)

$ make
make -C /usr/src/linux-2.6.21.5/drivers/ISP1362_Device/device/diskemu
make[1]: Entering directory `/usr/src/linux-2.6.21.5/drivers/ISP1362_Device/device/diskemu'
cc  -I../devmscd -D_8MB_SIZE_ -c disk_emu.c
cc -g -s -o msdisk disk_emu.o
make[1]: Leaving directory `/usr/src/linux-2.6.21.5/drivers/ISP1362_Device/device/diskemu'
make -C /usr/src/linux-2.6.21.5 M=/usr/src/linux-2.6.21.5/drivers/ISP1362_Device
make[1]: Entering directory `/usr/src/linux-2.6.21.5'
   LD      /usr/src/linux-2.6.21.5/drivers/ISP1362_Device/device/devmscd/built-in.o
   CC [M]  /usr/src/linux-2.6.21.5/drivers/ISP1362_Device/device/devmscd/devmscd.o
   CC [M]  /usr/src/linux-2.6.21.5/drivers/ISP1362_Device/device/devmscd/msbridge.o
   LD [M]  /usr/src/linux-2.6.21.5/drivers/ISP1362_Device/device/devmscd/mscd.o
   LD      /usr/src/linux-2.6.21.5/drivers/ISP1362_Device/device/pdc/built-in.o
   CC [M]  /usr/src/linux-2.6.21.5/drivers/ISP1362_Device/device/pdc/usb_pdc.o
/usr/src/linux-2.6.21.5/drivers/ISP1362_Device/device/pdc/usb_pdc.c: In function 'pdc_dev_control':
/usr/src/linux-2.6.21.5/drivers/ISP1362_Device/device/pdc/usb_pdc.c:313: warning: format '%d' expects type 'int', but argument 2 has type 'long unsigned int'
/usr/src/linux-2.6.21.5/drivers/ISP1362_Device/device/pdc/usb_pdc.c: In function 'rx_command':
/usr/src/linux-2.6.21.5/drivers/ISP1362_Device/device/pdc/usb_pdc.c:647: warning: format '%d' expects type 'int', but argument 2 has type 'long unsigned int'
/usr/src/linux-2.6.21.5/drivers/ISP1362_Device/device/pdc/usb_pdc.c: In function 'pdc_get_frame_number':
/usr/src/linux-2.6.21.5/drivers/ISP1362_Device/device/pdc/usb_pdc.c:851: warning: format '%d' expects type 'int', but argument 2 has type 'long unsigned int'
   CC [M]  /usr/src/linux-2.6.21.5/drivers/ISP1362_Device/device/pdc/pdc_bus.o
   LD [M]  /usr/src/linux-2.6.21.5/drivers/ISP1362_Device/device/pdc/pdc.o
   LD      /usr/src/linux-2.6.21.5/drivers/ISP1362_Device/x86pci/built-in.o
   CC [M]  /usr/src/linux-2.6.21.5/drivers/ISP1362_Device/x86pci/hal_pci.o
/usr/src/linux-2.6.21.5/drivers/ISP1362_Device/x86pci/hal_pci.c: In function 'isp1362_request_irq':
/usr/src/linux-2.6.21.5/drivers/ISP1362_Device/x86pci/hal_pci.c:724: warning: passing argument 2 of 'request_irq' from incompatible pointer type
   Building modules, stage 2.
   MODPOST 3 modules
   CC      /usr/src/linux-2.6.21.5/drivers/ISP1362_Device/device/devmscd/mscd.mod.o
   LD [M]  /usr/src/linux-2.6.21.5/drivers/ISP1362_Device/device/devmscd/mscd.ko
   CC      /usr/src/linux-2.6.21.5/drivers/ISP1362_Device/device/pdc/pdc.mod.o
   LD [M]  /usr/src/linux-2.6.21.5/drivers/ISP1362_Device/device/pdc/pdc.ko
   CC      /usr/src/linux-2.6.21.5/drivers/ISP1362_Device/x86pci/hal_pci.mod.o
   LD [M]  /usr/src/linux-2.6.21.5/drivers/ISP1362_Device/x86pci/hal_pci.ko
make[1]: Leaving directory `/usr/src/linux-2.6.21.5'
root@fox:/usr/src/linux-2.6.21.5/drivers/ISP1362_Device$ make
make -C /usr/src/linux-2.6.21.5/drivers/ISP1362_Device/device/diskemu
make[1]: Entering directory `/usr/src/linux-2.6.21.5/drivers/ISP1362_Device/device/diskemu'
make[1]: Nothing to be done for `all'.
make[1]: Leaving directory `/usr/src/linux-2.6.21.5/drivers/ISP1362_Device/device/diskemu'
make -C /usr/src/linux-2.6.21.5 M=/usr/src/linux-2.6.21.5/drivers/ISP1362_Device
make[1]: Entering directory `/usr/src/linux-2.6.21.5'
   CC [M]  /usr/src/linux-2.6.21.5/drivers/ISP1362_Device/x86pci/hal_pci.o
/usr/src/linux-2.6.21.5/drivers/ISP1362_Device/x86pci/hal_pci.c: In function 'isp1362_request_irq':
/usr/src/linux-2.6.21.5/drivers/ISP1362_Device/x86pci/hal_pci.c:724: warning: passing argument 2 of 'request_irq' from incompatible pointer type
   Building modules, stage 2.
   MODPOST 3 modules
   CC      /usr/src/linux-2.6.21.5/drivers/ISP1362_Device/device/devmscd/mscd.mod.o
   LD [M]  /usr/src/linux-2.6.21.5/drivers/ISP1362_Device/device/devmscd/mscd.ko
   CC      /usr/src/linux-2.6.21.5/drivers/ISP1362_Device/device/pdc/pdc.mod.o
   LD [M]  /usr/src/linux-2.6.21.5/drivers/ISP1362_Device/device/pdc/pdc.ko
   CC      /usr/src/linux-2.6.21.5/drivers/ISP1362_Device/x86pci/hal_pci.mod.o
   LD [M]  /usr/src/linux-2.6.21.5/drivers/ISP1362_Device/x86pci/hal_pci.ko
make[1]: Leaving directory `/usr/src/linux-2.6.21.5'

Quick and dirty patch attached below...
Give it a try and publish your results (also to the list!)

Anybody who wants to see this in mainline?
It would be good to pick up *now*!
For sure it needs more clean up...

Regards,
-- 
Clemens Koller
__________________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Straße 45/1
Linhof Werksgelände
D-81379 München
Tel.089-741518-50
Fax 089-741518-19
http://www.anagramm-technology.com

--------------050100040508010100070309
Content-Type: text/plain;
 name="ISP1362_Device-2.6.21.5-fix.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="ISP1362_Device-2.6.21.5-fix.patch"

ZGlmZiAtTnVycCBJU1AxMzYyX0RldmljZS9NYWtlZmlsZSBJU1AxMzYyX0RldmljZS5maXhl
ZC9NYWtlZmlsZQotLS0gSVNQMTM2Ml9EZXZpY2UvTWFrZWZpbGUJMjAwNi0wOS0yNSAxMToz
NzoyOS4wMDAwMDAwMDAgKzAyMDAKKysrIElTUDEzNjJfRGV2aWNlLmZpeGVkL01ha2VmaWxl
CTIwMDctMDctMTMgMjI6MDQ6NTMuMDAwMDAwMDAwICswMjAwCkBAIC0xLDUgKzEsNSBAQAog
VE9QRElSPSQoc2hlbGwgcHdkKQotS0VSTkVMX0RJUj0vdXNyL3NyYy9saW51eC0yLjYuNgor
S0VSTkVMX0RJUj0vdXNyL3NyYy9saW51eC0yLjYuMjEuNQogZXhwb3J0ICQoS0VSTkVMX0RJ
UikKIAogb2JqLW0gKz0geDg2cGNpLwpkaWZmIC1OdXJwIElTUDEzNjJfRGV2aWNlL2Rldmlj
ZS9kZXZtc2NkL2Rldm1zY2QuYyBJU1AxMzYyX0RldmljZS5maXhlZC9kZXZpY2UvZGV2bXNj
ZC9kZXZtc2NkLmMKLS0tIElTUDEzNjJfRGV2aWNlL2RldmljZS9kZXZtc2NkL2Rldm1zY2Qu
YwkyMDA2LTA5LTI1IDExOjMyOjIxLjAwMDAwMDAwMCArMDIwMAorKysgSVNQMTM2Ml9EZXZp
Y2UuZml4ZWQvZGV2aWNlL2Rldm1zY2QvZGV2bXNjZC5jCTIwMDctMDctMTMgMjI6MDg6NDgu
MDAwMDAwMDAwICswMjAwCkBAIC0zMiwxMCArMzIsNiBAQAogICoNCiAgKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKiovDQogDQotI2luY2x1ZGUgPGxpbnV4L2NvbmZpZy5oPg0KLSNpZmRlZiBMSU5VWF8y
NA0KLSNkZWZpbmUJTU9EVUxFDQotI2VuZGlmDQogI2luY2x1ZGUgPGxpbnV4L3R5cGVzLmg+
DQogI2luY2x1ZGUgPGxpbnV4L3N0cmluZy5oPg0KICNpbmNsdWRlIDxsaW51eC9rZXJuZWwu
aD4NCkBAIC01MCwyMCArNDYsMTQgQEAKICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCiAj
aW5jbHVkZSA8bGludXgvdm1hbGxvYy5oPg0KICNpbmNsdWRlIDxsaW51eC9pbml0Lmg+DQot
I2lmZGVmIExJTlVYXzI0DQotI2luY2x1ZGUgPGxpbnV4L3RxdWV1ZS5oPg0KLSNlbHNlDQog
I2luY2x1ZGUgPGxpbnV4L3dvcmtxdWV1ZS5oPg0KLSNlbmRpZg0KIA0KICNpbmNsdWRlIDxh
c20vYnl0ZW9yZGVyLmg+DQogI2luY2x1ZGUgPGFzbS9pcnEuaD4NCi0jaW5jbHVkZSA8YXNt
L3NlZ21lbnQuaD4NCiAjaW5jbHVkZSA8YXNtL2lvLmg+DQogI2luY2x1ZGUgPGxpbnV4L3By
b2NfZnMuaD4NCiAjaW5jbHVkZSA8bGludXgvcG9sbC5oPg0KIA0KLQ0KICNpbmNsdWRlICJw
ZGNfaW50Zi5oIg0KICNpbmNsdWRlICJkZXZtc2NkLmgiDQogI2luY2x1ZGUgIm1zY2Ricmlk
Z2UuaCINCmRpZmYgLU51cnAgSVNQMTM2Ml9EZXZpY2UvZGV2aWNlL2Rldm1zY2QvbXNicmlk
Z2UuYyBJU1AxMzYyX0RldmljZS5maXhlZC9kZXZpY2UvZGV2bXNjZC9tc2JyaWRnZS5jCi0t
LSBJU1AxMzYyX0RldmljZS9kZXZpY2UvZGV2bXNjZC9tc2JyaWRnZS5jCTIwMDYtMDktMjUg
MTE6MzI6MjEuMDAwMDAwMDAwICswMjAwCisrKyBJU1AxMzYyX0RldmljZS5maXhlZC9kZXZp
Y2UvZGV2bXNjZC9tc2JyaWRnZS5jCTIwMDctMDctMTMgMjI6MDk6NDYuMDAwMDAwMDAwICsw
MjAwCkBAIC0zMCwxNyArMzAsMTIgQEAKICAqIDA5LzI1LzA2CQlNTUFTQkFECQkJCQlSZWxl
YXNlZCB3aXRoIEdQTA0KICAqIA0KICAqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKi8NCi0jaW5jbHVkZSA8
bGludXgvY29uZmlnLmg+DQotI2lmZGVmIExJTlVYXzI0DQotI2RlZmluZQlNT0RVTEUNCi0j
ZW5kaWYNCiAjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+DQogI2luY2x1ZGUgPGxpbnV4L3Bj
aS5oPg0KICNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4NCiAjaW5jbHVkZSA8bGludXgvZGVs
YXkuaD4NCiAjaW5jbHVkZSA8bGludXgvaW9wb3J0Lmg+DQogI2luY2x1ZGUgPGxpbnV4L3Nj
aGVkLmg+DQotI2luY2x1ZGUgPGxpbnV4L2RldmZzX2ZzX2tlcm5lbC5oPg0KICNpbmNsdWRl
IDxsaW51eC9zbGFiLmg+DQogI2luY2x1ZGUgPGxpbnV4L3NtcF9sb2NrLmg+DQogI2luY2x1
ZGUgPGxpbnV4L2Vycm5vLmg+DQpCaW5hcnkgZmlsZXMgSVNQMTM2Ml9EZXZpY2UvZGV2aWNl
L2Rpc2tlbXUvbXNkaXNrIGFuZCBJU1AxMzYyX0RldmljZS5maXhlZC9kZXZpY2UvZGlza2Vt
dS9tc2Rpc2sgZGlmZmVyCmRpZmYgLU51cnAgSVNQMTM2Ml9EZXZpY2UvZGV2aWNlL3BkYy9w
ZGNfYnVzLmMgSVNQMTM2Ml9EZXZpY2UuZml4ZWQvZGV2aWNlL3BkYy9wZGNfYnVzLmMKLS0t
IElTUDEzNjJfRGV2aWNlL2RldmljZS9wZGMvcGRjX2J1cy5jCTIwMDYtMDktMjUgMTE6MzI6
MjIuMDAwMDAwMDAwICswMjAwCisrKyBJU1AxMzYyX0RldmljZS5maXhlZC9kZXZpY2UvcGRj
L3BkY19idXMuYwkyMDA3LTA3LTEzIDIyOjExOjA0LjAwMDAwMDAwMCArMDIwMApAQCAtMzEs
MTAgKzMxLDYgQEAKICAqIDA5LzIwLzA2CQlNTUFTQkFECQkJCQlBZGRlZCBJbnRlcmZhY2Ut
YmFzZWQgZGVidWdnaW5nIG9wdGlvbnMNCiAgKiAwOS8yNS8wNgkJTU1BU0JBRAkJCQkJUmVs
ZWFzZWQgd2l0aCBHUEwNCiAgKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKiovDQotI2luY2x1ZGUgPGxpbnV4
L2NvbmZpZy5oPg0KLSNpZmRlZiBMSU5VWF8yNA0KLSNkZWZpbmUgTU9EVUxFDQotI2VuZGlm
DQogI2luY2x1ZGUgPGxpbnV4L3R5cGVzLmg+DQogI2luY2x1ZGUgPGxpbnV4L3N0cmluZy5o
Pg0KICNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4NCkBAIC00OSwxNSArNDUsMTAgQEAKICNp
bmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCiAjaW5jbHVkZSA8bGludXgvdm1hbGxvYy5oPg0K
ICNpbmNsdWRlIDxsaW51eC9pbml0Lmg+DQotI2lmZGVmIExJTlVYXzI0DQotI2luY2x1ZGUg
PGxpbnV4L3RxdWV1ZS5oPg0KLSNlbHNlDQogI2luY2x1ZGUgPGxpbnV4L3dvcmtxdWV1ZS5o
Pg0KLSNlbmRpZg0KIA0KICNpbmNsdWRlIDxhc20vYnl0ZW9yZGVyLmg+DQogI2luY2x1ZGUg
PGFzbS9pcnEuaD4NCi0jaW5jbHVkZSA8YXNtL3NlZ21lbnQuaD4NCiAjaW5jbHVkZSA8YXNt
L2lvLmg+DQogI2luY2x1ZGUgPGxpbnV4L3Byb2NfZnMuaD4NCiAjaW5jbHVkZSA8bGludXgv
cG9sbC5oPg0KZGlmZiAtTnVycCBJU1AxMzYyX0RldmljZS9kZXZpY2UvcGRjL3VzYl9wZGMu
YyBJU1AxMzYyX0RldmljZS5maXhlZC9kZXZpY2UvcGRjL3VzYl9wZGMuYwotLS0gSVNQMTM2
Ml9EZXZpY2UvZGV2aWNlL3BkYy91c2JfcGRjLmMJMjAwNi0wOS0yNSAxMTo0NDowMi4wMDAw
MDAwMDAgKzAyMDAKKysrIElTUDEzNjJfRGV2aWNlLmZpeGVkL2RldmljZS9wZGMvdXNiX3Bk
Yy5jCTIwMDctMDctMTMgMjI6MTA6MjkuMDAwMDAwMDAwICswMjAwCkBAIC01MiwxMCArNTIs
NiBAQAogICoNCiAgKi8NCiANCi0jaW5jbHVkZSA8bGludXgvY29uZmlnLmg+DQotI2lmZGVm
IExJTlVYXzI0DQotI2RlZmluZSBNT0RVTEUNCi0jZW5kaWYNCiAjaW5jbHVkZSA8bGludXgv
dHlwZXMuaD4NCiAjaW5jbHVkZSA8bGludXgvc3RyaW5nLmg+DQogI2luY2x1ZGUgPGxpbnV4
L2tlcm5lbC5oPg0KQEAgLTcwLDE0ICs2Niw5IEBACiAjaW5jbHVkZSA8bGludXgvbW9kdWxl
Lmg+DQogI2luY2x1ZGUgPGxpbnV4L3ZtYWxsb2MuaD4NCiAjaW5jbHVkZSA8bGludXgvaW5p
dC5oPg0KLSNpZmRlZiBMSU5VWF8yNA0KLSNpbmNsdWRlIDxsaW51eC90cXVldWUuaD4NCi0j
ZWxzZQ0KICNpbmNsdWRlIDxsaW51eC93b3JrcXVldWUuaD4NCi0jZW5kaWYNCiAjaW5jbHVk
ZSA8YXNtL2J5dGVvcmRlci5oPg0KICNpbmNsdWRlIDxhc20vaXJxLmg+DQotI2luY2x1ZGUg
PGFzbS9zZWdtZW50Lmg+DQogI2luY2x1ZGUgPGFzbS9pby5oPg0KICNpbmNsdWRlIDxsaW51
eC9wcm9jX2ZzLmg+DQogI2luY2x1ZGUgPGxpbnV4L3BvbGwuaD4NCmRpZmYgLU51cnAgSVNQ
MTM2Ml9EZXZpY2UveDg2cGNpL2hhbF9wY2kuYyBJU1AxMzYyX0RldmljZS5maXhlZC94ODZw
Y2kvaGFsX3BjaS5jCi0tLSBJU1AxMzYyX0RldmljZS94ODZwY2kvaGFsX3BjaS5jCTIwMDYt
MDktMjUgMTE6MzI6MjIuMDAwMDAwMDAwICswMjAwCisrKyBJU1AxMzYyX0RldmljZS5maXhl
ZC94ODZwY2kvaGFsX3BjaS5jCTIwMDctMDctMTMgMjI6MTE6MzIuMDAwMDAwMDAwICswMjAw
CkBAIC0zMCwxMCArMzAsNiBAQAogICogMDkvMjUvMDYJCU1NQVNCQUQJCQkJCVJlbGVhc2Vk
IHdpdGggR1BMDQogICoNCiAgKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKiovDQotI2luY2x1ZGUgPGxpbnV4
L2NvbmZpZy5oPg0KLSNpZmRlZiBMSU5VWF8yNA0KLSNkZWZpbmUJTU9EVUxFDQotI2VuZGlm
DQogI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KICNpbmNsdWRlIDxsaW51eC9rZXJuZWwu
aD4NCiAjaW5jbHVkZSA8bGludXgvZGVsYXkuaD4NCg==
--------------050100040508010100070309--
