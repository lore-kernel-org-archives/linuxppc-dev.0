Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <40458A8C.8020009@246tNt.com>
Date: Wed, 03 Mar 2004 08:34:36 +0100
From: Sylvain Munaut <tnt@246tnt.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux on MPC5200 - LITE5200EVAL & New bestcomm code ?
References: <20040214145308.9E915C108D@atlas.denx.de> <402E633A.2040009@246tNt.com>
In-Reply-To: <402E633A.2040009@246tNt.com>
Content-Type: multipart/mixed;
 boundary="------------020106060202010204030904"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------020106060202010204030904
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi every one.


A little update on my problems. Apparently the problem was the u-boot
command I used to boot :

I used :
     tftp 100000 mpc5200/uImage; tftp 300000 mpc5200/pRamdisk;bootm
100000 300000

And now I use :
     tftp 200000 mpc5200/uImage; tftp 400000 mpc5200/pRamdisk;bootm
200000 400000

and it works just fine ... Apparently when the kernel was too big, the
area near 100000 is probably used by u-boot in some way, maybe during
decompression and it doesnt work. I've check with multiple different
memory tests that the concerned memory region is fine. So it is a
software issue. Maybe u-boot should give some warning about that ( if
it's the cause, not yet sure ). But that's off topic here.



Now, I'm just looking forward for new BestComm code, to get AC97 and IDE
DMA running ( quite slow and CPU intensive right now ... ).



Sylvain Munaut



--------------020106060202010204030904
Content-Type: application/pgp-signature;
 name="signature.asc"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEuMi40IChH
TlUvTGludXgpCgppRDhEQlFGQVJSSmdkTHQ3WjQvT1lBd1JBaDFJQUo5RU54dzU2VEpBWUlk
aVNLWjVRTFk1eU5FTmJ3Q2ZmSGx3CmtLT3cxWmE1ZURnaWgwdmw1VTY1bW1FPQo9a0tyeQot
LS0tLUVORCBQR1AgU0lHTkFUVVJFLS0tLS0KCg==
--------------020106060202010204030904--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
