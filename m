Return-Path: <daniel.schnell@marel.com>
Received: from mail.marel.com (mail.marel.is [213.167.134.96])
	by ozlabs.org (Postfix) with ESMTP id 45DD2DDEC9
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 May 2007 21:22:27 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C796E3.50605D29"
Subject: MPC5200B memory performance
Date: Tue, 15 May 2007 11:22:24 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB01EB1FEF@is-hdq-exchange.marel.net>
From: "Daniel Schnell" <daniel.schnell@marel.com>
To: <linuxppc-embedded@ozlabs.org>
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

------_=_NextPart_001_01C796E3.50605D29
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,


I am doing some memory performance measurements on our custom MPC5200B
board which runs on 396 MHz internally and is connected to DDR RAM. The
RAM is driven with 132 MHz.

With the attached program (compile with -lrt) I am testing the memcpy()
throughput. In theory the memory throughput should be the double of the
memcpy() throughput if source and destination buffers are same size and
inside the DDR-RAM.

So one could make the simple calculation:

132 MHz * 32 Bit (address width) * 2 (DDR) ~ 1GBytes/sec brutto memory
throughput.

For a memcpy this should be then ~500MB/second.

Of course in real world scenarios we cannot reach the theoretical limit,
but be about 30 % near I guess.


I get the following values on my board:

bash-2.05b# ./memcpy_perf
Test (10000) memcpy of sizes (1024) ....
10000 memcpy. Time per memcpy: 1567 [nsec] (653 MB/sec)
 finished.
Test (10000) memcpy of sizes (2048) ....
10000 memcpy. Time per memcpy: 2939 [nsec] (696 MB/sec)
 finished.
Test (10000) memcpy of sizes (4096) ....
10000 memcpy. Time per memcpy: 5706 [nsec] (717 MB/sec)
 finished.
Test (10000) memcpy of sizes (8192) ....
10000 memcpy. Time per memcpy: 17077 [nsec] (479 MB/sec)
 finished.
Test (10000) memcpy of sizes (16384) ....
10000 memcpy. Time per memcpy: 133314 [nsec] (122 MB/sec)
 finished.
Test (1000) memcpy of sizes (32768) ....
1000 memcpy. Time per memcpy: 243417 [nsec] (134 MB/sec)
 finished.
Test (1000) memcpy of sizes (51200) ....
1000 memcpy. Time per memcpy: 403455 [nsec] (126 MB/sec)
 finished.
Test (1000) memcpy of sizes (102400) ....
1000 memcpy. Time per memcpy: 713316 [nsec] (143 MB/sec)
 finished.
Test (100) memcpy of sizes (1048576) ....
100 memcpy. Time per memcpy: 7210570 [nsec] (145 MB/sec)
 finished.
Test (10) memcpy of sizes (10485760) ....
10 memcpy. Time per memcpy: 78162400 [nsec] (134 MB/sec)
 finished.
Test (5) memcpy of sizes (52428800) ....
5 memcpy. Time per memcpy: 425281800 [nsec] (123 MB/sec)
 finished.



The first 4 values are because of the data cache. So here we are testing
cache performance. All other values will test the memory controller
interface.

All in all, I am not sure, why the memory access is so much slower than
I expected.
Which factors did I miss in my calculation ? Can anybody run this
program on its 5200B based board as a comparision ?


Best regards,

Daniel Schnell.

------_=_NextPart_001_01C796E3.50605D29
Content-Type: application/octet-stream;
	name="memcpy_perf.c"
Content-Transfer-Encoding: base64
Content-Description: memcpy_perf.c
Content-Disposition: attachment;
	filename="memcpy_perf.c"

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRsaWIuaD4KI2luY2x1ZGUgPHN5cy90aW1l
Lmg+CiNpbmNsdWRlIDxwdGhyZWFkLmg+CgppbnQgb3NhX25vd190aW1lc3BlYyhzdHJ1Y3QgdGlt
ZXNwZWMqIHQpCnsKCXJldHVybiBjbG9ja19nZXR0aW1lIChDTE9DS19SRUFMVElNRSwgdCk7Cn0K
CgppbnQgb3NhX3RpbWVkaWZmKGNvbnN0IHN0cnVjdCB0aW1lc3BlYyogdDEsIGNvbnN0IHN0cnVj
dCB0aW1lc3BlYyogdDIsIHN0cnVjdCB0aW1lc3BlYyogZGlmZikKewoJaWYgKHQxIT1OVUxMICYm
IHQyIT1OVUxMICYmIGRpZmYhPU5VTEwpCgl7CgkJdW5zaWduZWQgbG9uZyBsb25nIGFfbnNlYywg
Yl9uc2VjLCBkaWZmX25zZWM7IAoKCQkvLyBjYWxjdWxhdGUgZGlmZmVyZW5jZSB0aW1lCgkJYV9u
c2VjID0gdDEtPnR2X3NlYyoxMDAwMDAwMDAwVUxMICsgdDEtPnR2X25zZWM7CgkJYl9uc2VjID0g
dDItPnR2X3NlYyoxMDAwMDAwMDAwVUxMICsgdDItPnR2X25zZWM7CgkJZGlmZl9uc2VjID0gYl9u
c2VjIC0gYV9uc2VjOwoJCWRpZmYtPnR2X3NlYyA9ICBkaWZmX25zZWMvMTAwMDAwMDAwMFVMTDsK
CQlkaWZmLT50dl9uc2VjID0gZGlmZl9uc2VjJTEwMDAwMDAwMDBVTEw7CgkJcmV0dXJuIDA7Cgl9
CglyZXR1cm4gLTE7Cn0KCgp1bnNpZ25lZCBsb25nIGxvbmcgb3NhX3RvX25zKGNvbnN0IHN0cnVj
dCB0aW1lc3BlYyogdCkKewoJIHJldHVybiAodC0+dHZfc2VjKjEwMDAwMDAwMDBVTEwgKyB0LT50
dl9uc2VjKTsKfQoKCmludCB0ZXN0TWVtY3B5KHVuc2lnbmVkIGxvbmcgbnVtLCBzaXplX3QgbXNn
c2l6ZSkKewoJcHJpbnRmKCJUZXN0ICglbGQpIG1lbWNweSBvZiBzaXplcyAoJWxkKSAuLi4uXG4i
LAogICAgICAgICAgICBudW0sIG1zZ3NpemUpOwogICAgdW5zaWduZWQgbG9uZyBpOwogICAgdW5z
aWduZWQgbG9uZyBsb25nIG5zdGltZTsKICAgIHN0cnVjdCB0aW1lc3BlYyB0MSwgdDIsIHQzOwoK
ICAgIGNoYXIgKmJ1ZjE9bWFsbG9jIChtc2dzaXplKTsKICAgIGNoYXIgKmJ1ZjI9bWFsbG9jICht
c2dzaXplKTsKCiAgICAvLyBtZWFzdXJlCglvc2Ffbm93X3RpbWVzcGVjKCZ0MSk7CiAgICBmb3Ig
KGk9MDsgaTxudW07IGkrKykKICAgICAgICB7CiAgICAgICAgbWVtY3B5IChidWYxLCBidWYyLCBt
c2dzaXplKTsKICAgICAgICB9CiAgICAvLyBtZWFzdXJlCglvc2Ffbm93X3RpbWVzcGVjKCZ0Mik7
Cglvc2FfdGltZWRpZmYoJnQxLCAmdDIsICZ0Myk7CiAgICAKICAgIGZyZWUgKGJ1ZjIpOwogICAg
ZnJlZSAoYnVmMSk7CiAgICAKICAgIG5zdGltZSA9IG9zYV90b19ucygmdDMpLyh1bnNpZ25lZCBs
b25nIGxvbmcpIGk7CglwcmludGYoIiVsZCBtZW1jcHkuIFRpbWUgcGVyIG1lbWNweTogJWxsdSBb
bnNlY10gKCVsbHUgTUIvc2VjKVxuIiwKICAgICAgICAgICAgaSwgbnN0aW1lLAogICAgICAgICAg
ICAoMTAwMFVMTCAqICh1bnNpZ25lZCBsb25nIGxvbmcpIG1zZ3NpemUpLyhuc3RpbWUpKSA7CiAg
ICBmZmx1c2ggKHN0ZG91dCk7CgoKCXByaW50ZigiIGZpbmlzaGVkLlxuIik7CiAgICBmZmx1c2gg
KHN0ZG91dCk7Cn0KCgppbnQgbWFpbigpCnsKICAgIHRlc3RNZW1jcHkoMTAwMDAsICAgICAgMSox
MDI0KTsKICAgIHRlc3RNZW1jcHkoMTAwMDAsICAgICAgMioxMDI0KTsKICAgIHRlc3RNZW1jcHko
MTAwMDAsICAgICAgNCoxMDI0KTsKICAgIHRlc3RNZW1jcHkoMTAwMDAsICAgICAgOCoxMDI0KTsK
ICAgIHRlc3RNZW1jcHkoMTAwMDAsICAgICAxNioxMDI0KTsKICAgIHRlc3RNZW1jcHkoMTAwMCAs
ICAgICAzMioxMDI0KTsKICAgIHRlc3RNZW1jcHkoMTAwMCAsICAgICA1MCoxMDI0KTsKICAgIHRl
c3RNZW1jcHkoMTAwMCAsICAgIDEwMCoxMDI0KTsKICAgIHRlc3RNZW1jcHkoIDEwMCAsICAgMTAy
NCoxMDI0KTsKICAgIHRlc3RNZW1jcHkoICAxMCAsMTAqMTAyNCoxMDI0KTsKICAgIHRlc3RNZW1j
cHkoICAgNSAsNTAqMTAyNCoxMDI0KTsKCiAgICByZXR1cm4gMDsKfQo=

------_=_NextPart_001_01C796E3.50605D29--
