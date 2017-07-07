Return-Path: <linus971@gmail.com>
Received: from mail-oi0-x242.google.com (mail-oi0-x242.google.com
 [IPv6:2607:f8b0:4003:c06::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x3znq0CsqzDr5l
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Jul 2017 01:59:43 +1000 (AEST)
Received: by mail-oi0-x242.google.com with SMTP id l130so4370765oib.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Jul 2017 08:59:42 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <87eftsv2hj.fsf@concordia.ellerman.id.au>
References: <20170705071423.GY10672@ZenIV.linux.org.uk>
 <87eftsv2hj.fsf@concordia.ellerman.id.au>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 7 Jul 2017 08:59:40 -0700
Message-ID: <CA+55aFyREtWvwCLc0iHMUOLo-VLDpxju7WwEmjOSyByHre3avQ@mail.gmail.com>
Subject: Re: [git pull] vfs.git part 1
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Content-Type: multipart/mixed; boundary="94eb2c0933a82841090553bc5257"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--94eb2c0933a82841090553bc5257
Content-Type: text/plain; charset="UTF-8"

On Fri, Jul 7, 2017 at 5:46 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Al Viro <viro@ZenIV.linux.org.uk> writes:
>
>>
>>   Switch flock copyin/copyout primitives to copy_{from,to}_user() (2017-06-26 23:52:44 -0400)
>
> This commit seems to have broken networking on a bunch of my PPC
> machines (64-bit kernel, 32-bit userspace).

Bah. I think that commit is entirely broken, due to having the
arguments to the "copy_flock_fields()" in the wrong order.

The copy_flock_fields() macro has the arguments in order <from, to>,
but all the users seem to do it the other way around.

I think it would have been more obvious if the put_compat_flock*()
source argument had been "const".

> Patch coming.

I'm not seeing a patch, so I did my own. But it's _entirely_ untested.
Does the attached fix things for you?

                     Linus

--94eb2c0933a82841090553bc5257
Content-Type: text/plain; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_j4u1r3qg0

IGZzL2ZjbnRsLmMgfCAxNiArKysrKysrKy0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgOCBpbnNl
cnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2ZzL2ZjbnRsLmMgYi9mcy9m
Y250bC5jCmluZGV4IGI2YmQ4OTYyODAyNS4uZWViMTllMjJmZDA4IDEwMDY0NAotLS0gYS9mcy9m
Y250bC5jCisrKyBiL2ZzL2ZjbnRsLmMKQEAgLTUyNyw0MyArNTI3LDQzIEBAIFNZU0NBTExfREVG
SU5FMyhmY250bDY0LCB1bnNpZ25lZCBpbnQsIGZkLCB1bnNpZ25lZCBpbnQsIGNtZCwKIAkodG8p
LmxfbGVuID0gKGZyb20pLmxfbGVuOwkJXAogCSh0bykubF9waWQgPSAoZnJvbSkubF9waWQ7CiAK
LXN0YXRpYyBpbnQgZ2V0X2NvbXBhdF9mbG9jayhzdHJ1Y3QgZmxvY2sgKmtmbCwgc3RydWN0IGNv
bXBhdF9mbG9jayBfX3VzZXIgKnVmbCkKK3N0YXRpYyBpbnQgZ2V0X2NvbXBhdF9mbG9jayhzdHJ1
Y3QgZmxvY2sgKmtmbCwgY29uc3Qgc3RydWN0IGNvbXBhdF9mbG9jayBfX3VzZXIgKnVmbCkKIHsK
IAlzdHJ1Y3QgY29tcGF0X2Zsb2NrIGZsOwogCiAJaWYgKGNvcHlfZnJvbV91c2VyKCZmbCwgdWZs
LCBzaXplb2Yoc3RydWN0IGNvbXBhdF9mbG9jaykpKQogCQlyZXR1cm4gLUVGQVVMVDsKLQljb3B5
X2Zsb2NrX2ZpZWxkcygqa2ZsLCBmbCk7CisJY29weV9mbG9ja19maWVsZHMoZmwsICprZmwpOwog
CXJldHVybiAwOwogfQogCi1zdGF0aWMgaW50IGdldF9jb21wYXRfZmxvY2s2NChzdHJ1Y3QgZmxv
Y2sgKmtmbCwgc3RydWN0IGNvbXBhdF9mbG9jazY0IF9fdXNlciAqdWZsKQorc3RhdGljIGludCBn
ZXRfY29tcGF0X2Zsb2NrNjQoc3RydWN0IGZsb2NrICprZmwsIGNvbnN0IHN0cnVjdCBjb21wYXRf
ZmxvY2s2NCBfX3VzZXIgKnVmbCkKIHsKIAlzdHJ1Y3QgY29tcGF0X2Zsb2NrNjQgZmw7CiAKIAlp
ZiAoY29weV9mcm9tX3VzZXIoJmZsLCB1ZmwsIHNpemVvZihzdHJ1Y3QgY29tcGF0X2Zsb2NrNjQp
KSkKIAkJcmV0dXJuIC1FRkFVTFQ7Ci0JY29weV9mbG9ja19maWVsZHMoKmtmbCwgZmwpOworCWNv
cHlfZmxvY2tfZmllbGRzKGZsLCAqa2ZsKTsKIAlyZXR1cm4gMDsKIH0KIAotc3RhdGljIGludCBw
dXRfY29tcGF0X2Zsb2NrKHN0cnVjdCBmbG9jayAqa2ZsLCBzdHJ1Y3QgY29tcGF0X2Zsb2NrIF9f
dXNlciAqdWZsKQorc3RhdGljIGludCBwdXRfY29tcGF0X2Zsb2NrKGNvbnN0IHN0cnVjdCBmbG9j
ayAqa2ZsLCBzdHJ1Y3QgY29tcGF0X2Zsb2NrIF9fdXNlciAqdWZsKQogewogCXN0cnVjdCBjb21w
YXRfZmxvY2sgZmw7CiAKIAltZW1zZXQoJmZsLCAwLCBzaXplb2Yoc3RydWN0IGNvbXBhdF9mbG9j
aykpOwotCWNvcHlfZmxvY2tfZmllbGRzKGZsLCAqa2ZsKTsKKwljb3B5X2Zsb2NrX2ZpZWxkcygq
a2ZsLCBmbCk7CiAJaWYgKGNvcHlfdG9fdXNlcih1ZmwsICZmbCwgc2l6ZW9mKHN0cnVjdCBjb21w
YXRfZmxvY2spKSkKIAkJcmV0dXJuIC1FRkFVTFQ7CiAJcmV0dXJuIDA7CiB9CiAKLXN0YXRpYyBp
bnQgcHV0X2NvbXBhdF9mbG9jazY0KHN0cnVjdCBmbG9jayAqa2ZsLCBzdHJ1Y3QgY29tcGF0X2Zs
b2NrNjQgX191c2VyICp1ZmwpCitzdGF0aWMgaW50IHB1dF9jb21wYXRfZmxvY2s2NChjb25zdCBz
dHJ1Y3QgZmxvY2sgKmtmbCwgc3RydWN0IGNvbXBhdF9mbG9jazY0IF9fdXNlciAqdWZsKQogewog
CXN0cnVjdCBjb21wYXRfZmxvY2s2NCBmbDsKIAogCW1lbXNldCgmZmwsIDAsIHNpemVvZihzdHJ1
Y3QgY29tcGF0X2Zsb2NrNjQpKTsKLQljb3B5X2Zsb2NrX2ZpZWxkcyhmbCwgKmtmbCk7CisJY29w
eV9mbG9ja19maWVsZHMoKmtmbCwgZmwpOwogCWlmIChjb3B5X3RvX3VzZXIodWZsLCAmZmwsIHNp
emVvZihzdHJ1Y3QgY29tcGF0X2Zsb2NrNjQpKSkKIAkJcmV0dXJuIC1FRkFVTFQ7CiAJcmV0dXJu
IDA7Cg==
--94eb2c0933a82841090553bc5257--
