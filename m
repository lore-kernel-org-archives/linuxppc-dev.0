Return-Path: <glikely@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.231])
	by ozlabs.org (Postfix) with ESMTP id 5E21CDDFE3
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 28 Apr 2007 04:42:35 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id 50so1055683wra
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Apr 2007 11:42:33 -0700 (PDT)
Message-ID: <528646bc0704271142j6018552x4c0b61dbaae6ef9d@mail.gmail.com>
Date: Fri, 27 Apr 2007 12:42:33 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Andrei Konovalov" <akonovalov@ru.mvista.com>
Subject: Re: [RFC] SystemACE driver - abstract register ops
In-Reply-To: <46324340.5000506@ru.mvista.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_14526_8165406.1177699353445"
References: <463199EF.3090900@itee.uq.edu.au>
	<528646bc0704270031w5c9966f8tc3a5e5292df10a35@mail.gmail.com>
	<46324340.5000506@ru.mvista.com>
Cc: Stefan Roese <sr@denx.de>, linuxppc-embedded@ozlabs.org,
	Rick Moleres <rick.moleres@xilinx.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_14526_8165406.1177699353445
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 4/27/07, Andrei Konovalov <akonovalov@ru.mvista.com> wrote:
> [   10.511016] xsysace xsa: kicking stalled fsm; state=3 task=1 iter=2 dc=0
>
> Will have a deeper look tomorrow.
> And try CF card too.
> At the moment not sure if this the driver issue.

Oops, I messed it up; try the attached change (I had left in a bogus
data_count decrement).  Thanks for catching the ptr increment bug.

g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195

------=_Part_14526_8165406.1177699353445
Content-Type: application/x-patch;
	name=0001-SYSACE-Bug-fixes-to-8-bit-binding.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f10zp700
Content-Disposition: attachment; filename="0001-SYSACE-Bug-fixes-to-8-bit-binding.patch"

RnJvbSBlZWZjODZlMTZkMTc5NGU2NzM4NGJiODU3MTEyOWYyODJjOWUzMjQyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBHcmFudCBMaWtlbHkgPGdyYW50Lmxpa2VseUBzZWNyZXRsYWIu
Y2E+CkRhdGU6IEZyaSwgMjcgQXByIDIwMDcgMTI6NDE6MzQgLTA2MDAKU3ViamVjdDogW1BBVENI
XSBbU1lTQUNFXSBCdWcgZml4ZXMgdG8gOCBiaXQgYmluZGluZwoKU2lnbmVkLW9mZi1ieTogR3Jh
bnQgTGlrZWx5IDxncmFudC5saWtlbHlAc2VjcmV0bGFiLmNhPgotLS0KIGRyaXZlcnMvYmxvY2sv
eHN5c2FjZS5jIHwgICAgOSArKysrLS0tLS0KIDEgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25z
KCspLCA1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmxvY2sveHN5c2FjZS5j
IGIvZHJpdmVycy9ibG9jay94c3lzYWNlLmMKaW5kZXggNTA4NTc3MC4uMTc3NzUyOSAxMDA2NDQK
LS0tIGEvZHJpdmVycy9ibG9jay94c3lzYWNlLmMKKysrIGIvZHJpdmVycy9ibG9jay94c3lzYWNl
LmMKQEAgLTI0MCwxMSArMjQwLDEwIEBAIHN0YXRpYyB2b2lkIGFjZV9pZGVudGluXzgoc3RydWN0
IGFjZV9kZXZpY2UgKmFjZSkKIAlpbnQgaSA9IEFDRV9GSUZPX1NJWkUvMjsKIAl3aGlsZSAoaS0t
KQogI2lmIGRlZmluZWQoX19CSUdfRU5ESUFOKQotCQkqYWNlLT5kYXRhX3B0ciA9IChpbl84KHIp
KSB8IChpbl84KHIrMSk8PDgpOworCQkqYWNlLT5kYXRhX3B0cisrID0gKGluXzgocikpIHwgKGlu
XzgocisxKTw8OCk7CiAjZWxzZQotCQkqYWNlLT5kYXRhX3B0ciA9IChpbl84KHIpPDw4KSB8IChp
bl84KHIrMSkpOworCQkqYWNlLT5kYXRhX3B0cisrID0gKGluXzgocik8PDgpIHwgKGluXzgocisx
KSk7CiAjZW5kaWYKLQlhY2UtPmRhdGFfY291bnQtLTsKIH0KIAogc3RhdGljIHZvaWQgYWNlX2Rh
dGFpbl84KHN0cnVjdCBhY2VfZGV2aWNlICphY2UpCkBAIC0yNTMsOSArMjUyLDkgQEAgc3RhdGlj
IHZvaWQgYWNlX2RhdGFpbl84KHN0cnVjdCBhY2VfZGV2aWNlICphY2UpCiAJaW50IGkgPSBBQ0Vf
RklGT19TSVpFLzI7CiAJd2hpbGUgKGktLSkKICNpZiBkZWZpbmVkKF9fQklHX0VORElBTikKLQkJ
KmFjZS0+ZGF0YV9wdHIgPSAoaW5fOChyKTw8OCkgfCAoaW5fOChyKzEpKTsKKwkJKmFjZS0+ZGF0
YV9wdHIrKyA9IChpbl84KHIpPDw4KSB8IChpbl84KHIrMSkpOwogI2Vsc2UKLQkJKmFjZS0+ZGF0
YV9wdHIgPSAoaW5fOChyKSkgfCAoaW5fOChyKzEpPDw4KTsKKwkJKmFjZS0+ZGF0YV9wdHIrKyA9
IChpbl84KHIpKSB8IChpbl84KHIrMSk8PDgpOwogI2VuZGlmCiB9CiAKLS0gCjEuNS4xCgo=
------=_Part_14526_8165406.1177699353445--
