Return-Path: <linus971@gmail.com>
Received: from mail-oi0-x244.google.com (mail-oi0-x244.google.com
 [IPv6:2607:f8b0:4003:c06::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x41wc6JCVzDr5m
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Jul 2017 03:35:44 +1000 (AEST)
Received: by mail-oi0-x244.google.com with SMTP id d77so4674578oig.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Jul 2017 10:35:44 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CA+55aFyREtWvwCLc0iHMUOLo-VLDpxju7WwEmjOSyByHre3avQ@mail.gmail.com>
References: <20170705071423.GY10672@ZenIV.linux.org.uk>
 <87eftsv2hj.fsf@concordia.ellerman.id.au>
 <CA+55aFyREtWvwCLc0iHMUOLo-VLDpxju7WwEmjOSyByHre3avQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 7 Jul 2017 10:35:41 -0700
Message-ID: <CA+55aFzHBR9M+UN2CMAQ0np275iyWyAY0uKK8LFo33g0e7Z-VQ@mail.gmail.com>
Subject: Re: [git pull] vfs.git part 1
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Content-Type: multipart/mixed; boundary="001a1137cfe89522570553bda95d"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001a1137cfe89522570553bda95d
Content-Type: text/plain; charset="UTF-8"

On Fri, Jul 7, 2017 at 8:59 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The copy_flock_fields() macro has the arguments in order <from, to>,
> but all the users seem to do it the other way around.

Looking more at it, I think I'd also like copy_flock_fields() to take
pointer arguments, to match all the code around it (both
copy_to/from_user and the memset calls.

The actual order of arguments I suspect Michael's patch did better -
make the copy_flock_fields() just match the order of memcpy() and
copy_to/from_user(), both of which have <dest,src> order.

So I think my preferred patch would be something like this, even if it
is bigger than either.

Comments? Michael, does this work for your case?

              Linus

--001a1137cfe89522570553bda95d
Content-Type: text/plain; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_j4u556fz1

IGZzL2ZjbnRsLmMgfCAzMCArKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0KIDEgZmlsZSBj
aGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9m
cy9mY250bC5jIGIvZnMvZmNudGwuYwppbmRleCBiNmJkODk2MjgwMjUuLjNiMDFiNjQ2ZTUyOCAx
MDA2NDQKLS0tIGEvZnMvZmNudGwuYworKysgYi9mcy9mY250bC5jCkBAIC01MjAsNTAgKzUyMCw1
MCBAQCBTWVNDQUxMX0RFRklORTMoZmNudGw2NCwgdW5zaWduZWQgaW50LCBmZCwgdW5zaWduZWQg
aW50LCBjbWQsCiAKICNpZmRlZiBDT05GSUdfQ09NUEFUCiAvKiBjYXJlZnVsIC0gZG9uJ3QgdXNl
IGFueXdoZXJlIGVsc2UgKi8KLSNkZWZpbmUgY29weV9mbG9ja19maWVsZHMoZnJvbSwgdG8pCQlc
Ci0JKHRvKS5sX3R5cGUgPSAoZnJvbSkubF90eXBlOwkJXAotCSh0bykubF93aGVuY2UgPSAoZnJv
bSkubF93aGVuY2U7CVwKLQkodG8pLmxfc3RhcnQgPSAoZnJvbSkubF9zdGFydDsJCVwKLQkodG8p
LmxfbGVuID0gKGZyb20pLmxfbGVuOwkJXAotCSh0bykubF9waWQgPSAoZnJvbSkubF9waWQ7Ci0K
LXN0YXRpYyBpbnQgZ2V0X2NvbXBhdF9mbG9jayhzdHJ1Y3QgZmxvY2sgKmtmbCwgc3RydWN0IGNv
bXBhdF9mbG9jayBfX3VzZXIgKnVmbCkKKyNkZWZpbmUgY29weV9mbG9ja19maWVsZHMoZHN0LCBz
cmMpCQlcCisJKGRzdCktPmxfdHlwZSA9IChzcmMpLT5sX3R5cGU7CQlcCisJKGRzdCktPmxfd2hl
bmNlID0gKHNyYyktPmxfd2hlbmNlOwlcCisJKGRzdCktPmxfc3RhcnQgPSAoc3JjKS0+bF9zdGFy
dDsJXAorCShkc3QpLT5sX2xlbiA9IChzcmMpLT5sX2xlbjsJCVwKKwkoZHN0KS0+bF9waWQgPSAo
c3JjKS0+bF9waWQ7CisKK3N0YXRpYyBpbnQgZ2V0X2NvbXBhdF9mbG9jayhzdHJ1Y3QgZmxvY2sg
KmtmbCwgY29uc3Qgc3RydWN0IGNvbXBhdF9mbG9jayBfX3VzZXIgKnVmbCkKIHsKIAlzdHJ1Y3Qg
Y29tcGF0X2Zsb2NrIGZsOwogCiAJaWYgKGNvcHlfZnJvbV91c2VyKCZmbCwgdWZsLCBzaXplb2Yo
c3RydWN0IGNvbXBhdF9mbG9jaykpKQogCQlyZXR1cm4gLUVGQVVMVDsKLQljb3B5X2Zsb2NrX2Zp
ZWxkcygqa2ZsLCBmbCk7CisJY29weV9mbG9ja19maWVsZHMoa2ZsLCAmZmwpOwogCXJldHVybiAw
OwogfQogCi1zdGF0aWMgaW50IGdldF9jb21wYXRfZmxvY2s2NChzdHJ1Y3QgZmxvY2sgKmtmbCwg
c3RydWN0IGNvbXBhdF9mbG9jazY0IF9fdXNlciAqdWZsKQorc3RhdGljIGludCBnZXRfY29tcGF0
X2Zsb2NrNjQoc3RydWN0IGZsb2NrICprZmwsIGNvbnN0IHN0cnVjdCBjb21wYXRfZmxvY2s2NCBf
X3VzZXIgKnVmbCkKIHsKIAlzdHJ1Y3QgY29tcGF0X2Zsb2NrNjQgZmw7CiAKIAlpZiAoY29weV9m
cm9tX3VzZXIoJmZsLCB1ZmwsIHNpemVvZihzdHJ1Y3QgY29tcGF0X2Zsb2NrNjQpKSkKIAkJcmV0
dXJuIC1FRkFVTFQ7Ci0JY29weV9mbG9ja19maWVsZHMoKmtmbCwgZmwpOworCWNvcHlfZmxvY2tf
ZmllbGRzKGtmbCwgJmZsKTsKIAlyZXR1cm4gMDsKIH0KIAotc3RhdGljIGludCBwdXRfY29tcGF0
X2Zsb2NrKHN0cnVjdCBmbG9jayAqa2ZsLCBzdHJ1Y3QgY29tcGF0X2Zsb2NrIF9fdXNlciAqdWZs
KQorc3RhdGljIGludCBwdXRfY29tcGF0X2Zsb2NrKGNvbnN0IHN0cnVjdCBmbG9jayAqa2ZsLCBz
dHJ1Y3QgY29tcGF0X2Zsb2NrIF9fdXNlciAqdWZsKQogewogCXN0cnVjdCBjb21wYXRfZmxvY2sg
Zmw7CiAKIAltZW1zZXQoJmZsLCAwLCBzaXplb2Yoc3RydWN0IGNvbXBhdF9mbG9jaykpOwotCWNv
cHlfZmxvY2tfZmllbGRzKGZsLCAqa2ZsKTsKKwljb3B5X2Zsb2NrX2ZpZWxkcygmZmwsIGtmbCk7
CiAJaWYgKGNvcHlfdG9fdXNlcih1ZmwsICZmbCwgc2l6ZW9mKHN0cnVjdCBjb21wYXRfZmxvY2sp
KSkKIAkJcmV0dXJuIC1FRkFVTFQ7CiAJcmV0dXJuIDA7CiB9CiAKLXN0YXRpYyBpbnQgcHV0X2Nv
bXBhdF9mbG9jazY0KHN0cnVjdCBmbG9jayAqa2ZsLCBzdHJ1Y3QgY29tcGF0X2Zsb2NrNjQgX191
c2VyICp1ZmwpCitzdGF0aWMgaW50IHB1dF9jb21wYXRfZmxvY2s2NChjb25zdCBzdHJ1Y3QgZmxv
Y2sgKmtmbCwgc3RydWN0IGNvbXBhdF9mbG9jazY0IF9fdXNlciAqdWZsKQogewogCXN0cnVjdCBj
b21wYXRfZmxvY2s2NCBmbDsKIAogCW1lbXNldCgmZmwsIDAsIHNpemVvZihzdHJ1Y3QgY29tcGF0
X2Zsb2NrNjQpKTsKLQljb3B5X2Zsb2NrX2ZpZWxkcyhmbCwgKmtmbCk7CisJY29weV9mbG9ja19m
aWVsZHMoJmZsLCBrZmwpOwogCWlmIChjb3B5X3RvX3VzZXIodWZsLCAmZmwsIHNpemVvZihzdHJ1
Y3QgY29tcGF0X2Zsb2NrNjQpKSkKIAkJcmV0dXJuIC1FRkFVTFQ7CiAJcmV0dXJuIDA7Cg==
--001a1137cfe89522570553bda95d--
