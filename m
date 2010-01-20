Return-Path: <stef.van.os@Prodrive.nl>
Received: from mail.prodrive.nl (mail.prodrive.nl [194.151.106.228])
	by ozlabs.org (Postfix) with ESMTP id A2BB5B7CBB
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Jan 2010 00:59:56 +1100 (EST)
From: Stef van Os <stef.van.os@prodrive.nl>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/4xx: Add pcix type 1 transactions
Date: Wed, 20 Jan 2010 14:59:39 +0100
Message-Id: <1263995979-10954-1-git-send-email-stef.van.os@prodrive.nl>
Content-Type: text/plain
Cc: Stef van Os <stef.van.os@gmail.com>, felix@embedded-sol.com, fkan@amcc.com,
	Stef van Os <stef.van.os@prodrive.nl>, sr@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

U29tZSBvZiB0aGUgbmV3ZXIgNHh4IHBjaSBjb3JlcyBkb24ndCBzZW5kIFBDSSB0eXBlIDEgdHJh
bnNhY3Rpb25zLg0KVGhpcyBwYXRjaCBlbmFibGVzIHR5cGUgMSB0cmFuc2F0aW9ucyBmb3IgcGNp
eCBub2RlcywgdGh1cyBlbmFibGluZw0KZGV2aWNlcyBiZWhpbmQgUENJIGJyaWRnZXMuDQoNClNp
Z25lZC1vZmYtYnk6IFN0ZWYgdmFuIE9zIDxzdGVmLnZhbi5vc0BnbWFpbC5jb20+DQotLS0NCiBh
cmNoL3Bvd2VycGMvc3lzZGV2L3BwYzR4eF9wY2kuYyB8ICAgIDMgKystDQogMSBmaWxlcyBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9hcmNo
L3Bvd2VycGMvc3lzZGV2L3BwYzR4eF9wY2kuYyBiL2FyY2gvcG93ZXJwYy9zeXNkZXYvcHBjNHh4
X3BjaS5jDQppbmRleCA2ZmY5ZDcxLi44YWEzMzAyIDEwMDY0NA0KLS0tIGEvYXJjaC9wb3dlcnBj
L3N5c2Rldi9wcGM0eHhfcGNpLmMNCisrKyBiL2FyY2gvcG93ZXJwYy9zeXNkZXYvcHBjNHh4X3Bj
aS5jDQpAQCAtNTY5LDcgKzU2OSw4IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBwcGM0eHhfcHJvYmVf
cGNpeF9icmlkZ2Uoc3RydWN0IGRldmljZV9ub2RlICpucCkNCiAJaG9zZS0+bGFzdF9idXNubyA9
IGJ1c19yYW5nZSA/IGJ1c19yYW5nZVsxXSA6IDB4ZmY7DQogDQogCS8qIFNldHVwIGNvbmZpZyBz
cGFjZSAqLw0KLQlzZXR1cF9pbmRpcmVjdF9wY2koaG9zZSwgcnNyY19jZmcuc3RhcnQsIHJzcmNf
Y2ZnLnN0YXJ0ICsgMHg0LCAwKTsNCisJc2V0dXBfaW5kaXJlY3RfcGNpKGhvc2UsIHJzcmNfY2Zn
LnN0YXJ0LCByc3JjX2NmZy5zdGFydCArIDB4NCwNCisJCQkJCVBQQ19JTkRJUkVDVF9UWVBFX1NF
VF9DRkdfVFlQRSk7DQogDQogCS8qIERpc2FibGUgYWxsIHdpbmRvd3MgKi8NCiAJd3JpdGVsKDAs
IHJlZyArIFBDSVgwX1BPTTBTQSk7DQotLSANCjEuNi42LjI2Ny5nNWIxNTkNCg0KDQpEaXNjbGFp
bWVyOiBUaGUgaW5mb3JtYXRpb24gY29udGFpbmVkIGluIHRoaXMgZW1haWwsIGluY2x1ZGluZyBh
bnkgYXR0YWNobWVudHMgaXMgDQpjb25maWRlbnRpYWwgYW5kIGlzIGZvciB0aGUgc29sZSB1c2Ug
b2YgdGhlIGludGVuZGVkIHJlY2lwaWVudChzKS4gQW55IHVuYXV0aG9yaXplZCANCnJldmlldywg
dXNlLCBkaXNjbG9zdXJlIG9yIGRpc3RyaWJ1dGlvbiBpcyBwcm9oaWJpdGVkLiBJZiB5b3UgYXJl
IG5vdCB0aGUgaW50ZW5kZWQgDQpyZWNpcGllbnQsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBp
bW1lZGlhdGVseSBieSByZXBseWluZyB0byB0aGlzIG1lc3NhZ2UgYW5kIA0KZGVzdHJveSBhbGwg
Y29waWVzIG9mIHRoaXMgbWVzc2FnZSBhbmQgYW55IGF0dGFjaG1lbnRzLg==
