Message-ID: <3ABA3E47.AC11DFED@inn.ericsson.se>
Date: Thu, 22 Mar 2001 19:02:47 +0100
From: Kenneth Johansson <kenneth.johansson@inn.ericsson.se>
MIME-Version: 1.0
To: Dan Malek <dan@mvista.com>
Cc: frowand@mvista.com,
	Matthias Fuchs <matthias.fuchs@esd-electronics.com>,
	linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>,
	frank@esd-electronics.com
Subject: Re: possible problem in memory management
References: <3AB8B894.1C5FCD37@esd-electronics.com> <3AB9148A.7F25E9A0@mvista.com> <3AB9254E.FE13F585@mvista.com> <3AB9CAE4.F92F3A6B@inn.ericsson.se> <3ABA24B8.7694BF5B@mvista.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:
>
> Kenneth Johansson wrote:
> > Running emacs or simply login over telnet puts it into that state.
>
> I know that login over telnet works for me.  That isn't much of test,
> as it is nice to be able to debug memory problems with carefully
> controlled tests so you know if you have really corrected problems.

You'r right I did some more testing and emacs was a false alarm. It turns out
that the offender is the tcpd wrapper that debian has in inetd.conf.
In the default configuration doing a telnet,finger or talk puts the system in
this "funny" state. Removing the wrapper and everything is fine.

I also found out that the man command get segmentation faults after tcpd has run.

So to sum it up "man ls" and "dpkg --configure" both works OK before the first run of
/usr/sbin/tcpd from debian (potato). After that they alwas get segmentation fault.

I think this is a good enough test however I don't even have a theory on why it's happening.


--
Kenneth Johansson
Ericsson Business Innovation AB   Tel: +46 8 404 71 83
Viderögatan 3                     Fax: +46 8 404 72 72
164 80 Stockholm                  kenneth.johansson@inn.ericsson.se

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
