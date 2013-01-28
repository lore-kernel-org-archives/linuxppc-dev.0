Return-Path: <yhlu.kernel@gmail.com>
Received: from mail-ia0-x22b.google.com (mail-ia0-x22b.google.com
 [IPv6:2607:f8b0:4001:c02::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 459AB2C0084
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jan 2013 16:23:07 +1100 (EST)
Received: by mail-ia0-f171.google.com with SMTP id z13so3674019iaz.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Jan 2013 21:23:03 -0800 (PST)
MIME-Version: 1.0
Sender: yhlu.kernel@gmail.com
In-Reply-To: <5105F51A.1060600@huawei.com>
References: <CAE9FiQXHG01NjnYNDbC-KEpbcvY-q4pBe97CxTOGS7W4vZQBYQ@mail.gmail.com>
 <1359314629-18651-1-git-send-email-yinghai@kernel.org>
 <1359314629-18651-21-git-send-email-yinghai@kernel.org>
 <5105F51A.1060600@huawei.com>
Date: Sun, 27 Jan 2013 21:23:02 -0800
Message-ID: <CAE9FiQWGAbgG2_nsLP4RTwZT=S9pYhfTBJQGcX2Doy0MY0wqKg@mail.gmail.com>
Subject: Re: [PATCH v3 20/22] PCI,
 powerpc: Kill pci_root_buses in resources reservations
From: Yinghai Lu <yinghai@kernel.org>
To: Yijing Wang <wangyijing@huawei.com>
Content-Type: multipart/mixed; boundary=e89a8f3b9dbb9f366104d452786c
Cc: Toshi Kani <toshi.kani@hp.com>, Jiang Liu <jiang.liu@huawei.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Taku Izumi <izumi.taku@jp.fujitsu.com>,
 linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--e89a8f3b9dbb9f366104d452786c
Content-Type: text/plain; charset=ISO-8859-1

On Sun, Jan 27, 2013 at 7:48 PM, Yijing Wang <wangyijing@huawei.com> wrote:
> On 2013/1/28 3:23, Yinghai Lu wrote:
>> diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
>> index 2cbe676..f848325 100644
>> --- a/arch/powerpc/kernel/pci_64.c
>> +++ b/arch/powerpc/kernel/pci_64.c
>> @@ -208,9 +208,9 @@ long sys_pciconfig_iobase(long which, unsigned long in_bus,
>>                         unsigned long in_devfn)
>>  {
>>       struct pci_controller* hose;
>> -     struct list_head *ln;
>> -     struct pci_bus *bus = NULL;
>> +     struct pci_bus *bus;
>>       struct device_node *hose_node;
>> +     struct pci_host_bridge *host_bridge = NULL;
>>
>>       /* Argh ! Please forgive me for that hack, but that's the
>>        * simplest way to get existing XFree to not lockup on some
>> @@ -230,8 +230,8 @@ long sys_pciconfig_iobase(long which, unsigned long in_bus,
>>        * used on pre-domains setup. We return the first match
>>        */
>>
>> -     for (ln = pci_root_buses.next; ln != &pci_root_buses; ln = ln->next) {
>> -             bus = pci_bus_b(ln);
>> +     for_each_pci_host_bridge(host_bridge) {
>> +             bus = host_bridge->bus;
>>               if (in_bus >= bus->number && in_bus <= bus->busn_res.end)
>
> Need put_device(&host_bridge->dev).
>

fixed in attached.

Thanks

Yinghai

--e89a8f3b9dbb9f366104d452786c
Content-Type: application/octet-stream;
	name="kill_pci_root_buses_powerpc.patch"
Content-Disposition: attachment;
	filename="kill_pci_root_buses_powerpc.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hch687480

U3ViamVjdDogW1BBVENIXSBQQ0ksIHBvd2VycGM6IEtpbGwgcGNpX3Jvb3RfYnVzZXMgaW4gcmVz
b3VyY2VzIHJlc2VydmF0aW9ucwoKUmVwbGFjZSB0aGF0IHdpdGggaG90cGx1Zy1zYWZlIHZlcnNp
b24gaXRlcmF0aW9uLgoKLXYyOiBhZGQgbWlzc2luZyBwdXRfZGV2aWNlIGZvdW5kIGJ5IFlpamlu
ZyBXYW5nIDx3YW5neWlqaW5nQGh1YXdlaS5jb20+CiAgICAgYWxzbyBtb3ZlIHRoZSBoYW5kbGlu
ZyBpbnRvIHRoZSBmb3JfZWFjaF9wY2lfaG9zdF9icmlkZ2Uge30gdG8KICAgICBtYWtlIGl0IHJl
YWxseSBob3RwbHVnIHNhZmUsIGFsc28gbWFrZSB0aGUgZnVuY3Rpb24gbW9yZSByZWFkYWJsZS4K
ClNpZ25lZC1vZmYtYnk6IFlpbmdoYWkgTHUgPHlpbmdoYWlAa2VybmVsLm9yZz4KQ2M6IEJlbmph
bWluIEhlcnJlbnNjaG1pZHQgPGJlbmhAa2VybmVsLmNyYXNoaW5nLm9yZz4KQ2M6IFBhdWwgTWFj
a2VycmFzIDxwYXVsdXNAc2FtYmEub3JnPgpDYzogbGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5v
cmcKCi0tLQogYXJjaC9wb3dlcnBjL2tlcm5lbC9wY2ktY29tbW9uLmMgfCAgIDEzICsrKy0tLS0K
IGFyY2gvcG93ZXJwYy9rZXJuZWwvcGNpXzY0LmMgICAgIHwgICA2NyArKysrKysrKysrKysrKysr
KysrKysrKy0tLS0tLS0tLS0tLS0tLS0KIDIgZmlsZXMgY2hhbmdlZCwgNDYgaW5zZXJ0aW9ucygr
KSwgMzQgZGVsZXRpb25zKC0pCgpJbmRleDogbGludXgtMi42L2FyY2gvcG93ZXJwYy9rZXJuZWwv
cGNpLWNvbW1vbi5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGxpbnV4LTIuNi5vcmlnL2FyY2gvcG93ZXJwYy9r
ZXJuZWwvcGNpLWNvbW1vbi5jCisrKyBsaW51eC0yLjYvYXJjaC9wb3dlcnBjL2tlcm5lbC9wY2kt
Y29tbW9uLmMKQEAgLTEzOTcsMTEgKzEzOTcsMTEgQEAgc3RhdGljIHZvaWQgX19pbml0IHBjaWJp
b3NfcmVzZXJ2ZV9sZWdhYwogCiB2b2lkIF9faW5pdCBwY2liaW9zX3Jlc291cmNlX3N1cnZleSh2
b2lkKQogewotCXN0cnVjdCBwY2lfYnVzICpiOworCXN0cnVjdCBwY2lfaG9zdF9icmlkZ2UgKmhv
c3RfYnJpZGdlID0gTlVMTDsKIAogCS8qIEFsbG9jYXRlIGFuZCBhc3NpZ24gcmVzb3VyY2VzICov
Ci0JbGlzdF9mb3JfZWFjaF9lbnRyeShiLCAmcGNpX3Jvb3RfYnVzZXMsIG5vZGUpCi0JCXBjaWJp
b3NfYWxsb2NhdGVfYnVzX3Jlc291cmNlcyhiKTsKKwlmb3JfZWFjaF9wY2lfaG9zdF9icmlkZ2Uo
aG9zdF9icmlkZ2UpCisJCXBjaWJpb3NfYWxsb2NhdGVfYnVzX3Jlc291cmNlcyhob3N0X2JyaWRn
ZS0+YnVzKTsKIAlwY2liaW9zX2FsbG9jYXRlX3Jlc291cmNlcygwKTsKIAlwY2liaW9zX2FsbG9j
YXRlX3Jlc291cmNlcygxKTsKIApAQCAtMTQwOSwxMCArMTQwOSw5IEBAIHZvaWQgX19pbml0IHBj
aWJpb3NfcmVzb3VyY2Vfc3VydmV5KHZvaWQKIAkgKiB0aGUgbG93IElPIGFyZWEgYW5kIHRoZSBW
R0EgbWVtb3J5IGFyZWEgaWYgdGhleSBpbnRlcnNlY3QgdGhlCiAJICogYnVzIGF2YWlsYWJsZSBy
ZXNvdXJjZXMgdG8gYXZvaWQgYWxsb2NhdGluZyB0aGluZ3Mgb24gdG9wIG9mIHRoZW0KIAkgKi8K
LQlpZiAoIXBjaV9oYXNfZmxhZyhQQ0lfUFJPQkVfT05MWSkpIHsKLQkJbGlzdF9mb3JfZWFjaF9l
bnRyeShiLCAmcGNpX3Jvb3RfYnVzZXMsIG5vZGUpCi0JCQlwY2liaW9zX3Jlc2VydmVfbGVnYWN5
X3JlZ2lvbnMoYik7Ci0JfQorCWlmICghcGNpX2hhc19mbGFnKFBDSV9QUk9CRV9PTkxZKSkKKwkJ
Zm9yX2VhY2hfcGNpX2hvc3RfYnJpZGdlKGhvc3RfYnJpZGdlKQorCQkJcGNpYmlvc19yZXNlcnZl
X2xlZ2FjeV9yZWdpb25zKGhvc3RfYnJpZGdlLT5idXMpOwogCiAJLyogTm93LCBpZiB0aGUgcGxh
dGZvcm0gZGlkbid0IGRlY2lkZSB0byBibGluZGx5IHRydXN0IHRoZSBmaXJtd2FyZSwKIAkgKiB3
ZSBwcm9jZWVkIHRvIGFzc2lnbmluZyB0aGluZ3MgdGhhdCB3ZXJlIGxlZnQgdW5hc3NpZ25lZApJ
bmRleDogbGludXgtMi42L2FyY2gvcG93ZXJwYy9rZXJuZWwvcGNpXzY0LmMKPT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQot
LS0gbGludXgtMi42Lm9yaWcvYXJjaC9wb3dlcnBjL2tlcm5lbC9wY2lfNjQuYworKysgbGludXgt
Mi42L2FyY2gvcG93ZXJwYy9rZXJuZWwvcGNpXzY0LmMKQEAgLTIwNywxMCArMjA3LDcgQEAgdm9p
ZCBwY2liaW9zX3NldHVwX3BoYl9pb19zcGFjZShzdHJ1Y3QgcAogbG9uZyBzeXNfcGNpY29uZmln
X2lvYmFzZShsb25nIHdoaWNoLCB1bnNpZ25lZCBsb25nIGluX2J1cywKIAkJCSAgdW5zaWduZWQg
bG9uZyBpbl9kZXZmbikKIHsKLQlzdHJ1Y3QgcGNpX2NvbnRyb2xsZXIqIGhvc2U7Ci0Jc3RydWN0
IGxpc3RfaGVhZCAqbG47Ci0Jc3RydWN0IHBjaV9idXMgKmJ1cyA9IE5VTEw7Ci0Jc3RydWN0IGRl
dmljZV9ub2RlICpob3NlX25vZGU7CisJc3RydWN0IHBjaV9ob3N0X2JyaWRnZSAqaG9zdF9icmlk
Z2UgPSBOVUxMOwogCiAJLyogQXJnaCAhIFBsZWFzZSBmb3JnaXZlIG1lIGZvciB0aGF0IGhhY2ss
IGJ1dCB0aGF0J3MgdGhlCiAJICogc2ltcGxlc3Qgd2F5IHRvIGdldCBleGlzdGluZyBYRnJlZSB0
byBub3QgbG9ja3VwIG9uIHNvbWUKQEAgLTIyOSwzMyArMjI2LDQ5IEBAIGxvbmcgc3lzX3BjaWNv
bmZpZ19pb2Jhc2UobG9uZyB3aGljaCwgdW4KIAkvKiBUaGF0IHN5c2NhbGwgaXNuJ3QgcXVpdGUg
Y29tcGF0aWJsZSB3aXRoIFBDSSBkb21haW5zLCBidXQgaXQncwogCSAqIHVzZWQgb24gcHJlLWRv
bWFpbnMgc2V0dXAuIFdlIHJldHVybiB0aGUgZmlyc3QgbWF0Y2gKIAkgKi8KLQotCWZvciAobG4g
PSBwY2lfcm9vdF9idXNlcy5uZXh0OyBsbiAhPSAmcGNpX3Jvb3RfYnVzZXM7IGxuID0gbG4tPm5l
eHQpIHsKLQkJYnVzID0gcGNpX2J1c19iKGxuKTsKLQkJaWYgKGluX2J1cyA+PSBidXMtPm51bWJl
ciAmJiBpbl9idXMgPD0gYnVzLT5idXNuX3Jlcy5lbmQpCisJZm9yX2VhY2hfcGNpX2hvc3RfYnJp
ZGdlKGhvc3RfYnJpZGdlKSB7CisJCXN0cnVjdCBkZXZpY2Vfbm9kZSAqaG9zZV9ub2RlOworCQlz
dHJ1Y3QgcGNpX2NvbnRyb2xsZXIqIGhvc2U7CisJCXN0cnVjdCBwY2lfYnVzICpidXM7CisJCWxv
bmcgcmV0OworCisJCWJ1cyA9IGhvc3RfYnJpZGdlLT5idXM7CisJCWlmIChpbl9idXMgPCBidXMt
Pm51bWJlciB8fCBpbl9idXMgPiBidXMtPmJ1c25fcmVzLmVuZCkKKwkJCWNvbnRpbnVlOworCisJ
CWlmICghYnVzLT5kZXYub2Zfbm9kZSkgeworCQkJcHV0X2RldmljZSgmaG9zdF9icmlkZ2UtPmRl
dik7CisJCQlyZXR1cm4gLUVOT0RFVjsKKwkJfQorCisJCWhvc2Vfbm9kZSA9IGJ1cy0+ZGV2Lm9m
X25vZGU7CisJCWhvc2UgPSBQQ0lfRE4oaG9zZV9ub2RlKS0+cGhiOworCisJCXN3aXRjaCAod2hp
Y2gpIHsKKwkJY2FzZSBJT0JBU0VfQlJJREdFX05VTUJFUjoKKwkJCXJldCA9IChsb25nKWhvc2Ut
PmZpcnN0X2J1c25vOwogCQkJYnJlYWs7Ci0JCWJ1cyA9IE5VTEw7Ci0JfQotCWlmIChidXMgPT0g
TlVMTCB8fCBidXMtPmRldi5vZl9ub2RlID09IE5VTEwpCi0JCXJldHVybiAtRU5PREVWOwotCi0J
aG9zZV9ub2RlID0gYnVzLT5kZXYub2Zfbm9kZTsKLQlob3NlID0gUENJX0ROKGhvc2Vfbm9kZSkt
PnBoYjsKKwkJY2FzZSBJT0JBU0VfTUVNT1JZOgorCQkJcmV0ID0gKGxvbmcpaG9zZS0+cGNpX21l
bV9vZmZzZXQ7CisJCQlicmVhazsKKwkJY2FzZSBJT0JBU0VfSU86CisJCQlyZXQgPSAobG9uZylo
b3NlLT5pb19iYXNlX3BoeXM7CisJCQlicmVhazsKKwkJY2FzZSBJT0JBU0VfSVNBX0lPOgorCQkJ
cmV0ID0gKGxvbmcpaXNhX2lvX2Jhc2U7CisJCQlicmVhazsKKwkJY2FzZSBJT0JBU0VfSVNBX01F
TToKKwkJCXJldCA9IC1FSU5WQUw7CisJCQlicmVhazsKKwkJZGVmYXVsdDoKKwkJCXJldCA9IC1F
T1BOT1RTVVBQOworCQl9CiAKLQlzd2l0Y2ggKHdoaWNoKSB7Ci0JY2FzZSBJT0JBU0VfQlJJREdF
X05VTUJFUjoKLQkJcmV0dXJuIChsb25nKWhvc2UtPmZpcnN0X2J1c25vOwotCWNhc2UgSU9CQVNF
X01FTU9SWToKLQkJcmV0dXJuIChsb25nKWhvc2UtPnBjaV9tZW1fb2Zmc2V0OwotCWNhc2UgSU9C
QVNFX0lPOgotCQlyZXR1cm4gKGxvbmcpaG9zZS0+aW9fYmFzZV9waHlzOwotCWNhc2UgSU9CQVNF
X0lTQV9JTzoKLQkJcmV0dXJuIChsb25nKWlzYV9pb19iYXNlOwotCWNhc2UgSU9CQVNFX0lTQV9N
RU06Ci0JCXJldHVybiAtRUlOVkFMOworCQlwdXRfZGV2aWNlKCZob3N0X2JyaWRnZS0+ZGV2KTsK
KwkJcmV0dXJuIHJldDsKIAl9CiAKLQlyZXR1cm4gLUVPUE5PVFNVUFA7CisJcmV0dXJuIC1FTk9E
RVY7CiB9CiAKICNpZmRlZiBDT05GSUdfTlVNQQo=
--e89a8f3b9dbb9f366104d452786c--
