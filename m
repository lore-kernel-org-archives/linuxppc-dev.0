From: kd@flaga.is
Subject: Re: fadsrom -> mkrombin
To: Ruedi.Hofer@ascom.ch
Cc: linuxppc-embedded@lists.linuxppc.org
Message-ID: <OFB22742F9.4454D8A1-ON00256842.00482140@flaga.is>
Date: Thu, 9 Dec 1999 13:42:07 +0000
MIME-Version: 1.0
Content-type: multipart/mixed;
	Boundary="0__=lNpSlWYk1NywnrhxVzG7IDTfv20qsudhZsduwNiQM1c0KPExs3avQfTC"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--0__=lNpSlWYk1NywnrhxVzG7IDTfv20qsudhZsduwNiQM1c0KPExs3avQfTC
Content-type: text/plain; charset=us-ascii


Yes thats correct I had to change mkrombin tooo.

Here is my diffs.

(See attached file: mkrombin.diff)
K.D.



                                                                                                                                                    
                    Ruedi.Hofer@ascom.ch                                                                                                            
                    Sent by:                                To:     linuxppc-embedded@lists.linuxppc.org                                            
                    owner-linuxppc-embedded@lists.li        cc:                                                                                     
                    nuxppc.org                              Subject:     fadsrom -> mkrombin                                                        
                                                                                                                                                    
                                                                                                                                                    
                    12/09/99 10:06 AM                                                                                                               
                                                                                                                                                    
                                                                                                                                                    




After some little changes I'm now able to compile fadsrom.

(I had to define __fswab16, __fswab32 and ffz)



Next problem: mkrombin doesn't work. It fails with an output message of

"something wrong with file fadsrom" in line 63

I compiled mkrombin with debug options and had a look why it fails.

It expects a value of 2 for nscns but it gets:

(gdb) print nscns
$3 = 512
(gdb)

whereas nscns is basically a copy of ehp->e_phnum

(gdb) print *ehp
$1 = {e_ident = "\177ELF\001\002\001\000\000\000\000\000\000\000\000",
e_type = 512, e_machine = 5120, e_version = 16777216, e_entry = 254,
e_phoff = 872415232, e_shoff = 3837985280, e_flags = 0, e_ehsize = 13312,
e_phentsize = 8192, e_phnum = 512, e_shentsize = 10240, e_shnum = 2560,
e_shstrndx = 1792}
(gdb)



Any ideas? Is cross-"mkrombin" a problem? (We develop on Intel)

Ruedi




--0__=lNpSlWYk1NywnrhxVzG7IDTfv20qsudhZsduwNiQM1c0KPExs3avQfTC
Content-type: application/octet-stream;
	name="mkrombin.diff"
Content-Disposition: attachment; filename="mkrombin.diff"
Content-Transfer-Encoding: base64

LS0tIGZhZHNyb20vbWtyb21iaW4uYwlXZWQgTm92IDE4IDA2OjQzOjM5IDE5OTgKKysrIGZhZHNy
b21fY3VycmVudC9ta3JvbWJpbi5jCVR1ZSBNYXkgIDQgMTQ6NTg6MTIgMTk5OQpAQCAtMTAsNiAr
MTAsOSBAQAogICogV2Ugc3RyaXAgdGhlIGhlYWRlciwgcGxhY2UgdGhlIGNvZGUgZmlyc3QsIGFu
ZCBtb3ZlIHRoZSBkYXRhIHRvCiAgKiBhIDRLIHBhZ2UgYm91bmRhcnkgZm9sbG93aW5nIHRoZSBj
b2RlLgogICovCisNCisNCisjaW5jbHVkZSAiYnl0ZWNvbnYuaCINCiAjaW5jbHVkZSA8c3lzL3R5
cGVzLmg+CiAjaW5jbHVkZSA8ZmNudGwuaD4KICNpbmNsdWRlIDxzdHJpbmcuaD4KQEAgLTUwLDMx
ICs1Myw0MiBAQAogCQlleGl0KDIpOwogCX0KIAllaHAgPSAoRWxmMzJfRWhkciAqKSBpYnVmOwor
I2lmZGVmIF9ERUJVRw0KKwlmcHJpbnRmKHN0ZG91dCwiaWJ1ZiA9ICV1LCBlaHAgPSAldSAiLCBp
YnVmLCBlaHApOw0KKyNlbmRpZg0KIAogCWlmIChzdHJuY21wKGVocC0+ZV9pZGVudCwgRUxGTUFH
LCA0KSAhPSAwKSB7CiAJCWZwcmludGYoc3RkZXJyLCAiJXMgZG9lc24ndCBsb29rIGxpa2UgRUxG
XG4iLCBhcmd2WzFdKTsKIAkJZXhpdCgyKTsKIAl9CiAKLQluc2NucyA9IGVocC0+ZV9waG51bTsK
LQllcHAgPSAoRWxmMzJfUGhkciAqKSgodWludCllaHAgKyBlaHAtPmVfcGhvZmYpOworCW5zY25z
ID0gQ1RPSFMoZWhwLT5lX3BobnVtKTsNCisJZXBwID0gKEVsZjMyX1BoZHIgKikoKHVpbnQpZWhw
ICsgQ1RPSEwoZWhwLT5lX3Bob2ZmKSk7DQorI2lmZGVmIF9ERUJVRw0KKwlmcHJpbnRmKHN0ZG91
dCwibnNjc24gPSAlaSwgZV9waG9mZiA9ICVpXG4iLCBuc2NucywgQ1RPSEwoZWhwLT5lX3Bob2Zm
KSk7DQorI2VuZGlmDQogCiAJaWYgKG5zY25zICE9IDIpIHsKLQkJZnByaW50ZihzdGRlcnIsICJz
b21ldGhpbmcgd3Jvbmcgd2l0aCBmaWxlICVzXG4iLCBhcmd2WzFdKTsKLQkJZXhpdCgyKTsKKwkJ
ZnByaW50ZihzdGRlcnIsICIxc29tZXRoaW5nIHdyb25nIHdpdGggZmlsZSAlc1xuIiwgYXJndlsx
XSk7DQorCS8vCWV4aXQoMik7DQogCX0KIAogCS8qIEdldCB0aGUgZGF0YSBwb3J0aW9uLgogCSov
Ci0JaWYgKChlcHAtPnBfdHlwZSAhPSBQVF9MT0FEKSB8fCAoZXBwLT5wX29mZnNldCAhPSAweDEw
MDAwKSkgewotCQlmcHJpbnRmKHN0ZGVyciwgInNvbWV0aGluZyB3cm9uZyB3aXRoIGZpbGUgJXNc
biIsIGFyZ3ZbMV0pOworI2lmZGVmIF9ERUJVRw0KKwlmcHJpbnRmKHN0ZG91dCwgInBfdHlwZSA9
ICVpLCBwX29mZnNldCA9ICVpXG4iLA0KKwkJCQlDVE9ITChlcHAtPnBfdHlwZSksQ1RPSEwoZXBw
LT5wX29mZnNldCkpOw0KKyNlbmRpZg0KKwlpZiAoKENUT0hMKGVwcC0+cF90eXBlKSAhPSBQVF9M
T0FEKSB8fA0KKwkJCQkoQ1RPSEwoZXBwLT5wX29mZnNldCkgIT0gMHgxMDAwMCkpIHsNCisJCWZw
cmludGYoc3RkZXJyLCAiMnNvbWV0aGluZyB3cm9uZyB3aXRoIGZpbGUgJXNcbiIsIGFyZ3ZbMV0p
Ow0KIAkJZXhpdCgyKTsKIAl9Ci0JZHNpemUgPSBlcHAtPnBfZmlsZXN6OworCWRzaXplID0gQ1RP
SEwoZXBwLT5wX2ZpbGVzeik7DQogCi0jaWYgMAotCXByaW50ZigiICVkICVkICVkICVkXG4iLCBl
cHAtPnBfdHlwZSwgZXBwLT5wX29mZnNldCwgZXBwLT5wX2ZpbGVzeiwKLQkJZXBwLT5wX21lbXN6
KTsKKyNpZiBfREVCVUcNCisJcHJpbnRmKCIgJWQgJWQgJWQgJWRcbiIsIENUT0hMKGVwcC0+cF90
eXBlKSwgQ1RPSEwoZXBwLT5wX29mZnNldCksDQorCQkJQ1RPSEwoZXBwLT5wX2ZpbGVzeiksIENU
T0hMKGVwcC0+cF9tZW1zeikpOw0KICNlbmRpZgogCWlmIChyZWFkKGVsZl9mZCwgZGJ1Ziwgc2l6
ZW9mKGRidWYpKSAhPSBzaXplb2YoZGJ1ZikpIHsKIAkJZnByaW50ZihzdGRlcnIsICIlcyBkb2Vz
bid0IGxvb2sgbGlrZSBFTEZcbiIsIGFyZ3ZbMV0pOwpAQCAtODQsMTYgKzk4LDE3IEBACiAJLyog
R2V0IHRoZSBpbnN0cnVjdGlvbiBwb3J0aW9uLgogCSovCiAJZXBwKys7Ci0JaWYgKChlcHAtPnBf
dHlwZSAhPSBQVF9MT0FEKSB8fCAoZXBwLT5wX29mZnNldCAhPSAweDIwMDAwKSB8fAotCQkoZXBw
LT5wX2ZpbGVzeiAhPSBlcHAtPnBfbWVtc3opKSB7Ci0JCWZwcmludGYoc3RkZXJyLCAic29tZXRo
aW5nIHdyb25nIHdpdGggZmlsZSAlc1xuIiwgYXJndlsxXSk7CisJaWYgKChDVE9ITChlcHAtPnBf
dHlwZSkgIT0gUFRfTE9BRCkgfHwNCisJCQkoQ1RPSEwoZXBwLT5wX29mZnNldCkgIT0gMHgyMDAw
MCkgfHwNCisJCQkoQ1RPSEwoZXBwLT5wX2ZpbGVzeikgIT0gQ1RPSEwoZXBwLT5wX21lbXN6KSkp
IHsNCisJCWZwcmludGYoc3RkZXJyLCAiM3NvbWV0aGluZyB3cm9uZyB3aXRoIGZpbGUgJXNcbiIs
IGFyZ3ZbMV0pOw0KIAkJZXhpdCgyKTsKIAl9CiAjaWYgMAotCXByaW50ZigiICVkICVkICVkICVk
XG4iLCBlcHAtPnBfdHlwZSwgZXBwLT5wX29mZnNldCwgZXBwLT5wX2ZpbGVzeiwKLQkJZXBwLT5w
X21lbXN6KTsKKwlwcmludGYoIiAlZCAlZCAlZCAlZFxuIiwgQ1RPSEwoZXBwLT5wX3R5cGUpLCBD
VE9ITChlcHAtPnBfb2Zmc2V0KSwgDQorCQkJQ1RPSEwoZXBwLT5wX2ZpbGVzeiksIENUT0hMKGVw
cC0+cF9tZW1zeikpOw0KICNlbmRpZgotCXNpemUgPSBlcHAtPnBfZmlsZXN6OworCXNpemUgPSBD
VE9ITChlcHAtPnBfZmlsZXN6KTsNCiAJaWYgKHJlYWQoZWxmX2ZkLCBpYnVmLCBzaXplKSAhPSBz
aXplKSB7CiAJCWZwcmludGYoc3RkZXJyLCAiJXMgZG9lc24ndCBsb29rIGxpa2UgRUxGXG4iLCBh
cmd2WzFdKTsKIAkJZXhpdCgyKTsK

--0__=lNpSlWYk1NywnrhxVzG7IDTfv20qsudhZsduwNiQM1c0KPExs3avQfTC--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
