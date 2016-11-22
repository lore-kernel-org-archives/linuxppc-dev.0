Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tN8Nr6pxYzDwQv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 13:21:48 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAM2IPXE017184
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 21:21:46 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26vcxk8ftx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 21:21:46 -0500
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 21 Nov 2016 19:21:45 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 6/6] powerpc/mm: Batch tlb flush when invalidating pte
 entries
In-Reply-To: <1479760841.10230.47.camel@kernel.crashing.org>
References: <20161121183322.14585-1-aneesh.kumar@linux.vnet.ibm.com>
 <20161121183322.14585-6-aneesh.kumar@linux.vnet.ibm.com>
 <1479760841.10230.47.camel@kernel.crashing.org>
Date: Tue, 22 Nov 2016 07:51:38 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <87d1ho1cgd.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

QmVuamFtaW4gSGVycmVuc2NobWlkdCA8YmVuaEBrZXJuZWwuY3Jhc2hpbmcub3JnPiB3cml0ZXM6
DQoNCj4gT24gVHVlLCAyMDE2LTExLTIyIGF0IDAwOjAzICswNTMwLCBBbmVlc2ggS3VtYXIgSy5W
IHdyb3RlOg0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC8qDQo+PiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogSWYgd2UgYXJlIHRyeWluZyB0byBjbGVhciB0aGUg
cHRlLCB3ZSBjYW4gc2tpcA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIHRo
ZSBiZWxvdyBzZXF1ZW5jZSBhbmQgYmF0Y2ggdGhlIHRsYiBmbHVzaC4gVGhlDQo+PiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogdGxiIGZsdXNoIGJhdGNoaW5nIGlzIGRvbmUgYnkg
bW11IGdhdGhlciBjb2RlDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICovDQo+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKG5ld19wdGUpIHsNCj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYXNtIHZvbGF0aWxlKCJw
dGVzeW5jIiA6IDogOiAibWVtb3J5Iik7DQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHBzaXplID0gcmFkaXhfZ2V0X21tdV9wc2l6ZShwZ19zeik7DQo+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJhZGl4X19m
bHVzaF90bGJfcGFnZV9wc2l6ZShtbSwgYWRkciwgcHNpemUpOw0KPj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBfX3JhZGl4X3B0ZV91cGRhdGUocHRlcCwg
MCwgbmV3X3B0ZSk7DQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfQ0KPj4gwqDC
oMKgwqDCoMKgwqDCoH0gZWxzZQ0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBv
bGRfcHRlID0gX19yYWRpeF9wdGVfdXBkYXRlKHB0ZXAsIGNsciwgc2V0KTsNCj4NCj4gQ2FuIHlv
dSBjaGVjayB0aGUgdmFsaWQgYml0ID8gV2hhdCBpZiB3ZSBhcmUganVzdCBzZXR0aW5nIGEgc3dh
cCBQVEUNCj4gb24gdG9wIG9mIGFuIGludmFsaWQgb25lIGZvciBleGFtcGxlID8NCj4NCj4gU2hv
dWxkIHRoZSBhYm92ZSBjYXNlIGJlIGxpbWl0ZWQgdG8gYm90aCBvbGQgYW5kIG5ldyBiZWluZyB2
YWxpZCA/DQoNCldlIHNob3VsZCB1c2Ugc2V0X3B0ZV9hdCBpZiB0aGUgb2xkIHB0ZSBpcyBub3Qg
dmFsaWQgYW5kIHRoYXQgZG9lc24ndA0KaW52b2x2ZSBhIHRsYiBmbHVzaC4NCg0KLWFuZWVzaA0K
