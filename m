Message-ID: <382a4a48382aafdc@villosa.wanadoo.fr> (added by villosa.wanadoo.fr)
Date: Thu, 11 Nov 1999 05:48:24 +0100
Subject: Re : Newworld OF boot
From: "Florent" <flobo@iname.com>
To: Benjamin Herrenschmidt <bh40@calva.net>
CC: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: multipart/mixed;
   boundary="MS_Mac_OE_3025144104_29190_MIME_Part"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> CE MESSAGE EST AU FORMAT MIME. Comme votre lecteur de courrier ne comprend pas
ce format, il se peut que tout ou partie de ce message soit illisible.

--MS_Mac_OE_3025144104_29190_MIME_Part
Content-type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit

> Marius Vollmer recently released "poof", an OF bootloader for NewWorld
> that apparently can read the kernel from ext2. I didn't test it nor I
> remember the URL, but a search on the linuxppc-usr mailing list archive
> should work.

Poof loads and boots perfectly on BlueG3, so it seems there's nothing more
to do.
It doesn't read the kernel from ext2 but from an OF-readable disk, or the
kernel may be included in poof's file.

> I think the new OF actually _can_ do raw block i/o since MacOS X Server
> bootloader will load and link the kernel from an UFS partition (which is
> obviously not supported by OF natively). I suggest you look at Darwin's
> SecondaryLoader source code on publicsource.apple.com. It contains a
> bunch of OF calls from the C code, some of them may give you some light
> on the matter.

It seems that the modified secondary quik bootloader doesn't really crashes
when using OF for raw disk access but in the middle of ext2fs'partition
opening code. And MacOS X server bootloader loads the kernel from the UFS
partition (even if the bootloader is on an HFS partition). But where is
Darwin's SecondaryLoader source code ? I've downloaded all Darwin files
containing the word "loader" but it doesn't seems to be here...

I have included an os chooser written in Forth that works with poof (you
must first install it). It's written for my configuration but it should be
easy to adapt since it's plain text and there is nothing else to do than
changing the partition numbers (and erase MacOS X from the list for those
who don't have it) To use it, you must first install poof, then copy
blueboot into an OF readable folder (like MacOS System Folder) and then
change the boot device (setenv boot-device hd:X,\\blueboot  where X is the
partition number containing blueboot, usually 5 if you put it into your
MacOS System folder).


--
Il est maintenant temps de clore votre connection et de reprendre une vie
normale.
Mon e-mail : FloBo@iName.com (Florent Boudet)
Mon e-mail secondaire : FloBo@Rocketmail.com (je ne le regarde jamais)
Mon QG : http://www.multimania.com/flobo/

--MS_Mac_OE_3025144104_29190_MIME_Part
Content-type: text/plain; name="blueboot"
Content-disposition: attachment
Content-Transfer-Encoding: base64

PENIUlAtQk9PVD4NPENPTVBBVElCTEU+DWlNYWMsMSBQb3dlck1hYzEsMSBQb3dlckJvb2sx
LDENPC9DT01QQVRJQkxFPg08REVTQ1JJUFRJT04+DU1hY1JPTSBmb3IgTmV3V29ybGQuDTwv
REVTQ1JJUFRJT04+DTxCT09ULVNDUklQVD4NOiBnb3Rvc2NyICIgZGV2IHNjcmVlbiIgZXZh
bHVhdGUgOw1nb3Rvc2NyDTogY3Jycg0iICAgICAiIHN3YXAgZHVwIDBhIHN3YXAgMGQgc3dh
cCAyISBzd2FwIHdyaXRlIGRyb3ANIiAgICAgIiBzd2FwIGR1cCAwZCBzd2FwIDBhIHN3YXAg
MiEgc3dhcCB3cml0ZSBkcm9wIDsNOiBjbGVhcnJyICIgICAgICIgc3dhcCBkdXAgMGMgc3dh
cCAwYyBzd2FwIDIhIHN3YXAgd3JpdGUgZHJvcCA7DTogcHJpbnRmZiB3cml0ZSBkcm9wIDsN
OiBtYWNvc3hib290ICIgYm9vdCBoZDo2LFxcOnRieGkiIGV2YWx1YXRlIDsNOiBsaW5ib290
ICIgYm9vdCBoZDo1LFxccG9vZiBib290IGhkOjUsXFx2bWxpbnV4IHJvb3Q9L2Rldi9oZGEx
MCB2aWRlbz1hdHkxMjhmYjtzaW5nbGUiIGV2YWx1YXRlIDsNOiBtYWNvc2Jvb3QgIiBib290
IGhkOjUsXFw6dGJ4aSIgZXZhbHVhdGUgOw1jcnJyDWNycnINY3Jycg1jcnJyICIgICAqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioiIHByaW50ZmYNY3JyciAiICAg
KiAgICAgICAgIFdlbGNvbWUgdG8gQmx1ZUJvb3QgICAgICAgICAqIiBwcmludGZmDWNycnIg
IiAgICogICAgICAgICBfX19fX19fX19fX19fX19fX19fICAgICAgICAgKiIgcHJpbnRmZg1j
cnJyICIgICAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICoiIHByaW50
ZmYNY3JyciAiICAgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAqIiBw
cmludGZmDWNycnIgIiAgICogICAgICAgICAgKE0pIE1hY09TIDguNiAgICAgICAgICAgICAg
KiIgcHJpbnRmZg1jcnJyICIgICAqICAgICAgICAgIChYKSBNYWNPUyBYIFNlcnZlciAgICAg
ICAgICoiIHByaW50ZmYNY3JyciAiICAgKiAgICAgICAgICAoTCkgTGludXggICAgICAgICAg
ICAgICAgICAqIiBwcmludGZmDWNycnIgIiAgICogICAgICAgICAgKE8pIE9wZW5GaXJtd2Fy
ZSAgICAgICAgICAgKiIgcHJpbnRmZg1jcnJyICIgICAqICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICoiIHByaW50ZmYNY3JyciAiICAgKiBQbGVhc2UgcHJlc3MgTS1Y
LUwtTyB0byBib290IGFuIE9TICAqIiBwcmludGZmDWNycnIgIiAgICoqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKiIgcHJpbnRmZg1jcnJyDWNycnINY3JyciAiICAg
ICAgICAgICAgICAgICAgICoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqIiBwcmludGZmDWNycnIgIiAgICAgICAgICAgICAgICAgICAqICAgKGMpIHRoZSBC
bHVlQm9vdCBUZWFtICAgICAgICAgICAgICAgICAgKiIgcHJpbnRmZg1jcnJyICIgICAgICAg
ICAgICAgICAgICAgKiAgICAgICAgICAgIEZsb0JvIGFuZCBKZWtvICAgICAgICAgICAgICAg
ICoiIHByaW50ZmYNY3JyciAiICAgICAgICAgICAgICAgICAgICogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAqIiBwcmludGZmDWNycnIgIiAgICAgICAgICAg
ICAgICAgICAqICAgICAgICAgICAgICAgICAgICBCbHVlQm9vdEBpRnJhbmNlLmNvbSAgKiIg
cHJpbnRmZg1jcnJyICIgICAgICAgICAgICAgICAgICAgKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioiIHByaW50ZmYNa2V5IGR1cCBkdXANNmMgPSBpZiAu
IiBCb290aW5nIExpbnV4Li4uIiBjciBsaW5ib290IHRoZW4NNmQgPSBpZiAuIiBCb290aW5n
IE1hY09TLi4uIiBjciBtYWNvc2Jvb3QgdGhlbg03OCA9IGlmIC4iIEJvb3RpbmcgTWFjT1Mg
WCBTZXJ2ZXIuLi4iIGNyIG1hY29zeGJvb3QgdGhlbg1jciAuIiBlbmQgb2YgQk9PVC1TQ1JJ
UFQiDWNsZWFycnINPC9CT09ULVNDUklQVD4NPC9DSFJQLUJPT1Q+DQ==

--MS_Mac_OE_3025144104_29190_MIME_Part--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
