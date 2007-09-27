Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 7DA1FDDE2B
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Sep 2007 05:12:36 +1000 (EST)
Content-Type: multipart/mixed; boundary="========GMX201981190920353771509"
Date: Thu, 27 Sep 2007 21:12:33 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Message-ID: <20070927191233.201980@gmx.net>
MIME-Version: 1.0
Subject: 2.6.23-rc8 dies somewhere during boot!?
To: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--========GMX201981190920353771509
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi,

I'm working on a 2.6.23 kernel for the AmigaOne. I implemented the device
tree and the platform setup code, which all compiles fine. I built a
cuImage target, loaded it on my target machine with TFTP and booted it.
The kernel passes the platform setup code and then dies somewhere in the
driver init code (AFAICT), but before the keyboard driver is initialized
(thus magic sysrq key doesn't work). Can somebody help me to track down
this problem?

I tried to recover the kernel log buffer and attached it to this e-mail.

regards,

Gerhard
-- 
Psssst! Schon vom neuen GMX MultiMessenger gehört?
Der kanns mit allen: http://www.gmx.net/de/go/multimessenger

--========GMX201981190920353771509
Content-Type: application/octet-stream; name="amigaone.dts"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="amigaone.dts"

LyoKICogQW1pZ2FPbmUgRGV2aWNlIFRyZWUgU291cmNlCiAqCiAqIENvcHlyaWdodCAyMDA3IEdl
cmhhcmQgUGlyY2hlciAoZ2VyaGFyZF9waXJjaGVyQGdteC5uZXQpCiAqCiAqIFRoaXMgcHJvZ3Jh
bSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSAgaXQgYW5kL29yIG1vZGlm
eSBpdAogKiB1bmRlciAgdGhlIHRlcm1zIG9mICB0aGUgR05VIEdlbmVyYWwgIFB1YmxpYyBMaWNl
bnNlIGFzIHB1Ymxpc2hlZCBieSB0aGUKICogRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uOyAgZWl0
aGVyIHZlcnNpb24gMiBvZiB0aGUgIExpY2Vuc2UsIG9yIChhdCB5b3VyCiAqIG9wdGlvbikgYW55
IGxhdGVyIHZlcnNpb24uCiAqLwoKLyB7Cgltb2RlbCA9ICJBbWlnYU9uZSI7Cgljb21wYXRpYmxl
ID0gImV5ZXRlY2gsYW1pZ2FvbmUiLCJtYWktbG9naWMsdGVyb24iOwoJY29oZXJlbmN5LW9mZjsK
CSNhZGRyZXNzLWNlbGxzID0gPDE+OwoJI3NpemUtY2VsbHMgPSA8MT47CgoJY3B1cyB7CgkJI2Nw
dXMgPSA8MT47CgkJI2FkZHJlc3MtY2VsbHMgPSA8MT47CgkJI3NpemUtY2VsbHMgPSA8MD47CgoJ
CWNwdUAwIHsKCQkJZGV2aWNlX3R5cGUgPSAiY3B1IjsKCQkJcmVnID0gPDA+OwoJCQlkLWNhY2hl
LWxpbmUtc2l6ZSA9IDwyMD47CS8vIDMyIGJ5dGVzCgkJCWktY2FjaGUtbGluZS1zaXplID0gPDIw
PjsJLy8gMzIgYnl0ZXMKCQkJZC1jYWNoZS1zaXplID0gPDgwMDA+OwkJLy8gTDEsIDMySwoJCQlp
LWNhY2hlLXNpemUgPSA8ODAwMD47CQkvLyBMMSwgMzJLCgkJCXRpbWViYXNlLWZyZXF1ZW5jeSA9
IDwwPjsJLy8gMzMuMyBNSHosIGZyb20gVS1ib290CgkJCWNsb2NrLWZyZXF1ZW5jeSA9IDwwPjsJ
CS8vIEZyb20gVS1ib290CgkJCWJ1cy1mcmVxdWVuY3kgPSA8MD47CQkvLyBGcm9tIFUtYm9vdAoJ
CQkzMi1iaXQ7CgkJfTsKCX07CgoJbWVtb3J5IHsKCQlkZXZpY2VfdHlwZSA9ICJtZW1vcnkiOwoJ
CXJlZyA9IDwwIDA+OwkJCQkvLyBGcm9tIFUtYm9vdAoJfTsKCiAgCXBjaUA4MDAwMDAwMCB7CgkJ
ZGV2aWNlX3R5cGUgPSAicGNpIjsKCQljb21wYXRpYmxlID0gIm1haS1sb2dpYyxhcnRpY2lhLXMi
OwoJCWJ1cy1mcmVxdWVuY3kgPSA8MDFmY2EwNTU+OwkJLy8gMzMuM01IegoJCWJ1cy1yYW5nZSA9
IDwwIGZmPjsKCQlyYW5nZXMgPSA8MDEwMDAwMDAgMCAwMDAwMDAwMCBmZTAwMDAwMCAwIDAwYzAw
MDAwCS8vIFBDSSBJL08KCQkJICAwMjAwMDAwMCAwIDgwMDAwMDAwIDgwMDAwMDAwIDAgN2QwMDAw
MDAJLy8gUENJIG1lbW9yeQoJCQkgIDAyMDAwMDAwIDAgZmQwMDAwMDAgZmQwMDAwMDAgMCAwMTAw
MDAwMD47CS8vIFBDSSBhbGlhcyBtZW1vcnkKCQlpbnRlcnJ1cHQtcGFyZW50ID0gPCZpODI1OT47
CgkJODI1OS1pbnRlcnJ1cHQtYWNrbm93bGVkZ2UgPSA8ZmVmMDAwMDA+OwoJCSNpbnRlcnJ1cHQt
Y2VsbHMgPSA8MT47CgkJI2FkZHJlc3MtY2VsbHMgPSA8Mz47CgkJI3NpemUtY2VsbHMgPSA8Mj47
CgoJCWhvc3RAMCB7CgkJCWNvbXBhdGlibGUgPSAicGNpY2xhc3MsMDYwMCI7CgkJCXZlbmRvci1p
ZCA9IDwwMDAwMTBjYz47CgkJCWRldmljZS1pZCA9IDwwMDAwMDY2MD47CgkJCXJldmlzaW9uLWlk
ID0gPDAwMDAwMDAxPjsKCQkJY2xhc3MtY29kZSA9IDwwMDA2MDAwMD47CgkJCXN1YnN5c3RlbS1p
ZCA9IDwwPjsKCQkJc3Vic3lzdGVtLXZlbmRvci1pZCA9IDwwPjsKCQkJZGV2c2VsLXNwZWVkID0g
PDAwMDAwMDAxPjsKCQkJNjZtaHotY2FwYWJsZTsKCQkJbWluLWdyYW50ID0gPDA+OwoJCQltYXgt
bGF0ZW5jeSA9IDwwPjsKCQkJLy8gQUdQIGFwZXJ0dXJlIGlzIHVuc2V0LgoJCQlyZWcgPSA8NDIw
MDAwMTAgMCAwMDAwMDAwMCAwIDAwNDAwMDAwPjsKCQkJYXNzaWduZWQtYWRkcmVzc2VzID0gPDQy
MDAwMDEwIDAgMDAwMDAwMDAgMCAwMDQwMDAwMD47CgkJfTsKCgkJaXNhQDcgewoJCQlkZXZpY2Vf
dHlwZSA9ICJpc2EiOwoJCQljb21wYXRpYmxlID0gInBjaWNsYXNzLDA2MDEiOwoJCQl2ZW5kb3It
aWQgPSA8MDAwMDExMDY+OwoJCQlkZXZpY2UtaWQgPSA8MDAwMDA2ODY+OwoJCQlyZXZpc2lvbi1p
ZCA9IDwwMDAwMDAxMD47CgkJCWNsYXNzLWNvZGUgPSA8MDAwNjAxMDA+OwoJCQlzdWJzeXN0ZW0t
aWQgPSA8MD47CgkJCXN1YnN5c3RlbS12ZW5kb3ItaWQgPSA8MD47CgkJCWRldnNlbC1zcGVlZCA9
IDwwMDAwMDAwMT47CgkJCW1pbi1ncmFudCA9IDwwPjsKCQkJbWF4LWxhdGVuY3kgPSA8MD47CgkJ
CS8qIEZpcnN0IDY0ayBmb3IgSS9PIGF0IDB4MCBvbiBQQ0kgbWFwcGVkIHRvIDB4MCBvbiBJU0Eu
ICovCgkJCXJhbmdlcyA9IDwwMDAwMDAwMSAwIDAxMDAwMDAwIDAgMDAwMDAwMDAgMDAwMTAwMDA+
OwoJCQlpbnRlcnJ1cHQtcGFyZW50ID0gPCZpODI1OT47CgkJCSNpbnRlcnJ1cHQtY2VsbHMgPSA8
Mj47CgkJCSNhZGRyZXNzLWNlbGxzID0gPDI+OwoJCQkjc2l6ZS1jZWxscyA9IDwxPjsKCgkJCWRt
YS1jb250cm9sbGVyQDAgewoJCQkJZGV2aWNlX3R5cGUgPSAiZG1hLWNvbnRyb2xsZXIiOwoJCQkJ
Y29tcGF0aWJsZSA9ICJwbnBQTlAsMjAwIjsKCQkJCXJlZyA9IDwwMDAwMDAwMSAwMDAwMDAwMCAw
MDAwMDAyMAoJCQkJICAgICAgIDAwMDAwMDAxIDAwMDAwMDgwIDAwMDAwMDEwCgkJCQkgICAgICAg
MDAwMDAwMDEgMDAwMDAwYzAgMDAwMDAwMjA+OwoJCQkJLyogQ2hhbm5lbCA0IHJlc2VydmVyZCwg
Y2FzY2FkZSBtb2RlLCAyeDMyayB0cmFuc2Zlci9jb3VudGVyCgkJCQkgKiB3aWR0aHMgYW5kIGJ1
cyBtYXN0ZXIgY2FwYWJpbGl0eS4gSXMgdGhpcyByZWFsbHkgbmVjZXNzYXJ5PwoJCQkJICovCi8q
CQkJCWRtYSA9IDw0IDQgMjAgMjAgMT47ICovCgkJCX07CgoJCSAgCWk4MjU5OiBpbnRlcnJ1cHQt
Y29udHJvbGxlckAyMCB7CgkJCQlkZXZpY2VfdHlwZSA9ICJpbnRlcnJ1cHQtY29udHJvbGxlciI7
CgkJCQljb21wYXRpYmxlID0gInBucFBOUCwwMDAiOwoJCQkJaW50ZXJydXB0LWNvbnRyb2xsZXI7
CgkJCQlyZWcgPSA8MDAwMDAwMDEgMDAwMDAwMjAgMDAwMDAwMDIKCQkJCSAgICAgICAwMDAwMDAw
MSAwMDAwMDBhMCAwMDAwMDAwMgoJCQkJICAgICAgIDAwMDAwMDAxIDAwMDAwNGQwIDAwMDAwMDAy
PjsKCQkJCXJlc2VydmVkLWludGVycnVwdHMgPSA8Mj47CgkJCX07CgoJCQl0aW1lckA0MCB7Ci8q
CQkJCWRldmljZV90eXBlID0gInRpbWVyIjsgKi8JCS8vIE5vIGRldmljZSB0eXBlIGJpbmRpbmcg
Zm9yIG5vdy4KCQkJCWNvbXBhdGliZSA9ICJwbnBQTlAsMTAwIjsJCS8vIEFsc28gYWRkIHBjc3Br
ciB0byBwbGF0Zm9ybSBkZXZpY2VzLgoJCQkJcmVnID0gPDAwMDAwMDAxIDAwMDAwMDQwIDAwMDAw
MDIwPjsKCQkJfTsKCgkJCTgwNDJANjAgewoJCQkJZGV2aWNlX3R5cGUgPSAiODA0MiI7CgkJCQly
ZWcgPSA8MDAwMDAwMDEgMDAwMDAwNjAgMDAwMDAwMDEKCQkJCSAgICAgICAwMDAwMDAwMSAwMDAw
MDA2NCAwMDAwMDAwMT47CgkJCQlpbnRlcnJ1cHRzID0gPDEgMyBjIDM+OwkJCS8vIElSUTEsIElS
UTEyIChyaXNpbmcgZWRnZSkKCQkJCSNhZGRyZXNzLWNlbGxzID0gPDE+OwoJCQkJI3NpemUtY2Vs
bHMgPSA8MD47CgoJCQkJa2V5Ym9hcmRAMCB7CgkJCQkJZGV2aWNlX3R5cGUgPSAia2V5Ym9hcmQi
OwoJCQkJCWNvbXBhdGlibGUgPSAicG5wUE5QLDMwMyI7CgkJCQkJcmVnID0gPDA+OwoJCQkJfTsK
CgkJCQltb3VzZUAxIHsKCQkJCQlkZXZpY2VfdHlwZSA9ICJtb3VzZSI7CgkJCQkJY29tcGF0aWJs
ZSA9ICJwbnBQTlAsZjAzIjsKCQkJCQlyZWcgPSA8MT47CgkJCQl9OwoJCQl9OwoKCQkJcnRjQDcw
IHsKCQkJCWRldmljZV90eXBlID0gInJ0YyI7CgkJCQljb21wYXRpYmxlID0gInBucFBOUCxiMDAi
OwoJCQkJcmVnID0gPDAwMDAwMDAxIDAwMDAwMDcwIDAwMDAwMDAyPjsKCQkJCWludGVycnVwdHMg
PSA8OCAzPjsKCQkJfTsKCgkJCXNlcmlhbEAyZjggewoJCQkJZGV2aWNlX3R5cGUgPSAic2VyaWFs
IjsKCQkJCWNvbXBhdGlibGUgPSAicG5wUE5QLDUwMSIsInBucFBOUCw1MDAiOwkvLyAibnMxNjU1
MCI7IGFkZCBwcm9wZXJ0eSBjaGVjayB0byBPRiBzZXJpYWwgY29kZS4KCQkJCXJlZyA9IDwwMDAw
MDAwMSAwMDAwMDJmOCAwMDAwMDAwOD47CgkJCQlpbnRlcnJ1cHRzID0gPDMgMz47CQkJLy8gSVJR
MyAocmlzaW5nIGVkZ2UpCgkJCQljbG9jay1mcmVxdWVuY3kgPSA8MD47CQkJLy8gTm90IG5lY2Vz
c2FyeT8KCQkJfTsKCgkJCXNlcmlhbEAzZjggewoJCQkJZGV2aWNlX3R5cGUgPSAic2VyaWFsIjsK
CQkJCWNvbXBhdGlibGUgPSAicG5wUE5QLDUwMSIsInBucFBOUCw1MDAiOwkvLyAibnMxNjU1MCI7
IGFkZCBwcm9wZXJ0eSBjaGVjayB0byBPRiBzZXJpYWwgY29kZS4KCQkJCXJlZyA9IDwwMDAwMDAw
MSAwMDAwMDNmOCAwMDAwMDAwOD47CgkJCQlpbnRlcnJ1cHRzID0gPDQgMz47CQkJLy8gSVJRNCAo
cmlzaW5nIGVkZ2UpCgkJCQljbG9jay1mcmVxdWVuY3kgPSA8MD47CQkJLy8gTm90IG5lY2Vzc2Fy
eT8KCQkJfTsKCgkJCXBhcmFsbGVsQDM3OCB7CgkJCQlkZXZpY2VfdHlwZSA9ICJwYXJhbGxlbCI7
CgkJCQljb21wYXRpYmxlID0gInBucFBOUCw0MDAiOyAJCS8vICJwbnBQTlAsNDAxIgkvLyBObyBF
Q1Agc3VwcG9ydCBmb3Igbm93LgoJCQkJcmVnID0gPDAwMDAwMDAxIDAwMDAwMzc4IDAwMDAwMDAz
CgkJCQkgICAgICAgMDAwMDAwMDEgMDAwMDA3NzggMDAwMDAwMDM+OwovKgkJCQlpbnRlcnJ1cHRz
ID0gPDc+OyAqLwovKgkJCQlkbWEgPSA8MyAwIDAgMD47ICovCQkJLy8gUGFyYWxsZWwgcG9ydCBE
TUEgbW9kZT8KCQkJfTsKCgkJCWZkY0AzZjAgewoJCQkJZGV2aWNlX3R5cGUgPSAiZmRjIjsKCQkJ
CWNvbXBhdGlibGUgPSAicG5wUE5QLDcwMCI7CgkJCQlyZWcgPSA8MDAwMDAwMDEgMDAwMDAzZjAg
MDAwMDAwMDg+OwoJCQkJaW50ZXJydXB0cyA9IDw2IDM+OwkJCS8vIElSUTYgKHJpc2luZyBlZGdl
KQovKgkJCQlkbWEgPSA8ID47ICovCQkJCS8vIEZsb3BweSBETUEgbW9kZT8KCQkJCSNhZGRyZXNz
LWNlbGxzID0gPDE+OwoJCQkJI3NpemUtY2VsbHMgPSA8MD47CgoJCQkJZGlza0AwIHsKCQkJCQlk
ZXZpY2VfdHlwZSA9ICJibG9jayI7CgkJCQkJcmVnID0gPDA+OwoJCQkJfTsKCQkJfTsKCQl9OwoK
CQlpZGVANywxIHsKCQkJY29tcGF0aWJsZSA9ICJwY2ljbGFzcywwMTAxOGYiOwoJCQl2ZW5kb3It
aWQgPSA8MDAwMDExMDY+OwoJCQlkZXZpY2UtaWQgPSA8MDAwMDA1NzE+OwoJCQlyZXZpc2lvbi1p
ZCA9IDwwMDAwMDAwNj47CgkJCS8vIENsYXNzIGNvZGUgd2l0aCBQQ0kgSURFIHByb2dyYW1taW5n
IGludGVyZmFjZSBpbmRpY2F0b3IuCgkJCWNsYXNzLWNvZGUgPSA8MDAwMTAxOGY+OwoJCQlzdWJz
eXN0ZW0taWQgPSA8MD47CgkJCXN1YnN5c3RlbS12ZW5kb3ItaWQgPSA8MD47CgkJCWRldnNlbC1z
cGVlZCA9IDwwMDAwMDAwMT47CgkJCW1pbi1ncmFudCA9IDwwPjsKCQkJbWF4LWxhdGVuY3kgPSA8
MD47CgkJCWZhc3QtYmFjay10by1iYWNrOwoJCQkvLyBBc3N1bWUgYmFzZSBhZGRyZXNzZXMgYXJl
IHJlbG9jYXRlYWJsZSwgZXZlbiBpZgoJCQkvLyBjb250cm9sbGVyIG9wZXJhdGVzIGluIGNvbXBh
dGliaWxpdHkgbW9kZS4KCQkJcmVnID0gPDIxMDAzOTEwIDAgMDAwMDAwMDAgMCAwMDAwMDAwMAoJ
CQkgICAgICAgMjEwMDM5MTQgMCAwMDAwMDAwMCAwIDAwMDAwMDAwCgkJCSAgICAgICAyMTAwMzkx
OCAwIDAwMDAwMDAwIDAgMDAwMDAwMDAKCQkJICAgICAgIDIxMDAzOTFjIDAgMDAwMDAwMDAgMCAw
MDAwMDAwMAoJCQkgICAgICAgMjEwMDM5MjAgMCAwMDAwMDAwMCAwIDAwMDAwMDAwPjsKCQkJYXNz
aWduZWQtYWRkcmVzc2VzID0gPDAxMDAzOTEwIDAgMDAwMDAxZjAgMCAwMDAwMDAwOAoJCQkJCSAg
ICAgIDAxMDAzOTE0IDAgMDAwMDAzZjQgMCAwMDAwMDAwNAoJCQkJCSAgICAgIDAxMDAzOTE4IDAg
MDAwMDAxNzAgMCAwMDAwMDAwOAoJCQkJCSAgICAgIDAxMDAzOTFjIDAgMDAwMDAzNzQgMCAwMDAw
MDAwNAoJCQkJCSAgICAgIDAxMDAzOTIwIDAgMDAwMGNjMDAgMCAwMDAwMDAxMD47CgkJCWludGVy
cnVwdC1wYXJlbnQgPSA8Jmk4MjU5PjsKCQkJaW50ZXJydXB0cyA9IDxlIDMgZiAzPjsKCQkJI2lu
dGVycnVwdC1jZWxscyA9IDwyPjsKCQl9OwoJfTsKCgljaG9zZW4gewoJCWxpbnV4LHN0ZG91dC1w
YXRoID0gIi9wY2lAODAwMDAwMDAvaXNhQDcvc2VyaWFsQDJmOCI7Cgl9Owp9Owo=
--========GMX201981190920353771509
Content-Type: text/x-csrc; charset="iso-8859-15"; name="setup.c"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="setup.c"

/*
 * AmigaOne platform setup
 *
 * Copyright 2007 Gerhard Pircher (gerhard_pircher@gmx.net)
 *
 *   Based on original amigaone_setup.c source code
 * Copyright 2003 by Hans-JÃ¶rg and Thomas Frieden
 *   and chrp/setup.c
 * Copyright 1995 by Linus Torvalds
 *
 * This program is free software; you can redistribute  it and/or modify it
 * under  the terms of  the GNU General  Public License as published by the
 * Free Software Foundation;  either version 2 of the  License, or (at your
 * option) any later version.
 */

#include <linux/errno.h>
#include <linux/sched.h>
#include <linux/kernel.h>
#include <linux/mm.h>
#include <linux/stddef.h>
#include <linux/unistd.h>
#include <linux/ptrace.h>
#include <linux/slab.h>
#include <linux/user.h>
#include <linux/tty.h>
#include <linux/major.h>
#include <linux/interrupt.h>
#include <linux/reboot.h>
#include <linux/init.h>
#include <linux/ide.h>
#include <linux/pci.h>
#include <linux/utsrelease.h>
#include <linux/module.h>
#include <linux/delay.h>
#include <linux/console.h>
#include <linux/seq_file.h>
#include <linux/root_dev.h>
#include <linux/initrd.h>
#include <linux/module.h>
#include <linux/timer.h>

#include <asm/cputable.h>
#include <asm/io.h>
#include <asm/pgtable.h>
#include <asm/pci-bridge.h>
#include <asm/dma.h>
#include <asm/machdep.h>
#include <asm/irq.h>
#include <asm/sections.h>
#include <asm/time.h>
#include <asm/i8259.h>
#include <asm/system.h>
#include <asm/udbg.h>
#include <asm/vga.h>

extern void amigaone_find_bridges(void);

void amigaone_set_l2cr(void)
{
	/* This disables the L2 hardware prefetch. It is normally disabled and
	 * enabled again within _set_L2CR(), but the L2 prefetch enable is not
	 * compiled in for the AmigaOne.
	 */
	_set_L2CR(_get_L2CR());

	if(((_get_L2CR() & L2CR_L2E) == 0) && (strstr(cmd_line, "l2cr=") == NULL))
	{
		printk("AmigaOne l2cr : L2 cache was not active, activating.\n");
		_set_L2CR(0);
		_set_L2CR(L2CR_L2E | L2CR_L2PE);
	}
}

int amigaone_show_cpuinfo(struct seq_file *m)
{
	struct device_node *root;
	const char *model = "";

	root = of_find_node_by_path("/");
	if (root)
		model = of_get_property(root, "model", NULL);
	seq_printf(m, "machine\t\t: %s\n", model);

	of_node_put(root);

	seq_printf(m, "msscr0\t\t: 0x%08lX\n", mfspr(SPRN_MSSCR0));

	return 0;
}

void __init amigaone_setup_arch(void)
{
	/* init to some ~sane value until calibrate_delay() runs */
	loops_per_jiffy = 50000000/HZ;

#ifdef CONFIG_BLK_DEV_INITRD
	/* this is fine for chrp */
	initrd_below_start_ok = 1;

	if (initrd_start)
		ROOT_DEV = Root_RAM0;
	else
#endif
		ROOT_DEV = Root_SDA2; /* sda2 (sda1 is for the kernel or OS4) */

	/* Enable the L2 cache. */
	amigaone_set_l2cr();

	/* Lookup PCI host bridges */
	/* setup PCI host bridge */

#ifdef CONFIG_PCI_HOST_DRIVER
	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
		articias_setup_pci(np);
#else
	amigaone_find_bridges();
#endif

	/* Uncomment, when U-boot was updated. */
//	pci_create_OF_bus_map();

	/* vgacon.c needs to know where VGA memory is mapped. */
//	vgacon_remap_base = (unsigned long) ioremap(0xfd000000, 0x01000000);
//	conswitchp = &vga_con;

	if (ppc_md.progress)
		ppc_md.progress("Linux/PPC "UTS_RELEASE"\n", 0x0);
}

void __init amigaone_init_IRQ(void)
{
	struct device_node *np, *pic = NULL;
	unsigned long amigaone_int_ack = 0;

	/* Search for ISA interrupt controller. */
	for_each_node_by_type(np, "interrupt-controller")
		if (of_device_is_compatible(np, "pnpPNP,000")) {
			pic = np;
			break;
		}

	BUG_ON(pic == NULL);

	/* Look for interrupt acknowledge address in the PCI root node. */
	for_each_node_by_name(np, "pci") {
		const unsigned int *addrp = of_get_property(np,
			"8259-interrupt-acknowledge", NULL);

		if (addrp == NULL)
			continue;
		amigaone_int_ack = addrp[of_n_addr_cells(np)-1];
		break;
	}
	of_node_put(np);

	if (np == NULL)
		printk(KERN_WARNING "Cannot find PCI interrupt acknowledge"
		       " address, polling\n");

	i8259_init(pic, amigaone_int_ack);
	ppc_md.get_irq = i8259_irq;
	irq_set_default_host(i8259_get_host());
}

void __init amigaone_init(void)
{
#ifdef CONFIG_NVRAM
//	amigaone_nvram_init();
#endif

	request_region(0x20,0x20,"pic1");
	request_region(0xa0,0x20,"pic2");
	request_region(0x00,0x20,"dma1");
	request_region(0x40,0x20,"timer");
	request_region(0x80,0x10,"dma page reg");
	request_region(0xc0,0x20,"dma2");
}

/* Copied from U-Boot. */
static inline void soft_restart(unsigned long addr)
{
	/* SRR0 has system reset vector, SRR1 has default MSR value.
	 * rfi restores MSR from SRR1 and sets the PC to the SRR0 value.
	 */
	__asm__ __volatile__ ("mtspr	26, %0"		:: "r" (addr));
	__asm__ __volatile__ ("li	4, (1 << 6)"	::: "r4");
	__asm__ __volatile__ ("mtspr	27, 4");
	__asm__ __volatile__ ("rfi");

	/* Not reached. */
	while(1);
}

void amigaone_restart(char *cmd)
{
    	unsigned long addr;

	local_irq_disable();

	/* Flush and disable I/D cache. */
	__asm__ __volatile__ ("mfspr	3, 1008"	::: "r3");
	__asm__ __volatile__ ("ori	5, 5, 0xcc00"	::: "r5");
	__asm__ __volatile__ ("ori	4, 3, 0xc00"	::: "r4");
	__asm__ __volatile__ ("andc	5, 3, 5"	::: "r5");
	__asm__ __volatile__ ("sync");
	__asm__ __volatile__ ("mtspr	1008, 4");
	__asm__ __volatile__ ("isync");
	__asm__ __volatile__ ("sync");
	__asm__ __volatile__ ("mtspr	1008, 5");
	__asm__ __volatile__ ("isync");
	__asm__ __volatile__ ("sync");

	addr = 0xfff00100;
	soft_restart(addr);
	while(1);
}

static int __init amigaone_probe(void)
{
	unsigned long root = of_get_flat_dt_root();

 	if (of_flat_dt_is_compatible(root, "eyetech,amigaone")) {
	 	/* Coherent memory access cause complete system lockup! Thus
		 * remove it in any case, even if the CPU needs it. We'll
		 * disable the L2 cache prefetch later on.
		 */
	 	cur_cpu_spec->cpu_features &= ~CPU_FTR_NEED_COHERENT;

		ISA_DMA_THRESHOLD = 0x00FFFFFF;
		DMA_MODE_READ = 0x44;
		DMA_MODE_WRITE = 0x48;

		return 1;
	}

	return 0;
}

define_machine(amigaone) {
	.name			= "AmigaOne",
	.probe			= amigaone_probe,
	.setup_arch		= amigaone_setup_arch,
	.init			= amigaone_init,
	.show_cpuinfo		= amigaone_show_cpuinfo,
	.init_IRQ		= amigaone_init_IRQ,
	.restart		= amigaone_restart,
	.calibrate_decr		= generic_calibrate_decr,
	.progress		= udbg_progress,
	.phys_mem_access_prot	= pci_phys_mem_access_prot,
};

--========GMX201981190920353771509
Content-Type: text/x-csrc; charset="iso-8859-15"; name="pci.c"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="pci.c"

/*
 * AmigaOne platform PCI setup
 *
 * Copyright 2007 Gerhard Pircher (gerhard_pircher@gmx.net)
 *
 * This program is free software; you can redistribute  it and/or modify it
 * under  the terms of  the GNU General  Public License as published by the
 * Free Software Foundation;  either version 2 of the  License, or (at your
 * option) any later version.
 */

#include <linux/kernel.h>
#include <linux/pci.h>
#include <linux/delay.h>
#include <linux/string.h>
#include <linux/init.h>

#include <asm/io.h>
#include <asm/pgtable.h>
#include <asm/irq.h>
#include <asm/machdep.h>
#include <asm/sections.h>
#include <asm/pci-bridge.h>

void __init
amigaone_find_bridges(void)
{
	struct device_node *dev;
	const int *bus_range;
	int len, index = -1;
	struct pci_controller *hose;
	struct device_node *root = of_find_node_by_path("/");

	for (dev = root->child; dev != NULL; dev = dev->sibling) {
		if (dev->type == NULL || strcmp(dev->type, "pci") != 0)
			continue;
		++index;

		bus_range = of_get_property(dev, "bus-range", &len);
		if (bus_range == NULL || len < 2 * sizeof(int)) {
			printk(KERN_WARNING "Can't get bus-range for %s\n",
				dev->full_name);
			continue;
		}

/*		if (bus_range[1] == bus_range[0])
			printk(KERN_INFO "PCI bus %d", bus_range[0]);
		else
			printk(KERN_INFO "PCI buses %d..%d",
			       bus_range[0], bus_range[1]);
		printk(" controlled by %s", dev->full_name); */

		hose = pcibios_alloc_controller(dev);
		if (!hose) {
			printk("Can't allocate PCI controller structure for %s\n",
				dev->full_name);
			continue;
		}
		hose->arch_data = dev;
		hose->first_busno = bus_range[0];
		hose->last_busno = bus_range[1];

		setup_indirect_pci(hose, 0xfec00cf8, 0xfee00cfc, 0);

		/* Interpret the "ranges" property */
		/* This also maps the I/O region and sets isa_io/mem_base. */
		pci_process_bridge_OF_ranges(hose, dev, index == 0);
	}

	of_node_put(root);
}

--========GMX201981190920353771509
Content-Type: text/x-log; charset="iso-8859-15"; name="syslog.log"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="syslog.log"

<6>Using AmigaOne machine description.
<4>Total memory = 1536MB; using 4096kB for hash table (at cfc00000).
<5>Linux version 2.6.23-rc8 (geri@earth) (gcc version 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)) #11 Wed Sep 26 22:35:58 CEST 2007.
<4> -> find_legacy_serial_port().
<4>stdout is /pci@80000000/isa@7/serial@2f8.
<4> -> add_legacy_isa_port(/pci@80000000/isa@7/serial@2f8).
<7>Found legacy serial port 0 for /pci@80000000/isa@7/serial@2f8.
<7>  port=2f8, taddr=fe0002f8, irq=0, clk=1843200,speed=0.
<4> -> add_legacy_isa_port(/pci@80000000/isa@7/serial@3f8).
<7>Found legacy serial port 1 for /pci@80000000/isa@7/serial@3f8.
<7>  port=3f8, taddr=fe0003f8, irq=0, clk=1843200, speed=0.
<4>legacy_serial_console = 0.
<4>default console speed = 115200.
<4> <- find_legacy_serial_port().
<6>console [udbg0] enabled.
<7>Entering add_active_range(0, 0, 393216) 0 entries of 256 used.
<4>AmigaOne l2cr : L2 cache was not active, activating..
<4>PCI: IO 0x0 -> 0xbfffff.
<4>PCI: MEM[0] 0x80000000 -> 0xfdffffff.
<7>Top of RAM: 0x60000000, Total RAM: 0x60000000.
<7>Memory hole size: 0MB.
<4>Zone PFN ranges:.
<4>  DMA             0 ->   196608.
<4>  Normal     196608 ->   196608.
<4>  HighMem    196608 ->   393216.
<4>Movable zone start PFN for each node.
<4>early_node_map[1] active PFN ranges.
<4>    0:        0 ->   393216.
<7>On node 0 totalpages: 393216.
<7>  DMA zone: 1536 pages used for memmap.
<7>  DMA zone: 0 pages reserved.
<7>  DMA zone: 195072 pages, LIFO batch:31.
<7>  Normal zone: 0 pages used for memmap.
<7>  HighMem zone: 1536 pages used for memmap.
<7>  HighMem zone: 195072 pages, LIFO batch:31.
<7>  Movable zone: 0 pages used for memmap.
<4>Built 1 zonelists in Zone order.  Total pages: 390144.
<5>Kernel command line: root=/dev/hda11 console=udbg0 console=/dev/ttyS0,115200n8.
<7>i8259_host_map(1, 0x1).
<7>i8259_host_map(2, 0x2).
<7>i8259_host_map(3, 0x3).
<7>i8259_host_map(4, 0x4).
<7>i8259_host_map(5, 0x5).
<7>i8259_host_map(6, 0x6).
<7>i8259_host_map(7, 0x7).
<7>i8259_host_map(8, 0x8).
<7>i8259_host_map(9, 0x9).
<7>i8259_host_map(10, 0xa).
<7>i8259_host_map(11, 0xb).
<7>i8259_host_map(12, 0xc).
<7>i8259_host_map(13, 0xd).
<7>i8259_host_map(14, 0xe).
<7>i8259_host_map(15, 0xf).
<7>irq: Allocated host of type 0 @0xc04b5080.
<6>i8259 legacy interrupt controller initialized.
<7>irq: Default host set to @0xc04b5080.
<4>PID hash table entries: 4096 (order: 12, 16384 bytes).
<7>time_init: decrementer frequency = 33.333333 MHz.
<7>time_init: processor frequency = 800.000000 MHz.
<4> -> check_legacy_serial_console().
<4> console was specified !.
<4>Console: colour dummy device 80x25.
<6>Dentry cache hash table entries: 131072 (order: 7, 524288 bytes).
<6>Inode-cache hash table entries: 65536 (order: 6, 262144 bytes).
<7>High memory: 786432k.
<6>Memory: 1549564k/1572864k available (3416k kernel code, 808700k reserved, 152k data, 1182k bss, 176k init).
<7>Calibrating delay loop... 66.56 BogoMIPS (lpj=133120).
<6>Security Framework v1.0.0 initialized.
<6>SELinux:  Disabled at boot..
<6>Capability LSM initialized.
<4>Mount-cache hash table entries: 512.
<4>khelper used greatest stack depth: 7316 bytes left.
<6>NET: Registered protocol family 16.
...
...4 bytes left.
<6>PCI: Probing PCI hardware.
<7>PCI: Scanning bus 0...
...00:00:07.0.
<7>PCI: Calling quirk...
...CI: Found 0000:00:07.2 [1106/303...

--========GMX201981190920353771509--
