Date: Thu, 17 Aug 2000 20:28:48 -0700 (PDT)
From: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
To: khendricks@ivey.uwo.ca
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Another signal handling bug?
In-Reply-To: <399C704B.CA63A22D@sympatico.ca>
Message-ID: <Pine.LNX.3.96.1000817202736.8005H-100000@deepspace.mklinux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 17 Aug 2000, Kevin B. Hendricks wrote:

> Hi David,
>
> If you are grabbing mutexes in a signal handler, you are obviously in a
> multithreaded environment.  When you set the sa_flags to zero you may prevent
> that thread from recursing in the signal handler but the signal could be delived
> to another thread which in fact has its own signal mask and things but shares
> sigaction strucutres and it could be entering your signal handler.
>
> Just a thought, but something to possibly check out.

Already did.  I thought I said that in the original message, but that's
probably been lost for some time in everyone's inbox.  ;-)

Anyway, the program blocks SIGALRM before it spawns threads, and only
unmasks it in the desired thread.


David

---------------------------------------------------------------------
A brief Haiku:

Microsoft is bad.
It seems secure at first glance.
Then you read your mail.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
