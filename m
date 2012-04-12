Return-Path: <matsumoto.hiroo@jp.fujitsu.com>
Received: from fgwmail7.fujitsu.co.jp (fgwmail7.fujitsu.co.jp [192.51.44.37])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8A9B4B7004
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Apr 2012 16:45:37 +1000 (EST)
Received: from fgwmail6.fujitsu.co.jp (fgwmail6.fujitsu.co.jp [192.51.44.36])
 by fgwmail7.fujitsu.co.jp (Postfix) with ESMTP id CB6AB1794BD4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Apr 2012 15:02:39 +0900 (JST)
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id C9AE13EE0B6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Apr 2012 15:02:34 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id B253245DE51
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Apr 2012 15:02:34 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 93D9345DE50
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Apr 2012 15:02:34 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 876981DB802F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Apr 2012 15:02:34 +0900 (JST)
Received: from m005.s.css.fujitsu.com (m005.s.css.fujitsu.com [10.23.4.35])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 3806CE08001
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Apr 2012 15:02:34 +0900 (JST)
Received: from m005.css.fujitsu.com (m005 [127.0.0.1])
 by m005.s.css.fujitsu.com (Postfix) with ESMTP id 887502E06B2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Apr 2012 15:02:33 +0900 (JST)
Received: from [127.0.0.1] (ubi135.utsfd.cs.fujitsu.co.jp [10.24.19.135])
 by m005.s.css.fujitsu.com (Postfix) with ESMTP id 390DF2E06AE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Apr 2012 15:02:33 +0900 (JST)
Message-ID: <4F867083.2090200@jp.fujitsu.com>
Date: Thu, 12 Apr 2012 15:04:51 +0900
From: Hiroo Matsumoto <matsumoto.hiroo@jp.fujitsu.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC] powerpc: set_dma_ops for pci hotplug
Content-Type: multipart/mixed; boundary="------------010902070108090108020003"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------010902070108090108020003
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

Hi


I'm trying to use PCI Express Hot Plug on powerpc platform.
But PCI driver returns error when hotplug.
Error log is as below.
http://www.spinics.net/lists/linux-pci/msg14534.html

Some of PCI driver needs dma_ops.
On x86 platform, dma_ops is getting from external variable.
On powerpc platform, dma_ops is getting from archdata.dma_ops in struct
device.
There is a problem that archdata.dma_ops is set only when boot with
pcibios_setup_bus_devices but not set when hotplug.
So when hotplug, PCI driver's probe will return error.

I add code of checking and setting dma_ops in pcibios_enable_device.
It is called from pci_enable_device_xxx in PCI driver's probe before
checking dma_ops.
And PCI driver works good when hotplug.


Regards.

Hiroo MATSUMOTO

--------------010902070108090108020003
Content-Type: text/plain;
 name="ppc-set_dma_ops-for-pcihp.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="ppc-set_dma_ops-for-pcihp.patch"

U2lnbmVkLW9mZi1ieTogSGlyb28gTUFUU1VNT1RPIDxtYXRzdW1vdG8uaGlyb29AanAuZnVq
aXRzdS5jb20+CmRpZmYgLS1naXQgYS9hcmNoL3Bvd2VycGMva2VybmVsL3BjaS1jb21tb24u
YyBiL2FyY2gvcG93ZXJwYy9rZXJuZWwvcGNpLWNvbW1vbi5jCmluZGV4IDMyNjU2ZjEuLjA4
MGZmMWQgMTAwNjQ0Ci0tLSBhL2FyY2gvcG93ZXJwYy9rZXJuZWwvcGNpLWNvbW1vbi5jCisr
KyBiL2FyY2gvcG93ZXJwYy9rZXJuZWwvcGNpLWNvbW1vbi5jCkBAIC0xMTEsNiArMTExLDE3
IEBAIHN0YXRpYyByZXNvdXJjZV9zaXplX3QgcGNpYmlvc19pb19zaXplKGNvbnN0IHN0cnVj
dCBwY2lfY29udHJvbGxlciAqaG9zZSkKICNlbmRpZgogfQogCitzdGF0aWMgaW5saW5lIHZv
aWQgcGNpYmlvc19zZXRfZG1hX29wcyhzdHJ1Y3QgcGNpX2RldiAqZGV2KQoreworCS8qIEhv
b2sgdXAgZGVmYXVsdCBETUEgb3BzICovCisJc2V0X2RtYV9vcHMoJmRldi0+ZGV2LCBwY2lf
ZG1hX29wcyk7CisJc2V0X2RtYV9vZmZzZXQoJmRldi0+ZGV2LCBQQ0lfRFJBTV9PRkZTRVQp
OworCisJLyogQWRkaXRpb25hbCBwbGF0Zm9ybSBETUEvaW9tbXUgc2V0dXAgKi8KKwlpZiAo
cHBjX21kLnBjaV9kbWFfZGV2X3NldHVwKQorCQlwcGNfbWQucGNpX2RtYV9kZXZfc2V0dXAo
ZGV2KTsKK30KKwogaW50IHBjaWJpb3NfdmFkZHJfaXNfaW9wb3J0KHZvaWQgX19pb21lbSAq
YWRkcmVzcykKIHsKIAlpbnQgcmV0ID0gMDsKQEAgLTExMDIsMTMgKzExMTMsNyBAQCB2b2lk
IF9fZGV2aW5pdCBwY2liaW9zX3NldHVwX2J1c19kZXZpY2VzKHN0cnVjdCBwY2lfYnVzICpi
dXMpCiAJCSAqLwogCQlzZXRfZGV2X25vZGUoJmRldi0+ZGV2LCBwY2lidXNfdG9fbm9kZShk
ZXYtPmJ1cykpOwogCi0JCS8qIEhvb2sgdXAgZGVmYXVsdCBETUEgb3BzICovCi0JCXNldF9k
bWFfb3BzKCZkZXYtPmRldiwgcGNpX2RtYV9vcHMpOwotCQlzZXRfZG1hX29mZnNldCgmZGV2
LT5kZXYsIFBDSV9EUkFNX09GRlNFVCk7Ci0KLQkJLyogQWRkaXRpb25hbCBwbGF0Zm9ybSBE
TUEvaW9tbXUgc2V0dXAgKi8KLQkJaWYgKHBwY19tZC5wY2lfZG1hX2Rldl9zZXR1cCkKLQkJ
CXBwY19tZC5wY2lfZG1hX2Rldl9zZXR1cChkZXYpOworCQlwY2liaW9zX3NldF9kbWFfb3Bz
KGRldik7CiAKIAkJLyogUmVhZCBkZWZhdWx0IElSUXMgYW5kIGZpeHVwIGlmIG5lY2Vzc2Fy
eSAqLwogCQlwY2lfcmVhZF9pcnFfbGluZShkZXYpOwpAQCAtMTU0Nyw2ICsxNTUyLDEwIEBA
IEVYUE9SVF9TWU1CT0xfR1BMKHBjaWJpb3NfZmluaXNoX2FkZGluZ190b19idXMpOwogCiBp
bnQgcGNpYmlvc19lbmFibGVfZGV2aWNlKHN0cnVjdCBwY2lfZGV2ICpkZXYsIGludCBtYXNr
KQogeworCS8qIGRtYV9vcHMgaXMgTlVMTCBmcm9tIGhvdHBsdWcgKi8KKwlpZiAoIWdldF9k
bWFfb3BzKCZkZXYtPmRldikpCisJCXBjaWJpb3Nfc2V0X2RtYV9vcHMoZGV2KTsKKwogCWlm
IChwcGNfbWQucGNpYmlvc19lbmFibGVfZGV2aWNlX2hvb2spCiAJCWlmIChwcGNfbWQucGNp
Ymlvc19lbmFibGVfZGV2aWNlX2hvb2soZGV2KSkKIAkJCXJldHVybiAtRUlOVkFMOwo=
--------------010902070108090108020003--
