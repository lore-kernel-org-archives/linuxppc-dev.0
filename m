Return-Path: <fdiakh@gmail.com>
Received: from mail-px0-f191.google.com (mail-px0-f191.google.com
	[209.85.216.191]) by ozlabs.org (Postfix) with ESMTP id 15B26B7D01
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 24 Mar 2010 02:18:42 +1100 (EST)
Received: by pxi29 with SMTP id 29so2559599pxi.7
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Mar 2010 08:18:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100323085520.GF8675@amit-x200.redhat.com>
References: <6ad07c641003221045m10ee5c84x3a92436582600f21@mail.gmail.com>
	<20100323085520.GF8675@amit-x200.redhat.com>
From: =?UTF-8?Q?Fran=C3=A7ois_Diakhate?= <fdiakh@gmail.com>
Date: Tue, 23 Mar 2010 15:58:17 +0100
Message-ID: <6ad07c641003230758q597559aeu1461471d1910d774@mail.gmail.com>
Subject: Re: Virtio_console usage of early printk
To: Amit Shah <amit.shah@redhat.com>
Content-Type: multipart/mixed; boundary=000e0cd1a3f0702a400482790c55
Cc: linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--000e0cd1a3f0702a400482790c55
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 23, 2010 at 9:55 AM, Amit Shah <amit.shah@redhat.com> wrote:
> On (Mon) Mar 22 2010 [18:45:47], Fran=C3=A7ois Diakhate wrote:
>> Hi all,
>>
>> As far as I can see, early_put_chars is not used by virtio_console
>> because it checks whether there is a port available before using it.
>> If I understand correctly, this makes it useless because once we have
>> a port, we can use the regular virtio transport to output things to
>> the console. Does the attached patch seem valid ? Feedback from s390
>> and powerpc users who use this functionality would be appreciated.
>>
>> Thanks,
>> Fran=C3=A7ois
>
>> From 3961f380bbe84a1036ddfc823039cbee31b44dcb Mon Sep 17 00:00:00 2001
>> From: =3D?utf-8?q?Fran=3DC3=3DA7ois=3D20Diakhat=3DC3=3DA9?=3D <fdiakh@gm=
ail.com>
>> Date: Thu, 18 Mar 2010 14:48:20 +0100
>> Subject: virtio: console: Fix early_put_chars usage
>>
>> Currently early_put_chars is not used by virtio_console because it can o=
nly be used once a port has been found, at which point it's too late becaus=
e it is no longer needed. This patch should fix it.
>
> You'll have to give a signed-off-by for the patch.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Amit
>

Sorry, I didn't have access to my computer this morning. Here is the
patch with a sign-off, if you still need it.

Fran=C3=A7ois

--000e0cd1a3f0702a400482790c55
Content-Type: text/x-patch; charset=UTF-8;
	name="0001-virtio-console-Fix-early_put_chars-usage.patch"
Content-Disposition: attachment;
	filename="0001-virtio-console-Fix-early_put_chars-usage.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g74tr58q0

RnJvbSAyMDljNTUzMzU1YTNhYzA0ZTY4YTllOTU2MGNlYTkwODk3NTg4MzA0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P3V0Zi04P3E/RnJhbj1DMz1BN29pcz0yMERpYWtoYXQ9QzM9
QTk/PSA8ZmRpYWtoQGdtYWlsLmNvbT4KRGF0ZTogVGh1LCAxOCBNYXIgMjAxMCAxNDo0ODoyMCAr
MDEwMApTdWJqZWN0OiBbUEFUQ0hdIHZpcnRpbzogY29uc29sZTogRml4IGVhcmx5X3B1dF9jaGFy
cyB1c2FnZQpNSU1FLVZlcnNpb246IDEuMApDb250ZW50LVR5cGU6IHRleHQvcGxhaW47IGNoYXJz
ZXQ9dXRmLTgKQ29udGVudC1UcmFuc2Zlci1FbmNvZGluZzogOGJpdAoKQ3VycmVudGx5IGVhcmx5
X3B1dF9jaGFycyBpcyBub3QgdXNlZCBieSB2aXJ0aW9fY29uc29sZSBiZWNhdXNlIGl0IGNhbiBv
bmx5IGJlIHVzZWQgb25jZSBhIHBvcnQgaGFzIGJlZW4gZm91bmQsIGF0IHdoaWNoIHBvaW50IGl0
J3MgdG9vIGxhdGUgYmVjYXVzZSBpdCBpcyBubyBsb25nZXIgbmVlZGVkLiBUaGlzIHBhdGNoIHNo
b3VsZCBmaXggaXQuCgpTaWduZWQtb2ZmLWJ5OiBGcmFuw6dvaXMgRGlha2hhdMOpIDxmZGlha2hA
Z21haWwuY29tPgotLS0KIGRyaXZlcnMvY2hhci92aXJ0aW9fY29uc29sZS5jIHwgICAgNiArKyst
LS0KIDEgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvY2hhci92aXJ0aW9fY29uc29sZS5jIGIvZHJpdmVycy9jaGFyL3Zp
cnRpb19jb25zb2xlLmMKaW5kZXggZjQwNGNjZi4uNjkxYmEyMSAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9jaGFyL3ZpcnRpb19jb25zb2xlLmMKKysrIGIvZHJpdmVycy9jaGFyL3ZpcnRpb19jb25zb2xl
LmMKQEAgLTY0NSwxMyArNjQ1LDEzIEBAIHN0YXRpYyBpbnQgcHV0X2NoYXJzKHUzMiB2dGVybW5v
LCBjb25zdCBjaGFyICpidWYsIGludCBjb3VudCkKIHsKIAlzdHJ1Y3QgcG9ydCAqcG9ydDsKIAor
CWlmICh1bmxpa2VseShlYXJseV9wdXRfY2hhcnMpKQorCQlyZXR1cm4gZWFybHlfcHV0X2NoYXJz
KHZ0ZXJtbm8sIGJ1ZiwgY291bnQpOworCiAJcG9ydCA9IGZpbmRfcG9ydF9ieV92dGVybW5vKHZ0
ZXJtbm8pOwogCWlmICghcG9ydCkKIAkJcmV0dXJuIDA7CiAKLQlpZiAodW5saWtlbHkoZWFybHlf
cHV0X2NoYXJzKSkKLQkJcmV0dXJuIGVhcmx5X3B1dF9jaGFycyh2dGVybW5vLCBidWYsIGNvdW50
KTsKLQogCXJldHVybiBzZW5kX2J1Zihwb3J0LCAodm9pZCAqKWJ1ZiwgY291bnQpOwogfQogCi0t
IAoxLjYuMy4zCgo=
--000e0cd1a3f0702a400482790c55--
