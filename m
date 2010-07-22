Return-Path: <glikely@secretlab.ca>
Received: from mail-gy0-f170.google.com (mail-gy0-f170.google.com
	[209.85.160.170]) by ozlabs.org (Postfix) with ESMTP id C761D1007D1
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 05:11:13 +1000 (EST)
Received: by gyh4 with SMTP id 4so981319gyh.15
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jul 2010 12:11:11 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <AANLkTim7kbHsouc==7gRAuRO6AYMNVdA4yyPFpRBC+QR@mail.gmail.com>
References: <1279756992-29543-1-git-send-email-dbaryshkov@gmail.com>
	<1279756992-29543-2-git-send-email-dbaryshkov@gmail.com>
	<566EC982-1CDA-4806-8EC0-8C9F36448F83@kernel.crashing.org>
	<AANLkTim7kbHsouc==7gRAuRO6AYMNVdA4yyPFpRBC+QR@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 22 Jul 2010 13:10:51 -0600
Message-ID: <AANLkTimsKcn3n90cyqQTQ4Ycy2dlsHdi7afeiNX4M0v5@mail.gmail.com>
Subject: Re: [PATCH 2/2] mpc85xx_edac: change to use new definitions for PCI
	EDAC regspace
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Content-Type: multipart/mixed; boundary=0016e640cf906f0eef048bfeae4d
Cc: linuxppc-dev@ozlabs.org, Doug Thompson <dougthompson@xmission.com>,
	bluesmoke-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0016e640cf906f0eef048bfeae4d
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 22, 2010 at 10:48 AM, Dmitry Eremin-Solenikov
<dbaryshkov@gmail.com> wrote:
> Hello,
>
> On Thu, Jul 22, 2010 at 7:38 PM, Kumar Gala <galak@kernel.crashing.org> w=
rote:
>>
>> On Jul 21, 2010, at 7:03 PM, Dmitry Eremin-Solenikov wrote:
>>
>>> Currently (as mpc8540-pci) devices are not created on of_platform bus,
>>> mpc85xx_edac can't probe to them. Follow the change to dts trees to bin=
d
>>> not to the main mpc8540-pci node but to special mpc85xx-pci-error nodes=
,
>>> present on soc bus.
>>>
>>> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
>>> ---
>>> drivers/edac/mpc85xx_edac.c | =A0 18 +++++++++---------
>>> 1 files changed, 9 insertions(+), 9 deletions(-)
>>
>> Nak.
>>
>> We already have a node in the dts for the PCI controller. =A0Lets update=
 the platform code to add the pci controller to the of_platform_bus_probe l=
ist.
>
> I've had that idea. However it's really look strange to me to call
> of_platform_bus_probe() on the bus node, for which we (IMO) explicitly
> won't like for
> child devices (PCI devices) to be added to of_platform bus. Would it
> be suitable to just call of_platform_device_create for it (Or do i
> miss someth<ing)?

Try the attached patch (lightly tested).  If it works for you then
I'll post it for wider review.

> BTW: While I'm at it, should I change all mpc8540-pci/-pcix device
> names to include respective SoC name?

It is good practice to include both the specific name, and the name of
the device it is backwards compatible to.

g.

--0016e640cf906f0eef048bfeae4d
Content-Type: text/x-diff; charset=US-ASCII;
	name="0001-of-device-Register-children-with-a-compatible-value-.patch"
Content-Disposition: attachment;
	filename="0001-of-device-Register-children-with-a-compatible-value-.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gbxz8qyx0

RnJvbSBkODRhZjE5NWRiY2Q5OWNlMTcyYmY2Mzk1MzgyMzExNDExNzZkNDAyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBHcmFudCBMaWtlbHkgPGdyYW50Lmxpa2VseUBzZWNyZXRsYWIu
Y2E+CkRhdGU6IFRodSwgMjIgSnVsIDIwMTAgMTM6MDE6MTEgLTA2MDAKU3ViamVjdDogW1BBVENI
XSBvZi9kZXZpY2U6IFJlZ2lzdGVyIGNoaWxkcmVuIHdpdGggYSBjb21wYXRpYmxlIHZhbHVlIGlu
IG9mX3BsYXRmb3JtX2J1c19wcm9iZSgpCgpDdXJyZW50bHksIG9mX3BsYXRmb3JtX2J1c19wcm9i
ZSgpIGNvbXBsZXRlbHkgc2tpcHMgbm9kZXMgd2hpY2ggZG8gbm90CmV4cGxpY2l0bHkgbWF0Y2gg
dGhlICdtYXRjaGVzJyB0YWJsZSBwYXNzZWQgaW4uICBPciwgaWYgdGhlIHJvb3Qgbm9kZQptYXRj
aGVzLCB0aGVuIGl0IHJlZ2lzdGVycyBhbGwgdGhlIGNoaWxkcmVuIHVuY29uZGl0aW9uYWxseS4g
IEhvd2V2ZXIsCnRoZXJlIGFyZSBzaXR1YXRpb25zLCBzdWNoIGFzIHJlZ2lzdGVyaW5nIGRldmlj
ZXMgZnJvbSB0aGUgcm9vdCBub2RlLAp3aGVuIGl0IGlzIGRlc2lyYWJsZSB0byByZWdpc3RlciBj
aGlsZCBub2RlcywgYnV0IG9ubHkgaWYgdGhleSBhY3R1YWxseQpyZXByZXNlbnQgZGV2aWNlcy4g
IEZvciBleGFtcGxlLCB0aGUgcm9vdCBub2RlIG1heSBjb250YWluIGJvdGggYSBsb2NhbApidXMg
YW5kIGEgUENJIGRldmljZSwgYnV0IGl0IGFsc28gY29udGFpbnMgdGhlIGNob3NlbiwgYWxpYXNl
cyBhbmQgY3B1cwpub2RlcyB3aGljaCBkb24ndCByZXByZXNlbnQgcmVhbCBkZXZpY2VzLgoKVGhp
cyBwYXRjaCBjaGFuZ2VzIG9mX3BsYXRmb3JtX2J1c19wcm9iZSgpIHRvIHJlZ2lzdGVyIGFsbCBu
b2RlcyBhdCB0aGUKdG9wIGxldmVsIGlmIHRoZXkgZWl0aGVyIG1hdGNoIHRoZSBtYXRjaGVzIHRh
YmxlICh0aGUgY3VycmVudCBiZWhhdmlvdXIpLApvciBpZiB0aGV5IGhhdmUgYSAnY29tcGF0aWJs
ZScgdmFsdWUgKGluZGljYXRpbmcgaXQgcmVwcmVzZW50cyBhIGRldmljZSkuCi0tLQogZHJpdmVy
cy9vZi9wbGF0Zm9ybS5jIHwgICAzMSArKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tCiAx
IGZpbGVzIGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9vZi9wbGF0Zm9ybS5jIGIvZHJpdmVycy9vZi9wbGF0Zm9ybS5jCmluZGV4
IGYzZjFlYzguLjJlYWQ1NjIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvb2YvcGxhdGZvcm0uYworKysg
Yi9kcml2ZXJzL29mL3BsYXRmb3JtLmMKQEAgLTcwOSwxNiArNzA5LDM3IEBAIGludCBvZl9wbGF0
Zm9ybV9idXNfcHJvYmUoc3RydWN0IGRldmljZV9ub2RlICpyb290LAogCQlyYyA9IG9mX3BsYXRm
b3JtX2J1c19jcmVhdGUocm9vdCwgbWF0Y2hlcywgJmRldi0+ZGV2KTsKIAkJZ290byBiYWlsOwog
CX0KKworCS8qIFJlZ2lzdGVyIGVhY2ggY2hpbGQgbm9kZSBpZiBlaXRoZXI6CisJICogIGEpIGl0
IGhhcyBhICdjb21wYXRpYmxlJyB2YWx1ZSBpbmRpY2F0aW5nIHRoZXkgYXJlIGEgZGV2aWNlLCBv
cgorCSAqICBiKSBpdCBpcyBzcGVjaWZpZWQgYnkgdGhlICdtYXRjaGVzJyB0YWJsZSAoYnkgbmFt
ZSBvciBkZXZpY2VfdHlwZSkKKwkgKiBJZiBhIG5vZGUgaXMgc3BlY2lmaWVkIGluIHRoZSBtYXRj
aGVzIHRhYmxlLCB0aGVuIGFsbCBpdHMgY2hpbGRyZW4KKwkgKiBhbHNvIGdldCByZWdpc3RlcmVk
LgorCSAqLwogCWZvcl9lYWNoX2NoaWxkX29mX25vZGUocm9vdCwgY2hpbGQpIHsKLQkJaWYgKCFv
Zl9tYXRjaF9ub2RlKG1hdGNoZXMsIGNoaWxkKSkKKwkJdm9pZCAqY29tcGF0ID0gb2ZfZ2V0X3By
b3BlcnR5KGNoaWxkLCAiY29tcGF0aWJsZSIsIE5VTEwpOworCQlzdHJ1Y3Qgb2ZfZGV2aWNlX2lk
ICptYXRjaCA9IG9mX21hdGNoX25vZGUobWF0Y2hlcywgY2hpbGQpOworCisJCS8qIFNraXAgaWYg
bm9kZSBuZWl0aGVyIG1hdGNoZXMgbm9yIGhhcyBhIGNvbXBhdGlibGUgcHJvcGVydHkgKi8KKwkJ
aWYgKCFjb21wYXQgJiYgIW1hdGNoKQogCQkJY29udGludWU7CiAKLQkJcHJfZGVidWcoIiAgbWF0
Y2g6ICVzXG4iLCBjaGlsZC0+ZnVsbF9uYW1lKTsKKwkJcHJfZGVidWcoIiAgcmVnaXN0ZXIgZGV2
aWNlOiAlc1xuIiwgY2hpbGQtPmZ1bGxfbmFtZSk7CisKKwkJLyogUGFzc2VkIHRoZSBmaXJzdCB0
ZXN0LCByZWdpc3RlciBub2RlIGFzIGEgcGxhdGZvcm0gZGV2aWNlICovCiAJCWRldiA9IG9mX3Bs
YXRmb3JtX2RldmljZV9jcmVhdGUoY2hpbGQsIE5VTEwsIHBhcmVudCk7Ci0JCWlmIChkZXYgPT0g
TlVMTCkKKwkJaWYgKCFkZXYpIHsKIAkJCXJjID0gLUVOT01FTTsKLQkJZWxzZQotCQkJcmMgPSBv
Zl9wbGF0Zm9ybV9idXNfY3JlYXRlKGNoaWxkLCBtYXRjaGVzLCAmZGV2LT5kZXYpOworCQkJb2Zf
bm9kZV9wdXQoY2hpbGQpOworCQkJYnJlYWs7CisJCX0KKworCQkvKiBPbmx5IHJlZ2lzdGVyIGNo
aWxkIG5vZGVzIGlmIHNwZWNpZmllZCBieSBtYXRjaGVzIHRhYmxlICovCisJCWlmICghbWF0Y2gp
CisJCQljb250aW51ZTsKKworCQlwcl9kZWJ1ZygiICByZWdpc3RlciBjaGlsZHJlbiBvZjogJXNc
biIsIGNoaWxkLT5mdWxsX25hbWUpOworCQlyYyA9IG9mX3BsYXRmb3JtX2J1c19jcmVhdGUoY2hp
bGQsIG1hdGNoZXMsICZkZXYtPmRldik7CiAJCWlmIChyYykgewogCQkJb2Zfbm9kZV9wdXQoY2hp
bGQpOwogCQkJYnJlYWs7Ci0tIAoxLjcuMC40Cgo=
--0016e640cf906f0eef048bfeae4d--
