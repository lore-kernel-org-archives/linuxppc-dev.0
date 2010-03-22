Return-Path: <fdiakh@gmail.com>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51]) by ozlabs.org (Postfix) with ESMTP id E6B60B7CF7
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Mar 2010 04:46:13 +1100 (EST)
Received: by pwj7 with SMTP id 7so3680060pwj.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 22 Mar 2010 10:46:12 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?Q?Fran=C3=A7ois_Diakhate?= <fdiakh@gmail.com>
Date: Mon, 22 Mar 2010 18:45:47 +0100
Message-ID: <6ad07c641003221045m10ee5c84x3a92436582600f21@mail.gmail.com>
Subject: Virtio_console usage of early printk
To: virtualization@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/mixed; boundary=005045017e419e6ec9048267458a
Cc: amit.shah@redhat.com, fdiakh@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--005045017e419e6ec9048267458a
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

As far as I can see, early_put_chars is not used by virtio_console
because it checks whether there is a port available before using it.
If I understand correctly, this makes it useless because once we have
a port, we can use the regular virtio transport to output things to
the console. Does the attached patch seem valid ? Feedback from s390
and powerpc users who use this functionality would be appreciated.

Thanks,
Fran=C3=A7ois

--005045017e419e6ec9048267458a
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-virtio-console-Fix-early_put_chars-usage.patch"
Content-Disposition: attachment;
	filename="0001-virtio-console-Fix-early_put_chars-usage.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g73k71k70

RnJvbSAzOTYxZjM4MGJiZTg0YTEwMzZkZGZjODIzMDM5Y2JlZTMxYjQ0ZGNiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P3V0Zi04P3E/RnJhbj1DMz1BN29pcz0yMERpYWtoYXQ9QzM9
QTk/PSA8ZmRpYWtoQGdtYWlsLmNvbT4KRGF0ZTogVGh1LCAxOCBNYXIgMjAxMCAxNDo0ODoyMCAr
MDEwMApTdWJqZWN0OiB2aXJ0aW86IGNvbnNvbGU6IEZpeCBlYXJseV9wdXRfY2hhcnMgdXNhZ2UK
CkN1cnJlbnRseSBlYXJseV9wdXRfY2hhcnMgaXMgbm90IHVzZWQgYnkgdmlydGlvX2NvbnNvbGUg
YmVjYXVzZSBpdCBjYW4gb25seSBiZSB1c2VkIG9uY2UgYSBwb3J0IGhhcyBiZWVuIGZvdW5kLCBh
dCB3aGljaCBwb2ludCBpdCdzIHRvbyBsYXRlIGJlY2F1c2UgaXQgaXMgbm8gbG9uZ2VyIG5lZWRl
ZC4gVGhpcyBwYXRjaCBzaG91bGQgZml4IGl0LgotLS0KIGRyaXZlcnMvY2hhci92aXJ0aW9fY29u
c29sZS5jIHwgICAgNiArKystLS0KIDEgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAz
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2hhci92aXJ0aW9fY29uc29sZS5j
IGIvZHJpdmVycy9jaGFyL3ZpcnRpb19jb25zb2xlLmMKaW5kZXggZjQwNGNjZi4uNjkxYmEyMSAx
MDA2NDQKLS0tIGEvZHJpdmVycy9jaGFyL3ZpcnRpb19jb25zb2xlLmMKKysrIGIvZHJpdmVycy9j
aGFyL3ZpcnRpb19jb25zb2xlLmMKQEAgLTY0NSwxMyArNjQ1LDEzIEBAIHN0YXRpYyBpbnQgcHV0
X2NoYXJzKHUzMiB2dGVybW5vLCBjb25zdCBjaGFyICpidWYsIGludCBjb3VudCkKIHsKIAlzdHJ1
Y3QgcG9ydCAqcG9ydDsKIAorCWlmICh1bmxpa2VseShlYXJseV9wdXRfY2hhcnMpKQorCQlyZXR1
cm4gZWFybHlfcHV0X2NoYXJzKHZ0ZXJtbm8sIGJ1ZiwgY291bnQpOworCiAJcG9ydCA9IGZpbmRf
cG9ydF9ieV92dGVybW5vKHZ0ZXJtbm8pOwogCWlmICghcG9ydCkKIAkJcmV0dXJuIDA7CiAKLQlp
ZiAodW5saWtlbHkoZWFybHlfcHV0X2NoYXJzKSkKLQkJcmV0dXJuIGVhcmx5X3B1dF9jaGFycyh2
dGVybW5vLCBidWYsIGNvdW50KTsKLQogCXJldHVybiBzZW5kX2J1Zihwb3J0LCAodm9pZCAqKWJ1
ZiwgY291bnQpOwogfQogCi0tIAoxLjYuMS4zCgo=
--005045017e419e6ec9048267458a--
