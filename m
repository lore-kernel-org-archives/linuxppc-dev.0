From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Serial port text corruption
Date: Tue, 18 May 2004 23:17:01 +0200
Message-ID: <BCEFJBPJCGFCNMMMIDBHIEBECGAA.Joakim.Tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <065ACD8E84315E4394C835E398C8D5EB089D46@cossmgmbx02.email.corp.tld>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> I would look at the SMC1 buffering and handling of caches (either snooping, not caching the buffers, or flushing before
> transmitting).

The 8xx uses its internal memory as buffers and this is uncached memory, so this should not be a problem.

>
> Another possiblility is sending data that is stored on the stack in a subroutine which subsequently returns before the
> data is actually transmitted -- when you are lucky, the data hasn't changed when the Tx occurs, when you are unlucky, a
> call sequence has overwritten the string on the stack.  Since this is (presumably) standard linux and that sort of a
> problem would have been found and fixed loooong ago in the linux core code, I would concentrate on your low level code.

OK, I will have a look at this.

>
> Just to eliminate variables, you should hook a logic analyzer or 'scope to the board's Tx line and verify the baud rate
> hasn't changed when you get the garbage characters.  If the baud rate has changed, it will be a clocking problem.

I will see what I can do.

 Jocke

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
