Subject: Re: cache coherence problem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reply-To: benh@kernel.crashing.org
To: Juergen Kienhoefer <juergen@kienhoefer.com>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <1069132955.7170.120.camel@gaston>
References: <3FB972E8.5090701@kienhoefer.com>
	 <1069122238.7168.63.camel@gaston>  <3FB9A77C.3030101@kienhoefer.com>
	 <1069132955.7170.120.camel@gaston>
Content-Type: text/plain
Message-Id: <1069133049.7168.123.camel@gaston>
Mime-Version: 1.0
Date: Tue, 18 Nov 2003 16:24:10 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 2003-11-18 at 16:22, Benjamin Herrenschmidt wrote:
> On Tue, 2003-11-18 at 16:00, Juergen Kienhoefer wrote:
> > Guys,
> > Thank you very much for the ideas.
> > Basically, what I need to do is:
> > dcbst
> > sync
> > iccci
> ^^^^^^^
> No: icbi
>
> > sync
> > isync
> > for every 32 bytes of the memory block I put code in.

Actually, to be precise, you need:

 1) A loop of dcbst's over every cache line crossed by your code
 2) one sync
 3) A loop of icbi's over every cache line crossed by your code
 4) one sync, one isync

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
