Date: Sat, 26 Feb 2000 13:37:46 -0800 (PST)
From: Ani Joshi <ajoshi@shell.unixbox.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: "Brandon S. Allbery KF8NH" <allbery@kf8nh.apk.net>,
        Brad Parker <brad@parker.boston.ma.us>,
        linuxppc-dev@lists.linuxppc.org,
        Linux Kernel List <linux-kernel@vger.rutgers.edu>
Subject: Re: 2.3.47 imac build?
In-Reply-To: <38B8286A.45F64EAD@mandrakesoft.com>
Message-ID: <Pine.LNX.4.10.10002261334130.32104-200000@shell.unixbox.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-741392083-115030922-951601066=:32104"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---741392083-115030922-951601066=:32104
Content-Type: TEXT/PLAIN; charset=US-ASCII


This little buglet is fixed with the attached patch i made a while back.
although it is really not needed anymore since cort tells me its fixed
(see 48pre probably, or bk).  anyhow, abs() is defined in misc.S.
but for those building 2.3.47 and don't want to see that annoying warning,
this patch will be fine.


ani


On Sat, 26 Feb 2000, Jeff Garzik wrote:

>
> "Brandon S. Allbery KF8NH" wrote:
> >
> > In message <38B82560.CE2A6EA4@mandrakesoft.com>, Jeff Garzik writes:
> > +-----
> > | 1) investigate why this warning does not occur on x86.  (is it a gcc
> > | builtin?)
> > +--->8
> >
> > The gcc 2.95.1 info pages claim so.
>
> Thanks, I was too slack to look it up :)
>
> PPC arch compiles with -fno-builtin.  Why is this?  It seems sub-optimal
> and non-uniform, leading to little platform discrepancies like this...
>
> 	Jeff
>
>
>
> --
> Jeff Garzik              |
> Building 1024            | Viva la open source!
> MandrakeSoft, Inc.       |
>
>

---741392083-115030922-951601066=:32104
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="abs-ppc.patch"
Content-ID: <Pine.LNX.4.10.10002261337460.32104@shell.unixbox.com>
Content-Description: 
Content-Disposition: attachment; filename="abs-ppc.patch"
Content-Transfer-Encoding: BASE64

ZGlmZiAtdU5yIGxpbnV4Lm9yaWcvYXJjaC9wcGMva2VybmVsL3BwY19rc3lt
cy5jIGxpbnV4L2FyY2gvcHBjL2tlcm5lbC9wcGNfa3N5bXMuYw0KLS0tIGxp
bnV4Lm9yaWcvYXJjaC9wcGMva2VybmVsL3BwY19rc3ltcy5jCU1vbiBGZWIg
MTQgMTQ6Mzc6MjUgMjAwMA0KKysrIGxpbnV4L2FyY2gvcHBjL2tlcm5lbC9w
cGNfa3N5bXMuYwlNb24gRmViIDIxIDE4OjIyOjQ3IDIwMDANCkBAIC01Niw3
ICs1Niw2IEBADQogDQogYXNtbGlua2FnZSBsb25nIGxvbmcgX19hc2hyZGkz
KGxvbmcgbG9uZywgaW50KTsNCiBhc21saW5rYWdlIGxvbmcgbG9uZyBfX2xz
aHJkaTMobG9uZyBsb25nLCBpbnQpOw0KLWFzbWxpbmthZ2UgaW50IGFicyhp
bnQpOw0KIA0KIEVYUE9SVF9TWU1CT0woY2xlYXJfcGFnZSk7DQogRVhQT1JU
X1NZTUJPTChkb19zaWduYWwpOw0KZGlmZiAtdU5yIGxpbnV4Lm9yaWcvYXJj
aC9wcGMvbGliL01ha2VmaWxlIGxpbnV4L2FyY2gvcHBjL2xpYi9NYWtlZmls
ZQ0KLS0tIGxpbnV4Lm9yaWcvYXJjaC9wcGMvbGliL01ha2VmaWxlCU1vbiBE
ZWMgMjAgMTU6NDM6NDAgMTk5OQ0KKysrIGxpbnV4L2FyY2gvcHBjL2xpYi9N
YWtlZmlsZQlNb24gRmViIDIxIDE4OjIyOjEzIDIwMDANCkBAIC02LDcgKzYs
NyBAQA0KIAkkKENDKSAtRF9fQVNTRU1CTFlfXyAkKEFGTEFHUykgLWMgJDwg
LW8gJCoubw0KIA0KIE9fVEFSR0VUID0gbGliLm8NCi1PX09CSlMgID0gY2hl
Y2tzdW0ubyBzdHJpbmcubyBzdHJjYXNlLm8NCitPX09CSlMgID0gY2hlY2tz
dW0ubyBzdHJpbmcubyBzdHJjYXNlLm8gYWJzLm8NCiANCiBpZmRlZiBDT05G
SUdfU01QDQogT19PQkpTICs9IGxvY2tzLm8NCmRpZmYgLXVOciBsaW51eC5v
cmlnL2FyY2gvcHBjL2xpYi9hYnMuUyBsaW51eC9hcmNoL3BwYy9saWIvYWJz
LlMNCi0tLSBsaW51eC5vcmlnL2FyY2gvcHBjL2xpYi9hYnMuUwlXZWQgRGVj
IDMxIDE3OjAwOjAwIDE5NjkNCisrKyBsaW51eC9hcmNoL3BwYy9saWIvYWJz
LlMJTW9uIEZlYiAyMSAxODoyMTo1OSAyMDAwDQpAQCAtMCwwICsxLDcgQEAN
CisgICAgICAgIC5nbG9ibCBhYnMNCithYnM6DQorICAgICAgICBtci4gMywz
DQorICAgICAgICBiY2xyIDQsMA0KKyAgICAgICAgbmVnIDMsMw0KKyAgICAg
ICAgYmxyDQorDQpkaWZmIC11TnIgbGludXgub3JpZy9pbmNsdWRlL2FzbS1w
cGMvc3lzdGVtLmggbGludXgvaW5jbHVkZS9hc20tcHBjL3N5c3RlbS5oDQot
LS0gbGludXgub3JpZy9pbmNsdWRlL2FzbS1wcGMvc3lzdGVtLmgJTW9uIERl
YyAyNyAxNToxMDoyMCAxOTk5DQorKysgbGludXgvaW5jbHVkZS9hc20tcHBj
L3N5c3RlbS5oCU1vbiBGZWIgMjEgMTg6MzE6NDIgMjAwMA0KQEAgLTE0OCw0
ICsxNDgsNiBAQA0KIAlyZXR1cm4gKHZvaWQgKikgeGNoZ191MzIobSwgKHVu
c2lnbmVkIGxvbmcpIHZhbCk7DQogfQ0KIA0KKw0KK2FzbWxpbmthZ2UgaW50
IGFicyhpbnQpOw0KICNlbmRpZg0K
---741392083-115030922-951601066=:32104--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
