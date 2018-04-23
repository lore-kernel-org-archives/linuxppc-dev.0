Return-Path: <srs0=wz6g=hm=gmail.com=bsingharora@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40V1HC54bhzDrJw
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Apr 2018 19:23:51 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40V1HC4K32z8swl
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Apr 2018 19:23:51 +1000 (AEST)
Received: from mail-ua0-x244.google.com (mail-ua0-x244.google.com
 [IPv6:2607:f8b0:400c:c08::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40V1HB6sRdz9ryr
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Apr 2018 19:23:50 +1000 (AEST)
Received: by mail-ua0-x244.google.com with SMTP id s15so9733906uae.10
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Apr 2018 02:23:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKTCnznTiS2kQThYrCALGGKb8DfAu-diYzrCbOzwO2vd7Cfw9Q@mail.gmail.com>
References: <152445952887.3244.567606806755236868.stgit@jupiter.in.ibm.com>
 <CAKTCnznTiS2kQThYrCALGGKb8DfAu-diYzrCbOzwO2vd7Cfw9Q@mail.gmail.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Mon, 23 Apr 2018 19:23:47 +1000
Message-ID: <CAKTCnznXan87jiGbTpuv2aNKo93UoC0J=THD=7r-7P8TVj0XUw@mail.gmail.com>
Subject: Re: [PATCH] powerpc/mce: Fix a bug where mce loops on memory UE.
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: multipart/mixed; boundary="001a113d71cc5dc4b1056a80987c"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001a113d71cc5dc4b1056a80987c
Content-Type: text/plain; charset="UTF-8"

On Mon, Apr 23, 2018 at 4:51 PM, Balbir Singh <bsingharora@gmail.com> wrote:
> On Mon, Apr 23, 2018 at 2:59 PM, Mahesh J Salgaonkar
> <mahesh@linux.vnet.ibm.com> wrote:
>> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>>
>> The current code extracts the physical address for UE errors and then
>> hooks it up into memory failure infrastructure. On successful extraction
>> of physical address it wrongly sets "handled = 1" which means this UE error
>> has been recovered. Since MCE handler gets return value as handled = 1, it
>> assumes that error has been recovered and goes back to same NIP. This causes
>> MCE interrupt again and again in a loop leading to hard lockup.
>>
>> Also, initialize phys_addr to ULONG_MAX so that we don't end up queuing
>> undesired page to hwpoison.
>>
>> Without this patch we see:
>> [ 1476.541984] Severe Machine check interrupt [Recovered]
>> [ 1476.541985]   NIP: [000000001002588c] PID: 7109 Comm: find
>> [ 1476.541986]   Initiator: CPU
>> [ 1476.541987]   Error type: UE [Load/Store]
>> [ 1476.541988]     Effective address: 00007fffd2755940
>> [ 1476.541989]     Physical address:  000020181a080000
>> [...]
>> [ 1476.542003] Severe Machine check interrupt [Recovered]
>> [ 1476.542004]   NIP: [000000001002588c] PID: 7109 Comm: find
>> [ 1476.542005]   Initiator: CPU
>> [ 1476.542006]   Error type: UE [Load/Store]
>> [ 1476.542006]     Effective address: 00007fffd2755940
>> [ 1476.542007]     Physical address:  000020181a080000
>> [ 1476.542010] Severe Machine check interrupt [Recovered]
>> [ 1476.542012]   NIP: [000000001002588c] PID: 7109 Comm: find
>> [ 1476.542013]   Initiator: CPU
>> [ 1476.542014]   Error type: UE [Load/Store]
>> [ 1476.542015]     Effective address: 00007fffd2755940
>> [ 1476.542016]     Physical address:  000020181a080000
>> [ 1476.542448] Memory failure: 0x20181a08: recovery action for dirty LRU page: Recovered
>> [ 1476.542452] Memory failure: 0x20181a08: already hardware poisoned
>> [ 1476.542453] Memory failure: 0x20181a08: already hardware poisoned
>> [ 1476.542454] Memory failure: 0x20181a08: already hardware poisoned
>> [ 1476.542455] Memory failure: 0x20181a08: already hardware poisoned
>> [ 1476.542456] Memory failure: 0x20181a08: already hardware poisoned
>> [ 1476.542457] Memory failure: 0x20181a08: already hardware poisoned
>> [...]
>> [ 1490.972174] Watchdog CPU:38 Hard LOCKUP
>>
>> After this patch we see:
>>
>> [  325.384336] Severe Machine check interrupt [Not recovered]
>
> How did you test for this? If the error was recovered, shouldn't the
> process have gotten
> a SIGBUS and we should have prevented further access as a part of the handling
> (memory_failure()). Do we just need a MF_MUST_KILL in the flags?
>
> Why shouldn't we treat it as handled if we isolate the page?

Not yet signed-off-by patch attached for testing, Mahesh, please check/confirm

Thanks,
Balbir

>
> Thanks,
> Balbir Singh.

--001a113d71cc5dc4b1056a80987c
Content-Type: text/x-patch; charset="US-ASCII";
	name="0001-powerpc-mce-force-a-KILL-on-user-page-MCE.patch"
Content-Disposition: attachment;
	filename="0001-powerpc-mce-force-a-KILL-on-user-page-MCE.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jgc1altt0

RnJvbSBiMjk3ZjJhZDg0NzNlZWE3NzU1YmNjMjM5ZTdkZTIxMjI3NDM4MDY1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBCYWxiaXIgU2luZ2ggPGJzaW5naGFyb3JhQGdtYWlsLmNvbT4K
RGF0ZTogTW9uLCAyMyBBcHIgMjAxOCAxOToyMToyNyArMTAwMApTdWJqZWN0OiBbUEFUQ0hdIHBv
d2VycGMvbWNlOiBmb3JjZSBhIEtJTEwgb24gdXNlciBwYWdlIE1DRQoKRXhwZXJpbWVudGFsIGZp
eCBmb3IgTUNFIGVycm9yLCBmb3JjZSBhIGtpbGwKYmVjYXVzZSB0aGF0J3Mgb3VyIGN1cnJlbnQg
cmVjb3ZlcnkgbWVjaGFuaXNtCgpOb3QgdGVzdGVkL2NvbXBpbGVkIHlldAoKU2lnbmVkLW9mZi1i
eTogQmFsYmlyIFNpbmdoIDxic2luZ2hhcm9yYUBnbWFpbC5jb20+Ci0tLQogYXJjaC9wb3dlcnBj
L2tlcm5lbC9tY2UuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBk
ZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2FyY2gvcG93ZXJwYy9rZXJuZWwvbWNlLmMgYi9hcmNo
L3Bvd2VycGMva2VybmVsL21jZS5jCmluZGV4IGVmZGQxNmE3OTA3NS4uYTg0NDFmNzU4NjFlIDEw
MDY0NAotLS0gYS9hcmNoL3Bvd2VycGMva2VybmVsL21jZS5jCisrKyBiL2FyY2gvcG93ZXJwYy9r
ZXJuZWwvbWNlLmMKQEAgLTI3Myw3ICsyNzMsNyBAQCBzdGF0aWMgdm9pZCBtYWNoaW5lX3Byb2Nl
c3NfdWVfZXZlbnQoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQogCiAJCQkJcGZuID0gZXZ0LT51
LnVlX2Vycm9yLnBoeXNpY2FsX2FkZHJlc3MgPj4KIAkJCQkJUEFHRV9TSElGVDsKLQkJCQltZW1v
cnlfZmFpbHVyZShwZm4sIDApOworCQkJCW1lbW9yeV9mYWlsdXJlKHBmbiwgTUZfTVVTVF9LSUxM
KTsKIAkJCX0gZWxzZQogCQkJCXByX3dhcm4oIkZhaWxlZCB0byBpZGVudGlmeSBiYWQgYWRkcmVz
cyBmcm9tICIKIAkJCQkJIndoZXJlIHRoZSB1bmNvcnJlY3RhYmxlIGVycm9yIChVRSkgIgotLSAK
Mi4xNy4wCgo=
--001a113d71cc5dc4b1056a80987c--
