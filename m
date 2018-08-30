Return-Path: <Pavel.Tatashin@microsoft.com>
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam03on0137.outbound.protection.outlook.com [104.47.41.137])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 421Xmz0wx2zF37P
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Aug 2018 05:36:50 +1000 (AEST)
From: Pasha Tatashin <Pavel.Tatashin@microsoft.com>
To: David Hildenbrand <david@redhat.com>, "linux-mm@kvack.org"
 <linux-mm@kvack.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, "Rafael J. Wysocki"
 <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Juergen Gross <jgross@suse.com>, Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>, Andrew Morton
 <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Dan Williams
 <dan.j.williams@intel.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil
 Babka <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>, Mathieu Malaterre
 <malat@debian.org>, YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>
Subject: Re: [PATCH RFCv2 2/6] mm/memory_hotplug: make add_memory() take the
 device_hotplug_lock
Date: Thu, 30 Aug 2018 19:36:43 +0000
Message-ID: <b535ed4a-faa1-9281-e759-ef4b599298ae@microsoft.com>
References: <20180821104418.12710-1-david@redhat.com>
 <20180821104418.12710-3-david@redhat.com>
In-Reply-To: <20180821104418.12710-3-david@redhat.com>
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

T24gOC8yMS8xOCA2OjQ0IEFNLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90ZToNCj4gYWRkX21lbW9y
eSgpIGN1cnJlbnRseSBkb2VzIG5vdCB0YWtlIHRoZSBkZXZpY2VfaG90cGx1Z19sb2NrLCBob3dl
dmVyDQo+IGlzIGFsZWFkeSBjYWxsZWQgdW5kZXIgdGhlIGxvY2sgZnJvbQ0KPiAJYXJjaC9wb3dl
cnBjL3BsYXRmb3Jtcy9wc2VyaWVzL2hvdHBsdWctbWVtb3J5LmMNCj4gCWRyaXZlcnMvYWNwaS9h
Y3BpX21lbWhvdHBsdWcuYw0KPiB0byBzeW5jaHJvbml6ZSBhZ2FpbnN0IENQVSBob3QtcmVtb3Zl
IGFuZCBzaW1pbGFyLg0KPiANCj4gSW4gZ2VuZXJhbCwgd2Ugc2hvdWxkIGhvbGQgdGhlIGRldmlj
ZV9ob3RwbHVnX2xvY2sgd2hlbiBhZGRpbmcgbWVtb3J5DQo+IHRvIHN5bmNocm9uaXplIGFnYWlu
c3Qgb25saW5lL29mZmxpbmUgcmVxdWVzdCAoZS5nLiBmcm9tIHVzZXIgc3BhY2UpIC0NCj4gd2hp
Y2ggYWxyZWFkeSByZXN1bHRlZCBpbiBsb2NrIGludmVyc2lvbnMgZHVlIHRvIGRldmljZV9sb2Nr
KCkgYW5kDQo+IG1lbV9ob3RwbHVnX2xvY2sgLSBzZWUgMzA0NjdlMGIzYmUgKCJtbSwgaG90cGx1
ZzogZml4IGNvbmN1cnJlbnQgbWVtb3J5DQo+IGhvdC1hZGQgZGVhZGxvY2siKS4gYWRkX21lbW9y
eSgpL2FkZF9tZW1vcnlfcmVzb3VyY2UoKSB3aWxsIGNyZWF0ZSBtZW1vcnkNCj4gYmxvY2sgZGV2
aWNlcywgc28gdGhpcyByZWFsbHkgZmVlbHMgbGlrZSB0aGUgcmlnaHQgdGhpbmcgdG8gZG8uDQo+
IA0KPiBIb2xkaW5nIHRoZSBkZXZpY2VfaG90cGx1Z19sb2NrIG1ha2VzIHN1cmUgdGhhdCBhIG1l
bW9yeSBibG9jayBkZXZpY2UNCj4gY2FuIHJlYWxseSBvbmx5IGJlIGFjY2Vzc2VkIChlLmcuIHZp
YSAub25saW5lLy5zdGF0ZSkgZnJvbSB1c2VyIHNwYWNlLA0KPiBvbmNlIHRoZSBtZW1vcnkgaGFz
IGJlZW4gZnVsbHkgYWRkZWQgdG8gdGhlIHN5c3RlbS4NCj4gDQo+IFRoZSBsb2NrIGlzIG5vdCBo
ZWxkIHlldCBpbg0KPiAJZHJpdmVycy94ZW4vYmFsbG9vbi5jDQo+IAlhcmNoL3Bvd2VycGMvcGxh
dGZvcm1zL3Bvd2VybnYvbWVtdHJhY2UuYw0KPiAJZHJpdmVycy9zMzkwL2NoYXIvc2NscF9jbWQu
Yw0KPiAJZHJpdmVycy9odi9odl9iYWxsb29uLmMNCj4gU28sIGxldCdzIGVpdGhlciB1c2UgdGhl
IGxvY2tlZCB2YXJpYW50cyBvciB0YWtlIHRoZSBsb2NrLg0KPiANCj4gRG9uJ3QgZXhwb3J0IGFk
ZF9tZW1vcnlfcmVzb3VyY2UoKSwgYXMgaXQgb25jZSB3YXMgZXhwb3J0ZWQgdG8gYmUgdXNlZA0K
PiBieSBYRU4sIHdoaWNoIGlzIG5ldmVyIGJ1aWx0IGFzIGEgbW9kdWxlLiBJZiBzb21lYm9keSBy
ZXF1aXJlcyBpdCwgd2UNCj4gYWxzbyBoYXZlIHRvIGV4cG9ydCBhIGxvY2tlZCB2YXJpYW50IChh
cyBkZXZpY2VfaG90cGx1Z19sb2NrIGlzIG5ldmVyDQo+IGV4cG9ydGVkKS4NCg0KUmV2aWV3ZWQt
Ynk6IFBhdmVsIFRhdGFzaGluIDxwYXZlbC50YXRhc2hpbkBtaWNyb3NvZnQuY29tPg==
