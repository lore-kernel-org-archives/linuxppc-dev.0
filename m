Date: Tue, 2 Mar 1999 01:13:57 -0600 (CST)
From: Takashi Oe <toe@unlinfo.unl.edu>
To: linuxppc-dev@lists.linuxppc.org
cc: Cort Dougan <cort@persephone.cs.nmt.edu>
Subject: ioreamp() and modules
Message-ID: <Pine.LNX.3.96LJ1.1b7.990302003814.624A-200000@selq119.unl.edu>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-838631075-1679362092-920358837=:624"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---838631075-1679362092-920358837=:624
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi,

Recently, I've been trying to modify pm2fb.c so that it works for my
Permedia 2v card, but I'm not getting much success with ioremap().

I have a dummy driver which basically does ioremap() and some register
accesses and exits.  As long as the driver is compiled in, everything goes
as expected and things are nice.  However, when the driver is loaded via
insmod, it usually ends up causing a kernel exception.  The size of i/o
mapping seems to matter.  For example, if I try to ioremap the size of
0x10000 or so, it will cause the exception almost every time with 2.2.2
from cvs.samba.org as of yesterday, but, if the size is about 0x1000 or
so, I have to load the driver many times before causing the exception.
When the exception occurs, it usually goes like
	ioremap
	__ioremap
	map_page
	MMU_get_page
and, since MMU_get_page() is __initfunc(), there is no wonder I see the
exception, but I don't know why MMU_get_page() gets to be called in the
first place.  I don't remember exactly how it was with 2.2.1, but it
wasn't much better as I recall.

I have made a workaround and it's attached.  It just avoids using
map_page() and probably not good for performance reasons or something.
Anyhow, I am yet to see the exception with this patch.

Has anybody seen something like this?

My machine is Apple PowerMac 7600 with 604e/225MHz and 128MB RAM.


Takashi Oe

---838631075-1679362092-920358837=:624
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="init.c.diff"
Content-ID: <Pine.LNX.3.96LJ1.1b7.990302011357.624B@selq119.unl.edu>
Content-Description: 
Content-Transfer-Encoding: BASE64

LS0tIGxpbnV4L2FyY2gvcHBjL21tL2luaXQuYy5PUklHCVN1biBGZWIgMjgg
MTc6NTk6NTkgMTk5OQ0KKysrIGxpbnV4L2FyY2gvcHBjL21tL2luaXQuYwlU
dWUgTWFyICAyIDAwOjIzOjIwIDE5OTkNCkBAIC0zMzgsMzUgKzMzOCw0NSBA
QA0KIAkgKi8NCiAJcCA9IGFkZHIgJiBQQUdFX01BU0s7DQogCXNpemUgPSBQ
QUdFX0FMSUdOKGFkZHIgKyBzaXplKSAtIHA7DQotCWlmIChzaXplID09IDAp
DQorCWlmIChzaXplID09IDAgfHwgc2l6ZSA+PSBzaXplICsgcCkNCiAJCXJl
dHVybiBOVUxMOw0KIA0KKwlpZiAoKGZsYWdzICYgX1BBR0VfUFJFU0VOVCkg
PT0gMCkNCisJCWZsYWdzIHw9IHBncHJvdF92YWwoUEFHRV9LRVJORUwpOw0K
KwlpZiAoZmxhZ3MgJiAoX1BBR0VfTk9fQ0FDSEUgfCBfUEFHRV9XUklURVRI
UlUpKQ0KKwkJZmxhZ3MgfD0gX1BBR0VfR1VBUkRFRDsNCisNCiAJaWYgKG1l
bV9pbml0X2RvbmUpIHsNCiAJCXN0cnVjdCB2bV9zdHJ1Y3QgKmFyZWE7DQog
CQlhcmVhID0gZ2V0X3ZtX2FyZWEoc2l6ZSk7DQogCQlpZiAoYXJlYSA9PSAw
KQ0KIAkJCXJldHVybiBOVUxMOw0KIAkJdiA9IFZNQUxMT0NfVk1BRERSKGFy
ZWEtPmFkZHIpOw0KKwkJZm9yIChpID0gMDsgaSA8IHNpemU7IGkgKz0gUEFH
RV9TSVpFKSB7DQorCQkJaWYocmVtYXBfcGFnZV9yYW5nZSh2K2ksIHAraSwg
UEFHRV9TSVpFLCBfX3BncHJvdChmbGFncykpKSB7DQorCQkJCXZmcmVlKGFy
ZWEtPmFkZHIpOw0KKwkJCQlyZXR1cm4gTlVMTDsNCisJCQl9DQorCQl9DQog
CX0gZWxzZSB7DQogCQlpZiAocCA+PSBpb3JlbWFwX2Jhc2UpDQogCQkJdiA9
IHA7DQogCQllbHNlDQogCQkJdiA9IChpb3JlbWFwX2JvdCAtPSBzaXplKTsN
Ci0JfQ0KLQ0KLQlpZiAoKGZsYWdzICYgX1BBR0VfUFJFU0VOVCkgPT0gMCkN
Ci0JCWZsYWdzIHw9IHBncHJvdF92YWwoUEFHRV9LRVJORUwpOw0KLQlpZiAo
ZmxhZ3MgJiAoX1BBR0VfTk9fQ0FDSEUgfCBfUEFHRV9XUklURVRIUlUpKQ0K
LQkJZmxhZ3MgfD0gX1BBR0VfR1VBUkRFRDsNCi0JZm9yIChpID0gMDsgaSA8
IHNpemU7IGkgKz0gUEFHRV9TSVpFKQ0KLQkJbWFwX3BhZ2UoJmluaXRfdGFz
aywgditpLCBwK2ksIGZsYWdzKTsNCiANCisJCWZvciAoaSA9IDA7IGkgPCBz
aXplOyBpICs9IFBBR0VfU0laRSkNCisJCQltYXBfcGFnZSgmaW5pdF90YXNr
LCB2K2ksIHAraSwgZmxhZ3MpOw0KKwl9DQogCXJldHVybiAodm9pZCAqKSAo
diArIChhZGRyICYgflBBR0VfTUFTSykpOw0KIH0NCiANCiB2b2lkIGlvdW5t
YXAodm9pZCAqYWRkcikNCiB7DQotCS8qIFhYWCB0b2RvICovDQorCXVuc2ln
bmVkIGxvbmcgdiA9ICh1bnNpZ25lZCBsb25nKWFkZHIgJiBQQUdFX01BU0s7
DQorDQorCWlmKHYgPT0gaW9wYSh2KSB8fCB2IDwgaW9yZW1hcF9iYXNlKQ0K
KwkJcmV0dXJuOw0KKwl2ZnJlZSgodm9pZCAqKXYpOw0KIH0NCiANCiB1bnNp
Z25lZCBsb25nIGlvcGEodW5zaWduZWQgbG9uZyBhZGRyKQ0K
---838631075-1679362092-920358837=:624--

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
