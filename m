Return-Path: <prvs=441ccb01c=michael.tessier@axiontech.ca>
Received: from mail.axiontech.ca (unknown [207.164.255.36])
 by lists.ozlabs.org (Postfix) with ESMTP id EC4A11A0007
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jan 2015 03:50:24 +1100 (AEDT)
From: Michael Tessier <michael.tessier@axiontech.ca>
To: Fabio Estevam <festevam@gmail.com>
Subject: RE: PROBLEM: USB isochronous urb leak on EHCI driver
Date: Tue, 6 Jan 2015 16:50:22 +0000
Message-ID: <66A26A9AA227D947AF088537F041526E2009D3@VSVR-EX10-MB1.pocatec.com>
References: <66A26A9AA227D947AF088537F041526E1FF44F@VSVR-EX10-MB1.pocatec.com>
 <Pine.LNX.4.44L0.1412171119590.2947-100000@netrider.rowland.org>
 <66A26A9AA227D947AF088537F041526E2008FE@VSVR-EX10-MB1.pocatec.com>
 <CAOMZO5DESCa3BOYwv0rAkoWLgTYwDdrYkNbr_jjW30s9UfR5RA@mail.gmail.com>
In-Reply-To: <CAOMZO5DESCa3BOYwv0rAkoWLgTYwDdrYkNbr_jjW30s9UfR5RA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Alan Stern <stern@rowland.harvard.edu>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQo+ID4gSWYgc291bmQgaXMgb2sgd2hlbiB1c2luZyBvbmx5IDEgY29kZWMgYW5kIGJlY29tZXMg
Y2hvcHB5IHdoZW4gYWRkaW5nIA0KPiA+IGEgc2Vjb25kIGNvZGVjLCB0aGVuIGl0IG1lYW5zIHRo
YXQgdGhpcyBpc3N1ZSBpcyBzdGlsbCBpbiB0aGUgMy54IA0KPiA+IGtlcm5lbC4gVGhpcyBhbnN3
ZXIgd2lsbCB0ZWxsIG1lIGlmIGl0IGlzIHdvcnRoIHdvcmtpbmcgb24gdXNpbmcgYSBuZXdlciBr
ZXJuZWwgb3Igbm90Lg0KPiA+IEkgaGF2ZSB0byBzYXkgdGhhdCBJJ20gbm90IGEgbGludXggZXhw
ZXJ0LCBzbyBJIHNlZSB0aGUgbWlncmF0aW9uIHRvIGEgDQo+ID4gbmV3ZXIga2VybmVsIGFzIGEg
cXVpdGUgYmlnIGFtb3VudCBvZiB3b3JrLi4uDQo+DQo+IFdlIGhhdmUgc3VwcG9ydCBmb3IgbXg1
MSBvbiB0aGUgbGF0ZXN0IGtlcm5lbC4gQWxsIHlvdSBuZWVkIHRvIGRvIGlzIHRvIGRlc2NyaWJl
IHlvdXIgaGFyZHdhcmUgb24gYSBkZXZpY2UgdHJlZSBmaWxlLiBZb3UgY2FuIHJlZmVyIHRvIGFy
Y2gvYXJtL2Jvb3QvZHRzL2lteDUxLWJhYmJhZ2UuZHRzIGFzIGFuIGV4YW1wbGUuDQo+DQo+IFNo
b3VsZCBiZSBzaW1wbGUgZm9yIHlvdSB0byBtYWtlIHN1Y2ggdGVzdCB3aXRoIHRoZSBsYXRlc3Qg
a2VybmVsLg0KDQpJJ2xsIHRyeSB0byBkbyBzby4gTXkgbWFpbiBjb25jZXJuIGlzIHRoYXQgZXZl
biBpZiBpdCBoYXMgYmVlbiBjb3JyZWN0ZWQNCmluIHRoZSBsYXN0IGtlcm5lbCwgSSdtIG5vdCBm
cmVlIHRvIGp1c3QgdXNlIHRoZSBsYXN0IGtlcm5lbDsgb3VyIGN1c3RvbWVycw0KYWxyZWFkeSBo
YXZlIHVuaXRzIGluIHRoZWlyIGhhbmRzLCBhbmQgdGhleSBib3VnaHQgdXMgYSAiRm9ybSBGaXQg
JiBGdW5jdGlvbiINCnBsYXR0Zm9ybS4gV2UgaGF2ZSBhIGh1Z2UgYnVuY2ggb2YgZG9jdW1lbnRh
dGlvbiBjb21pbmcgd2l0aCBlYWNoIGRlbGl2ZXJhYmxlDQoocGFydCBvZiBhbiBJU08gcHJvY2Vz
cywgZm9sbG93aW5nIElFRUUgc29mdHdhcmUgc3RhbmRhcmRzKS4gU28gZm9yIHRoZQ0KY29tcGFu
eSwgbWlncmF0aW5nIHRvIHRoZSBsYXRlc3Qga2VybmVsIGlzIHRoZSBsYXN0IHJlc29ydCBiZWNh
dXNlIG9mIHRoZQ0KYW1vdW50IG9mIHdvcmsgaXQgd291bGQgcmVxdWlyZS4gVGhhbmtzIGZvciB0
aGUgaWRlYSwgSSdsbCBsZXQgeW91IGtub3cuDQoNCk1pY2hhZWwgVGVzc2llcg0K
