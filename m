Message-ID: <3BF57B4F.7B0ABCC@inn.ericsson.se>
Date: Fri, 16 Nov 2001 21:47:11 +0100
From: Kenneth Johansson <kenneth.johansson@inn.ericsson.se>
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>
Cc: Armin Kuster <akuster@mvista.com>,
	"linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: linuxppc_2_4_devel on walnut
References: <3BDD855B.8D3FC72F@inn.ericsson.se> <3BE971BC.34591FF1@inn.ericsson.se> <3BEBF4E5.B60BD9E3@inn.ericsson.se> <3BF2A361.5FBB0246@mvista.com> <3BF4041F.A732B099@inn.ericsson.se> <3BF4A2D4.5080302@embeddededge.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:
>
> Kenneth Johansson wrote:
>
> > But "time dd if=/dev/zero of=testing bs=1024k count=100" on a nfs mouted fs
> > used to be 18s and is now 21s, a 16% slowdown not that I care much but still
> > quite a large difference.
>
> What versions of kernels/drivers are you comparing?  Do you do this
> back-to-back with the same NFS server, or have you introduced more
> variables into your testing?  This is why specially prepared network
> performance testers are better suited for discussion.

This was to the same nfs server on a live network. I did the test only two
times on the first kernel version that was checke out a few hours before the
mail was posted last friday.

This was not done to benchmark anything but a way for me to verify what speed
the networks was using 10/100 Mb was at the time reported wrong by the
driver.

The reason I run it twice was that I thougt 5,5MB/s was not so great but the
second run had the same number. Then I upgraded the tree to a version that
had Armin Kusters changes and just for fun run the test again.

If I test only tcp/ip over the network I now get this..
----
walnut:/tmp# time dd if=/dev/zero  bs=1024k count=100 | nc -q0 <server> 9
100+0 records in
100+0 records out

real    0m14.838s
user    0m0.370s
sys     0m14.380s
---
6,7Mb/s

If I do the same from a intel 400MHz kernel 2.2.20 I get
---
[innkeon@spawn innkeon]$time dd if=/dev/zero  bs=1024k count=100 | nc -q0
<server> 9
100+0 records in
100+0 records out

real    0m12.838s
user    0m0.110s
sys     0m1.890s
---
7,8 MB/s

hmm funny the difference is also 16%

(nc is the netcat program.)

--
Kenneth Johansson
Ericsson Business Innovation AB   Tel: +46 8 404 71 83
Viderögatan 3                     Fax: +46 8 404 72 72
164 80 Stockholm                  kenneth.johansson@inn.ericsson.se

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
