Return-Path: <seiji.aguchi@hds.com>
Received: from usindpps04.hds.com (usindpps04.hds.com [207.126.252.17])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 73E2D2C00A3
 for <linuxppc-dev@ozlabs.org>; Fri, 23 Aug 2013 09:43:20 +1000 (EST)
From: Seiji Aguchi <seiji.aguchi@hds.com>
To: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>, "linuxppc-dev@ozlabs.org"
 <linuxppc-dev@ozlabs.org>, "tony.luck@intel.com" <tony.luck@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "keescook@chromium.org" <keescook@chromium.org>
Subject: RE: [RFC PATCH v2 06/11] pstore: Add decompression support to pstore
Date: Thu, 22 Aug 2013 23:04:11 +0000
Message-ID: <A5ED84D3BB3A384992CBB9C77DEDA4D443E8F0B8@USINDEM103.corp.hds.com>
References: <20130816131403.3338.82330.stgit@aruna-ThinkPad-T420>
 <20130816131821.3338.27923.stgit@aruna-ThinkPad-T420>
In-Reply-To: <20130816131821.3338.27923.stgit@aruna-ThinkPad-T420>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "jkenisto@linux.vnet.ibm.com" <jkenisto@linux.vnet.ibm.com>,
 "cbouatmailru@gmail.com" <cbouatmailru@gmail.com>,
 "mahesh@linux.vnet.ibm.com" <mahesh@linux.vnet.ibm.com>,
 "ccross@android.com" <ccross@android.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbGludXgta2VybmVsLW93
bmVyQHZnZXIua2VybmVsLm9yZyBbbWFpbHRvOmxpbnV4LWtlcm5lbC1vd25lckB2Z2VyLmtlcm5l
bC5vcmddIE9uIEJlaGFsZiBPZiBBcnVuYSBCYWxha3Jpc2huYWlhaA0KPiBTZW50OiBGcmlkYXks
IEF1Z3VzdCAxNiwgMjAxMyA5OjE4IEFNDQo+IFRvOiBsaW51eHBwYy1kZXZAb3psYWJzLm9yZzsg
dG9ueS5sdWNrQGludGVsLmNvbTsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsga2Vlc2Nv
b2tAY2hyb21pdW0ub3JnDQo+IENjOiBqa2VuaXN0b0BsaW51eC52bmV0LmlibS5jb207IGFuYW50
aEBpbi5pYm0uY29tOyBiZW5oQGtlcm5lbC5jcmFzaGluZy5vcmc7IGNib3VhdG1haWxydUBnbWFp
bC5jb207DQo+IG1haGVzaEBsaW51eC52bmV0LmlibS5jb207IGNjcm9zc0BhbmRyb2lkLmNvbQ0K
PiBTdWJqZWN0OiBbUkZDIFBBVENIIHYyIDA2LzExXSBwc3RvcmU6IEFkZCBkZWNvbXByZXNzaW9u
IHN1cHBvcnQgdG8gcHN0b3JlDQo+IA0KPiBCYXNlZCBvbiB0aGUgZmxhZyAnY29tcHJlc3NlZCcg
c2V0IG9yIG5vdCwgcHN0b3JlIHdpbGwgZGVjb21wcmVzcyB0aGUNCj4gZGF0YSByZXR1cm5pbmcg
YSBwbGFpbiB0ZXh0IGZpbGUuIElmIGRlY29tcHJlc3Npb24gZmFpbHMgZm9yIGEgcGFydGljdWxh
cg0KPiByZWNvcmQgaXQgd2lsbCBoYXZlIHRoZSBjb21wcmVzc2VkIGRhdGEgaW4gdGhlIGZpbGUg
d2hpY2ggY2FuIGJlDQo+IGRlY29tcHJlc3NlZCB3aXRoICdvcGVuc3NsJyBjb21tYW5kIGxpbmUg
dG9vbC4NCg0KSWYgdGhlIGRlY29tcHJlc3Npb24gZmFpbHMgYW5kIG9wZW5zc2wgZG9lc24ndCB3
b3JrLCB0aGUgd29yc3QgY2FzZSBpcyB0aGF0IHVzZXJzIGNhbid0IHJlYWQgdGhlIGVudHJ5Lg0K
SW4gdGhhdCBjYXNlLCBwc3RvcmUgaXMgbWVhbmluZ2xlc3MgYXQgYWxsLg0KDQpBbHNvLCBmb3Ig
dXNlcnMgd2hvIHdhbnQgdG8gZ2V0IGEgc2luZ2xlIHBhbmljIG1lc3NhZ2UsIGEgY29tcHJlc3Np
b24gaXMgbm90IG5lZWRlZC4NCg0KU28sIEkgdGhpbmsgd2Ugc3RpbGwgaGF2ZSB0byBzdXBwb3J0
IG5vbi1jb21wcmVzc2lvbiBtb2RlLg0KKElNTywgcHN0b3JlIGNhbiB0YWtlIGtkdW1wIGFzIGEg
bW9kZWwuIEtkdW1wIHN1cHBvcnRzIGJvdGggY29tcHJlc3Npb24gYW5kIG5vbi1jb21wcmVzc2lv
biBtb2RlLikNCg0KQnV0LCBpZiB5b3UgdGhpbmsgbXkgY29tbWVudCBpcyBvdXRzaWRlIHRoaXMg
cGF0Y2hzZXQsIGl0J3MgT0suDQpXZSBjYW4gbWFrZSBpdCB3aXRoIGEgc2VwYXJhdGUgcGF0Y2gu
DQoNClNlaWppDQo=
