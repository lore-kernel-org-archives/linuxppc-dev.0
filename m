Return-Path: <paguilar@junkerhq.net>
Received: from webmail.abac.com (webmail.abac.com [216.55.191.200])
	by ozlabs.org (Postfix) with ESMTP id 800AD2BF0E
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Jan 2005 04:18:05 +1100 (EST)
Received: from webmail.junkerhq.net (localhost [127.0.0.1])
	by webmail.abac.com (8.12.11/8.12.8) with ESMTP id j0AH4LRU092460
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 10 Jan 2005 09:04:21 -0800 (PST)
	(envelope-from paguilar@junkerhq.net)
Message-ID: <61163.81.72.55.167.1105376661.squirrel@81.72.55.167>
Date: Mon, 10 Jan 2005 18:04:21 +0100 (CET)
From: "Pedro Aguilar" <paguilar@junkerhq.net>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20050110180421_54297"
Subject: 8xx_imap patch for the mpc8xx ATM driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_20050110180421_54297
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi,

I have a mpc8xx based board that must provide ATM functionality using the
utopia interface. I used the mpc86x ESAR Linux ATM driver, but since the
driver was develop and has been tested only with kernels 2.4.4 and 2.4.17,
I had to modify my kernel (2.4.25 from DENX) in order to make it work.

It is a very simple change in the include/asm-ppc/8xx_imap.h file .
All the 2.4.x kernels that I've seen need this change.
It seems that the Fast Ethernet Controller needs this change too.

Here's the patch (and in the attchmnt too).
It can be applied from the kernel's top dir.

--- include/asm-ppc/8xx_immap.h 2004-06-25 21:14:33.000000000 +0200
+++ include/asm-ppc/8xx_immap.h 2005-01-10 18:27:57.264606288 +0100
@@ -272,7 +272,8 @@
        ushort  iop_pdpar;
        char    res3[2];
        ushort  iop_pddat;
-       char    res4[8];
+        uint    utmode;
+        char    res4[4];
 } iop8xx_t;

 /* Communication Processor Module Timers


Thanks.

Pedro
------=_20050110180421_54297
Content-Type: application/octet-stream; name="patch_8xx_imap_100105"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="patch_8xx_imap_100105"

LS0tIGluY2x1ZGUvYXNtLXBwYy84eHhfaW1tYXAuaAkyMDA0LTA2LTI1IDIxOjE0OjMzLjAwMDAw
MDAwMCArMDIwMAorKysgaW5jbHVkZS9hc20tcHBjLzh4eF9pbW1hcC5oCTIwMDUtMDEtMTAgMTg6
Mjc6NTcuMjY0NjA2Mjg4ICswMTAwCkBAIC0yNzIsNyArMjcyLDggQEAKIAl1c2hvcnQJaW9wX3Bk
cGFyOwogCWNoYXIJcmVzM1syXTsKIAl1c2hvcnQJaW9wX3BkZGF0OwotCWNoYXIJcmVzNFs4XTsK
KyAgICAgICAgdWludCAgICB1dG1vZGU7CisgICAgICAgIGNoYXIgICAgcmVzNFs0XTsKIH0gaW9w
OHh4X3Q7CiAKIC8qIENvbW11bmljYXRpb24gUHJvY2Vzc29yIE1vZHVsZSBUaW1lcnMK
------=_20050110180421_54297--
