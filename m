Message-ID: <408E0DFE.9000302@siemens.com>
Date: Tue, 27 Apr 2004 09:38:38 +0200
From: Steffen Rumler <Steffen.Rumler@siemens.com>
MIME-Version: 1.0
To: linuxppc <linuxppc-embedded@lists.linuxppc.org>
Subject: Debugging deadlocks using SV semaphores via PROC FS
Content-Type: multipart/mixed;
 boundary="------------060706000701040404050100"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------060706000701040404050100
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I have extended the PROC FS entry in ipc/sem.c for the 2.4.20 DEVEL
in order to debug deadlock problems; see attachment.

For each semaphore array, now also all array elements: (last-pid, sem.-value)
will be traced.

In this way, I can easy answer the question:

     "Which process is holding a distinct semaphore in a permanent way ?"

An subsequent strace of the found process provides additional information.



Steffen

--


--------------------------------------------------------------

Steffen Rumler
ICN CP D NT SW 3
Siemens AG
Hofmannstr. 51                 Email: Steffen.Rumler@siemens.com
D-81359 Munich                 Phone: +49 89 722-44061
Germany                        Fax  : +49 89 722-36703

--------------------------------------------------------------





--------------060706000701040404050100
Content-Type: text/plain;
 name="sem.c"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="sem.c"

c3RhdGljIGludCBzeXN2aXBjX3NlbV9yZWFkX3Byb2MoY2hhciAqYnVmZmVyLCBjaGFyICoq
c3RhcnQsIG9mZl90IG9mZnNldCwgaW50IGxlbmd0aCwgaW50ICplb2YsIHZvaWQgKmRhdGEp
CnsKCW9mZl90IHBvcyA9IDA7CglvZmZfdCBiZWdpbiA9IDA7CglpbnQgaSwgbGVuID0gMDsK
ICAgICAgICBpbnQgajsKICAgICAgICBzdHJ1Y3Qgc2VtICpzZW1fYmFzZTsKCglsZW4gKz0g
c3ByaW50ZihidWZmZXIsICIgICAgICAga2V5ICAgICAgc2VtaWQgcGVybXMgICAgICBuc2Vt
cyAgIHVpZCAgIGdpZCAgY3VpZCAgY2dpZCAgICAgIG90aW1lICAgICAgY3RpbWVcbiIpOwoJ
ZG93bigmc2VtX2lkcy5zZW0pOwoKCWZvcihpID0gMDsgaSA8PSBzZW1faWRzLm1heF9pZDsg
aSsrKSB7CgkJc3RydWN0IHNlbV9hcnJheSAqc21hOwoJCXNtYSA9IHNlbV9sb2NrKGkpOwoJ
CWlmKHNtYSkgewoJCQlsZW4gKz0gc3ByaW50ZihidWZmZXIgKyBsZW4sICJcbiUxMGQgJTEw
ZCAgJTRvICUxMGx1ICU1dSAlNXUgJTV1ICU1dSAlMTBsdSAlMTBsdVxuIiwKCQkJCXNtYS0+
c2VtX3Blcm0ua2V5LAoJCQkJc2VtX2J1aWxkaWQoaSxzbWEtPnNlbV9wZXJtLnNlcSksCgkJ
CQlzbWEtPnNlbV9wZXJtLm1vZGUsCgkJCQlzbWEtPnNlbV9uc2VtcywKCQkJCXNtYS0+c2Vt
X3Blcm0udWlkLAoJCQkJc21hLT5zZW1fcGVybS5naWQsCgkJCQlzbWEtPnNlbV9wZXJtLmN1
aWQsCgkJCQlzbWEtPnNlbV9wZXJtLmNnaWQsCgkJCQlzbWEtPnNlbV9vdGltZSwKCQkJCXNt
YS0+c2VtX2N0aW1lKTsKCgkJCXBvcyArPSBsZW47CgkJCWlmKHBvcyA8IG9mZnNldCkgewoJ
CQkJbGVuID0gMDsKCSAgICAJCQliZWdpbiA9IHBvczsKCQkJfQoJCQlpZihwb3MgPiBvZmZz
ZXQgKyBsZW5ndGgpewogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNlbV91bmxv
Y2soaSk7CgkJCQlnb3RvIGRvbmU7CiAgICAgICAgICAgICAgICAgICAgICAgIH0KCiAgICAg
ICAgICAgICAgICAgICAgICAgIC8qICBTLlIuOiAgcHJpbnQtb3V0IChwaWQsIHZhbCkgcGFp
cnMgZm9yIHNlbWFwaG9yZSBhcnJheQogICAgICAgICAgICAgICAgICAgICAgICAgKi8KICAg
ICAgICAgICAgICAgICAgICAgICAgc2VtX2Jhc2UgPSBzbWEtPnNlbV9iYXNlOwogICAgICAg
ICAgICAgICAgICAgICAgICBmb3Ioaj0wOyBqIDwgc21hLT5zZW1fbnNlbXM7IGorKyl7Cgog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgbGVuICs9IHNwcmludGYoYnVmZmVyICsgbGVu
LCAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICIgICAgICAg
ICAgICAgICAlbGQgKHBpZCkgICVsZCAodmFsKVxuIiwgCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAoc2VtX2Jhc2UtPnNlbXBpZCkgJiAweGZmZmYsIAog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2VtX2Jhc2UtPnNl
bXZhbCk7CgogICAgICAgICAgICAgICAgICAgICAgICAgICAgcG9zICs9IGxlbjsKICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGlmKHBvcyA8IG9mZnNldCkgewogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGxlbiA9IDA7CiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgYmVnaW4gPSBwb3M7CiAgICAgICAgICAgICAgICAgICAgICAgICAgICB9CiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBpZihwb3MgPiBvZmZzZXQgKyBsZW5ndGgpewogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNlbV91bmxvY2soaSk7CiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgZ290byBkb25lOwogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfQoKICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNlbV9iYXNlKys7CiAgICAg
ICAgICAgICAgICAgICAgICAgIH0gCiAgICAgICAgICAgICAgICAgICAgICAgIHNlbV91bmxv
Y2soaSk7CgkJfQoJfQoJKmVvZiA9IDE7CmRvbmU6Cgl1cCgmc2VtX2lkcy5zZW0pOwoJKnN0
YXJ0ID0gYnVmZmVyICsgKG9mZnNldCAtIGJlZ2luKTsKCWxlbiAtPSAob2Zmc2V0IC0gYmVn
aW4pOwoJaWYobGVuID4gbGVuZ3RoKQoJCWxlbiA9IGxlbmd0aDsKCWlmKGxlbiA8IDApCgkJ
bGVuID0gMDsKCXJldHVybiBsZW47Cn0K
--------------060706000701040404050100--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
