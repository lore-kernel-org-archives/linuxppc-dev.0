Message-ID: <3F6591E2.5070205@siemens.com>
Date: Mon, 15 Sep 2003 12:18:10 +0200
From: Steffen Rumler <Steffen.Rumler@siemens.com>
MIME-Version: 1.0
To: linuxppc <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Problem of concurrency in arch/ppc/8260_io/uart.c
Content-Type: multipart/mixed;
 boundary="------------030401060107020402030905"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------030401060107020402030905
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I have seen a similar problem for the 2.4.20.

When I force a lot of console output via the following command:

   while true; do cd /; ls -R; done

and type-in some letters in parallel, the console
becomes crazy.

I have added some instrumentation in order to dump the
TX Buffer Descriptor Table. I have found that the
hardware pointer (TBPTR) and the software pointer (tx_cur)
are not more synchronized together:

 >> make new rlogin session <<
/root# cd /proc/driver

/root# cat uart-bdtables; cat mpc82xx/smc1_pram | grep SMC1_PRAM_TBPTR

TX BD table
   (000 at 0xfff005f0) status: 0x1000 len: 0001 addr: 0x001bb084
   (001 at 0xfff005f8) status: 0x1000 len: 0001 addr: 0x001bb0a4
* (002 at 0xfff00600) status: 0x1000 len: 0001 addr: 0x001bb0c4
   (003 at 0xfff00608) status: 0x3000 len: 0004 addr: 0x001bb0e4
    SMC1_PRAM_TBPTR            0x20         2     0600

    --> hardware and software pointer still synchronized

    >> force console to become crazy (see above) <<

/root# cat uart-bdtables; cat mpc82xx/smc1_pram | grep SMC1_PRAM_TBPTR

TX BD table (tbptr: 0x00000088)
   (000 at 0xfff005f0) status: 0x1000 len: 0003 addr: 0x001bb084
* (001 at 0xfff005f8) status: 0x1000 len: 0021 addr: 0x001bb0a4
   (002 at 0xfff00600) status: 0x1000 len: 0001 addr: 0x001bb0c4
   (003 at 0xfff00608) status: 0x3000 len: 0001 addr: 0x001bb0e4
    SMC1_PRAM_TBPTR            0x20         2     0600

    --> hardware and software pointer NOT more synchronized

    >> make additional console output: echo foo >/dev/console <<

/root# cat uart-bdtables; cat mpc82xx/smc1_pram | grep SMC1_PRAM_TBPTR

* (000 at 0xfff005f0) status: 0x1000 len: 0003 addr: 0x001bb084
   (001 at 0xfff005f8) status: 0x9000 len: 0004 addr: 0x001bb0a4
   (002 at 0xfff00600) status: 0x1000 len: 0001 addr: 0x001bb0c4
   (003 at 0xfff00608) status: 0x3000 len: 0001 addr: 0x001bb0e4
    SMC1_PRAM_TBPTR            0x20         2     05f0

    --> hardware pointer hangs at 0x5f0 because R-Bit not set, but
        at 0x5f8

Inside uart.c, there are the following output routines:

   rs_8xx_put_char()
   rs_8xx_write()
   rs_8xx_send_xchar()
   my_console_write()

I think there must be a synchronization accessing the
TX BD table. I suggest the patch attached.


Best Regards
Steffen
--


--------------------------------------------------------------

Steffen Rumler
ICN CP D NT SW 7
Siemens AG
Hofmannstr. 51                 Email: Steffen.Rumler@siemens.com
D-81359 Munich                 Phone: +49 89 722-44061
Germany                        Fax  : +49 89 722-36703

--------------------------------------------------------------



--------------030401060107020402030905
Content-Type: text/plain;
 name="uart.c.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="uart.c.patch"

ZGlmZiAtTmF1ciBvbGQvdWFydC5jIG5ldy91YXJ0LmMKLS0tIG9sZC91YXJ0LmMJTW9uIFNl
cCAxNSAxMTo1MjowMiAyMDAzCisrKyBuZXcvdWFydC5jCU1vbiBTZXAgMTUgMTE6NTE6MzIg
MjAwMwpAQCAtNDQsNiArNDQsNyBAQAogI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4KICNpbmNs
dWRlIDxsaW51eC9pbml0Lmg+CiAjaW5jbHVkZSA8bGludXgvZGVsYXkuaD4KKyNpbmNsdWRl
IDxsaW51eC9zcGlubG9jay5oPgogI2luY2x1ZGUgPGFzbS91YWNjZXNzLmg+CiAjaW5jbHVk
ZSA8YXNtL2ltbWFwXzgyNjAuaD4KICNpbmNsdWRlIDxhc20vbXBjODI2MC5oPgpAQCAtMjUz
LDYgKzI1NCwxMSBAQAogCWNiZF90CQkJKnJ4X2N1cjsKIAljYmRfdAkJCSp0eF9iZF9iYXNl
OwogCWNiZF90CQkJKnR4X2N1cjsKKworICAgICAgICAvKiAgZm9yIG91dHB1dCBzeW5jaHJv
bml6YXRpb24KKyAgICAgICAgICovCisgICAgICAgIHNwaW5sb2NrX3Qgb3V0cHV0X2xvY2s7
CisgICAgICAgIAogfSBzZXJfaW5mb190OwogCiBzdGF0aWMgdm9pZCBjaGFuZ2Vfc3BlZWQo
c2VyX2luZm9fdCAqaW5mbyk7CkBAIC0xMDEwLDYgKzEwMTYsNyBAQAogewogCXNlcl9pbmZv
X3QgKmluZm8gPSAoc2VyX2luZm9fdCAqKXR0eS0+ZHJpdmVyX2RhdGE7CiAJdm9sYXRpbGUg
Y2JkX3QJKmJkcDsKKyAgICAgICAgdW5zaWduZWQgbG9uZyBmbGFnczsKIAogCWlmIChzZXJp
YWxfcGFyYW5vaWFfY2hlY2soaW5mbywgdHR5LT5kZXZpY2UsICJyc19wdXRfY2hhciIpKQog
CQlyZXR1cm47CkBAIC0xMDE3LDYgKzEwMjQsOCBAQAogCWlmICghdHR5KQogCQlyZXR1cm47
CiAKKyAgICAgICAgc3Bpbl9sb2NrX2lycXNhdmUoJihpbmZvLT5vdXRwdXRfbG9jayksIGZs
YWdzKTsKKwogCWJkcCA9IGluZm8tPnR4X2N1cjsKIAl3aGlsZSAoYmRwLT5jYmRfc2MgJiBC
RF9TQ19SRUFEWSk7CiAKQEAgLTEwMzMsNiArMTA0Miw4IEBACiAKIAlpbmZvLT50eF9jdXIg
PSAoY2JkX3QgKiliZHA7CiAKKyAgICAgICAgc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmKGlu
Zm8tPm91dHB1dF9sb2NrKSwgZmxhZ3MpOworCiB9CiAKIHN0YXRpYyBpbnQgcnNfOHh4X3dy
aXRlKHN0cnVjdCB0dHlfc3RydWN0ICogdHR5LCBpbnQgZnJvbV91c2VyLApAQCAtMTA0MSw2
ICsxMDUyLDcgQEAKIAlpbnQJYywgcmV0ID0gMDsKIAlzZXJfaW5mb190ICppbmZvID0gKHNl
cl9pbmZvX3QgKil0dHktPmRyaXZlcl9kYXRhOwogCXZvbGF0aWxlIGNiZF90ICpiZHA7Cisg
ICAgICAgIHVuc2lnbmVkIGxvbmcgZmxhZ3M7CiAKIAlpZiAoc2VyaWFsX3BhcmFub2lhX2No
ZWNrKGluZm8sIHR0eS0+ZGV2aWNlLCAicnNfd3JpdGUiKSkKIAkJcmV0dXJuIDA7CkBAIC0x
MDQ4LDYgKzEwNjAsOCBAQAogCWlmICghdHR5KSAKIAkJcmV0dXJuIDA7CiAKKyAgICAgICAg
c3Bpbl9sb2NrX2lycXNhdmUoJihpbmZvLT5vdXRwdXRfbG9jayksIGZsYWdzKTsKKwogCWJk
cCA9IGluZm8tPnR4X2N1cjsKIAogCXdoaWxlICgxKSB7CkBAIC0xMDg2LDYgKzExMDAsOSBA
QAogCQkJYmRwKys7CiAJCWluZm8tPnR4X2N1ciA9IChjYmRfdCAqKWJkcDsKIAl9CisKKyAg
ICAgICAgc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmKGluZm8tPm91dHB1dF9sb2NrKSwgZmxh
Z3MpOworCiAJcmV0dXJuIHJldDsKIH0KIApAQCAtMTE0MywxMiArMTE2MCwxNSBAQAogc3Rh
dGljIHZvaWQgcnNfOHh4X3NlbmRfeGNoYXIoc3RydWN0IHR0eV9zdHJ1Y3QgKnR0eSwgY2hh
ciBjaCkKIHsKIAl2b2xhdGlsZSBjYmRfdAkqYmRwOworICAgICAgICB1bnNpZ25lZCBsb25n
IGZsYWdzOwogCiAJc2VyX2luZm9fdCAqaW5mbyA9IChzZXJfaW5mb190ICopdHR5LT5kcml2
ZXJfZGF0YTsKIAogCWlmIChzZXJpYWxfcGFyYW5vaWFfY2hlY2soaW5mbywgdHR5LT5kZXZp
Y2UsICJyc19zZW5kX2NoYXIiKSkKIAkJcmV0dXJuOwogCisgICAgICAgIHNwaW5fbG9ja19p
cnFzYXZlKCYoaW5mby0+b3V0cHV0X2xvY2spLCBmbGFncyk7CisKIAliZHAgPSBpbmZvLT50
eF9jdXI7CiAJd2hpbGUgKGJkcC0+Y2JkX3NjICYgQkRfU0NfUkVBRFkpOwogCkBAIC0xMTY0
LDYgKzExODQsOCBAQAogCQliZHArKzsKIAogCWluZm8tPnR4X2N1ciA9IChjYmRfdCAqKWJk
cDsKKworICAgICAgICBzcGluX3VubG9ja19pcnFyZXN0b3JlKCYoaW5mby0+b3V0cHV0X2xv
Y2spLCBmbGFncyk7CiB9CiAKIC8qCkBAIC0yMjI3LDkgKzIyNDksMTEgQEAKIAl2b2xhdGls
ZQljYmRfdAkJKmJkcCwgKmJkYmFzZTsKIAl2b2xhdGlsZQlzbWNfdWFydF90CSp1cDsKIAl2
b2xhdGlsZQl1X2NoYXIJCSpjcDsKKyAgICAgICAgdW5zaWduZWQgbG9uZyAgIGZsYWdzOwog
CiAJc2VyID0gcnNfdGFibGUgKyBpZHg7CiAKKwogCS8qIElmIHRoZSBwb3J0IGhhcyBiZWVu
IGluaXRpYWxpemVkIGZvciBnZW5lcmFsIHVzZSwgd2UgaGF2ZQogCSAqIHRvIHVzZSB0aGUg
YnVmZmVyIGRlc2NyaXB0b3JzIGFsbG9jYXRlZCB0aGVyZS4gIE90aGVyd2lzZSwKIAkgKiB3
ZSBzaW1wbHkgdXNlIHRoZSBzaW5nbGUgYnVmZmVyIGFsbG9jYXRlZC4KQEAgLTIyMzcsNiAr
MjI2MSw3IEBACiAJaWYgKChpbmZvID0gKHNlcl9pbmZvX3QgKilzZXItPmluZm8pICE9IE5V
TEwpIHsKIAkJYmRwID0gaW5mby0+dHhfY3VyOwogCQliZGJhc2UgPSBpbmZvLT50eF9iZF9i
YXNlOworICAgICAgICAgICAgICAgIHNwaW5fbG9ja19pcnFzYXZlKCYoaW5mby0+b3V0cHV0
X2xvY2spLCBmbGFncyk7CiAJfQogCWVsc2UgewogCQkvKiBQb2ludGVyIHRvIFVBUlQgaW4g
cGFyYW1ldGVyIHJhbS4KQEAgLTIzMDksNiArMjMzNCw5IEBACiAKIAlpZiAoaW5mbykKIAkJ
aW5mby0+dHhfY3VyID0gKGNiZF90ICopYmRwOworCisgICAgICAgIGlmIChpbmZvKQorICAg
ICAgICAgICAgc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmKGluZm8tPm91dHB1dF9sb2NrKSwg
ZmxhZ3MpOwogfQogCiBzdGF0aWMgdm9pZCBzZXJpYWxfY29uc29sZV93cml0ZShzdHJ1Y3Qg
Y29uc29sZSAqYywgY29uc3QgY2hhciAqcywKQEAgLTI3NjQsNiArMjc5Miw3IEBACiAJCQlp
bmZvLT50cXVldWVfaGFuZ3VwLmRhdGEgPSBpbmZvOwogCQkJaW5mby0+bGluZSA9IGk7CiAJ
CQlpbmZvLT5zdGF0ZSA9IHN0YXRlOworICAgICAgICAgICAgICAgICAgICAgICAgc3Bpbl9s
b2NrX2luaXQoJihpbmZvLT5vdXRwdXRfbG9jaykpOwogCQkJc3RhdGUtPmluZm8gPSAoc3Ry
dWN0IGFzeW5jX3N0cnVjdCAqKWluZm87CiAKIAkJCS8qIFdlIG5lZWQgdG8gYWxsb2NhdGUg
YSB0cmFuc21pdCBhbmQgcmVjZWl2ZSBidWZmZXIK
--------------030401060107020402030905--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
