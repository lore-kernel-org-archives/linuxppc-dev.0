Return-Path: <plasmaroo@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.181])
	by ozlabs.org (Postfix) with ESMTP id C4884DDE1D
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jun 2008 18:33:15 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id n7so4261985wag.13
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jun 2008 01:33:14 -0700 (PDT)
Message-ID: <792f5f410806170133t3fb8f69creabf9a4142b1c7e1@mail.gmail.com>
Date: Tue, 17 Jun 2008 09:33:14 +0100
From: "Tim Yamin" <plasm@roo.me.uk>
Sender: plasmaroo@gmail.com
To: linuxppc-dev@ozlabs.org
Subject: [PATCH]: [MPC5200] Fix lite5200b suspend/resume
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_46157_10436357.1213691594308"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_46157_10436357.1213691594308
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

Suspend/resume ("echo mem > /sys/power/state") does not work for me
with vanilla kernels -- the system does not suspend correctly and just
hangs. The attached patch fixes this so suspend/resume works:

1) of_iomap does not map the whole 0xC0000 of the MPC5200 for me, so
saving registers does not work. Maybe this is just a bug in my DTB? Or
is this an of_iomap bug?
2) PCI registers need to be saved and restored. Would it make sense to
move struct mpc52xx_pci out of mpc52xx_pci.c and into a header?

If somebody else with a lite5200B board could do some testing this
would be appreciated as would comments on the above two issues.

Thanks,

Tim

------=_Part_46157_10436357.1213691594308
Content-Type: text/x-patch; name=1100-mpc5200-lite5200b-fix-suspend.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fhk8le780
Content-Disposition: attachment;
 filename=1100-mpc5200-lite5200b-fix-suspend.patch

LSBDdXJyZW50IG1lbW9yeSByZW1hcHBpbmcgaXMgd3Jvbmc7IHRoZSByZW1hcHBlZCBhcmVhIGRv
ZXMgbm90IGhhdmUKICB0aGUgY29ycmVjdCBsZW5ndGggKDB4MTAwIGluc3RlYWQgb2YgMHhDMDAw
KSBhbmQgdGhlIHN5c3RlbSBkb2VzCiAgbm90IHBvd2VyIGRvd24gcHJvcGVybHkgYXMgYSByZXN1
bHQuLi4gW29mX2lvcmVtYXAgYnVnP10KCi0gTWFrZSBzdXJlIHRoZSBQQ0kgcmVnaXN0ZXJzIGFy
ZSBzYXZlZCBhbmQgcmVzdG9yZWQsIHRoaXMgZml4ZXMgYQogIGtlcm5lbCBwYW5pYyBmb3IgbWUg
b24gcmVzdW1lLgoKU2lnbmVkLW9mZi1ieTogVGltIFlhbWluIDxwbGFzbUByb28ubWUudWs+Cgot
LS0gbGludXgtMi42LjI2LXJjNi9hcmNoL3Bvd2VycGMvcGxhdGZvcm1zLzUyeHgvbGl0ZTUyMDBf
cG0uY34JMjAwOC0wNC0xNyAwMzo0OTo0NC4wMDAwMDAwMDAgKzAxMDAKKysrIGxpbnV4LTIuNi4y
Ni1yYzYvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy81Mnh4L2xpdGU1MjAwX3BtLmMJMjAwOC0wNi0x
NiAxNTo0MDowMi4wMDAwMDAwMDAgKzAxMDAKQEAgLTE0LDYgKzE0LDcgQEAKIHN0YXRpYyBzdHJ1
Y3QgbXBjNTJ4eF94bGIgX19pb21lbSAqeGxiOwogc3RhdGljIHN0cnVjdCBtcGM1Mnh4X2dwaW8g
X19pb21lbSAqZ3BzOwogc3RhdGljIHN0cnVjdCBtcGM1Mnh4X2dwaW9fd2t1cCBfX2lvbWVtICpn
cHc7CitzdGF0aWMgdm9pZCBfX2lvbWVtICpwY2k7CiBzdGF0aWMgdm9pZCBfX2lvbWVtICpzcmFt
Owogc3RhdGljIGNvbnN0IGludCBzcmFtX3NpemUgPSAweDQwMDA7CS8qIDE2IGtCeXRlcyAqLwog
c3RhdGljIHZvaWQgX19pb21lbSAqbWJhcjsKQEAgLTQyLDYgKzQzLDkgQEAKIAogc3RhdGljIGlu
dCBsaXRlNTIwMF9wbV9wcmVwYXJlKHZvaWQpCiB7CisJdTY0IHJlZ2FkZHI2NDsKKwljb25zdCB1
MzIgKnJlZ2FkZHJfcDsKKwogCXN0cnVjdCBkZXZpY2Vfbm9kZSAqbnA7CiAJY29uc3Qgc3RydWN0
IG9mX2RldmljZV9pZCBpbW1yX2lkc1tdID0gewogCQl7IC5jb21wYXRpYmxlID0gImZzbCxtcGM1
MjAwLWltbXIiLCB9LApAQCAtNjAsOCArNjQsMTEgQEAKIAogCS8qIG1hcCByZWdpc3RlcnMgKi8K
IAlucCA9IG9mX2ZpbmRfbWF0Y2hpbmdfbm9kZShOVUxMLCBpbW1yX2lkcyk7Ci0JbWJhciA9IG9m
X2lvbWFwKG5wLCAwKTsKKwlyZWdhZGRyX3AgPSBvZl9nZXRfYWRkcmVzcyhucCwgMCwgTlVMTCwg
TlVMTCk7CisJcmVnYWRkcjY0ID0gb2ZfdHJhbnNsYXRlX2FkZHJlc3MobnAsIHJlZ2FkZHJfcCk7
CiAJb2Zfbm9kZV9wdXQobnApOworCisJbWJhciA9IGlvcmVtYXAoKHUzMikgcmVnYWRkcjY0LCAw
eEMwMDAwKTsKIAlpZiAoIW1iYXIpIHsKIAkJcHJpbnRrKEtFUk5fRVJSICIlczolaSBFcnJvciBt
YXBwaW5nIHJlZ2lzdGVyc1xuIiwgX19mdW5jX18sIF9fTElORV9fKTsKIAkJcmV0dXJuIC1FTk9T
WVM7CkBAIC03MSw2ICs3OCw3IEBACiAJcGljID0gbWJhciArIDB4NTAwOwogCWdwcyA9IG1iYXIg
KyAweGIwMDsKIAlncHcgPSBtYmFyICsgMHhjMDA7CisJcGNpID0gbWJhciArIDB4ZDAwOwogCWJl
cyA9IG1iYXIgKyAweDEyMDA7CiAJeGxiID0gbWJhciArIDB4MWYwMDsKIAlzcmFtID0gbWJhciAr
IDB4ODAwMDsKQEAgLTg1LDYgKzkzLDcgQEAKIHN0YXRpYyBzdHJ1Y3QgbXBjNTJ4eF94bGIgc3hs
YjsKIHN0YXRpYyBzdHJ1Y3QgbXBjNTJ4eF9ncGlvIHNncHM7CiBzdGF0aWMgc3RydWN0IG1wYzUy
eHhfZ3Bpb193a3VwIHNncHc7CitzdGF0aWMgY2hhciBzcGNpWzB4MjAwXTsKIAogc3RhdGljIHZv
aWQgbGl0ZTUyMDBfc2F2ZV9yZWdzKHZvaWQpCiB7CkBAIC05NCw2ICsxMDMsNyBAQAogCV9tZW1j
cHlfZnJvbWlvKCZzeGxiLCB4bGIsIHNpemVvZigqeGxiKSk7CiAJX21lbWNweV9mcm9taW8oJnNn
cHMsIGdwcywgc2l6ZW9mKCpncHMpKTsKIAlfbWVtY3B5X2Zyb21pbygmc2dwdywgZ3B3LCBzaXpl
b2YoKmdwdykpOworCV9tZW1jcHlfZnJvbWlvKHNwY2ksIHBjaSwgMHgyMDApOwogCiAJX21lbWNw
eV9mcm9taW8oc2F2ZWRfc3JhbSwgc3JhbSwgc3JhbV9zaXplKTsKIH0KQEAgLTEwMyw2ICsxMTMs
OCBAQAogCWludCBpOwogCV9tZW1jcHlfdG9pbyhzcmFtLCBzYXZlZF9zcmFtLCBzcmFtX3NpemUp
OwogCisJLyogUENJIENvbmZpZ3VyYXRpb24gKi8KKwlfbWVtY3B5X3RvaW8ocGNpLCBzcGNpLCAw
eDIwMCk7CiAKIAkvKgogCSAqIEdQSU9zLiBJbnRlcnJ1cHQgTWFzdGVyIEVuYWJsZSBoYXMgaGln
aGVyIGFkZHJlc3MgdGhlbiBvdGhlcgo=
------=_Part_46157_10436357.1213691594308--
