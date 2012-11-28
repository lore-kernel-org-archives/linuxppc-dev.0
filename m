Return-Path: <fransmeulenbroeks@gmail.com>
Received: from mail-da0-f51.google.com (mail-da0-f51.google.com
 [209.85.210.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5AFEA2C0086
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Nov 2012 20:39:25 +1100 (EST)
Received: by mail-da0-f51.google.com with SMTP id i30so3812248dad.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Nov 2012 01:39:23 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 28 Nov 2012 10:39:22 +0100
Message-ID: <CACW_hTa4eVOfxKus1ma8vB6dVZu4PovasLtn=+7UygqYtC_Vww@mail.gmail.com>
Subject: fsl spi questions & patch
From: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/mixed; boundary=047d7b2eda8b07d7a404cf8af1fb
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--047d7b2eda8b07d7a404cf8af1fb
Content-Type: multipart/alternative; boundary=047d7b2eda8b07d79604cf8af1f9

--047d7b2eda8b07d79604cf8af1f9
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I've been playing with spi on mpc8313e and have some things on
spi-fsl-spi.c:

Is QE useful on 8313?
I've tried it (using cpu-qe in my dts file) and see in the boot log that it
is used, but I do not really see any effect when it comes to performance or
cpu usage.

Furthermore:
In the fsl_spi_cpu_irq there is a line:
        /* Clear the events */
        mpc8xxx_spi_write_reg(&reg_base->event, events);

Is this really useful? The 8313 book says NE is cleared upon reading and NF
is cleared upon writing.
(this might apply to fsl_spi_cpm_irq too, I do not have info on cpm.

Next, I noticed some spacing between two spi words being sent. It seems the
transmit buffer is not filled when possible, but only when a word is
received (and the previous word is transmitted). By modifying the code
somewhat I was able to roughly double the effective transfer rate in my
test setup (8 Mhz spi clock, 32 bit transfers). Attached is my changed
code. Feedback on it is appreciated.

This patch also eliminated the spinning until TX is done. (actually I am
not sure if this will happen, I would expect NE and NF to be raised roughly
at the same time.

Thanks for any feedback!

Frans Meulenbroeks

PS:it would probably be nice if in board setup one could also set the
(default) value of bits-per-word.

--047d7b2eda8b07d79604cf8af1f9
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>I&#39;ve been playing with spi on mpc8313e and have some things =
on spi-fsl-spi.c:<br><br>Is QE useful on 8313? <br>I&#39;ve tried it (using=
 cpu-qe in my dts file) and see in the boot log that it is used, but I do n=
ot really see any effect when it comes to performance or cpu usage.<br>
<br>Furthermore:<br>In the fsl_spi_cpu_irq there is a line:<br>=A0=A0=A0=A0=
=A0=A0=A0 /* Clear the events */<br>=A0=A0=A0=A0=A0=A0=A0 mpc8xxx_spi_write=
_reg(&amp;reg_base-&gt;event, events);<br><br>Is this really useful? The 83=
13 book says NE is cleared upon reading and NF is cleared upon writing.<br>
(this might apply to fsl_spi_cpm_irq too, I do not have info on cpm.<br><br=
>Next, I noticed some spacing between two spi words being sent. It seems th=
e transmit buffer is not filled when possible, but only when a word is rece=
ived (and the previous word is transmitted). By modifying the code somewhat=
 I was able to roughly double the effective transfer rate in my test setup =
(8 Mhz spi clock, 32 bit transfers). Attached is my changed code. Feedback =
on it is appreciated.<br>
<br>This patch also eliminated the spinning until TX is done. (actually I a=
m not sure if this will happen, I would expect NE and NF to be raised rough=
ly at the same time.<br><br>Thanks for any feedback!<br><br>Frans Meulenbro=
eks<br>
<br>PS:it would probably be nice if in board setup one could also set the (=
default) value of bits-per-word.<br>

--047d7b2eda8b07d79604cf8af1f9--

--047d7b2eda8b07d7a404cf8af1fb
Content-Type: application/octet-stream;
	name="0001-spi-fsl-spi.c-use-NF-interrupt-instead-of-NE.patch"
Content-Disposition: attachment;
	filename="0001-spi-fsl-spi.c-use-NF-interrupt-instead-of-NE.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ha282kjm0

RnJvbSBmZTc4M2FjMGZlM2QyZWE0ODE0ZDI4MmY0MzZjOTY3MGY4OTJiZGEyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBGcmFucyBNZXVsZW5icm9la3MgPGZyYW5zbWV1bGVuYnJvZWtz
QGdtYWlsLmNvbT4KRGF0ZTogV2VkLCAyOCBOb3YgMjAxMiAwOTo0Mjo1MSArMDEwMApTdWJqZWN0
OiBbUEFUQ0hdIHNwaS1mc2wtc3BpLmM6IHVzZSBORiBpbnRlcnJ1cHQgaW5zdGVhZCBvZiBORQoK
V2hlbiB1c2luZyBORSAobm90IGVtcHR5KSBpbnRlcnJ1cHQgd2UgZ2V0IHRoZSBmaXJzdCBpbnRl
cnJ1cHQKd2hlbiB0aGUgZmlyc3Qgd29yZCBpcyByZWNlaXZlZCAoYW5kIHRoZSBmaXJzdCBvbmUg
c2VuZCBhcwpzZW5kaW5nIGFuZCByZWNlaXZpbmcgaGFwcGVucyBzaW11bHRhbmVvdXNseSBhbmQg
c3ljaHJvbm91c2x5KS4KSW4gdGhlIGNhc2Ugb2YgbXVsdGktd29yZCB0cmFuc21pdHMgdGhlcmUg
aXMgYSBzaG9ydCBkZWxheSB0bwpyZWxvYWQgdGhlIHRyYW5zbWl0IGJ1ZmZlciAob24gbXkgdGVz
dCBzeXN0ZW0gMS41IHVzKS4KSG93ZXZlciBpdCBpcyBwb3NzaWJsZSB0byBsb2FkIHRoZSBuZXh0
IGJ5dGUgYmVmb3JlIGFzIHRoZXJlCmlzIGEgb25lIHdvcmQgaG9sZCByZWdpc3Rlci4KCkJ5IHVz
aW5nIE5GIChub3QgZnVsbCkgdG8gdHJpZ2dlciB0aGUgaW50ZXJydXB0IHdlIGZpbGwgdGhlCnJl
Z2lzdGVyIGFzIHNvb24gYXMgcG9zc2libGUsIGltcHJvdmluZyB0aGUgdHJhbnNtaXNzaW9uIHNw
ZWVkLgooYWJvdXQgZG91YmxpbmcgaXQgd2l0aCBhbiA4TWh6IFNQSSBjbG9jayBhbmQgMzIgYml0
IHRyYW5zZmVycwpvbiBNUEM4MzEzZSkKCkkgYWxzbyBtb3ZlZCB0aGUgZGlzYWJsaW5nIG9mIHRo
ZSBpbnRlcnJ1cHQgaW50byB0aGUgX2lycQpoYW5kbGVyIChiZWZvcmUgY2FsbGluZyBjb21wbGV0
ZSgpICkgaW5zdGVhZCBvZiBhZnRlcgp3YWl0X2Zvcl9jb21wbGV0aW9uKCkuCk9uIG15IHN5c3Rl
bSB0aGUgTkYgaW50ZXJydXB0IGtlcHQgYmVpbmcgcmFpc2VkOyB0aGlzIGZpeGVkIHRoYXQuCgpT
aWduZWQtb2ZmLWJ5OiBGcmFucyBNZXVsZW5icm9la3MgPGZyYW5zbWV1bGVuYnJvZWtzQGdtYWls
LmNvbT4KLS0tCiBkcml2ZXJzL3NwaS9zcGktZnNsLXNwaS5jIHwgICAyNyArKysrKysrKysrLS0t
LS0tLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAxNyBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3NwaS9zcGktZnNsLXNwaS5jIGIvZHJpdmVy
cy9zcGkvc3BpLWZzbC1zcGkuYwppbmRleCA2YTYyOTM0Li4xZjgxY2NkIDEwMDY0NAotLS0gYS9k
cml2ZXJzL3NwaS9zcGktZnNsLXNwaS5jCisrKyBiL2RyaXZlcnMvc3BpL3NwaS1mc2wtc3BpLmMK
QEAgLTQxMCw3ICs0MTAsNyBAQCBzdGF0aWMgaW50IGZzbF9zcGlfY3B1X2J1ZnMoc3RydWN0IG1w
Yzh4eHhfc3BpICptc3BpLAogCW1zcGktPmNvdW50ID0gbGVuOwogCiAJLyogZW5hYmxlIHJ4IGlu
dHMgKi8KLQltcGM4eHh4X3NwaV93cml0ZV9yZWcoJnJlZ19iYXNlLT5tYXNrLCBTUElNX05FKTsK
KwltcGM4eHh4X3NwaV93cml0ZV9yZWcoJnJlZ19iYXNlLT5tYXNrLCBTUElNX05GKTsKIAogCS8q
IHRyYW5zbWl0IHdvcmQgKi8KIAl3b3JkID0gbXNwaS0+Z2V0X3R4KG1zcGkpOwpAQCAtNDYwLDkg
KzQ2MCw2IEBAIHN0YXRpYyBpbnQgZnNsX3NwaV9idWZzKHN0cnVjdCBzcGlfZGV2aWNlICpzcGks
IHN0cnVjdCBzcGlfdHJhbnNmZXIgKnQsCiAKIAl3YWl0X2Zvcl9jb21wbGV0aW9uKCZtcGM4eHh4
X3NwaS0+ZG9uZSk7CiAKLQkvKiBkaXNhYmxlIHJ4IGludHMgKi8KLQltcGM4eHh4X3NwaV93cml0
ZV9yZWcoJnJlZ19iYXNlLT5tYXNrLCAwKTsKLQogCWlmIChtcGM4eHh4X3NwaS0+ZmxhZ3MgJiBT
UElfQ1BNX01PREUpCiAJCWZzbF9zcGlfY3BtX2J1ZnNfY29tcGxldGUobXBjOHh4eF9zcGkpOwog
CkBAIC02MDQsMjMgKzYwMSwxOSBAQCBzdGF0aWMgdm9pZCBmc2xfc3BpX2NwdV9pcnEoc3RydWN0
IG1wYzh4eHhfc3BpICptc3BpLCB1MzIgZXZlbnRzKQogCQkJbXNwaS0+Z2V0X3J4KHJ4X2RhdGEs
IG1zcGkpOwogCX0KIAotCWlmICgoZXZlbnRzICYgU1BJRV9ORikgPT0gMCkKLQkJLyogc3BpbiB1
bnRpbCBUWCBpcyBkb25lICovCi0JCXdoaWxlICgoKGV2ZW50cyA9Ci0JCQltcGM4eHh4X3NwaV9y
ZWFkX3JlZygmcmVnX2Jhc2UtPmV2ZW50KSkgJgotCQkJCQkJU1BJRV9ORikgPT0gMCkKLQkJCWNw
dV9yZWxheCgpOwotCiAJLyogQ2xlYXIgdGhlIGV2ZW50cyAqLwogCW1wYzh4eHhfc3BpX3dyaXRl
X3JlZygmcmVnX2Jhc2UtPmV2ZW50LCBldmVudHMpOwogCi0JbXNwaS0+Y291bnQgLT0gMTsKLQlp
ZiAobXNwaS0+Y291bnQpIHsKLQkJdTMyIHdvcmQgPSBtc3BpLT5nZXRfdHgobXNwaSk7CisJaWYg
KChldmVudHMgJiBTUElFX05GKSAmJiAobXNwaS0+Y291bnQgPiAxKSkKKwl7CW1zcGktPmNvdW50
IC09IDE7CisJCWlmIChtc3BpLT5jb3VudCkgeworCQkJdTMyIHdvcmQgPSBtc3BpLT5nZXRfdHgo
bXNwaSk7CiAKLQkJbXBjOHh4eF9zcGlfd3JpdGVfcmVnKCZyZWdfYmFzZS0+dHJhbnNtaXQsIHdv
cmQpOwotCX0gZWxzZSB7Ci0JCWNvbXBsZXRlKCZtc3BpLT5kb25lKTsKKwkJCW1wYzh4eHhfc3Bp
X3dyaXRlX3JlZygmcmVnX2Jhc2UtPnRyYW5zbWl0LCB3b3JkKTsKKwkJfSBlbHNlIHsKKwkJCW1w
Yzh4eHhfc3BpX3dyaXRlX3JlZygmcmVnX2Jhc2UtPm1hc2ssIDApOyAvKiBkaXNhYmxlIGludGVy
cnVwdHMgKi8KKwkJCWNvbXBsZXRlKCZtc3BpLT5kb25lKTsKKwkJfQogCX0KIH0KIAotLSAKMS43
LjkuNQoK
--047d7b2eda8b07d7a404cf8af1fb--
