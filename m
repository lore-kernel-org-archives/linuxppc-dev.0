Reply-To: <joakim.tjernlund@lumentis.se>
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "'Tom Rini'" <trini@kernel.crashing.org>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: tx_full v.s tx_free race fix in 8xx_io/enet.c?
Date: Thu, 4 Dec 2003 15:32:04 +0100
Message-ID: <000201c3ba73$63dba410$0a01a8c0@LUMENTIS02>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: 
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Something I find a bit odd is that I can run ping -s 1472 -f
> <myTargetIp>
> without problems, but if i "jump start" the ping with "ping
> -s 800 -f <myTargetIp> -l 8"
> I start to loose packages. Ifconfig shows no errors for both cases.
> Do you get the same?
>
>  Jocke

Found this problem. It is the backoff/retry logic thats
causing very long TX delays. If I reduce "retlim"(retry limit) from
15 to 6, the system recovers from a large packet ping storm.

Is it a bad idea to reduce the retry limit?

 Jocke

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
