Date: Tue, 5 Feb 2002 16:46:13 -0800 (PST)
From: "David A. Gatwood" <dgatwood@gatwood.net>
To: murali nagarajan <muralin@gdatech.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Problem with ping/telnet
In-Reply-To: <028801c1aea2$610d96a0$0900a8c0@Domain.invalid>
Message-ID: <Pine.LNX.3.96.1020205163126.16943I-100000@gatwood.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 5 Feb 2002, murali nagarajan wrote:

> With your info, I am able to do a telnet from my board to the host, only if
> I specify the port number. What surprises me is that the presence of both
> /etc/services (entry to telnet is available with a port number) and the
> /etc/protocols files. For some reason, may be the boot process is unable to
> read these information.  But when I want to do a telnet to my board from my
> host iMAc, I am unable to do. I get an error message "connection refused".

This sounds vaguely familiar like I've run into it before, but I can't
remember where.

The boot process doesn't read /etc/services.  That's read on-the-fly by
the telnet program itself with calls to either getservbyname or
getservent, which are standard C library calls, and should always work if
the service is listed and the files (and directory) are readable by the
user that telnet is being run as.

You said this is an NFS root, right?  Is it set to squash root permissions
to nobody, by chance?  If so, you might try turning that off.  Just a
vague notion.

Beyond that, I'm out of ideas.  Maybe some of the folks who do daily
embedded work could say more.  I haven't done that in the better part of a
year, and I'm a little rusty.  :-)


Later,
David

---------------------------------------------------------------------
                    Check out my weekly web comic:
                     http://www.techmagazine.org


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
