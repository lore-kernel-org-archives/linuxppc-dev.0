Mime-Version: 1.0
Message-Id: <v04220801b568cc2210b4@[129.105.9.193]>
Date: Sun, 11 Jun 2000 00:03:26 -0500
To: linuxppc-dev@lists.linuxppc.org
From: Geoff Hutchison <ghutchis@wso.williams.edu>
Subject: Possible gcc bug?
Content-Type: multipart/mixed; boundary="============_-1251422681==_============"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--============_-1251422681==_============
Content-Type: text/plain; charset="us-ascii" ; format="flowed"


Before I send this message off to gcc-bugs, I wanted to check with
the list to see if it's a problem with the particular gcc RPM I'm
using (Franz's latest of gcc-2.95.3-2a.src.rpm). I also need to pare
the code down a bit more to see if I can come up with a smaller
testcase.

       When compiled with optimization, x and y loops run correctly
           gcc -O -o loop-bug loop-bug.c -lm
       When compiled WITHOUT optimization, x and y loops run incorrectly
           gcc -o loop-bug loop-bug.c -lm

Here's the problem. I'm doing some numerical calculations and main
loop isn't being executed! It seems like something is clobbering one
of my const declarations internally. There are other strange problems
with other parts of my original code when optimization is turned on,
but I'd rather one step at a time.

If I'm being a complete moron and doing something silly, please let
me know and I'll eat my words.

Thanks,

--============_-1251422681==_============
Content-Id: <v04220801b568cc2210b4@[129.105.9.193].0.0>
Content-Type: multipart/appledouble; boundary="============_-1251422681==_D============"

--============_-1251422681==_D============
Content-Type: application/applefile; name="%loop-bug.c"
Content-Disposition: attachment; filename="%loop-bug.c"
 ; modification-date="Sun, 11 Jun 2000 00:03:07 -0500"
Content-Transfer-Encoding: base64

AAUWBwACAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAADAAAASgAAAAoAAAAJAAAAVAAAACAA
AAAIAAAAdAAAABAAAAACAAAAhAAAAX5sb29wLWJ1Zy5jVEVYVEFMRkEBAAA1AI0AAAAA
AAAAAAAAAAAAAAAAAAAA1X78ANWTu0ttDAAA1ZPXAAABAAAAAUwAAABMAAAAMsDAwMDA
wMDAwMDJwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMnJycnJycDAwMnAwMDAwMDAwMDAwMDA
wMDAwMDAwMnJwMDAwMDAycDAycDAwMDAwMDAwMDAwMDAwMDAwMnJwMDAwMDAwMDJycnA
wMDAwMDAwMDAwMDAwMDAwMnJwMDAwMDAwMDJycnJwMDAwMDAwMDAwMDAwMDAwMnJwMDA
wMDAwMDAycDJycnAwMDAwMDAwMDAwMDAwMnJwMDAwMDAwMDAwMDAycDAycnAwMDAwMDA
wMDAwMnJwMDAwMDAwMDAwMDAwMDAwMDJycDAwMDAwAAAAEgACU1vbmFjbwCZIAAAACHK
A4nbkAO4YIAiAASIA4KtxP/8AAgACAAoAAIC6wIAACgAAgLrAgC1aIe8AAABkQAAAZEA
AAAAAQAAAAEAAAABTAAAAEwAAAAyA4AZKCHKAAAAHAAyAABNUFNSAAAACgPt//8AAAAA
A5j4cA==
--============_-1251422681==_D============
Content-Type: application/octet-stream; name="loop-bug.c"
Content-Disposition: attachment; filename="loop-bug.c"
Content-Transfer-Encoding: base64

Ci8qCiAgICAgIFRlc3QgcHJvZ3JhbSB0byBleHBvc2UgbG9vcCBidWcgaW4gZ2NjCiAg
ICAgICAgIFRlc3RlZCBvbiBwcGMtdW5rbm93bi1saW51eC1nbnUgdy8KCSAgIGdjYyB2
ZXJzaW9uIDIuOTUuMyAxOTk5MTAzMCAocHJlcmVsZWFzZS9mcmFuem8pCgkgICAoIGdj
Yy0yLjk1LjMtMmEuc3JjLnJwbSApCiAgICAgIEFsc28gc2VlbXMgdG8gaGF2ZSBwcm9i
bGVtcyBvbiBJUklYIDYuNSB3L2djYy0yLjguMQogICAgICAKICAgICAgV2hlbiBjb21w
aWxlZCB3aXRoIG9wdGltaXphdGlvbiwgeCBhbmQgeSBsb29wcyBydW4gY29ycmVjdGx5
CiAgICAgICAgICBnY2MgLU8gLW8gbG9vcC1idWcgbG9vcC1idWcuYyAtbG0KICAgICAg
V2hlbiBjb21waWxlZCBXSVRIT1VUIG9wdGltaXphdGlvbiwgeCBhbmQgeSBsb29wcyBy
dW4gaW5jb3JyZWN0bHkKICAgICAgICAgIGdjYyAtbyBsb29wLWJ1ZyBsb29wLWJ1Zy5j
IC1sbQoKICAgICAgYnkgR2VvZmYgSHV0Y2hpc29uIDxnaHV0Y2hpc0B3c28ud2lsbGlh
bXMuZWR1PgoKICAgICAgb3JpZ2luYWxseSBpbnRlbmRlZCB0byBudW1lcmljYWxseSBl
c3RpbWF0ZSBlbGVjdHJpYyBmaWVsZHMgYWNyb3NzIGEgc3VyZmFjZQoKICAgICAgKi8K
CiNpbmNsdWRlIDxzdGRpby5oPgojaW5jbHVkZSA8c3RkbGliLmg+CiNpbmNsdWRlIDx0
aW1lLmg+CiNpbmNsdWRlIDxtYXRoLmg+CgppbnQgbWFpbigpCnsKCiAgLyogU2l6ZSBv
ZiB0aGUgZ3JpZCAqLwogIGNvbnN0IGRvdWJsZSBncmlkID0gMjAwLjA7CiAgY29uc3Qg
aW50IG1heFggPSBncmlkIC8gKDIuMCAqIDIuMjk1KTsKICBjb25zdCBpbnQgbWF4WSA9
IG1heFg7CiAgY29uc3QgaW50IGxvb3BYID0gbWF4WCAtIDE7CiAgY29uc3QgaW50IGxv
b3BZID0gbWF4WSAtIDE7CiAgY29uc3QgaW50IG1heFB0cyA9IG1heFgqbWF4WTsKICBj
b25zdCBpbnQgbG9vcFB0cyA9IG1heFB0cyAtIDE7CiAgY29uc3QgaW50IHNodWZmbGVz
ID0gbWF4UHRzICogMzsKCiAgaW50IGNvdW50LCB4LCB5OwogIGRvdWJsZSByLCB0b3Rh
bCA9IDAuMDsKICBkb3VibGUgZmllbGRbbG9vcFhdW2xvb3BZXTsKICBzdHJ1Y3QgcG9p
bnQgewogICAgaW50IHB0WDsKICAgIGludCBwdFk7CiAgfSBwb2ludHNbbG9vcFB0c107
CiAgaW50IHRlbXB4LCB0ZW1weSwgcmFuZDEsIHJhbmQyOwoKICBzcmFuZCh0aW1lKDAp
KTsKCiAgLyogSW5pdGlhbGl6ZSBhcnJheXMgKi8KICBmb3IgKHggPSAwOyB4IDw9IGxv
b3BYOyB4KyspCiAgICBmb3IgKHkgPSAwOyB5IDw9IGxvb3BZOyB5KyspCiAgICAgIHsK
CWZpZWxkW3hdW3ldID0gMC4wOwoJcG9pbnRzW21heFggKiB4ICsgeV0ucHRYID0geDsK
CXBvaW50c1ttYXhYICogeCArIHldLnB0WSA9IHk7CiAgICAgIH0KCiAgLyogU2h1ZmZs
ZSBwb2ludHMgYXJyYXkgKi8KICBmb3IgKGNvdW50ID0gMDsgY291bnQgPD0gc2h1ZmZs
ZXM7IGNvdW50KyspCiAgICB7CiAgICAgIHJhbmQxID0gcmFuZCgpICUgbWF4UHRzOwog
ICAgICByYW5kMiA9IHJhbmQoKSAlIG1heFB0czsKICAgICAgdGVtcHggPSBwb2ludHNb
cmFuZDFdLnB0WDsKICAgICAgdGVtcHkgPSBwb2ludHNbcmFuZDFdLnB0WTsKICAgICAg
cG9pbnRzW3JhbmQxXS5wdFggPSBwb2ludHNbcmFuZDJdLnB0WDsKICAgICAgcG9pbnRz
W3JhbmQxXS5wdFkgPSBwb2ludHNbcmFuZDJdLnB0WTsKICAgICAgcG9pbnRzW3JhbmQy
XS5wdFggPSB0ZW1weDsKICAgICAgcG9pbnRzW3JhbmQyXS5wdFkgPSB0ZW1weTsKICAg
IH0KCiAgLyogTWFpbiBsb29wLiBBZGQgYW5vdGhlciBwb2ludCBhbmQgcmVjYWxjdWxh
dGUgZmllbGQgKi8KICBmb3IgKGNvdW50ID0gMDsgY291bnQgPD0gbG9vcFB0czsgY291
bnQrKykKICAgIHsKICAgICAgdG90YWwgPSAwLjA7CiAgICAgIGZvciAoeCA9IDA7IHgg
PD0gbG9vcFg7IHgrKykKCWZvciAoeSA9IDA7IHkgPD0gbG9vcFk7IHkrKykKCSAgewoJ
ICAgIHByaW50ZigiJWRcdCVkXG4iLCB4LCB5KTsKCSAgfQogICAgfQoKICByZXR1cm4g
MDsKfQo=
--============_-1251422681==_D============--

--============_-1251422681==_============
Content-Type: text/plain; charset="us-ascii" ; format="flowed"

--
-Geoff Hutchison
Williams Students Online
http://wso.williams.edu/
--============_-1251422681==_============--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
