Message-ID: <399C704B.CA63A22D@sympatico.ca>
Date: Thu, 17 Aug 2000 19:07:55 -0400
From: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>
Reply-To: khendricks@ivey.uwo.ca
MIME-Version: 1.0
To: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Another signal handling bug?
References: <Pine.LNX.3.96.1000817193728.8005E-100000@deepspace.mklinux.org>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi David,

If you are grabbing mutexes in a signal handler, you are obviously in a
multithreaded environment.  When you set the sa_flags to zero you may prevent
that thread from recursing in the signal handler but the signal could be delived
to another thread which in fact has its own signal mask and things but shares
sigaction strucutres and it could be entering your signal handler.

Just a thought, but something to possibly check out.

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
