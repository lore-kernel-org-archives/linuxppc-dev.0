Return-Path: <Steffen.Rumler@siemens.com>
Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
	by ozlabs.org (Postfix) with ESMTP id 3F1C567A75
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Feb 2005 20:56:34 +1100 (EST)
Message-ID: <421318C2.6040908@siemens.com>
Date: Wed, 16 Feb 2005 10:56:18 +0100
From: Steffen Rumler <Steffen.Rumler@siemens.com>
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>
References: <4202408A.7050200@siemens.com>
	<754ecc31c2497b32a0c3f6df5ce21881@embeddededge.com>
In-Reply-To: <754ecc31c2497b32a0c3f6df5ce21881@embeddededge.com>
Content-Type: multipart/mixed; boundary="------------000201090301020101050106"
Cc: linuxppc <linuxppc-embedded@ozlabs.org>
Subject: Re: uart.c: avoid changing parameter RAM on-the-fly for the console
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------000201090301020101050106
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Dan Malek wrote:
> 
> On Feb 3, 2005, at 10:17 AM, Steffen Rumler wrote:
> 
>> According to Motorola this is _NOT_ allowed and dangerous.
> 
> 
> :-)  yeah, ok ...
> 
>> I suggest to do this inside rs_8xx_init() and startup() as shown
>> in the patch below.
> 
> 
> would you please read Documentation/CodingStyle and
> try sending the patch again?
> 
> Although it doesn't make too much difference in this case,
> 2.4.20 is pretty old and it helps to get patches against
> the latest kernels.
> 
>> With this fix, the modules hanging before can boot now.
> 
> 
> I suspect there is something else amiss, but I'll take a
> look at it.  What is the speed of the processor and the
> baud rate?

Hi Dan,

have you checked this problem in detail now ?

Unfortunately, I have forgotten the 'INIT RX TX' inside
my patched startup() (see new patch attached).
Sorry.

Thank you for help. The serial driver is rather complex.
Please, can you look into this (ignoring coding style at this time).


Steffen

-- 






--------------000201090301020101050106
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="patch"

ZGlmZiAtTmF1ciBvbGQvYXJjaC9wcGMvOHh4X2lvL3VhcnQuYyBuZXcvYXJjaC9wcGMvOHh4
X2lvL3VhcnQuYwotLS0gb2xkL2FyY2gvcHBjLzh4eF9pby91YXJ0LmMJV2VkIEZlYiAxNiAx
MDo0MzoyNCAyMDA1CisrKyBuZXcvYXJjaC9wcGMvOHh4X2lvL3VhcnQuYwlXZWQgRmViIDE2
IDEwOjQyOjAxIDIwMDUKQEAgLTExOSw2ICsxMTksMTEgQEAKIHN0YXRpYyBpbnQgIHVhcnRf
YnVmX3JlYWRfcHJvYyAgICAoY2hhciAqLCBjaGFyICoqLCBvZmZfdCwgaW50LCBpbnQgKiwg
dm9pZCAqKTsKICNlbmRpZgogCisjaWZkZWYgQ09ORklHX1NFUklBTF9DT05TT0xFCitzdGF0
aWMgdm9pZCBmdWxsX3NlcV9zbWNfc3RvcCAoaW50IHBvcnQpOworc3RhdGljIHZvaWQgc21j
X2luaXRfcnhfdHggKGludCBwb3J0KTsKKyNlbmRpZgorCiAvKgogICogU2VyaWFsIGRyaXZl
ciBjb25maWd1cmF0aW9uIHNlY3Rpb24uICBIZXJlIGFyZSB0aGUgdmFyaW91cyBvcHRpb25z
OgogICovCkBAIC04MzEsMTAgKzgzNiwxNyBAQAogCWVsc2UgewogCQlzbWNwID0gJmNwbXAt
PmNwX3NtY1tpZHhdOwogCisjaWZkZWYgQ09ORklHX1NFUklBTF9DT05TT0xFCisgICAgICAg
ICAgICAgICAgLyogIHN0b3AgU01DIGluIHRoZSBjb3JyZWN0IHdheSwgYmVmb3JlIHJlLWNv
bmZpZ3VyaW5nIGl0CisgICAgICAgICAgICAgICAgICovCisJCWlmICgoKHN0YXRlIC0gcnNf
dGFibGUpID09IENPTkZJR19TRVJJQUxfQ09OU09MRV9QT1JUKSl7CisgICAgICAgICAgICAg
ICAgICAgIGZ1bGxfc2VxX3NtY19zdG9wKFBPUlRfTlVNKGluZm8tPnN0YXRlLT5zbWNfc2Nj
X251bSkpOworICAgICAgICAgICAgICAgIH0KKyNlbmRpZgorCiAJCS8qIEVuYWJsZSBpbnRl
cnJ1cHRzIGFuZCBJL08uCiAJCSovCiAJCXNtY3AtPnNtY19zbWNtIHw9IChTTUNNX1JYIHwg
U01DTV9UWCk7Ci0JCXNtY3AtPnNtY19zbWNtciB8PSAoU01DTVJfUkVOIHwgU01DTVJfVEVO
KTsKIAogCQkvKiBXZSBjYW4gdHVuZSB0aGUgYnVmZmVyIGxlbmd0aCBhbmQgaWRsZSBjaGFy
YWN0ZXJzCiAJCSAqIHRvIHRha2UgYWR2YW50YWdlIG9mIHRoZSBlbnRpcmUgaW5jb21pbmcg
YnVmZmVyIHNpemUuCkBAIC04NDgsNiArODYwLDE3IEBACiAJCXVwLT5zbWNfbXJibHIgPSBS
WF9CVUZfU0laRTsKIAkJdXAtPnNtY19tYXhpZGwgPSBSWF9CVUZfU0laRTsKIAkJdXAtPnNt
Y19icmtjciA9IDE7CS8qIG51bWJlciBvZiBicmVhayBjaGFycyAqLworCisjaWZkZWYgQ09O
RklHX1NFUklBTF9DT05TT0xFCisgICAgICAgICAgICAgICAgaWYgKCgoc3RhdGUgLSByc190
YWJsZSkgPT0gQ09ORklHX1NFUklBTF9DT05TT0xFX1BPUlQpKXsKKworICAgICAgICAgICAg
ICAgICAgICBzbWNfaW5pdF9yeF90eChQT1JUX05VTShpbmZvLT5zdGF0ZS0+c21jX3NjY19u
dW0pKTsKKyAgICAgICAgICAgICAgICAgICAgaW5mby0+cnhfY3VyID0gaW5mby0+cnhfYmRf
YmFzZTsKKyAgICAgICAgICAgICAgICAgICAgaW5mby0+dHhfY3VyID0gaW5mby0+dHhfYmRf
YmFzZTsKKyAgICAgICAgICAgICAgICB9CisjZW5kaWYKKworCQlzbWNwLT5zbWNfc21jbXIg
fD0gKFNNQ01SX1JFTiB8IFNNQ01SX1RFTik7CiAJfQogCiAJaW5mby0+ZmxhZ3MgfD0gQVNZ
TkNfSU5JVElBTElaRUQ7CkBAIC0yNjk0LDYgKzI3MTcsNDYgQEAKICAgCiB9IC8qIGVuZCB1
YXJ0X3JlbW92ZVByb2NFbnRyaWVzKCkgKi8KIAorCisjaWZkZWYgQ09ORklHX1NFUklBTF9D
T05TT0xFCitzdGF0aWMgdm9pZCBmdWxsX3NlcV9zbWNfc3RvcCAoaW50IHBvcnQpCit7Cisg
ICAgdm9sYXRpbGUgY3BtOHh4X3QgKmNwPWNwbXA7CisgICAgdm9sYXRpbGUgc21jX3QgKnNw
OworICAgIHVzaG9ydCBjaGFuOworICAgIHVuc2lnbmVkIGxvbmcgZmxhZ3M7CisKKyAgICBz
cCAgID0gJmNwLT5jcF9zbWNbcG9ydF07CisgICAgY2hhbiA9IHNtY19jaGFuX21hcFtwb3J0
XTsKKworICAgIGxvY2FsX2lycV9zYXZlKGZsYWdzKTsKKworICAgIHdoaWxlIChjcC0+Y3Bf
Y3BjciAmIENQTV9DUl9GTEcpOworICAgIGNwLT5jcF9jcGNyID0gbWtfY3JfY21kKGNoYW4s
IENQTV9DUl9TVE9QX1RYKSB8IENQTV9DUl9GTEc7CisgICAgd2hpbGUgKGNwLT5jcF9jcGNy
ICYgQ1BNX0NSX0ZMRyk7CisgICAgc3AtPnNtY19zbWNtciAmPSB+KFNNQ01SX1JFTiB8IFNN
Q01SX1RFTik7CisKKyAgICBsb2NhbF9pcnFfcmVzdG9yZShmbGFncyk7CisKK30gIC8qIGZ1
bGxfc2VxX3NtY19zdG9wICovIAorCitzdGF0aWMgdm9pZCBzbWNfaW5pdF9yeF90eCAoaW50
IHBvcnQpCit7CisgICAgdW5zaWduZWQgbG9uZyBmbGFnczsKKyAgICB2b2xhdGlsZSBjcG04
eHhfdCAqY3A9Y3BtcDsKKyAgICB1c2hvcnQgY2hhbjsKKworICAgIGNoYW4gPSBzbWNfY2hh
bl9tYXBbcG9ydF07CisKKyAgICBsb2NhbF9pcnFfc2F2ZShmbGFncyk7CisgICAgd2hpbGUg
KGNwLT5jcF9jcGNyICYgQ1BNX0NSX0ZMRyk7CisgICAgY3AtPmNwX2NwY3IgPSBta19jcl9j
bWQoY2hhbiwgQ1BNX0NSX0lOSVRfVFJYKSB8IENQTV9DUl9GTEc7CisgICAgd2hpbGUgKGNw
LT5jcF9jcGNyICYgQ1BNX0NSX0ZMRyk7CisgICAgbG9jYWxfaXJxX3Jlc3RvcmUoZmxhZ3Mp
OworCit9ICAvKiBzbWNfaW5pdF9yeF90eCAqLworI2VuZGlmICAvKiBDT05GSUdfU0VSSUFM
X0NPTlNPTEUgKi8KKwogLyoKICAqIFRoZSBzZXJpYWwgZHJpdmVyIGJvb3QtdGltZSBpbml0
aWFsaXphdGlvbiBjb2RlIQogICovCkBAIC0yOTA1LDYgKzI5NjgsMTUgQEAKIAkJCX0KIAkJ
CWVsc2UgewogCQkJCXNwID0gJmNwLT5jcF9zbWNbaWR4XTsKKworI2lmZGVmIENPTkZJR19T
RVJJQUxfQ09OU09MRQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAvKiAgc3Rv
cCBTTUMgaW4gdGhlIGNvcnJlY3Qgd2F5LCBiZWZvcmUgcmUtY29uZmlndXJpbmcgaXQKKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICovCisgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGlmIChpID09IENPTkZJR19TRVJJQUxfQ09OU09MRV9QT1JUKXsKKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGZ1bGxfc2VxX3NtY19zdG9wKGlk
eCk7CisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIH0KKyNlbmRpZgorCiAJCQkJ
dXAgPSAoc21jX3VhcnRfdCAqKSZjcC0+Y3BfZHBhcmFtW3N0YXRlLT5wb3J0XTsKIAkJCQl1
cC0+c21jX3JiYXNlID0gZHBfYWRkcjsKIAkJCX0K
--------------000201090301020101050106--
