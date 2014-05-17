Return-Path: <jeffbailey@google.com>
Received: from mail-qg0-x22a.google.com (mail-qg0-x22a.google.com
 [IPv6:2607:f8b0:400d:c04::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 316F91401FB
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 May 2014 01:05:49 +1000 (EST)
Received: by mail-qg0-f42.google.com with SMTP id q107so6251749qgd.1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 May 2014 08:05:44 -0700 (PDT)
MIME-Version: 1.0
From: Jeff Bailey <jeffbailey@google.com>
Date: Sat, 17 May 2014 15:05:43 +0000
Message-ID: <CAMai9+pd4krwCttqSACFvwghQd3i7VBFvXQSqBPaXZSO-ePEyw@mail.gmail.com>
Subject: [PATCH] powerpc: Clear ELF personality flag if ELFv2 is not requested.
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=001a11c0f6ee42ff7d04f999ddfa
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001a11c0f6ee42ff7d04f999ddfa
Content-Type: text/plain; charset=UTF-8

powerpc: Clear ELF personality flag if ELFv2 is not requested.

The POWER kernel uses a personality flag to determine whether it should
be setting up function descriptors or not (per the updated ABI).  This
flag wasn't being cleared on a new process but instead was being
inherited.  The visible effect was that an ELFv2 binary could not execve
to an ELFv1 binary.

Signed-off-by: Jeff Bailey <jeffbailey@google.com>

 arch/powerpc/include/asm/elf.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/include/asm/elf.h b/arch/powerpc/include/asm/elf.h
index 935b5e7..888d8f3 100644
--- a/arch/powerpc/include/asm/elf.h
+++ b/arch/powerpc/include/asm/elf.h
@@ -90,6 +90,8 @@ typedef elf_vrregset_t elf_fpxregset_t;
 do {                                                           \
        if (((ex).e_flags & 0x3) == 2)                          \
                set_thread_flag(TIF_ELF2ABI);                   \
+       else                                                    \
+               clear_thread_flag(TIF_ELF2ABI);                 \
        if ((ex).e_ident[EI_CLASS] == ELFCLASS32)               \
                set_thread_flag(TIF_32BIT);                     \
        else                                                    \

--001a11c0f6ee42ff7d04f999ddfa
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: base64

PGRpdj48ZGl2PnBvd2VycGM6IENsZWFyIEVMRiBwZXJzb25hbGl0eSBmbGFnIGlmIEVMRnYyIGlz
IG5vdCByZXF1ZXN0ZWQuPC9kaXY+PGRpdj7CoCDCoMKgPC9kaXY+PGRpdj5UaGUgUE9XRVIga2Vy
bmVsIHVzZXMgYSBwZXJzb25hbGl0eSBmbGFnIHRvIGRldGVybWluZSB3aGV0aGVyIGl0IHNob3Vs
ZDwvZGl2PjxkaXY+YmUgc2V0dGluZyB1cCBmdW5jdGlvbiBkZXNjcmlwdG9ycyBvciBub3QgKHBl
ciB0aGUgdXBkYXRlZCBBQkkpLiDCoFRoaXM8L2Rpdj4NCjxkaXY+ZmxhZyB3YXNuJiMzOTt0IGJl
aW5nIGNsZWFyZWQgb24gYSBuZXcgcHJvY2VzcyBidXQgaW5zdGVhZCB3YXMgYmVpbmc8L2Rpdj48
ZGl2PmluaGVyaXRlZC4gwqBUaGUgdmlzaWJsZSBlZmZlY3Qgd2FzIHRoYXQgYW4gRUxGdjIgYmlu
YXJ5IGNvdWxkIG5vdCBleGVjdmU8L2Rpdj48ZGl2PnRvIGFuIEVMRnYxIGJpbmFyeS48L2Rpdj48
L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PlNpZ25lZC1vZmYtYnk6IEplZmYgQmFpbGV5ICZsdDs8
YSBocmVmPSJtYWlsdG86amVmZmJhaWxleUBnb29nbGUuY29tIj5qZWZmYmFpbGV5QGdvb2dsZS5j
b208L2E+Jmd0OzwvZGl2Pg0KPGRpdj48YnI+PC9kaXY+PGRpdj7CoGFyY2gvcG93ZXJwYy9pbmNs
dWRlL2FzbS9lbGYuaCB8IDIgKys8L2Rpdj48ZGl2PsKgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0
aW9ucygrKTwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+ZGlmZiAtLWdpdCBhL2FyY2gvcG93ZXJw
Yy9pbmNsdWRlL2FzbS9lbGYuaCBiL2FyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9lbGYuaDwvZGl2
PjxkaXY+aW5kZXggOTM1YjVlNy4uODg4ZDhmMyAxMDA2NDQ8L2Rpdj4NCjxkaXY+LS0tIGEvYXJj
aC9wb3dlcnBjL2luY2x1ZGUvYXNtL2VsZi5oPC9kaXY+PGRpdj4rKysgYi9hcmNoL3Bvd2VycGMv
aW5jbHVkZS9hc20vZWxmLmg8L2Rpdj48ZGl2PkBAIC05MCw2ICs5MCw4IEBAIHR5cGVkZWYgZWxm
X3ZycmVnc2V0X3QgZWxmX2ZweHJlZ3NldF90OzwvZGl2PjxkaXY+wqBkbyB7IMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIFw8L2Rpdj4NCjxkaXY+wqAgwqAgwqAgwqAgaWYgKCgoZXgpLmVf
ZmxhZ3MgJmFtcDsgMHgzKSA9PSAyKSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoFw8L2Rpdj48ZGl2PsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHNldF90aHJlYWRfZmxhZyhU
SUZfRUxGMkFCSSk7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8L2Rpdj48ZGl2PisgwqAg
wqAgwqAgZWxzZSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8L2Rpdj4NCjxkaXY+KyDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBjbGVhcl90aHJlYWRfZmxhZyhUSUZfRUxGMkFCSSk7IMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIFw8L2Rpdj48ZGl2PsKgIMKgIMKgIMKgIGlmICgoZXgpLmVfaWRlbnRbRUlfQ0xB
U1NdID09IEVMRkNMQVNTMzIpIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8L2Rpdj48ZGl2PsKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIHNldF90aHJlYWRfZmxhZyhUSUZfMzJCSVQpOyDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBcPC9kaXY+DQo8ZGl2PsKgIMKgIMKgIMKgIGVsc2UgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBcPC9kaXY+DQo=
--001a11c0f6ee42ff7d04f999ddfa--
