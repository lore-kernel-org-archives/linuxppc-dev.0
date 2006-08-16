Return-Path: <dpelton@ciena.com>
Received: from hicks.ciena.com (unknown [63.118.34.22])
	by ozlabs.org (Postfix) with ESMTP id C55CC67B32
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Aug 2006 06:58:51 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C6C175.1777CB19"
Subject: RE: 8260  SMC1 and SMC2 serial port problems
Date: Wed, 16 Aug 2006 16:46:46 -0400
Message-ID: <3B9518857C91E345AA1806A6F53C0EB70190DE9E@onmxm01.ciena.com>
From: "Pelton, Dave" <dpelton@ciena.com>
To: <linuxppc-embedded@ozlabs.org>
Cc: Boris Shteinbock <boris@fabiotec.com>
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

------_=_NextPart_001_01C6C175.1777CB19
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Boris,

I recently upgraded my kernel from 2.6.15 to 2.6.17 on a 8247 based
custom board (8247 has a CPM2 and is similar to the 8260).  I use SMC2
as a serial port, and I had a couple of problems when I started using
2.6.17.  I think initially I was seeing the same behaviour as you
(serial port only worked when it was defined as the console).

The "compat mode" message you are seeing is part of the new CPM UART
0.02 driver (refer to =
http://patchwork.ozlabs.org/linuxppc/patch?id=3D5149
and related patches).  If there are no UART platform devices added in
your board specific code, then you will see this message.  To make the
compat mode work properly with the new driver I made a couple of changes
(see attached cpm2_uart_noplatform.diff).  The changes are to
drivers/serial/cpm_uart/cpm_uart_core.c:

1) Added a call to pinfo->set_lineif in cpm_uart_request_port
This code is required to set up the port pins and BRG for the UART.
This was in the old version of the driver and I added it back.  As far
as I can tell, this chunk of code is what makes the serial port work
properly when it is not the console (in compat mode).  To make this
properly compatible with the platform stuff, this call should not be
made if the device has platform data, but I'm not exactly sure how to
add that check in a clean way.

2) Added a call to cpm_uart_init_portdesc in cpm_uart_console_init
This was another snippet that was in the previous version of the driver.
I don't recall exactly what behaviour this fixed, but I think it made
things better.  Again this may not work properly if the device has
platform data.


I did try defining a platform device for the UART in my board specific
file (similar to what is done in arch/ppc/platforms/mpc8272ads_setup.c),
but I ran into a couple of problems here too.  The main problem is that
arch/ppc/syslib/pq2_devices.c needs a small change to the naming of
things for the SMCs (see attached cpm2_smc_resource_rename.diff).  That
made things work better, but not 100%.  I decided to go back to compat
mode, because with the fixes outlined above it was working fine for me.


- Hope this helps,
  David Pelton


-----Original Message-----
Sent: Monday, August 14, 2006 6:26 PM
To: linuxppc-embedded@ozlabs.org
Subject: 8260 SMC1 and SMC2 serial port problems

Hi guys.

I am working on the Linux port on a custom 8260-based board.
During the port I've encountered a few problems with serial ports.

1. On the latest kernel 2.6.17 the cpm2 serial driver fails during the
bus scan and fails back to so called compat mode.
2. For whatever strange reason, the driver is unable to initialize
serial port, if the console on SMC is not selected.
3. I am unable to work with both SMC1 and SMC2 together. During driver
init, only one port actually gets an IRQ.
In another words, if I enable both SMC1 and SMC2 in the  kernel config.=20
and put console on ttyCPM0, then SMC1 gets IRQ, but SMC2 doesn't. dmesg
actually prints IRQs for both ports, but looking into /proc/irq reveals,
that only one interrupt is assigned only for port that is used as a
console.

2) and 3) relate for both 2.6.17 and 2.6.16 kernel trees

Could someone, please, advise me, on possible solutions for those
problems ?

Thanks in advance,
Boris
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded

------_=_NextPart_001_01C6C175.1777CB19
Content-Type: application/octet-stream;
	name="cpm2_smc_resource_rename.diff"
Content-Transfer-Encoding: base64
Content-Description: cpm2_smc_resource_rename.diff
Content-Disposition: attachment;
	filename="cpm2_smc_resource_rename.diff"

SW5kZXg6IGxpbnV4L2FyY2gvcHBjL3N5c2xpYi9wcTJfZGV2aWNlcy5jCj09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0t
IGxpbnV4L2FyY2gvcHBjL3N5c2xpYi9wcTJfZGV2aWNlcy5jCShyZXZpc2lvbiAzMzc0MykKKysr
IGxpbnV4L2FyY2gvcHBjL3N5c2xpYi9wcTJfZGV2aWNlcy5jCSh3b3JraW5nIGNvcHkpCkBAIC0y
OTcsMTMgKzI5NywxMyBAQAogCQkubnVtX3Jlc291cmNlcwkgPSAzLAogCQkucmVzb3VyY2UgPSAo
c3RydWN0IHJlc291cmNlW10pIHsKIAkJCXsKLQkJCQkubmFtZQk9ICJzbWNfbWVtIiwKKwkJCQku
bmFtZQk9ICJyZWdzIiwKIAkJCQkuc3RhcnQJPSAweDExQTgwLAogCQkJCS5lbmQJPSAweDExQThG
LAogCQkJCS5mbGFncwk9IElPUkVTT1VSQ0VfTUVNLAogCQkJfSwKIAkJCXsKLQkJCQkubmFtZQk9
ICJzbWNfcHJhbSIsCisJCQkJLm5hbWUJPSAicHJhbSIsCiAJCQkJLnN0YXJ0CT0gMHg4N2ZjLAog
CQkJCS5lbmQJPSAweDg3ZmQsCiAJCQkJLmZsYWdzCT0gSU9SRVNPVVJDRV9NRU0sCkBAIC0zMjEs
MTMgKzMyMSwxMyBAQAogCQkubnVtX3Jlc291cmNlcwkgPSAzLAogCQkucmVzb3VyY2UgPSAoc3Ry
dWN0IHJlc291cmNlW10pIHsKIAkJCXsKLQkJCQkubmFtZQk9ICJzbWNfbWVtIiwKKwkJCQkubmFt
ZQk9ICJyZWdzIiwKIAkJCQkuc3RhcnQJPSAweDExQTkwLAogCQkJCS5lbmQJPSAweDExQTlGLAog
CQkJCS5mbGFncwk9IElPUkVTT1VSQ0VfTUVNLAogCQkJfSwKIAkJCXsKLQkJCQkubmFtZQk9ICJz
bWNfcHJhbSIsCisJCQkJLm5hbWUJPSAicHJhbSIsCiAJCQkJLnN0YXJ0CT0gMHg4OGZjLAogCQkJ
CS5lbmQJPSAweDg4ZmQsCiAJCQkJLmZsYWdzCT0gSU9SRVNPVVJDRV9NRU0sCg==

------_=_NextPart_001_01C6C175.1777CB19
Content-Type: application/octet-stream;
	name="cpm2_uart_noplatform.diff"
Content-Transfer-Encoding: base64
Content-Description: cpm2_uart_noplatform.diff
Content-Disposition: attachment;
	filename="cpm2_uart_noplatform.diff"

SW5kZXg6IGxpbnV4L2RyaXZlcnMvc2VyaWFsL2NwbV91YXJ0L2NwbV91YXJ0X2NvcmUuYwo9PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09Ci0tLSBsaW51eC9kcml2ZXJzL3NlcmlhbC9jcG1fdWFydC9jcG1fdWFydF9jb3JlLmMJ
KHJldmlzaW9uIDMzNTU5KQorKysgbGludXgvZHJpdmVycy9zZXJpYWwvY3BtX3VhcnQvY3BtX3Vh
cnRfY29yZS5jCSh3b3JraW5nIGNvcHkpCkBAIC04NjgsNiArODY5LDE0IEBACiAJaWYgKHBpbmZv
LT5mbGFncyAmIEZMQUdfQ09OU09MRSkKIAkJcmV0dXJuIDA7CiAKKwkvKgorCSAqIFNldHVwIGFu
eSBwb3J0IElPLCBjb25uZWN0IGFueSBiYXVkIHJhdGUgZ2VuZXJhdG9ycywKKwkgKiBldGMuCSBU
aGlzIGlzIGV4cGVjdGVkIHRvIGJlIGhhbmRsZWQgYnkgYm9hcmQKKwkgKiBkZXBlbmRhbnQgY29k
ZQorCSAqLworCWlmIChwaW5mby0+c2V0X2xpbmVpZikJCSAKKwkJcGluZm8tPnNldF9saW5laWYo
cGluZm8pOwkgCisgCiAJaWYgKElTX1NNQyhwaW5mbykpIHsKIAkJcGluZm8tPnNtY3AtPnNtY19z
bWNtICY9IH4oU01DTV9SWCB8IFNNQ01fVFgpOwogCQlwaW5mby0+c21jcC0+c21jX3NtY21yICY9
IH4oU01DTVJfUkVOIHwgU01DTVJfVEVOKTsKQEAgLTEyMzgsNyArMTI0MywxMCBAQAogCiBpbnQg
X19pbml0IGNwbV91YXJ0X2NvbnNvbGVfaW5pdCh2b2lkKQogewotCXJlZ2lzdGVyX2NvbnNvbGUo
JmNwbV9zY2NfdWFydF9jb25zb2xlKTsKKwlpbnQgcmV0ID0gY3BtX3VhcnRfaW5pdF9wb3J0ZGVz
YygpOyAJIAorCisJaWYgKCFyZXQpCisJCXJlZ2lzdGVyX2NvbnNvbGUoJmNwbV9zY2NfdWFydF9j
b25zb2xlKTsKIAlyZXR1cm4gMDsKIH0KIAo=

------_=_NextPart_001_01C6C175.1777CB19--
