Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xJ3tc41DHzDqpR
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 17:45:44 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Brijesh Singh' <brijesh.singh@amd.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Arnd Bergmann <arnd@arndb.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>, "linux-efi@vger.kernel.org"
 <linux-efi@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Fenghua Yu <fenghua.yu@intel.com>, Matt Fleming <matt@codeblueprint.co.uk>,
 David Howells <dhowells@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Christoph Lameter <cl@linux.com>, Jonathan Corbet <corbet@lwn.net>,
 =?utf-8?B?UmFkaW0gS3JjbcOhcg==?= <rkrcmar@redhat.com>, Piotr Luc
 <piotr.luc@intel.com>, Ingo Molnar <mingo@redhat.com>, Dave Airlie
 <airlied@redhat.com>, Borislav Petkov <bp@suse.de>, Tom Lendacky
 <thomas.lendacky@amd.com>, Kees Cook <keescook@chromium.org>, "Konrad
 Rzeszutek Wilk" <konrad.wilk@oracle.com>, Reza Arbab
 <arbab@linux.vnet.ibm.com>, Andy Lutomirski <luto@kernel.org>, "Thomas
 Gleixner" <tglx@linutronix.de>, Laura Abbott <labbott@redhat.com>, Tony Luck
 <tony.luck@intel.com>, "Ard.Biesheuvel@zytor.com" <Ard.Biesheuvel@zytor.com>
Subject: RE: [RFC Part1 PATCH v3 13/17] x86/io: Unroll string I/O when SEV
 is active
Date: Thu, 27 Jul 2017 07:45:25 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD00436A7@AcuExch.aculab.com>
References: <20170724190757.11278-1-brijesh.singh@amd.com>
 <20170724190757.11278-14-brijesh.singh@amd.com>
 <063D6719AE5E284EB5DD2968C1650D6DD003FB85@AcuExch.aculab.com>
 <CAK8P3a3h7JpmkW7W=HwqAuWWmro=ngj6HSeiiML_=T82x-FtZQ@mail.gmail.com>
 <ed6d4ce7-97a6-f664-d7d7-4ff48bc6f06a@amd.com>
 <201707261927.v6QJR228008075@mail.zytor.com>
 <589d65a4-eb09-bae9-e8b4-a2d78ca6b509@amd.com>
In-Reply-To: <589d65a4-eb09-bae9-e8b4-a2d78ca6b509@amd.com>
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

RnJvbTogQnJpamVzaCBTaW5naA0KPiBTZW50OiAyNiBKdWx5IDIwMTcgMjE6MDcNCi4uLg0KPiBJ
IGFtIG5vdCBzdXJlIGlmIEkgdW5kZXJzdGFuZCB5b3VyIGNvbmNlcm4uDQo+IA0KPiBBcmUgeW91
IGNvbW1lbnRpbmcgb24gYW1vdW50IG9mIGNvZGUgZHVwbGljYXRpb24gPyBJZiBzbywgSSBjYW4g
Y2VydGFpbmx5IGltcHJvdmUNCj4gYW5kIHVzZSB0aGUgc2ltaWxhciBtYWNybyB1c2VkIGludG8g
aGVhZGVyIGZpbGUgdG8gZ2VuZXJhdGUgdGhlIGZ1bmN0aW9ucyBib2R5Lg0KDQpJZiB5b3UgYXJl
IGNhcmVmdWwgdGhlIHJlYWwgZnVuY3Rpb25zIGNvdWxkIGV4cGFuZCB0aGUgaW5saW5lIGZ1bmN0
aW9ucw0KdGhhdCBnZXQgdXNlZCB3aGVuIFNFViBpcyBjb21waWxlZCBvdXQuDQoNCk9oLCBpZiB5
b3UgYXJlIGxvb2tpbmcgYXQgdGhpcywgY2FuIHlvdSBmaXggbWVtY3B5X3RvX2lvKCkNCnNvIHRo
YXQgaXQgaXMgbmV2ZXIgJ3JlcCBtb3ZzYic/DQoNCglEYXZpZA0KDQo=
