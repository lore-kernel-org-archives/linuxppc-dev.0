Date: Thu, 11 Mar 2004 20:54:51 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Stephen Williams <612dlag102@sneakemail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [RFC] "indirect" DCR access (40x, BookE)
Message-ID: <20040312045451.GA25876@gate.ebshome.net>
References: <20040312014800.GA25455@gate.ebshome.net> <405124A3.3040002@embeddededge.com> <20040312030502.GA25644@gate.ebshome.net> <24019-11838@sneakemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <24019-11838@sneakemail.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Mar 11, 2004 at 08:44:09PM -0800, Stephen Williams wrote:
> >>I think you should just write it as self modifying code :-)
> >>Write the instruction with the DCR number and just execute it.
> >
> >
> >And deal with locking and icache/dcache coherency ?
> >
> >No, thanks :)
>
>
> Actually, I recall that there is a code fixup mechanism that
> is invoked early in kernel init that does exactly that: it
> manages some machine specific differences by editing the code
> in place in a safe way.

Yes, you are correct, but this is done only once during startup and
nobody cares how fast it is. BTW, there is no locking issues at this
stage.

I'm not saying that it's impossible :). It's just not very efficient
to do such stuff on run-time (lock a spinlock, change memory, dcache
flush, icache invalidate, isync...)

Eugene.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
