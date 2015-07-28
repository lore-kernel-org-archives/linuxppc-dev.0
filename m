Return-Path: <qiang.zhao@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0109.outbound.protection.outlook.com [207.46.100.109])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7347F1A1A41
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2015 15:32:50 +1000 (AEST)
From: Zhao Qiang <qiang.zhao@freescale.com>
To: Scott Wood <scottwood@freescale.com>
CC: "lauraa@codeaurora.org" <lauraa@codeaurora.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "olof@lixom.net"
 <olof@lixom.net>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "Xiaobo Xie" <X.Xie@freescale.com>
Subject: RE: [RFC v2] genalloc:add an gen_pool_first_fit_align algo to genalloc
Date: Tue, 28 Jul 2015 05:32:42 +0000
Message-ID: <SN1PR0301MB155080E4B7B2313969E30DAC9B8D0@SN1PR0301MB1550.namprd03.prod.outlook.com>
References: <1437991074-35377-1-git-send-email-qiang.zhao@freescale.com>
 <1438032043.2993.311.camel@freescale.com>
In-Reply-To: <1438032043.2993.311.camel@freescale.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

T24gVHVlLCAyMDE1LTA3LTI4IGF0IDU6MjEsIFNjb3R0IFdvb2Qgd3JvdGU6DQo+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFdvb2QgU2NvdHQtQjA3NDIxDQo+IFNlbnQ6IFR1
ZXNkYXksIEp1bHkgMjgsIDIwMTUgNToyMSBBTQ0KPiBUbzogWmhhbyBRaWFuZy1CNDU0NzUNCj4g
Q2M6IGxhdXJhYUBjb2RlYXVyb3JhLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsg
bGludXhwcGMtDQo+IGRldkBsaXN0cy5vemxhYnMub3JnOyBha3BtQGxpbnV4LWZvdW5kYXRpb24u
b3JnOyBvbG9mQGxpeG9tLm5ldDsNCj4gY2F0YWxpbi5tYXJpbmFzQGFybS5jb207IFhpZSBYaWFv
Ym8tUjYzMDYxDQo+IFN1YmplY3Q6IFJlOiBbUkZDIHYyXSBnZW5hbGxvYzphZGQgYW4gZ2VuX3Bv
b2xfZmlyc3RfZml0X2FsaWduIGFsZ28gdG8NCj4gZ2VuYWxsb2MNCj4gDQo+IE9uIE1vbiwgMjAx
NS0wNy0yNyBhdCAxNzo1NyArMDgwMCwgWmhhbyBRaWFuZyB3cm90ZToNCj4gDQo+IFdoZXJlJ3Mg
dGhlIHBhcnQgdGhhdCBhZGRzIHRoZSBhYmlsaXR5IHRvIHBhc3MgaW4gZGF0YSB0byBlYWNoIGFs
bG9jYXRpb24NCj4gY2FsbCwgYXMgcGVyIHRoZSBwcmV2aW91cyBkaXNjdXNzaW9uPw0KDQpZb3Ug
bWVhbnMgdG8gdXNlIGdlbl9wb29sX2FsbG9jX2RhdGEoKT8NClByZXZpb3VzbHkgeW91IHNhaWQg
dGhhdCB0aGUgZm9ybWF0IG9mIGRhdGEgaXMgYWxnb3JpdGhtLXNwZWNpZmljLA0KU28gSSB0aGlu
ayBpdCBpcyBiZXR0ZXIgdG8gaGFuZGxlIGRhdGEgaW4gYWxnb3JpdGhtIGZ1bmN0aW9uLg0KDQpJ
ZiB5b3Ugc3RpbGwgcHJlZmVyIGdlbl9wb29sX2FsbG9jX2RhdGEoKSwgSSB3aWxsIG1vZGlmeSBp
dC4NCkJ1dCB0aGVyZSBzdGlsbCBhcmUgZGV0YWlscyBJIHdhbnQgdG8gY29uZmlybSB3aXRoIHlv
dS4NCjEuIElmIHVzZSBnZW5fcG9vbF9hbGxvY19kYXRhKCksIHNob3VsZCBJIHBhc3MgZGF0YSBh
cyBhIHBhcmFtZXRlcj8NCjIuIFNob3VsZCBJIGNvdW50IGFsaWduX21hc2sgaW4gZ2VuX3Bvb2xf
YWxsb2NfZGF0YSgpLCBtZWFud2hpbGUsIGFkZCANCiAgIGEgYWxpZ25fbWFzayB0byBkYXRhIGFz
IGEgbWVtYmVyPw0KMy4gd2hlcmUgdG8gZGVmaW5lIHRoZSBkYXRhLCBpbiBnZW5hbGxvYy5oIG9y
IGNhbGxlciBsYXllcj8NCg0KPiANCj4gLVNjb3R0DQoNCg==
