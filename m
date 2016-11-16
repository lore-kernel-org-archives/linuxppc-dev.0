Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJXWL09WzzDvZ2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 16:14:54 +1100 (AEDT)
Message-ID: <1479273293.11921.1.camel@neuling.org>
Subject: Re: [PATCH] powerpc/mm/radix: Invalidate ERAT on tlbiel for POWER9 DD1
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mpe@ellerman.id.au
Cc: aneesh.kumar@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Date: Wed, 16 Nov 2016 16:14:53 +1100
In-Reply-To: <1479270952.2608.82.camel@kernel.crashing.org>
References: <20161116041820.28433-1-mikey@neuling.org>
 <1479270952.2608.82.camel@kernel.crashing.org>
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

T24gV2VkLCAyMDE2LTExLTE2IGF0IDE1OjM1ICsxMTAwLCBCZW5qYW1pbiBIZXJyZW5zY2htaWR0
IHdyb3RlOgo+IE9uIFdlZCwgMjAxNi0xMS0xNiBhdCAxNToxOCArMTEwMCwgTWljaGFlbCBOZXVs
aW5nIHdyb3RlOgo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGFzbSB2b2xhdGls
ZSgiaXN5bmMgXG4iCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIFBQQ19TTEJJQSgweDcpCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDogOiA6Im1lbW9yeSIpOwo+ID4gwqDC
oMKgwqDCoMKgwqDCoHJldHVybjsKPiA+IMKgfQo+ID4gCj4gCj4gV2UgcHJvYmFibHkgZG9uJ3Qg
bmVlZCB0aGUgaXN5bmMncwoKWWVwLCB0ZXN0aW5nIGNvbmZpcm1zIHRoYXQgdG9vLiBJJ2xsIHJl
c2VuZC4KClRoYW5rcywKTWlrZXkKCj4gCj4gPiBAQCAtODMsNiArODcsMTAgQEAgc3RhdGljIGlu
bGluZSB2b2lkIF90bGJpZWxfdmEodW5zaWduZWQgbG9uZyB2YSwKPiA+IHVuc2lnbmVkIGxvbmcg
cGlkLAo+ID4gwqDCoMKgwqDCoMKgwqDCoGFzbSB2b2xhdGlsZShQUENfVExCSUVMKCUwLCAlNCwg
JTMsICUyLCAlMSkKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
OiA6ICJyIihyYiksICJpIihyKSwgImkiKHBycyksICJpIihyaWMpLCAiciIocnMpCj4gPiA6ICJt
ZW1vcnkiKTsKPiA+IMKgwqDCoMKgwqDCoMKgwqBhc20gdm9sYXRpbGUoInB0ZXN5bmMiOiA6IDoi
bWVtb3J5Iik7Cj4gPiArwqDCoMKgwqDCoMKgwqBpZiAoY3B1X2hhc19mZWF0dXJlKENQVV9GVFJf
UE9XRVI5X0REMSkpCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYXNtIHZvbGF0
aWxlKCJpc3luYyBcbiIKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgUFBDX1NMQklBKDB4NykKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgOiA6IDoibWVtb3J5Iik7Cj4gPiDC
oH0KPiAKPiA=
