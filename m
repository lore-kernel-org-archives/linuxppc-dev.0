From: "Jeffrey D. Kowing" <jeffrey.d.kowing1@jsc.nasa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15456.32984.74998.373361@igor.jsc.nasa.gov>
Date: Tue, 5 Feb 2002 19:03:20 -0600
To: "David A. Gatwood" <dgatwood@gatwood.net>
Cc: murali nagarajan <muralin@gdatech.com>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Problem with ping/telnet
In-Reply-To: <Pine.LNX.3.96.1020205163126.16943I-100000@gatwood.net>
References: <028801c1aea2$610d96a0$0900a8c0@Domain.invalid>
	<Pine.LNX.3.96.1020205163126.16943I-100000@gatwood.net>
Reply-To: jeffrey.d.kowing1@jsc.nasa.gov
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


David A. Gatwood writes:
 >
 > On Tue, 5 Feb 2002, murali nagarajan wrote:
 >
 > > With your info, I am able to do a telnet from my board to the host, only if
 > > I specify the port number. What surprises me is that the presence of both
 > > /etc/services (entry to telnet is available with a port number) and the
 > > /etc/protocols files. For some reason, may be the boot process is unable to
 > > read these information.  But when I want to do a telnet to my board from my
 > > host iMAc, I am unable to do. I get an error message "connection refused".
 >
 > This sounds vaguely familiar like I've run into it before, but I can't
 > remember where.
 >
 > The boot process doesn't read /etc/services.  That's read on-the-fly by
 > the telnet program itself with calls to either getservbyname or
 > getservent, which are standard C library calls, and should always work if
 > the service is listed and the files (and directory) are readable by the
 > user that telnet is being run as.

It sounds like you might be missing some of the glibc resolver
libraries that allow programs to access the various databases (i.e.,
things like /etc/services and /etc/protocols.)  In particular, I think
you might be missing the /lib/libnss_files.so.  There is a discussion
of this somewhere in the glibc info pages as I recall.  Also, your
/etc/nsswitch.conf file is important for determining which source of
information takes precedence (for instance, in the case of name
resolution, do you use /ect/hosts first or a domain name server
first).

Regards.

--
Jeff Kowing
jeffrey.d.kowing1@jsc.nasa.gov

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
