Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xyKLb39qFzDrCn
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Sep 2017 11:50:15 +1000 (AEST)
Message-ID: <1505958614.15768.1.camel@neuling.org>
Subject: Re: [PATCH 2/2] powerpc: Handle MCE on POWER9 with only DSISR bit
 33 set
From: Michael Neuling <mikey@neuling.org>
To: Balbir Singh <bsingharora@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, "open list:LINUX FOR POWERPC
 (32-BIT AND 64-BIT)" <linuxppc-dev@lists.ozlabs.org>
Date: Thu, 21 Sep 2017 11:50:14 +1000
In-Reply-To: <CAKTCnz=8vDAb45wgq1NsoKUwaJFfwUvZoGJ44ip54UPc5wg6PQ@mail.gmail.com>
References: <20170915052549.8105-1-mikey@neuling.org>
 <20170915052549.8105-2-mikey@neuling.org>
 <CAKTCnz=8vDAb45wgq1NsoKUwaJFfwUvZoGJ44ip54UPc5wg6PQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Cj4gPiArwqDCoMKgwqDCoMKgwqAvKgo+ID4gK8KgwqDCoMKgwqDCoMKgwqAqIE9uIFBPV0VSOSBE
RDIuMSBhbmQgYmVsb3csIGl0J3MgcG9zc2libGUgdG8gZ2V0IG1hY2hpbmUKPiA+ICvCoMKgwqDC
oMKgwqDCoMKgKiBjaGVjayB3aGVyZSBvbmx5IERTSVNSIGJpdCAzMyBpcyBzZXQuIFRoaXMgd2ls
bCByZXN1bHQgaW4KPiA+ICvCoMKgwqDCoMKgwqDCoMKgKiB0aGUgTUNFIGhhbmRsZXIgc2VlaW5n
IGFuIHVua25vd24gZXZlbnQgYW5kIHVzIGNyYXNoaW5nLgo+ID4gK8KgwqDCoMKgwqDCoMKgwqAq
IENoYW5nZSB0aGlzIHRvIG1hcmsgYXMgaGFuZGxlZCBvbiB0aGVzZSByZXZpc2lvbnMuCj4gPiAr
wqDCoMKgwqDCoMKgwqDCoCovCj4gPiArwqDCoMKgwqDCoMKgwqBwdnIgPSBtZnNwcihTUFJOX1BW
Uik7Cj4gPiArwqDCoMKgwqDCoMKgwqBpZiAoKChQVlJfVkVSKHB2cikgPT0gUFZSX1BPV0VSOSkg
JiYKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAoUFZSX0NGRyhwdnIpID09IDIpICYmCj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgKFBWUl9NSU4ocHZyKSA8PSAxKSkgfHwgY3B1X2hh
c19mZWF0dXJlKENQVV9GVFJfUE9XRVI5X0REMSkpCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgLyogREQyLjEgYW5kIGJlbG93ICovCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgaWYgKG1jZV9lcnIuZXJyb3JfdHlwZSA9PSBNQ0VfRVJST1JfVFlQRV9VTktOT1dO
KQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaGFuZGxlZCA9IDE7
Cj4gPiArCj4gCj4gV2hhdCBkb2VzIHRoaXMgbWVhbiBpbiB0ZXJtcyBvZiBoYW5kbGluZz8gU2lu
Y2Ugd2UgZG8gbm90IGtub3cgdGhlIGV2ZW50LAo+IGhvdyBkbyB3ZSByZWNvdmVyL2hhbmRsZT8g
VGhlIHN5c3RlbSB3aWxsIGFueXdheSBjcmFzaCBmb3Igbm90LXJlY292ZXJlZAo+IGNhc2VzLiBE
b2VzIHRoaXMgcHJldmVudCB1cyBmcm9tIHNlZWluZyB0aGUgc2FtZSBleGNlcHRpb24gc2V2ZXJh
bCB0aW1lcz8KClNvIHRoZSBNQ0UgaXMgc3B1cmlvdXMsIHNvIHdlIGRvbid0IG5lZWQgdG8gZG8g
YW55dGhpbmcgaW4gdGVybXMgb2Ygc2VydmljaW5nCml0LiBJZiB0aGVyZSBpcyBzb21ldGhpbmcg
dGhhdCBuZWVkcyB0byBiZSBzZXJ2aWNlZCwgdGhlIENQVSB3aWxsIHJhaXNlIHRoZSBNQ0UKYWdh
aW4gd2l0aCB0aGUgY29ycmVjdCBEU0lTUiBzbyB0aGF0IGl0IGNhbiBiZSBzZXJ2aWNlZC4KCkkn
bGwgYWRkIGEgY29tbWVudCB0byB0aGF0IGVmZmVjdCBhbmQgcmVwb3J0LgoKVGhhbmtzCk1pa2V5
