Date: Sun, 1 Oct 2000 14:52:38 -0700 (PDT)
From: William Blew <wblew@home.com>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
cc: Kostas Gewrgiou <gewrgiou@imbc.gr>, R Shapiro <rshapiro@bbn.com>,
        Michel Dänzer <daenzerm@student.ethz.ch>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linuxppc-dev@lists.linuxppc.org, Jon Erick Ween <jween@som.llu.edu>
Subject: Re: Patch: PCI resource fixup for atyfb (was: Re: xf 4.0.1 + ati
 driver with rage II/rage pro)
In-Reply-To: <Pine.LNX.4.10.10010011928450.9543-100000@opal.biophys.uni-duesseldorf.de>
Message-ID: <Pine.LNX.4.10.10010011433130.17208-200000@apollo.kulian.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-271842951-2125353565-970437158=:17208"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---271842951-2125353565-970437158=:17208
Content-Type: TEXT/PLAIN; charset=US-ASCII

Just to give you another testing point, I tried your patch on my beige
G3/266 workstation (rev 2 with the 3D rage pro). My setup is the latest
(as of 1 hour ago) pmac-stable rsync (says its 2.2.17) launched via BootX,
from the MacOS 9.0.4

I started the console with atyfb, mode 17, color 32. The FBDev X server
(v3.3.6-11.2) started fine, with the latest utah-glx (pseudo DMA as real
DMA is still broken in utah-glx) also working well. Checking utah-glx is
useful as it accesses the MMIO mapped registers (particularly the 3D
engine's registers) as returned by /dev/fb0's fixed screen info IOCTL.

As the X server's mode is 1280x1024-61 (at 15 bpp) and the console was
running 1024x768-75 (at 32 bpp) this included a color depth mode switch.

Anyway, the conclusion: it didn't break my (utterly normal except for
utah-glx) setup.

FYI, my lspci -vv output is attached.

PS: I second the motion on the fixing of atyfb's depth switching.
--
William Blew, wblew@home.com
Gamer by Choice, Geek by Birth

---271842951-2125353565-970437158=:17208
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="lspci.out"
Content-ID: <Pine.LNX.4.10.10010011452380.17208@apollo.kulian.net>
Content-Description: the lspci -vv output
Content-Disposition: attachment; filename="lspci.out"
Content-Transfer-Encoding: BASE64

MDA6MDAuMCBIb3N0IGJyaWRnZTogTW90b3JvbGEgTVBDMTA2IFtHcmFja2xl
XSAocmV2IDQwKQ0KCUNvbnRyb2w6IEkvTy0gTWVtKyBCdXNNYXN0ZXIrIFNw
ZWNDeWNsZS0gTWVtV0lOVi0gVkdBU25vb3AtIFBhckVyci0gU3RlcHBpbmct
IFNFUlItIEZhc3RCMkItDQoJU3RhdHVzOiBDYXAtIDY2TWh6LSBVREYtIEZh
c3RCMkIrIFBhckVyci0gREVWU0VMPWZhc3QgPlRBYm9ydC0gPFRBYm9ydC0g
PE1BYm9ydCsgPlNFUlItIDxQRVJSLQ0KCUxhdGVuY3k6IDAgc2V0LCBjYWNo
ZSBsaW5lIHNpemUgMDgNCg0KMDA6MTAuMCBDbGFzcyBmZjAwOiBBcHBsZSBD
b21wdXRlciBJbmMuIEhlYXRocm93IE1hYyBJL08gKHJldiAwMSkNCglDb250
cm9sOiBJL08tIE1lbSsgQnVzTWFzdGVyKyBTcGVjQ3ljbGUtIE1lbVdJTlYr
IFZHQVNub29wLSBQYXJFcnItIFN0ZXBwaW5nLSBTRVJSLSBGYXN0QjJCLQ0K
CVN0YXR1czogQ2FwLSA2Nk1oei0gVURGLSBGYXN0QjJCLSBQYXJFcnItIERF
VlNFTD1tZWRpdW0gPlRBYm9ydC0gPFRBYm9ydC0gPE1BYm9ydC0gPlNFUlIt
IDxQRVJSLQ0KCUxhdGVuY3k6IDMyIHNldCwgY2FjaGUgbGluZSBzaXplIDA4
DQoJUmVnaW9uIDA6IE1lbW9yeSBhdCBmMzAwMDAwMCAoMzItYml0LCBub24t
cHJlZmV0Y2hhYmxlKQ0KDQowMDoxMi4wIFZHQSBjb21wYXRpYmxlIGNvbnRy
b2xsZXI6IEFUSSBUZWNobm9sb2dpZXMgSW5jIDNEIFJhZ2UgUHJvIDIxNUdQ
IChyZXYgNWMpIChwcm9nLWlmIDAwIFtWR0FdKQ0KCUNvbnRyb2w6IEkvTy0g
TWVtKyBCdXNNYXN0ZXIrIFNwZWNDeWNsZS0gTWVtV0lOVi0gVkdBU25vb3At
IFBhckVyci0gU3RlcHBpbmcrIFNFUlItIEZhc3RCMkItDQoJU3RhdHVzOiBD
YXAtIDY2TWh6LSBVREYtIEZhc3RCMkIrIFBhckVyci0gREVWU0VMPW1lZGl1
bSA+VEFib3J0LSA8VEFib3J0LSA8TUFib3J0LSA+U0VSUi0gPFBFUlItDQoJ
TGF0ZW5jeTogOCBtaW4sIDMyIHNldCwgY2FjaGUgbGluZSBzaXplIDA4DQoJ
SW50ZXJydXB0OiBwaW4gQSByb3V0ZWQgdG8gSVJRIDIyDQoJUmVnaW9uIDA6
IE1lbW9yeSBhdCA4MTAwMDAwMCAoMzItYml0LCBub24tcHJlZmV0Y2hhYmxl
KQ0KCVJlZ2lvbiAxOiBJL08gcG9ydHMgYXQgMGMwMCBbZGlzYWJsZWRdDQoJ
UmVnaW9uIDI6IE1lbW9yeSBhdCA4MDgwMDAwMCAoMzItYml0LCBub24tcHJl
ZmV0Y2hhYmxlKQ0KDQo=
---271842951-2125353565-970437158=:17208--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
