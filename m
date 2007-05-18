Return-Path: <daniel.schnell@marel.com>
Received: from mail.marel.com (mail.marel.is [213.167.134.96])
	by ozlabs.org (Postfix) with ESMTP id E8D3CDDE02
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 May 2007 20:27:46 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: MPC5200B memory performance
Date: Fri, 18 May 2007 10:27:43 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB01F09586@is-hdq-exchange.marel.net>
In-Reply-To: <20070516180259.GA23085@server.idefix.lan>
References: <DD39B5C3F4963040ADC9768BE7E430CB01EB1FEF@is-hdq-exchange.marel.net>
	<20070516180259.GA23085@server.idefix.lan>
From: "Daniel Schnell" <daniel.schnell@marel.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I found the following link to get more insights about the memcpy =
performance of my board:

http://www.greyhound-data.com/gunnar/glibc/index.htm
=20
One can download a testsuite for memory performance and let it run. Not =
only memcpy, but also memcmp and memset is tested.

This gave quite interesting results. Most of the time I get better =
values from optimized functions than from the glibc functions. As a rule =
of thumb: depending on the buffer size used, 15-20 % speedup, sometimes =
> 100% !

I will definetly integrate some of these functions in our software and =
then use=20
-Wl,--wrap,memcpy on the linker line to replace all occurences of =
memcpy, memcmp, etc. also for external libraries.


Best regards,

Daniel Schnell

--=20
Daniel Schnell                   | daniel.schnell@marel.com
Hugb=FAna=F0arger=F0                   | www.marel.com

-----Original Message-----
From: linuxppc-embedded-bounces+daniel.schnell=3Dmarel.com@ozlabs.org =
[mailto:linuxppc-embedded-bounces+daniel.schnell=3Dmarel.com@ozlabs.org] =
On Behalf Of Matthias Fechner
Sent: 16. ma=ED 2007 18:03
To: linuxppc-embedded@ozlabs.org
Subject: Re: MPC5200B memory performance

Hello Daniel,

* Daniel Schnell <daniel.schnell@marel.com> [15-05-07 11:22]:
> I get the following values on my board:

my result is:
Test (10000) memcpy of sizes (1024) ....
10000 memcpy. Time per memcpy: 1814 [nsec] (564 MB/sec)  finished.
Test (10000) memcpy of sizes (2048) ....
10000 memcpy. Time per memcpy: 3433 [nsec] (596 MB/sec)  finished.
Test (10000) memcpy of sizes (4096) ....
10000 memcpy. Time per memcpy: 6687 [nsec] (612 MB/sec)  finished.
Test (10000) memcpy of sizes (8192) ....
10000 memcpy. Time per memcpy: 21454 [nsec] (381 MB/sec)  finished.
Test (10000) memcpy of sizes (16384) ....
10000 memcpy. Time per memcpy: 205551 [nsec] (79 MB/sec)  finished.
Test (1000) memcpy of sizes (32768) ....
1000 memcpy. Time per memcpy: 379875 [nsec] (86 MB/sec)  finished.
Test (1000) memcpy of sizes (51200) ....
1000 memcpy. Time per memcpy: 588792 [nsec] (86 MB/sec)  finished.
Test (1000) memcpy of sizes (102400) ....
1000 memcpy. Time per memcpy: 1126511 [nsec] (90 MB/sec)  finished.
Test (100) memcpy of sizes (1048576) ....
100 memcpy. Time per memcpy: 11307890 [nsec] (92 MB/sec)  finished.
Test (10) memcpy of sizes (10485760) ....
10 memcpy. Time per memcpy: 120783600 [nsec] (86 MB/sec)  finished.
Test (5) memcpy of sizes (52428800) ....
5 memcpy. Time per memcpy: 673867800 [nsec] (77 MB/sec)  finished.
	  =20


Best regards,
Matthias

--=20

"Programming today is a race between software engineers striving to =
build bigger and better idiot-proof programs, and the universe trying to =
produce bigger and better idiots. So far, the universe is winning." -- =
Rich Cook _______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
