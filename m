Return-Path: <linuxppc-dev+bounces-20719-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6CFCCD37BE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 May 2026 21:58:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gDtrS6vDXz2xRw;
	Tue, 12 May 2026 07:58:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=141.14.17.11
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778536680;
	cv=none; b=Dtew+osHkaOUWwMR0UEkZJMlvM85sebpd4WbJw6RMrQEKKSKBDxJ5phoLF3CjdBngHlFo3+qoG/mh8JuHrtrKuL3nfRZfqQlGqpnebpRLWX3tpW0b5rFNh7bUqcIh6fxbP1ZIo2/LoiGOGadHjBVfjGGqrSL48SyDlJclJk94iZoixhAzCBCBcZICGnmPVHXZhOiqIrtZM4ERAw28l5laDLf/qVzX9GZ8X7hu0j4UftmXs2KyF8TafzCNCVnKEtXexI0Usv7rLVnch2+AkV0ZeXEXIx25FwxDn/q7LWIp7FdHbUjAgNEvgl8JS7TEF4zMTNDost64exB1EB2tG0aUg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778536680; c=relaxed/relaxed;
	bh=0y9bCwkULPMaD74a4Jizo8wULbnDYbw90+1zbRhnHl4=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=gX2M+1W8T+fH3ulcbEgAe5QGorXfh6ef0ThNdWkEziR1Zbv22s9DugiLUwdhCoUOyN/blnDZJWl7bpF4Xtpk5juRe8DlDDsKFAdHtYzRR1elQwYS8rk/WnygWJzndE4f47pweX7hbxubBUPskDAYqaOY854cJwF6k4Oj8nATyYiJHpoAr5HyXEKaMRNh4BswENGr0AfAXOBn6z+tqpbQE9UJJONrIbW52H8f6Wjf6b/PxPjBgGQQZmJMJ+11UyCR+stE+cXUGBtVRDjzuFOXUkWTfrky7RkyT9yhAvWHKNAQItOD0tDFZKHnfxzMrydriOHrW6Mcugz5wfY+bilkWA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass (client-ip=141.14.17.11; helo=mx3.molgen.mpg.de; envelope-from=pmenzel@molgen.mpg.de; receiver=lists.ozlabs.org) smtp.mailfrom=molgen.mpg.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=molgen.mpg.de (client-ip=141.14.17.11; helo=mx3.molgen.mpg.de; envelope-from=pmenzel@molgen.mpg.de; receiver=lists.ozlabs.org)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bit raw public key) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gDtrQ5mlyz2x9N
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2026 07:57:56 +1000 (AEST)
Received: from [192.168.0.192] (ip5f5af765.dynamic.kabel-deutschland.de [95.90.247.101])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 287E54C2C37F00;
	Mon, 11 May 2026 23:57:34 +0200 (CEST)
Content-Type: multipart/mixed; boundary="------------ZjKhgj2VAadPB7IkJSUJfcKq"
Message-ID: <69fa1c3f-3ea9-42cb-a49a-7da39f72806e@molgen.mpg.de>
Date: Mon, 11 May 2026 23:57:33 +0200
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: IBM Power S822LC: pci 0021:0d:00.0: xHCI HW did not halt within
 32000 usec status = 0x0
To: Michal Pecio <michal.pecio@gmail.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org
References: <fb68e15d-b8f2-42ac-aa65-0d9fedcfcdbd@molgen.mpg.de>
 <20260506193037.6de9e355.michal.pecio@gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260506193037.6de9e355.michal.pecio@gmail.com>

This is a multi-part message in MIME format.
--------------ZjKhgj2VAadPB7IkJSUJfcKq
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

[Cc: +linuxppc-dev]

Dear Michal,


Thank you for your reply.

Am 06.05.26 um 19:30 schrieb Michal Pecio:
> On Wed, 6 May 2026 18:06:20 +0200, Paul Menzel wrote:

>> On the IBM Power S822LC (8335-GCA POWER8), rebooting into Linux 7.1-rc2+
>> with kexec results in the warning below:
>>
>>       [    0.000000] Linux version 7.1.0-rc2+ (x@b) (gcc (Ubuntu 11.2.0-7ubuntu2) 11.2.0, GNU ld (GNU Binutils for Ubuntu) 2.37) #3 SMP PREEMPT Wed May  6 08:50:5
>>       […]
>>       [    0.000000] Hardware name: 8335-GCA POWER8 (raw) 0x4d0200 opal:skiboot-5.4.8-5787ad3 PowerNV
>>       […]
>>       [    1.593760] NET: Registered PF_UNIX/PF_LOCAL protocol family
>>       [    1.593859] pci 0021:0d:00.0: enabling device (0140 -> 0142)
>>       [    1.627080] pci 0021:0d:00.0: xHCI HW did not halt within 32000 usec status = 0x0
>>       [    1.627094] pci 0021:0d:00.0: quirk_usb_early_handoff+0x0/0x300 took 32465 usecs
>>       [    1.627123] PCI: CLS 0 bytes, default 128

> Does it work any better if kexecing other kernel versions?

No, the problem goes as far back as 5.17-rc7. (I didn’t try anything 
before.)

> What if you increase XHCI_MAX_HALT_USEC by 10* or 100* ?

I have to test this.

> Does the controller work normally after this warning?
It does not look like it. In the log attached to my report, later on 
there is:

     [    1.739374] xhci_hcd 0021:0d:00.0: xHCI Host Controller
     [    1.739431] xhci_hcd 0021:0d:00.0: new USB bus registered, 
assigned bus number 1
     [    1.794727] Freeing initrd memory: 52928K
     [    1.801984] xhci_hcd 0021:0d:00.0: Host halt failed, -110
     [    1.801988] xhci_hcd 0021:0d:00.0: can't setup: -110
     [    1.802137] xhci_hcd 0021:0d:00.0: USB bus 1 deregistered
     [    1.802154] xhci_hcd 0021:0d:00.0: init 0021:0d:00.0 fail, -110
     [    1.802250] xhci_hcd 0021:0d:00.0: probe with driver xhci_hcd 
failed with error -110

`lsusb` also does not list the device. But I need to check on hardware.


Kind regards,

Paul


PS: Claude Sonnet 4.6 cooked up the attached patch, which does *not* 
help though, but does get it to the return code 0x10, which Claude 
replied to with:

> ● The status change 0x0 → 0x10 is meaningful: 0x10 is PCD (Port Change Detect, bit 4),
>   HCHalted=0. The old-kernel reset (from our commit) did take effect …

Please excuse, if I attach/cite hallucinations.
--------------ZjKhgj2VAadPB7IkJSUJfcKq
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-usb-xhci-Reset-controller-on-kexec-to-prevent-stale-.patch"
Content-Disposition: attachment;
 filename*0="0001-usb-xhci-Reset-controller-on-kexec-to-prevent-stale-.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBiMTEwZDEyOGViZTY2MmEwMjMxOWFmNjg5OWQ4ZGM1MDc1OWExMTQ3IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBQYXVsIE1lbnplbCA8cG1lbnplbEBtb2xnZW4ubXBn
LmRlPgpEYXRlOiBNb24sIDExIE1heSAyMDI2IDE3OjMzOjM1ICswMjAwClN1YmplY3Q6IFtQ
QVRDSF0gdXNiOiB4aGNpOiBSZXNldCBjb250cm9sbGVyIG9uIGtleGVjIHRvIHByZXZlbnQg
c3RhbGUgc3RhdGUKIGluIG5leHQga2VybmVsCk1JTUUtVmVyc2lvbjogMS4wCkNvbnRlbnQt
VHlwZTogdGV4dC9wbGFpbjsgY2hhcnNldD1VVEYtOApDb250ZW50LVRyYW5zZmVyLUVuY29k
aW5nOiA4Yml0CgpXaGVuIGtleGVjIGlzIHVzZWQgdG8gYm9vdCBpbnRvIGEgbmV3IExpbnV4
IGtlcm5lbCwgeGhjaV9zaHV0ZG93bigpIG9ubHkKaGFsdHMgdGhlIHhIQ0kgY29udHJvbGxl
ciAoQ01EX1JVTj0wLCB3YWl0cyBmb3IgU1RTX0hBTFQpIHdpdGhvdXQKcmVzZXR0aW5nIGl0
LiAgQWZ0ZXIgaGFsdCwgdGhlIGNvbnRyb2xsZXIgc3RpbGwgaG9sZHMgc3RhbGUgaW50ZXJu
YWwgc3RhdGUKZnJvbSB0aGUgb2xkIGtlcm5lbDogdGhlIERDQkFBIHBvaW50ZXIsIHNjcmF0
Y2hwYWQgYnVmZmVyIGFkZHJlc3MsIGV2ZW50CmFuZCBjb21tYW5kIHJpbmcgZGVxdWV1ZSBw
b2ludGVycywgYW5kIHNvIG9uLCBhbGwgcG9pbnRpbmcgaW50byB0aGUgb2xkCmtlcm5lbCdz
IG5vdy1pbnZhbGlkIG1lbW9yeS4KCklmIHBsYXRmb3JtIGZpcm13YXJlIChlLmcuIE9QQUwg
b24gSUJNIFBPV0VSOCkgdGhlbiB0b3VjaGVzIHRoZSBVU0IKY29udHJvbGxlciBkdXJpbmcg
dGhlIGtleGVjIHRyYW5zaXRpb24g4oCTIGZvciBleGFtcGxlIHRvIHByb3ZpZGUgYSBVU0IK
a2V5Ym9hcmQgY29uc29sZSDigJMgaXQgbWF5IGF0dGVtcHQgdG8gdXNlIHRob3NlIHN0YWxl
IHJpbmctYnVmZmVyCnBvaW50ZXJzLiAgVGhpcyBsZWF2ZXMgdGhlIGNvbnRyb2xsZXIgaW4g
YW4gdW5kZWZpbmVkLCBydW5uaW5nIHN0YXRlCihTVFNfSEFMVD0wKSB3aGVuIHRoZSBuZXcg
a2VybmVsIGFycml2ZXMuICBUaGUgbmV3IGtlcm5lbCdzIGVhcmx5CnF1aXJrX3VzYl9oYW5k
b2ZmX3hoY2koKSBmaXh1cCB0aGVuIGZhaWxzIHRvIGhhbHQgdGhlIGNvbnRyb2xsZXIgYW5k
CnRoZSB4SENJIGRyaXZlciBjYW4gbm8gbG9uZ2VyIGluaXRpYWxpc2UgaXQsIHByb2R1Y2lu
ZzoKCiAgSUJNIFBvd2VyIFM4MjJMQzogcGNpIDAwMjE6MGQ6MDAuMDogeEhDSSBIVyBkaWQg
bm90IGhhbHQgd2l0aGluCiAgICAgICAgICAgICAgICAgICAgMzIwMDAgdXNlYyBzdGF0dXMg
PSAweDAKCkEgUGV0aXRib290LXRvLUxpbnV4IGtleGVjIGNoYWluIHdvcmtzIGNvcnJlY3Rs
eSBiZWNhdXNlIFBldGl0Ym9vdCwgYXMKdGhlIGFjdGl2ZSBVU0Igb3duZXIsIHByb3Blcmx5
IGhhbHRlZCB0aGUgY29udHJvbGxlcjsgdGhlIG5ldyBrZXJuZWwKZmluZHMgaXQgY2xlYW5s
eSBoYWx0ZWQuCgpGaXggdGhpcyBieSBpc3N1aW5nIGEgY29udHJvbGxlciByZXNldCAoQ01E
X1JFU0VUKSBhZnRlciB0aGUgaGFsdAp3aGVuZXZlciBrZXhlYyBpcyBpbiBwcm9ncmVzcy4g
IFRoZSByZXNldCBjbGVhcnMgYWxsIGludGVybmFsIHN0YXRlCihEQ0JBQSwgc2NyYXRjaHBh
ZCwgcmluZyBidWZmZXJzLCBwb3J0IHN0YXRlKSBzbyB0aGF0IGFueSBmaXJtd2FyZSBvcgp0
aGUgaW5jb21pbmcga2VybmVsIGFsd2F5cyBzdGFydHMgZnJvbSBhIHdlbGwta25vd24sIGlu
aXRpYWxpc2F0aW9uLXJlYWR5CnN0YXRlLiAgVGhpcyBtaXJyb3JzIHRoZSBhcHByb2FjaCBh
bHJlYWR5IHVzZWQgZm9yIHRoZQpYSENJX1NQVVJJT1VTX1dBS0VVUCBhbmQgWEhDSV9SRVNF
VF9UT19ERUZBVUxUIHF1aXJrcy4KCkxpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2Fs
bC9mYjY4ZTE1ZC1iOGYyLTQyYWMtYWE2NS0wZDlmZWRjZmNkYmRAbW9sZ2VuLm1wZy5kZS8K
U2lnbmVkLW9mZi1ieTogUGF1bCBNZW56ZWwgPHBtZW56ZWxAbW9sZ2VuLm1wZy5kZT4KQXNz
aXN0ZWQtYnk6IENsYXVkZSBTb25uZXQgNC42IDxub3JlcGx5QGFudGhyb3BpYy5jb20+Ci0t
LQogZHJpdmVycy91c2IvaG9zdC94aGNpLmMgfCAxMiArKysrKysrKystLS0KIDEgZmlsZSBj
aGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy91c2IvaG9zdC94aGNpLmMgYi9kcml2ZXJzL3VzYi9ob3N0L3hoY2kuYwppbmRl
eCBhNTRmNWI1N2YyMDU1Li41NTAzMWQwM2FkNDBlIDEwMDY0NAotLS0gYS9kcml2ZXJzL3Vz
Yi9ob3N0L3hoY2kuYworKysgYi9kcml2ZXJzL3VzYi9ob3N0L3hoY2kuYwpAQCAtOSw2ICs5
LDcgQEAKICAqLwogCiAjaW5jbHVkZSA8bGludXgvamlmZmllcy5oPgorI2luY2x1ZGUgPGxp
bnV4L2tleGVjLmg+CiAjaW5jbHVkZSA8bGludXgvcGNpLmg+CiAjaW5jbHVkZSA8bGludXgv
aW9tbXUuaD4KICNpbmNsdWRlIDxsaW51eC9pb3BvbGwuaD4KQEAgLTc3NSwxMSArNzc2LDE2
IEBAIHZvaWQgeGhjaV9zaHV0ZG93bihzdHJ1Y3QgdXNiX2hjZCAqaGNkKQogCXhoY2lfaGFs
dCh4aGNpKTsKIAogCS8qCi0JICogV29ya2Fyb3VuZCBmb3Igc3B1cmlvdXMgd2FrZXBzIGF0
IHNodXRkb3duIHdpdGggSFNXLCBhbmQgZm9yIGJvb3QKLQkgKiBmaXJtd2FyZSBkZWxheSBp
biBBREwtUCBQQ0ggaWYgcG9ydCBhcmUgbGVmdCBpbiBVMyBhdCBzaHV0ZG93bgorCSAqIFdv
cmthcm91bmQgZm9yIHNwdXJpb3VzIHdha2V1cHMgYXQgc2h1dGRvd24gd2l0aCBIU1csIGFu
ZCBmb3IgYm9vdAorCSAqIGZpcm13YXJlIGRlbGF5IGluIEFETC1QIFBDSCBpZiBwb3J0cyBh
cmUgbGVmdCBpbiBVMyBhdCBzaHV0ZG93bi4KKwkgKiBBbHNvIHJlc2V0IG9uIGtleGVjIHRv
IGxlYXZlIHRoZSBjb250cm9sbGVyIGluIGEgY2xlYW4gc3RhdGUgd2l0aAorCSAqIGFsbCBp
bnRlcm5hbCBzdGF0ZSAoRENCQUEsIHNjcmF0Y2hwYWQsIHJpbmdzKSBjbGVhcmVkLCBzbyB0
aGUgbmV4dAorCSAqIGtlcm5lbCBjYW4gaW5pdGlhbGl6ZSBpdCB3aXRob3V0IGludGVyZmVy
ZW5jZSBmcm9tIHN0YWxlIHBvaW50ZXJzCisJICogaW50byB0aGUgb2xkIGtlcm5lbCdzIG1l
bW9yeS4KIAkgKi8KIAlpZiAoeGhjaS0+cXVpcmtzICYgWEhDSV9TUFVSSU9VU19XQUtFVVAg
fHwKLQkgICAgeGhjaS0+cXVpcmtzICYgWEhDSV9SRVNFVF9UT19ERUZBVUxUKQorCSAgICB4
aGNpLT5xdWlya3MgJiBYSENJX1JFU0VUX1RPX0RFRkFVTFQgfHwKKwkgICAga2V4ZWNfaW5f
cHJvZ3Jlc3MpCiAJCXhoY2lfcmVzZXQoeGhjaSwgWEhDSV9SRVNFVF9TSE9SVF9VU0VDKTsK
IAogCXNwaW5fdW5sb2NrX2lycSgmeGhjaS0+bG9jayk7Ci0tIAoyLjU0LjAKCg==

--------------ZjKhgj2VAadPB7IkJSUJfcKq--

