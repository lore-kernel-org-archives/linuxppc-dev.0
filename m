From: Kevin Hendricks <khendricks@ivey.uwo.ca>
Reply-To: khendricks@ivey.uwo.ca
To: Kostas Gewrgiou <gewrgiou@imbc.gr>, anthony tong <atong@uiuc.edu>
Subject: Patches to fix aty128fb and xf400 r128 to work with both Rage128 and Rage128Pros
Date: Mon, 20 Mar 2000 21:33:10 -0500
Content-Type: Multipart/Mixed;
  boundary="Boundary-=_nWlrBbmQBhCDarzOwKkYHIDdqSCD"
Cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
References: <Pine.LNX.4.21.0003151544550.3091-100000@idd-01.imbc.gr>
In-Reply-To: <Pine.LNX.4.21.0003151544550.3091-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Message-Id: <00032021464800.00801@localhost.localdomain>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--Boundary-=_nWlrBbmQBhCDarzOwKkYHIDdqSCD
Content-Type: text/plain
Content-Transfer-Encoding: 8bit

Hi Kostas,

With lots of help from Ben, we were able to figure out that the OF values used
to initialize the Rage128 and Rage128Pro cards are the same ones used by the
MacOS and that we can actually read the X_MPLL_REF_FB_DIV value, the XCLK_CNTL,
and PLL_REF_DIV values and calculate the proper XCLK.  In a similar way you can
calculate the MCLK value too so you can get or calculate almost all of the same
info as is probed from the Bios under x86 machines.

This allows both machines with G3s, and G4 (even with the Rage 128 cards) to
work with the same aty128fb.c kernel driver without any table lookups.

The patch to add this to the aty128fb.c is attached.  I have also used
similar code to replace the bios code probe for powerpc in the r128_driver.c for
xf400. The patch to do that is also attached.

These patches have been tested and work fine on my B+W G3 rev 2, my brand new
G4 with Rage128Pro card, and on Ben's older G4 with the non-pro card.

We still need to test this on a B+W G3 revision 1 just to be complete (but Ben
will do that soon).

Assuming they test out fine, Kostas would you see about getting the r128 patch
integrated into the next xf40X release while I see about getting Paul and/or
Anthony to integrate the aty128fb.c patch into both the stable and development
kernels.

Hopefully with these in place, new G4s will work as well as older G4s
and G3s.

Thanks!!!

Kevin


--
Kevin B. Hendricks
Associate Professor of Operations and Information Technology
Richard Ivey School of Business, University of Western Ontario
London, Ontario  N6A-3K7  CANADA
khendricks@ivey.uwo.ca, (519) 661-3874, fax: 519-661-3959


--Boundary-=_nWlrBbmQBhCDarzOwKkYHIDdqSCD
Content-Type: application/x-gzip;
  name="xf4_usepll.patch.gz"
Content-Disposition: attachment; filename="xf4_usepll.patch.gz"
Content-Transfer-Encoding: base64

H4sICIHc1jgAA3hmNF91c2VwbGwucGF0Y2gAnVVtb+I4EP4Mv2JuT7ciEJaQBZaCitptDwktoajs
nSp1K8skDljN29mmpO3uf7+xU0IpvS8XRY4ZzzyeeeaFZrMJud/KRLoSNJatG8nEAxOt9baVh4Kx
fq8VCI4S2RJtt28WUkg++Z8iKlVlsUnAowLaJ/gOOi6+4DqOU200Gv8fu+KlBazrgNsetPuDbqeA
PTuDZrdzYvegoT+dNpydVcE8edjvXTMazH3+dXK1qKVhKJmygSdh2hyh9Dtd2eDYsNyEIRM2RCxZ
qbUFAzh8frwBNGgFit6eBwEa79DfgFlVqDZ+52HAQiAkS7dMZD4h1YYGfK42ik2rDmrNBAMuIUlh
yVMJmyRgAqY82eQw13bzCwRXcJWxBMZcxFsqWGGOT5AyCegAbDINBfPpFARbcamQUUDWMyaiR6BJ
AFsGPk1gI/fWap1KBirFg8jfRFQxzFV0b9RDjouGFAwDY4nPIOAPXDtXb+0CQG8lXyUsgJzEWRQR
VCbhkqDm8EgDkYmfqOjoZJbb4B1J56lUl/xhwdTtHZzCM2asbYNrQ8eGvg2fbeihxP1lDF+MkdBz
KTcxg+s/x+BHqX+vuXVPug5g6hCcK4k5g7Zzv36yTCQ7Q2ripQpoFAHGoomIN1LBkuGrtgz5b7td
8NZPRtftOnpbQqBJc1SSRbC4/0G39dXD1xoxT4hmypwDaiCm80aF5ocqWkOr7J1NGDKEiYtZnIpH
iGmRfp5qIaYYJjNdCpLrvHEFZcphTXWt6agwniBNGDxi+WDYao1MZSlPFLaKQZOKCoWFVYZ4jc3p
0czzJle1bOGLxNr5fZR+9Nq4UOjZxpTcEA9FBHNDxl/J5eTvvf2uON63u5h+Ixez71MLPoKTfxm+
T/nxtcZ6vrtTX4gAR0LinS++DffkbhLNJ7JGVxSpOAj/L312SMDL6SzHy2vHRGiPHWc8dhwLRiPo
7y7yUP2/9bXFK3ATqenN08IP7IxazYW6vrb+Xu1ZNia9UqnUPDx/1Usl03fWHv8XDisW4WQo4ywH
HradijMbS+mJpWEN99rO6PEQ9O9b5w5+O0Wvu134+VNr37ZfJJRahepzMbFPunpi9z479hczsCsH
V2ki9HwlS9O4DU1E30atisGoXZxfX/ahbn0s2SjdKiWlcyakJOAhTuJyjF+KB0+uitQ1RxLXCY5b
HD83ZDIbX+m7Xtrkg26fjOJ/FtOjdAAiPP0jABHoFXvYfGiOn6EpXtz8SD7Y1X8BOSUa5EwHAAA=

--Boundary-=_nWlrBbmQBhCDarzOwKkYHIDdqSCD
Content-Type: application/x-gzip;
  name="aty128fb_fix.patch.gz"
Content-Disposition: attachment; filename="aty128fb_fix.patch.gz"
Content-Transfer-Encoding: base64

H4sICDnd1jgAA2F0eTEyOGZiX2ZpeC5wYXRjaACtVW1v0zAQ/tz8ikNIkLRp5zjdVlYxBhuVEOs2
MYQqIWS5sbNaTZModroC4r9zdrpqL+34QhWpSfzc23PPXbrdLohKLWWl95ZKyGKPm58RHaTTXtLL
uData25gzCuIBkDjI9I/on2ghBCv0+nsNG1d13lj9QaigyN6eNSPG6uTE+jSiMbhAXTcf7wPJyce
aMONSmBZKAGMqVwZDxp/zKiFym+0r01VJwbSKR6nBWtOoW0fAg9+ex2v81KlIGSqcil8xsriVlZl
wljgdQD22qBybSQXUKTAwfBpJiErinldAte6Xki4HMGMayiropRV9hO0NFCX1hp/Zibh6vwcKnmj
0E+lgecCai3tiapgybNaajCFM7Poyen557Xx+tBaVDKVlcwTCUJZ4jaW7T1bA0AdU1ixRZllDLEM
C0bgcHOSZHOW5CbbvLlYhTBunnKtbrB4uCq0OVPLa2m+/4C38JuEEIVAQ+iHMAghDuEA39A/zmrN
zvuGgy8fR5BkRTIHpYG+2Sfgqxw9K6MtcRGZz34FLldnZSsyMxQJzzLAlDE7WNTawFTiZW6lzDHQ
PoxnvxyW7hN729jb3nWPkwL7wnOje6IwTei3LvIQtoFKSwxKAkHomJDhbhBfWU+IsSALe0IrnqOQ
WCYYvvcnbIwdZkgBG31gZ5++Bc75hvJHaGwvO734eh7AKyCrQ4e9sCH9p3EsgpDRiJAAjo9h4MBj
xO4GW3iwTvxxfTYla1wVdS6sje9TaNvo7Z2sBiHy2Wq1/DGC7ilkU96PYFc4m9udWh9wcHXHlyUL
877/zMbvrz87hy9lpmUzCZ4bBxTO18uzS1jwuURZoEcjFyWKyNjhm+K8W4U4KI60/2JnSR60/iWi
9c6J4/DQ7pwDirvHrpydzu+0s835E121sBQa4x0UOegCByjhldDvXP5e126kaFPzZDJxdffglGdJ
nXEjN8umByO1wg30WtsxAqSa697zLNzryrZcHzaNrOLpHRd9GkaxJeOQhBF1bDRhbGe12T4LoRNl
P+knkUSdbPCWkdtKGVmXAgvy3UIeYumu6V2X/X+UE/rNhUq9h0q6z+iznFmxbyNrPVBkFYm+cF3V
HJuJX4OFPWl288PQj12kCj9Lt0qYmVtNg+EzMCFLB4vp0PsLv6WIaoUHAAA=

--Boundary-=_nWlrBbmQBhCDarzOwKkYHIDdqSCD--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
