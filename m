Date: Wed, 25 Apr 2001 18:57:12 -0300
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Rsync access through NAT?
Message-ID: <20010425185712.A10982@llama.nslug.ns.ca>
References: <200104250459.XAA22227@lists.linuxppc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
In-Reply-To: <200104250459.XAA22227@lists.linuxppc.org>; from owner-linuxppc-dev-digest@lists.linuxppc.org on Tue, Apr 24, 2001 at 11:59:17PM -0500
From: Peter Cordes <peter@llama.nslug.ns.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Apr 24, 2001 at 11:59:17PM -0500, Linux PPC Developer Digest wrote:

> Date: Tue, 24 Apr 2001 22:51:10 +0200
> From: Michel =?iso-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>
> Subject: Re: Rsync access through NAT?

> > Cisco might 'accidentaly' support it in normal packet forwarding, but might
> > not when doing NAT, since the IP header may need to be rewritten-- probably
> > without the ECN bits.
>
> I must admit I don't really know anything about ECN but that the name of the
> /proc file is tcp_ecn, right? It kinda implies that ECN is only involved with
> TCP, not ICMP or UDP or whatever. In particular, UDP worked fine (DNS lookups)
> when TCP didn't.
>
> - --
> Earthling Michel Dänzer (MrCooper)    \   Debian GNU/Linux (powerpc) developer
> CS student, Free Software enthusiast   \        XFree86 and DRI project member

 That's correct.  The ECN flags go in the TOS byte of the IP header.  (octet
in network-speak).  The rationale is that a fixed location in the IP header
is faster for routers to deal with than a TCP option.  (Also, ECN could
obviously be used for any protocol that runs over IP, not just TCP.  AFAIK,
people currently are only using it for IP packets that hold TCP segments.)

 See http://www.faqs.org/rfcs/rfc2481.html for info on ECN in IPv4.  Search
on "ecn" at http://www.faqs.org/rfcs/ to turn up some other more recent
RFCs.  I haven't read them yet.  (BTW, especially read section 19 of rfc
2481, it explains the history of different definitions of the TOS byte.)

--
#define X(x,y) x##y
Peter Cordes ;  e-mail: X(peter@llama.nslug. , ns.ca)

"The gods confound the man who first found out how to distinguish the hours!
 Confound him, too, who in this place set up a sundial, to cut and hack
 my day so wretchedly into small pieces!" -- Plautus, 200 BCE

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
