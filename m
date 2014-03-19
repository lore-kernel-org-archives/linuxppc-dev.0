Return-Path: <xuelin.shi@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0210.outbound.protection.outlook.com [207.46.163.210])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B1DBE2C009A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Mar 2014 17:55:25 +1100 (EST)
From: Xuelin Shi <xuelin.shi@freescale.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: RE: [PATCH] fix dmaengine_unmap failure.
Date: Wed, 19 Mar 2014 06:39:59 +0000
Message-ID: <30ef7093dcc247e490831a43355ec10f@BL2PR03MB147.namprd03.prod.outlook.com>
References: <1395131520-30207-1-git-send-email-xuelin.shi@freescale.com>
 <CAPcyv4gs-jos5TvfDbsaXTNebQf8VjJvbdjmjsbGZLZwZKi34g@mail.gmail.com>
In-Reply-To: <CAPcyv4gs-jos5TvfDbsaXTNebQf8VjJvbdjmjsbGZLZwZKi34g@mail.gmail.com>
Content-Type: text/plain; charset="gb2312"
MIME-Version: 1.0
Cc: Vinod Koul <vinod.koul@intel.com>,
 "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

SGkgRGFuLA0KDQpJbiBhc3luY19tdWx0KC4uLikgb2YgYXN5bmNfcmFpZDZfcmVjb3YuYywgdGhl
IGNvdW50IDMgaXMgdXNlZCB0byByZXF1ZXN0IGFuIHVubWFwLg0KSG93ZXZlciB0aGUgdG9fY250
IGFuZCBiaWRpX2NudCBhcmUgYm90aCBzZXQgdG8gMSBhbmQgZnJvbV9jbnQgdG8gMC4NClRoZW4g
d2hpbGUgdHJ5aW5nIHRvIGRvIHVubWFwLCB3ZSBhcmUgZ2V0dGluZyB0aGUgd3JvbmcgInVubWFw
IiBmcm9tIGEgZGlmZmVyZW50IG1lbXBvb2wuDQoNCkluIHRoaXMgcGF0Y2gsIHRoZSBtZW1wb29s
IGlzIGFzc29jaWF0ZWQgd2l0aCB0aGUgdW5tYXAgc3RydWN0dXJlIGluc3RlYWQgb2YgY29tcHV0
aW5nIGl0IGFnYWluLg0KQnkgdGhpcyB3YXksIGl0IGlzIGd1YXJhbnRlZWQgdGhhdCB0aGUgdW5t
YXAgaXMgdGhlIHNhbWUgd2hlbiB3ZSBnZXQgYW5kIHB1dCB0aGUgdW5tYXAgZGF0YS4NCg0KQlRX
OiB0aGUgbWVtcG9vbCBpcyBqdXN0IHVzZWQgdG8gbWFuYWdlIHRoZSBzdHJ1Y3QgdW5tYXAsIG5v
dCB0aGUgcGFnZXMuDQoNClRoYW5rcywNClh1ZWxpbiBTaGkNCg0KDQotLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KRnJvbTogRGFuIFdpbGxpYW1zIFttYWlsdG86ZGFuLmoud2lsbGlhbXNAaW50
ZWwuY29tXSANClNlbnQ6IDIwMTTE6jPUwjE5yNUgMToxNA0KVG86IFNoaSBYdWVsaW4tQjI5MjM3
DQpDYzogVmlub2QgS291bDsgbGludXhwcGMtZGV2OyBkbWFlbmdpbmVAdmdlci5rZXJuZWwub3Jn
DQpTdWJqZWN0OiBSZTogW1BBVENIXSBmaXggZG1hZW5naW5lX3VubWFwIGZhaWx1cmUuDQoNCk9u
IFR1ZSwgTWFyIDE4LCAyMDE0IGF0IDE6MzIgQU0sICA8eHVlbGluLnNoaUBmcmVlc2NhbGUuY29t
PiB3cm90ZToNCj4gRnJvbTogWHVlbGluIFNoaSA8eHVlbGluLnNoaUBmcmVlc2NhbGUuY29tPg0K
Pg0KPiBUaGUgY291bnQgd2hpY2ggaXMgdXNlZCB0byBnZXRfdW5tYXBfZGF0YSBtYXliZSBub3Qg
dGhlIHNhbWUgYXMgdGhlIA0KPiBjb3VudCBjb21wdXRlZCBpbiBkbWFlbmdpbmVfdW5tYXAgd2hp
Y2ggY2F1c2VzIHRvIGZyZWUgZGF0YSBpbiBhIHdyb25nIA0KPiBwb29sLg0KPg0KPiBUaGlzIHBh
dGNoIGZpeGVzIHRoaXMgaXNzdWUgYnkga2VlcGluZyB0aGUgcG9vbCBpbiB1bm1hcF9kYXRhIA0K
PiBzdHJ1Y3R1cmUuDQoNCldvbid0IHRoaXMgZnJlZSB0aGUgZW50aXJlIGNvdW50IGFueXdheXM/
ICBJbiB3aGF0IHNjZW5hcmlvIGlzIHRoZSBjb3VudCBkaWZmZXJlbnQgYXQgdW5tYXA/DQoNCg0K
