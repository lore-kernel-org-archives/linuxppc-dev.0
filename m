Return-Path: <Steffen.Rumler@siemens.com>
Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
	by ozlabs.org (Postfix) with ESMTP id 2C18567A30
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Feb 2005 02:17:39 +1100 (EST)
Received: from mail3.siemens.de (mail3.siemens.de [139.25.208.14])
	by thoth.sbs.de (8.12.6/8.12.6) with ESMTP id j13FHaFF000191
	for <linuxppc-embedded@ozlabs.org>; Thu, 3 Feb 2005 16:17:37 +0100
Message-ID: <4202408A.7050200@siemens.com>
Date: Thu, 03 Feb 2005 16:17:30 +0100
From: Steffen Rumler <Steffen.Rumler@siemens.com>
MIME-Version: 1.0
To: linuxppc <linuxppc-embedded@ozlabs.org>
Content-Type: multipart/mixed; boundary="------------060409040505060608040308"
Subject: uart.c: avoid changing parameter RAM on-the-fly for the console
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
--------------060409040505060608040308
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

We are using the 2.4.20 PPC kernel running on the TQM859T module.

A lot of this kind of modules always hangs during the boot,
something like this:

      Linux version 2.4.20-rthal5 (ru@styx) (gcc version 2.95.3 20010111 (prerelease/franzo/20010111))
      #31 Thu Feb 3 15:07:0
      1 CET 2005
      On node 0 totalpages: 8128
      zone(0): 8128 pages.
      zone(1): 0 pages.
      zone(2): 0 pages.
      ...
      CPM UART driver version 0.03+
      ttyS00 at 0x0280 is a SMC
                           ^^^^^
                             THE SYSTEM HANGS HERE :-(

Deeper inspecting the uart.c, we recognized that the SMC (or SCC)
hardware related to the console will be (re-)configured multiple times in:

    (1) serial_console_setup():  early setup with small BD tables

    (2) rs_8xx_init(): bigger BD tables; without interrupts

    (3) startup(): with interrupts

The re-configuring (1->2, 2->3) will be performed on-the-fly,
without disabling the hardware.

According to Motorola this is _NOT_ allowed and dangerous.

For the SMC, it is suggested to run a 'STOP TX' CPCR command followed
by disabling RX/TX in SMCMR (TEN/REN), in order to stop the controller
correctly.

I suggest to do this inside rs_8xx_init() and startup() as shown
in the patch below.
The SCC is not addressed by the patch.

With this fix, the modules hanging before can boot now.


Steffen

--







--------------060409040505060608040308
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="patch"

ZGlmZiAtTmF1ciBvbGQvYXJjaC9wcGMvOHh4X2lvL3VhcnQuYyBuZXcvYXJjaC9wcGMvOHh4
X2lvL3VhcnQuYwotLS0gb2xkL2FyY2gvcHBjLzh4eF9pby91YXJ0LmMJVGh1IEZlYiAgMyAx
NTo1NDoyMSAyMDA1CisrKyBuZXcvYXJjaC9wcGMvOHh4X2lvL3VhcnQuYwlUaHUgRmViICAz
IDE1OjUyOjQ0IDIwMDUKQEAgLTExOSw2ICsxMTksMTAgQEAKIHN0YXRpYyBpbnQgIHVhcnRf
YnVmX3JlYWRfcHJvYyAgICAoY2hhciAqLCBjaGFyICoqLCBvZmZfdCwgaW50LCBpbnQgKiwg
dm9pZCAqKTsKICNlbmRpZgogCisjaWZkZWYgQ09ORklHX1NFUklBTF9DT05TT0xFCitzdGF0
aWMgdm9pZCBmdWxsX3NlcV9zbWNfc3RvcCAoaW50IHBvcnQpOworI2VuZGlmCisKIC8qCiAg
KiBTZXJpYWwgZHJpdmVyIGNvbmZpZ3VyYXRpb24gc2VjdGlvbi4gIEhlcmUgYXJlIHRoZSB2
YXJpb3VzIG9wdGlvbnM6CiAgKi8KQEAgLTgzMSwxMCArODM1LDE3IEBACiAJZWxzZSB7CiAJ
CXNtY3AgPSAmY3BtcC0+Y3Bfc21jW2lkeF07CiAKKyNpZmRlZiBDT05GSUdfU0VSSUFMX0NP
TlNPTEUKKyAgICAgICAgICAgICAgICAvKiAgc3RvcCBTTUMgaW4gdGhlIGNvcnJlY3Qgd2F5
LCBiZWZvcmUgcmUtY29uZmlndXJpbmcgaXQKKyAgICAgICAgICAgICAgICAgKi8KKwkJaWYg
KCgoc3RhdGUgLSByc190YWJsZSkgPT0gQ09ORklHX1NFUklBTF9DT05TT0xFX1BPUlQpKXsK
KyAgICAgICAgICAgICAgICAgICAgZnVsbF9zZXFfc21jX3N0b3AoUE9SVF9OVU0oaW5mby0+
c3RhdGUtPnNtY19zY2NfbnVtKSk7CisgICAgICAgICAgICAgICAgfQorI2VuZGlmCisKIAkJ
LyogRW5hYmxlIGludGVycnVwdHMgYW5kIEkvTy4KIAkJKi8KIAkJc21jcC0+c21jX3NtY20g
fD0gKFNNQ01fUlggfCBTTUNNX1RYKTsKLQkJc21jcC0+c21jX3NtY21yIHw9IChTTUNNUl9S
RU4gfCBTTUNNUl9URU4pOwogCiAJCS8qIFdlIGNhbiB0dW5lIHRoZSBidWZmZXIgbGVuZ3Ro
IGFuZCBpZGxlIGNoYXJhY3RlcnMKIAkJICogdG8gdGFrZSBhZHZhbnRhZ2Ugb2YgdGhlIGVu
dGlyZSBpbmNvbWluZyBidWZmZXIgc2l6ZS4KQEAgLTg0OCw2ICs4NTksOCBAQAogCQl1cC0+
c21jX21yYmxyID0gUlhfQlVGX1NJWkU7CiAJCXVwLT5zbWNfbWF4aWRsID0gUlhfQlVGX1NJ
WkU7CiAJCXVwLT5zbWNfYnJrY3IgPSAxOwkvKiBudW1iZXIgb2YgYnJlYWsgY2hhcnMgKi8K
KworCQlzbWNwLT5zbWNfc21jbXIgfD0gKFNNQ01SX1JFTiB8IFNNQ01SX1RFTik7CiAJfQog
CiAJaW5mby0+ZmxhZ3MgfD0gQVNZTkNfSU5JVElBTElaRUQ7CkBAIC0yNjk0LDYgKzI3MDcs
MzAgQEAKICAgCiB9IC8qIGVuZCB1YXJ0X3JlbW92ZVByb2NFbnRyaWVzKCkgKi8KIAorCisj
aWZkZWYgQ09ORklHX1NFUklBTF9DT05TT0xFCitzdGF0aWMgdm9pZCBmdWxsX3NlcV9zbWNf
c3RvcCAoaW50IHBvcnQpCit7CisgICAgdm9sYXRpbGUgY3BtOHh4X3QgKmNwPWNwbXA7Cisg
ICAgdm9sYXRpbGUgc21jX3QgKnNwOworICAgIHVzaG9ydCBjaGFuOworICAgIHVuc2lnbmVk
IGxvbmcgZmxhZ3M7CisKKyAgICBzcCAgID0gJmNwLT5jcF9zbWNbcG9ydF07CisgICAgY2hh
biA9IHNtY19jaGFuX21hcFtwb3J0XTsKKworICAgIGxvY2FsX2lycV9zYXZlKGZsYWdzKTsK
KworICAgIHdoaWxlIChjcC0+Y3BfY3BjciAmIENQTV9DUl9GTEcpOworICAgIGNwLT5jcF9j
cGNyID0gbWtfY3JfY21kKGNoYW4sIENQTV9DUl9TVE9QX1RYKSB8IENQTV9DUl9GTEc7Cisg
ICAgd2hpbGUgKGNwLT5jcF9jcGNyICYgQ1BNX0NSX0ZMRyk7CisgICAgc3AtPnNtY19zbWNt
ciAmPSB+KFNNQ01SX1JFTiB8IFNNQ01SX1RFTik7CisKKyAgICBsb2NhbF9pcnFfcmVzdG9y
ZShmbGFncyk7CisKK30gIC8qIGZ1bGxfc2VxX3NtY19zdG9wICovIAorI2VuZGlmICAvKiBD
T05GSUdfU0VSSUFMX0NPTlNPTEUgKi8KKwogLyoKICAqIFRoZSBzZXJpYWwgZHJpdmVyIGJv
b3QtdGltZSBpbml0aWFsaXphdGlvbiBjb2RlIQogICovCkBAIC0yOTA1LDYgKzI5NDIsMTUg
QEAKIAkJCX0KIAkJCWVsc2UgewogCQkJCXNwID0gJmNwLT5jcF9zbWNbaWR4XTsKKworI2lm
ZGVmIENPTkZJR19TRVJJQUxfQ09OU09MRQorICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAvKiAgc3RvcCBTTUMgaW4gdGhlIGNvcnJlY3Qgd2F5LCBiZWZvcmUgcmUtY29uZmln
dXJpbmcgaXQKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICovCisgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChpID09IENPTkZJR19TRVJJQUxfQ09OU09M
RV9QT1JUKXsKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGZ1bGxfc2Vx
X3NtY19zdG9wKGlkeCk7CisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIH0KKyNl
bmRpZgorCiAJCQkJdXAgPSAoc21jX3VhcnRfdCAqKSZjcC0+Y3BfZHBhcmFtW3N0YXRlLT5w
b3J0XTsKIAkJCQl1cC0+c21jX3JiYXNlID0gZHBfYWRkcjsKIAkJCX0K
--------------060409040505060608040308--
