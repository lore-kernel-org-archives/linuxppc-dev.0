Date: Wed, 16 Aug 2000 20:11:01 -0700 (PDT)
From: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
To: Frank Jas <frank@jrware.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Signal mask restore anomaly
In-Reply-To: <200008161925.MAA00373@tallis.jrware.com>
Message-ID: <Pine.LNX.3.96.1000816200603.30198F-100000@deepspace.mklinux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 16 Aug 2000, Frank Jas wrote:

> Under certain circumstances, a signal blocked while a
> signal handler is executing will not be restored.

Hmm... I think I may be seeing something similar to this as well.  It
could explain some very strange behaviour I'm seeing in my alarm handler.


> The following execution sequence leads to the anomalous behavior.
>
>
> Trigger the SIGTSTP handler with a ^Z
> While executing the handler, deliver a ^Z and ^C
> Hit return to return from the handler.
> Another instance of the SIGTSTP handler should execute.
> Hit return to return from that instance of the handler.
> Notice that the SIGINT handler does not execute and should have.
> Any subsequent SIGINT are apparently blocked.

I'm almost sure I'm seeing this.  Except for me, it's a 10/sec. alarm
handler and a SIGUSR2 that only occurs occasionally.  Major hair rippage.
Let me know if anybody sees what's up.  Until then, I may stop blocking
SIGUSR2 and see if that helps one of my two problems.  :-)


Later,
David

---------------------------------------------------------------------
A brief Haiku:

Microsoft is bad.
It seems secure at first glance.
Then you read your mail.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
