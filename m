Return-Path: <grundler@google.com>
Received: from smtp-out.google.com (smtp-out.google.com [216.239.33.17])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D02C5DDEDF
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 11:50:19 +1100 (EST)
Received: from wpaz1.hot.corp.google.com (wpaz1.hot.corp.google.com
	[172.24.198.65]) by smtp-out.google.com with ESMTP id n2V0duos017595
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 01:39:57 +0100
Received: from yw-out-1718.google.com (ywq4.prod.google.com [10.192.17.4])
	by wpaz1.hot.corp.google.com with ESMTP id n2V0dstF008622
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Mar 2009 17:39:55 -0700
Received: by yw-out-1718.google.com with SMTP id 4so1551004ywq.62
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Mar 2009 17:39:54 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 30 Mar 2009 17:39:54 -0700
Message-ID: <da824cf30903301739l688e8eb2r46086953245ebbe5@mail.gmail.com>
Subject: [PATCH] linux-next remove wmb() from ide-dma-sff.c and scc_pata.c
From: Grant Grundler <grundler@google.com>
To: "IDE/ATA Devel" <linux-ide@vger.kernel.org>,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Content-Type: multipart/mixed; boundary=000325579fd60da07704665f706a
Cc: linuxppc-dev@ozlabs.org, LKML <linux-kernel@google.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--000325579fd60da07704665f706a
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Followup to "[PATCH 03/10] ide: destroy DMA mappings after ending DMA"
email on March 14th:
    http://lkml.org/lkml/2009/3/14/17

No maintainer is listed for "Toshiba CELL Reference Set IDE" (BLK_DEV_CELLEB)
or tx4939ide.c in MAINTAINERS. I've CC'd "Ishizaki Kou" @Toshiba (Maintainer for
"Spidernet Network Driver for CELL") and linuxppc-dev list in the hope
someone else
would know or would be able to ACK this patch.

This patch:
o replaces "mask" variable in ide_dma_end() with #define.
o removes use of wmb() in ide-dma-sff.c and scc_pata.c.
o is not tested - I don't have (or want) the HW.

I did NOT remove wmb() use in tx4939ide.c. tx4939ide.c __raw_writeb()
for MMIO transactions. __raw_writeb() does NOT guarantee memory
transaction ordering.

tx4939ide also uses mmiowb(). AFAIK, mmiowb() only has an effect on
SGI IA64 NUMA machines. I'm not going to guess how this driver might work.

Gmail is broken for sending patches (word wrap). My apologies.
I've attached the patch: diff-next-remove_wmb_from_ide-01.txt

Patch is against linux-next tree:
     git://git.kernel.org/pub/scm/linux/kernel/git/sfr/linux-next

Signed-off-by: Grant Grundler <grundler@google.com>

--000325579fd60da07704665f706a
Content-Type: text/plain; charset=US-ASCII; name="diff-next-remove_wmb_from_ide-01.txt"
Content-Disposition: attachment;
	filename="diff-next-remove_wmb_from_ide-01.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fsxu7t3p1

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWRlL2lkZS1kbWEtc2ZmLmMgYi9kcml2ZXJzL2lkZS9pZGUt
ZG1hLXNmZi5jCmluZGV4IDE2ZmM0NmUuLmU0Y2RmNzggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvaWRl
L2lkZS1kbWEtc2ZmLmMKKysrIGIvZHJpdmVycy9pZGUvaWRlLWRtYS1zZmYuYwpAQCAtMjc3LDgg
KzI3Nyw2IEBAIHZvaWQgaWRlX2RtYV9zdGFydChpZGVfZHJpdmVfdCAqZHJpdmUpCiAJCWRtYV9j
bWQgPSBpbmIoaHdpZi0+ZG1hX2Jhc2UgKyBBVEFfRE1BX0NNRCk7CiAJCW91dGIoZG1hX2NtZCB8
IEFUQV9ETUFfU1RBUlQsIGh3aWYtPmRtYV9iYXNlICsgQVRBX0RNQV9DTUQpOwogCX0KLQotCXdt
YigpOwogfQogRVhQT1JUX1NZTUJPTF9HUEwoaWRlX2RtYV9zdGFydCk7CiAKQEAgLTI4Niw3ICsy
ODQsNyBAQCBFWFBPUlRfU1lNQk9MX0dQTChpZGVfZG1hX3N0YXJ0KTsKIGludCBpZGVfZG1hX2Vu
ZChpZGVfZHJpdmVfdCAqZHJpdmUpCiB7CiAJaWRlX2h3aWZfdCAqaHdpZiA9IGRyaXZlLT5od2lm
OwotCXU4IGRtYV9zdGF0ID0gMCwgZG1hX2NtZCA9IDAsIG1hc2s7CisJdTggZG1hX3N0YXQgPSAw
LCBkbWFfY21kID0gMDsKIAogCS8qIHN0b3AgRE1BICovCiAJaWYgKGh3aWYtPmhvc3RfZmxhZ3Mg
JiBJREVfSEZMQUdfTU1JTykgewpAQCAtMzA0LDExICszMDIsMTAgQEAgaW50IGlkZV9kbWFfZW5k
KGlkZV9kcml2ZV90ICpkcml2ZSkKIAkvKiBjbGVhciBJTlRSICYgRVJST1IgYml0cyAqLwogCWlk
ZV9kbWFfc2ZmX3dyaXRlX3N0YXR1cyhod2lmLCBkbWFfc3RhdCB8IEFUQV9ETUFfRVJSIHwgQVRB
X0RNQV9JTlRSKTsKIAotCXdtYigpOworI2RlZmluZSBDSEVDS19ETUFfTUFTSyAoQVRBX0RNQV9B
Q1RJVkUgfCBBVEFfRE1BX0VSUiB8IEFUQV9ETUFfSU5UUikKIAogCS8qIHZlcmlmeSBnb29kIERN
QSBzdGF0dXMgKi8KLQltYXNrID0gQVRBX0RNQV9BQ1RJVkUgfCBBVEFfRE1BX0VSUiB8IEFUQV9E
TUFfSU5UUjsKLQlpZiAoKGRtYV9zdGF0ICYgbWFzaykgIT0gQVRBX0RNQV9JTlRSKQorCWlmICgo
ZG1hX3N0YXQgJiBDSEVDS19ETUFfTUFTSykgIT0gQVRBX0RNQV9JTlRSKQogCQlyZXR1cm4gMHgx
MCB8IGRtYV9zdGF0OwogCXJldHVybiAwOwogfQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pZGUvc2Nj
X3BhdGEuYyBiL2RyaXZlcnMvaWRlL3NjY19wYXRhLmMKaW5kZXggOTdmOGUwZS4uZGNiYjI5OSAx
MDA2NDQKLS0tIGEvZHJpdmVycy9pZGUvc2NjX3BhdGEuYworKysgYi9kcml2ZXJzL2lkZS9zY2Nf
cGF0YS5jCkBAIC0zMzcsNyArMzM3LDYgQEAgc3RhdGljIHZvaWQgc2NjX2RtYV9zdGFydChpZGVf
ZHJpdmVfdCAqZHJpdmUpCiAKIAkvKiBzdGFydCBETUEgKi8KIAlzY2NfaWRlX291dGIoZG1hX2Nt
ZCB8IDEsIGh3aWYtPmRtYV9iYXNlKTsKLQl3bWIoKTsKIH0KIAogc3RhdGljIGludCBfX3NjY19k
bWFfZW5kKGlkZV9kcml2ZV90ICpkcml2ZSkKQEAgLTM1NCw3ICszNTMsNiBAQCBzdGF0aWMgaW50
IF9fc2NjX2RtYV9lbmQoaWRlX2RyaXZlX3QgKmRyaXZlKQogCS8qIGNsZWFyIHRoZSBJTlRSICYg
RVJST1IgYml0cyAqLwogCXNjY19pZGVfb3V0YihkbWFfc3RhdCB8IDYsIGh3aWYtPmRtYV9iYXNl
ICsgNCk7CiAJLyogdmVyaWZ5IGdvb2QgRE1BIHN0YXR1cyAqLwotCXdtYigpOwogCXJldHVybiAo
ZG1hX3N0YXQgJiA3KSAhPSA0ID8gKDB4MTAgfCBkbWFfc3RhdCkgOiAwOwogfQogCg==
--000325579fd60da07704665f706a--
