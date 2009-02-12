Return-Path: <risto.suominen@gmail.com>
MIME-Version: 1.0
Date: Thu, 12 Feb 2009 13:22:05 +0200
Message-ID: <46e1c7760902120322r11cffbdcgff330a242ca586fb@mail.gmail.com>
Subject: [PATCH 002/002] de2104x: support for systems lacking cache coherence
From: Risto Suominen <risto.suominen@gmail.com>
To: LinuxPPC-dev@ozlabs.org
Content-Type: multipart/mixed; boundary=0016e6de003328d6540462b6ee8d
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--0016e6de003328d6540462b6ee8d
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Here is a patch that helped me to get my de2104x NIC working on my
PowerMac 5500. As an interesting side effect, it also made my mesh
module crash.

Background can be found here: http://www.spinics.net/lists/netdev/msg88488.html

Risto

Allow setting NOT_COHERENT_CACHE explicitly.

Signed-off-by: Risto Suominen <Risto.Suominen@gmail.com>
---
The testing is done on kernel version 2.6.24.

--- a/arch/powerpc/platforms/powermac/Kconfig.org	2008-01-25
00:58:37.000000000 +0200
+++ b/arch/powerpc/platforms/powermac/Kconfig	2009-02-10
17:44:24.000000000 +0200
@@ -18,4 +18,10 @@ config PPC_PMAC64
 	select PPC_970_NAP
 	default y

-
+config NOT_COHERENT_CACHE
+	bool "Incoherent cache"
+	default n
+	help
+	  Setting this option may be necessary for avoiding cache-related
+	  problems with some network cards on some platforms. An example is
+	  2104x and PowerMac 5500.

--0016e6de003328d6540462b6ee8d
Content-Type: text/x-diff; charset=US-ASCII; name="incoherent_cache.patch"
Content-Disposition: attachment; filename="incoherent_cache.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fr3bybcj0

QWxsb3cgc2V0dGluZyBOT1RfQ09IRVJFTlRfQ0FDSEUgZXhwbGljaXRseS4KClNpZ25lZC1vZmYt
Ynk6IFJpc3RvIFN1b21pbmVuIDxSaXN0by5TdW9taW5lbkBnbWFpbC5jb20+Ci0tLQpUaGUgdGVz
dGluZyBpcyBkb25lIG9uIGtlcm5lbCB2ZXJzaW9uIDIuNi4yNC4KCi0tLSBhL2FyY2gvcG93ZXJw
Yy9wbGF0Zm9ybXMvcG93ZXJtYWMvS2NvbmZpZy5vcmcJMjAwOC0wMS0yNSAwMDo1ODozNy4wMDAw
MDAwMDAgKzAyMDAKKysrIGIvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9wb3dlcm1hYy9LY29uZmln
CTIwMDktMDItMTAgMTc6NDQ6MjQuMDAwMDAwMDAwICswMjAwCkBAIC0xOCw0ICsxOCwxMCBAQCBj
b25maWcgUFBDX1BNQUM2NAogCXNlbGVjdCBQUENfOTcwX05BUAogCWRlZmF1bHQgeQogCi0KK2Nv
bmZpZyBOT1RfQ09IRVJFTlRfQ0FDSEUKKwlib29sICJJbmNvaGVyZW50IGNhY2hlIgorCWRlZmF1
bHQgbgorCWhlbHAKKwkgIFNldHRpbmcgdGhpcyBvcHRpb24gbWF5IGJlIG5lY2Vzc2FyeSBmb3Ig
YXZvaWRpbmcgY2FjaGUtcmVsYXRlZAorCSAgcHJvYmxlbXMgd2l0aCBzb21lIG5ldHdvcmsgY2Fy
ZHMgb24gc29tZSBwbGF0Zm9ybXMuIEFuIGV4YW1wbGUgaXMKKwkgIDIxMDR4IGFuZCBQb3dlck1h
YyA1NTAwLgo=
--0016e6de003328d6540462b6ee8d--
