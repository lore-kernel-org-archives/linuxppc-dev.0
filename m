Return-Path: <R65777@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 096B92C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Oct 2013 14:42:53 +1100 (EST)
From: Bhushan Bharat-R65777 <R65777@freescale.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: RE: [PATCH 2/7] iommu: add api to get iommu_domain of a device
Date: Tue, 8 Oct 2013 03:42:45 +0000
Message-ID: <6A3DF150A5B70D4F9B66A25E3F7C888D071950B2@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1379575763-2091-1-git-send-email-Bharat.Bhushan@freescale.com>
 <1379575763-2091-3-git-send-email-Bharat.Bhushan@freescale.com>
 <1380127533.3030.319.camel@ul30vt.home>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0718FD1C@039-SN2MPN1-011.039d.mgd.msft.net>
 <1380901507.2673.204.camel@ul30vt.home>
 <6A3DF150A5B70D4F9B66A25E3F7C888D07190F35@039-SN2MPN1-011.039d.mgd.msft.net>
 <1380906772.25705.19.camel@ul30vt.home>
 <6A3DF150A5B70D4F9B66A25E3F7C888D07191143@039-SN2MPN1-011.039d.mgd.msft.net>
 <1380910322.25705.56.camel@ul30vt.home>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0719385B@039-SN2MPN1-011.039d.mgd.msft.net>
 <1381201980.6330.4.camel@ul30vt.home>
In-Reply-To: <1381201980.6330.4.camel@ul30vt.home>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "agraf@suse.de" <agraf@suse.de>, Wood Scott-B07421 <B07421@freescale.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "joro@8bytes.org" <joro@8bytes.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PiA+ID4gRG8geW91IHJlYWxseSB3YW50IG1vZHVsZSBkZXBlbmRlbmNpZXMgYmV0d2VlbiB2Zmlv
IGFuZCB5b3VyIGNvcmUNCj4gPiA+IGtlcm5lbCBNU0kgc2V0dXA/ICBMb29rIGF0IHRoZSB2Zmlv
IGV4dGVybmFsIHVzZXIgaW50ZXJmYWNlIHRoYXQgd2UndmUNCj4gYWxyZWFkeSBkZWZpbmVkLg0K
PiA+ID4gVGhhdCBhbGxvd3Mgb3RoZXIgY29tcG9uZW50cyBvZiB0aGUga2VybmVsIHRvIGdldCBh
IHByb3BlciByZWZlcmVuY2UNCj4gPiA+IHRvIGEgdmZpbyBncm91cC4gIEZyb20gdGhlcmUgeW91
IGNhbiB3b3JrIG91dCBob3cgdG8gZ2V0IHdoYXQgeW91DQo+ID4gPiB3YW50LiAgQW5vdGhlciBh
bHRlcm5hdGl2ZSBpcyB0aGF0IHZmaW8gY291bGQgcmVnaXN0ZXIgYW4gTVNJIHRvDQo+ID4gPiBJ
T1ZBIG1hcHBpbmcgd2l0aCBhcmNoaXRlY3R1cmUgY29kZSB3aGVuIHRoZSBtYXBwaW5nIGlzIGNy
ZWF0ZWQuDQo+ID4gPiBUaGUgTVNJIHNldHVwIHBhdGggY291bGQgdGhlbiBkbyBhIGxvb2t1cCBp
biBhcmNoaXRlY3R1cmUgY29kZSBmb3INCj4gPiA+IHRoZSBtYXBwaW5nLiAgWW91IGNvdWxkIGV2
ZW4gc3RvcmUgdGhlIE1TSSB0byBJT1ZBIG1hcHBpbmcgaW4gVkZJTw0KPiA+ID4gYW5kIGNyZWF0
ZSBhbiBpbnRlcmZhY2Ugd2hlcmUgU0VUX0lSUSBwYXNzZXMgdGhhdCBtYXBwaW5nIGludG8gc2V0
dXAgY29kZS4NCj4gPg0KPiA+IE9rLCBXaGF0IEkgd2FudCBpcyB0byBnZXQgSU9WQSBhc3NvY2lh
dGVkIHdpdGggYSBwaHlzaWNhbCBhZGRyZXNzDQo+ID4gKHBoeXNpY2FsIGFkZHJlc3Mgb2YgTVNJ
LWJhbmspLg0KPiA+IEFuZCBjdXJyZW50bHkgSSBkbyBub3Qgc2VlIGEgd2F5IHRvIGtub3cgSU9W
QSBvZiBhIHBoeXNpY2FsIGFkZHJlc3MNCj4gPiBhbmQgZG9pbmcgYWxsIHRoaXMgZG9tYWluIGdl
dCBhbmQgdGhlbiBzZWFyY2ggdGhyb3VnaCBhbGwgb2YNCj4gPiBpb21tdS13aW5kb3dzIG9mIHRo
YXQgZG9tYWluLg0KPiA+DQo+ID4gV2hhdCBpZiB3ZSBhZGQgYW4gaW9tbXUtQVBJIHdoaWNoIGNh
biByZXR1cm4gdGhlIElPVkEgbWFwcGluZyBvZiBhDQo+ID4gcGh5c2ljYWwgYWRkcmVzcy4gQ3Vy
cmVudCB1c2UgY2FzZSBpcyBzZXR0aW5nIHVwIE1TSSdzIGZvciBhcGVydHVyZQ0KPiA+IHR5cGUg
b2YgSU9NTVUgYWxzbyBnZXR0aW5nIGEgcGh5c190b19pb3ZhKCkgbWFwcGluZyBpcyBpbmRlcGVu
ZGVudCBvZg0KPiA+IFZGSU8sIHlvdXIgdGhvdWdodD8NCj4gDQo+IEEgcGh5c2ljYWwgYWRkcmVz
cyBjYW4gYmUgbWFwcGVkIHRvIG11bHRpcGxlIElPVkFzLCBzbyB0aGUgaW50ZXJmYWNlIHNlZW1z
DQo+IGZsYXdlZCBieSBkZXNpZ24uICBJdCBhbHNvIGhhcyB0aGUgc2FtZSBwcm9ibGVtIGFzIGFi
b3ZlLCBpdCdzIGEgYmFja2Rvb3IgdGhhdA0KPiBjYW4gYmUgY2FsbGVkIGFzeW5jaHJvbm91cyB0
byB0aGUgb3duZXIgb2YgdGhlIGRvbWFpbiwgc28gd2hhdCByZWFzb24gaXMgdGhlcmUNCj4gdG8g
YmVsaWV2ZSB0aGUgcmVzdWx0PyAgSXQganVzdCByZXBsYWNlcyBhbiBpb21tdV9kb21haW4gcG9p
bnRlciB3aXRoIGFuIElPVkEuDQo+IFZGSU8ga25vd3MgdGhpcyBtYXBwaW5nLCBzbyB3aHkgYXJl
IHdlIHRyeWluZyB0byBnbyBiZWhpbmQgaXRzIGJhY2sgYW5kIGFzayB0aGUNCj4gSU9NTVU/DQpJ
T01NVSBpcyB0aGUgZmluYWwgcGxhY2Ugd2hlcmUgbWFwcGluZyBpcyBjcmVhdGVkLCBzbyBtYXkg
YmUgdG9kYXkgaXQgaXMgY2FsbGluZyBvbiBiZWhhbGYgb2YgVkZJTywgdG9tb3Jyb3cgaXQgY2Fu
IGJlIGZvciBub3JtYWwgTGludXggb3Igc29tZSBvdGhlciBpbnRlcmZhY2UuIEJ1dCBJIGFtIGZp
bmUgdG8gZGlyZWN0bHkgdGFsayB0byB2ZmlvIGFuZCB3aWxsIG5vdCB0cnkgdG8gc29sdmUgYSBw
cm9ibGVtIHdoaWNoIGRvZXMgbm90IGV4aXN0cyB0b2RheS4NCg0KTVNJIHN1YnN5c3RlbSBrbm93
cyBwZGV2IChwY2kgZGV2aWNlKSBhbmQgcGh5c2ljYWwgYWRkcmVzcywgdGhlbiB3aGF0IGludGVy
ZmFjZSBpdCB3aWxsIHVzZSB0byBnZXQgdGhlIElPVkEgZnJvbSBWRklPPw0KDQpUaGFua3MNCi1C
aGFyYXQNCg0KPiAgVGhhbmtzLA0KPiANCj4gQWxleA0KPiANCg0K
