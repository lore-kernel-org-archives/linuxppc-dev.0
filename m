Date: Sun, 29 Jul 2001 01:09:05 -0500
From: "Joseph P. Garcia" <jpgarcia@execpc.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: userspace button controls
Message-Id: <20010729010905.3faf9642.jpgarcia@execpc.com>
In-Reply-To: <3B63877E.9060001@hadess.net>
References: <20010724015531.516c9985.jpgarcia@execpc.com>
	<3B63877E.9060001@hadess.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Sun__29_Jul_2001_01:09:05_-0500_101f3520"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.

--Multipart_Sun__29_Jul_2001_01:09:05_-0500_101f3520
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Greetings.

On Sun, 29 Jul 2001 04:48:14 +0100
Bastien Nocera <hadess@hadess.net> wrote:
> Well, the buttons_patch doesn't work on the ibook2:
[...]
> eject: Unhandled button code 0b

Perfect!  This is what I was looking for.  Attached is a patch to make things work... maybe.  I don't know what to expect with the power key.  The eject key on the iBook2 is apparantly still an adb-button... neato.. i think.

You will probably get an 'unknown scancode' for the eject key, but you can get the idea how to fix that from the patch.  change the cooresponding 0 to a KEY_EJECTCD, recompile, and it should work.  I don't know what exactly to expect from it.

BTW, I contacted James Simmons, a developer in linuxconsole and framebuffer.  He mentioned that this sort of thing (fb-backlight, new input keys) are planned for 2.5.x.  Which makes sense, as volume/eject keys are no big diff at the moment, but, as Michael Schmitz pointed out, the backlight-related changes should not be introduced under the table.

So volume keys and eject key (power too?) should be merge-able after completion and some testing.

Thanks for your help.

--
Joseph P. Garcia
http://www.lycestra.com/ (that's lie-kes-tra)

--Multipart_Sun__29_Jul_2001_01:09:05_-0500_101f3520
Content-Type: application/octet-stream;
 name="eject.patch"
Content-Disposition: attachment;
 filename="eject.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtcnVQIC1YIC4uL2lnbm9yZWRpZmYgbGludXgtMi40LjctcHJlNy1iZW5oMjAwMTA3MjIt
dm9sdW1lL2RyaXZlcnMvbWFjaW50b3NoL2FkYmhpZC5jIGxpbnV4LTIuNC43LXByZTctYmVuaDIw
MDEwNzIyLXZvbHVtZTIvZHJpdmVycy9tYWNpbnRvc2gvYWRiaGlkLmMKLS0tIGxpbnV4LTIuNC43
LXByZTctYmVuaDIwMDEwNzIyLXZvbHVtZS9kcml2ZXJzL21hY2ludG9zaC9hZGJoaWQuYwlNb24g
SnVsIDIzIDE3OjI4OjM1IDIwMDEKKysrIGxpbnV4LTIuNC43LXByZTctYmVuaDIwMDEwNzIyLXZv
bHVtZTIvZHJpdmVycy9tYWNpbnRvc2gvYWRiaGlkLmMJU3VuIEp1bCAyOSAwMDozMjoyNSAyMDAx
CkBAIC0yODgsNiArMjg4LDkgQEAKIAljYXNlIDB4OToJLyogYnJpZ2h0bmVzcyBpbmNyZWFzZSAq
LwogCSAgaW5wdXRfcmVwb3J0X2tleSgmYWRiaGlkW2lkXS0+aW5wdXQsIEtFWV9CUklHSFRORVNT
VVAsIGRhdGFbMV0gPT0gKGRhdGFbMV0gJiAweGYpKTsKIAkgIGJyZWFrOworCWNhc2UgMHhiOgkv
KiBlamVjdCBrZXkgKi8KKwkgIGlucHV0X3JlcG9ydF9rZXkoJmFkYmhpZFtpZF0tPmlucHV0LCBL
RVlfRUpFQ1RDRCwgZGF0YVsxXSA9PSAoZGF0YVsxXSAmIDB4ZikpOworCSAgYnJlYWs7CiAJZGVm
YXVsdDoKIAkgIHByaW50ayhLRVJOX0lORk8gIlVuaGFuZGxlZCBidXR0b24gY29kZSAlMDJ4XG4i
LGRhdGFbMV0mMHhmKTsKIAkgIGJyZWFrOwpkaWZmIC1ydVAgLVggLi4vaWdub3JlZGlmZiBsaW51
eC0yLjQuNy1wcmU3LWJlbmgyMDAxMDcyMi12b2x1bWUvZHJpdmVycy9tYWNpbnRvc2gvbWFjX2hp
ZC5jIGxpbnV4LTIuNC43LXByZTctYmVuaDIwMDEwNzIyLXZvbHVtZTIvZHJpdmVycy9tYWNpbnRv
c2gvbWFjX2hpZC5jCi0tLSBsaW51eC0yLjQuNy1wcmU3LWJlbmgyMDAxMDcyMi12b2x1bWUvZHJp
dmVycy9tYWNpbnRvc2gvbWFjX2hpZC5jCVRodSBKdW4gMjggMDk6Mjk6NTAgMjAwMQorKysgbGlu
dXgtMi40LjctcHJlNy1iZW5oMjAwMTA3MjItdm9sdW1lMi9kcml2ZXJzL21hY2ludG9zaC9tYWNf
aGlkLmMJU3VuIEp1bCAyOSAwMDozODo0MyAyMDAxCkBAIC0yMDAsMTUgKzIwMCwxNSBAQAogCTAs
IDAsIDAsIEtFWV9LUENPTU1BLCAwLCBLRVlfSU5UTDMsIDAsIDAsCQkvKiAweDAwLTB4MDcgKi8K
IAkwLCAwLCAwLCAwLCBLRVlfTEFORzEsIEtFWV9MQU5HMiwgMCwgMCwJCQkvKiAweDA4LTB4MGYg
Ki8KIAkwLCAwLCAwLCAwLCAwLCAwLCAwLCAwLAkJCQkJLyogMHgxMC0weDE3ICovCi0JMCwgMCwg
MCwgMCwgS0VZX0tQRU5URVIsIEtFWV9SSUdIVENUUkwsIDAsIDAsCQkvKiAweDE4LTB4MWYgKi8K
LQkwLCAwLCAwLCAwLCAwLCAwLCAwLCAwLAkJCQkJLyogMHgyMC0weDI3ICovCisJMCwgMCwgMCwg
MCwgS0VZX0tQRU5URVIsIEtFWV9SSUdIVENUUkwsIEtFWV9WT0xVTUVVUCwgMCwJCS8qIDB4MTgt
MHgxZiAqLworCTAsIDAsIDAsIDAsIDAsIEtFWV9WT0xVTUVET1dOLCBLRVlfTVVURSwgMCwJCQkJ
CS8qIDB4MjAtMHgyNyAqLwogCTAsIDAsIDAsIDAsIDAsIDAsIDAsIDAsCQkJCQkvKiAweDI4LTB4
MmYgKi8KIAkwLCAwLCAwLCAwLCAwLCBLRVlfS1BTTEFTSCwgMCwgS0VZX1NZU1JRLAkJLyogMHgz
MC0weDM3ICovCi0JS0VZX1JJR0hUQUxULCAwLCAwLCAwLCAwLCAwLCAwLCAwLAkJCS8qIDB4Mzgt
MHgzZiAqLworCUtFWV9SSUdIVEFMVCwgS0VZX0JSSUdIVE5FU1NVUCwgS0VZX0JSSUdIVE5FU1NE
T1dOLCAwLCAwLCAwLCAwLCAwLAkJCS8qIDB4MzgtMHgzZiAqLwogCTAsIDAsIDAsIDAsIDAsIDAs
IDAsIEtFWV9IT01FLAkJCQkvKiAweDQwLTB4NDcgKi8KIAlLRVlfVVAsIEtFWV9QQUdFVVAsIDAs
IEtFWV9MRUZULCAwLCBLRVlfUklHSFQsIDAsIEtFWV9FTkQsIC8qIDB4NDgtMHg0ZiAqLwogCUtF
WV9ET1dOLCBLRVlfUEFHRURPV04sIEtFWV9JTlNFUlQsIEtFWV9ERUxFVEUsIDAsIDAsIDAsIDAs
IC8qIDB4NTAtMHg1NyAqLwotCTAsIDAsIDAsIEtFWV9MRUZUTUVUQSwgS0VZX1JJR0hUTUVUQSwg
S0VZX0NPTVBPU0UsIDAsIDAsIC8qIDB4NTgtMHg1ZiAqLworCTAsIDAsIDAsIEtFWV9MRUZUTUVU
QSwgS0VZX1JJR0hUTUVUQSwgS0VZX0NPTVBPU0UsIEtFWV9QT1dFUiwgMCwgLyogMHg1OC0weDVm
ICovCiAJMCwgMCwgMCwgMCwgMCwgMCwgMCwgMCwJCQkJCS8qIDB4NjAtMHg2NyAqLwogCTAsIDAs
IDAsIDAsIDAsIDAsIDAsIEtFWV9NQUNSTywJCQkJLyogMHg2OC0weDZmICovCiAJMCwgMCwgMCwg
MCwgMCwgMCwgMCwgMCwJCQkJCS8qIDB4NzAtMHg3NyAqLwo=

--Multipart_Sun__29_Jul_2001_01:09:05_-0500_101f3520--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
