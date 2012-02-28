Return-Path: <r63875@freescale.com>
Received: from DB3EHSOBE002.bigfish.com (db3ehsobe004.messaging.microsoft.com
 [213.199.154.142])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 65B51B6EEC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2012 18:10:05 +1100 (EST)
From: Yin Olivia-R63875 <r63875@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH 1/2] powerpc/e500: make load_up_spe a normal fuction
Date: Tue, 28 Feb 2012 07:09:54 +0000
Message-ID: <B5012D5F6E2BBC4DBF16B3E6037A5B7316CCE0@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1330340388-30296-1-git-send-email-hong-hua.yin@freescale.com>
 <4F4BD726.1030805@freescale.com>
In-Reply-To: <4F4BD726.1030805@freescale.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

SGkgU2NvdHQsDQoNClRoaXMgaGFkIGJlZW4gcmV2aWV3ZWQgYmVmb3JlIGFuZCBhY2NlcHRlZCBi
eSBpbnRlcm5hbCB0cmVlLg0KaHR0cDovL2xpbnV4LmZyZWVzY2FsZS5uZXQvcGF0Y2h3b3JrL3Bh
dGNoLzExMTAwLw0KaHR0cDovL2dpdC5hbS5mcmVlc2NhbGUubmV0L2dpdG9saXRlL2dpdHdlYi5j
Z2kvc2RrL2t2bS5naXQvY29tbWl0Lz9oPWZvci1zZGsxLjImaWQ9YzUwODg4NDRkYzY2NWRiZGFl
NGZhNTFiOGQ1OGRjMjAzYmFjYzE3ZQ0KDQpJIGRpZG4ndCBjaGFuZ2UgYW55dGhpbmcgZXhjZXB0
IHRoZSBsaW5lLg0KSSBqdXN0IGNvbW1pdCB0byBleHRlcm5hbCBrdm0tcHBjIG1haWxpbmcgbGlz
dC4gU2hvdWxkIEkgYWRkIG15IG93biBTaWduZWQtb2ZmLWJ5Pw0KDQpCZXN0IFJlZ2FyZHMsDQpP
bGl2aWENCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFdvb2QgU2NvdHQtQjA3
NDIxIA0KU2VudDogVHVlc2RheSwgRmVicnVhcnkgMjgsIDIwMTIgMzoxOSBBTQ0KVG86IFlpbiBP
bGl2aWEtUjYzODc1DQpDYzoga3ZtLXBwY0B2Z2VyLmtlcm5lbC5vcmc7IGt2bUB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnOyBMaXUgWXUtQjEzMjAxDQpTdWJq
ZWN0OiBSZTogW1BBVENIIDEvMl0gcG93ZXJwYy9lNTAwOiBtYWtlIGxvYWRfdXBfc3BlIGEgbm9y
bWFsIGZ1Y3Rpb24NCg0KT24gMDIvMjcvMjAxMiAwNDo1OSBBTSwgT2xpdmlhIFlpbiB3cm90ZToN
Cj4gU28gdGhhdCB3ZSBjYW4gY2FsbCBpdCBpbiBrZXJuZWwuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBMaXUgWXUgPHl1LmxpdUBmcmVlc2NhbGUuY29tPg0KDQpFeHBsYWluIHdoeSB3ZSB3YW50IHRo
aXMsIGFuZCBwb2ludCBvdXQgdGhhdCB0aGlzIG1ha2VzIGl0IHNpbWlsYXIgdG8gbG9hZF91cF9m
cHUuDQoNCj4gLS0tDQo+ICBhcmNoL3Bvd2VycGMva2VybmVsL2hlYWRfZnNsX2Jvb2tlLlMgfCAg
IDIzICsrKysrKy0tLS0tLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0
aW9ucygrKSwgMTcgZGVsZXRpb25zKC0pDQoNCldoZW4gcG9zdGluZyBhIHBhdGNoIGF1dGhvcmVk
IGJ5IHNvbWVvbmUgZWxzZSwgbW9yZSBvciBsZXNzIHVuY2hhbmdlZCwgeW91IHNob3VsZCBwdXQg
YSBGcm9tOiBsaW5lIGluIHRoZSBib2R5IG9mIHRoZSBlLW1haWwuDQoNCmdpdCBzZW5kLWVtYWls
IHdpbGwgZG8gdGhpcyBhdXRvbWF0aWNhbGx5IGlmIHlvdSBwcmVzZXJ2ZSB0aGUgYXV0aG9yc2hp
cCBpbiB0aGUgZ2l0IGNvbW1pdC4NCg0KQWxzbywgeW91IHNob3VsZCBhZGQgeW91ciBvd24gU2ln
bmVkLW9mZi1ieS4NCg0KLVNjb3R0DQo=
