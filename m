Mime-Version: 1.0
Message-Id: <v04220806b4b3862478e5@[10.0.1.120]>
In-Reply-To: <388D7A4C.91D0E2BC@tiac.net>
References: <388D7A4C.91D0E2BC@tiac.net>
Date: Tue, 25 Jan 2000 12:25:26 -0500
To: Patrick Callahan <pac1@tiac.net>,
        "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
From: Paul Schinder <schinder@pobox.com>
Subject: Re: getservbyname as used in tcpserver ucspi-tcp-0.84 not finding
 smtp in  /etc/services
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 6:28 AM -0400 1/25/00, Patrick Callahan wrote:
>I'm attempting an install of qmail using the additional packages
>recommended for use with qmail, ucspi-tcp and daemontools.

I use them on two Yellow Dog Linux CS 1.1 boxes.  No problems whatsoever.

>
>Everything seems to be up and running.  qmail can send mail via smtp to
>my isp just fine, but local mail is fried due to a failure in starting
>tcpserver to process requests local smtp requests.   tcpserver fails on
>a call to getenvbyname, which is apparently returning a null, when given
>smtp and tcp for parameter values.  /etc/services is as provided in
>YDL's CS-1.1  I'll probably switch to having qmail-smtpd started from
>inetd as a workaround. While I work on getting this particular snag
>straightened out.

You mean getservbyname?  What does your /etc/nsswitch.conf say about
services:?  Which version of glibc are you using, the one that came
with YDL CS 1.1?

>
>I'm not' quite prepared to do debugging yet so I've got two questions:
>some for this list and one for the users list.
>
>Here's the "dev" questions
>
>is anyone working on tcpserver or the ucpsi package of which it is a
>part?  Has anyone encountered situations where calls to getservbyname do
>not return valid services listed in /etc/services?


What is there to "work" on?  The software compiles out of the box, so
whatever problems you're having are likely specific to your machine.
Did you install the glibc-devel package when you installed CS 1.1?

>
>The author of qmail makes statements about the relative security of
>qmail vs sendmail, and states that many sites are switching to tcpserver
>as a replacement for inetd.  What's the PPC development community's
>thoughts on this?  Is he right?,  are any of you moving in that
>direction?


Yes, he is absolutely right.  You can count on Berntein's software to
be two things, very secure and different from what it's replacing.
It takes a little getting used to, but the "start and forget"
security is worth it.  I use daemontools, ucspi-tcp, qmail, and
dnscache on Yellow Dog Linux and and on Solaris and HP-UX boxes.  For
the history of problems with Sendmail and BIND and inetd, you only
need go to places like CERT <http://www.cert.org/> and do a little
digging.

You'll find no mention of qmail at CERT.  There have only ever been
two reported problems with qmail that I'm aware of.  The first was by
Wietse Venema, after Dan Bernstein found a serious problem with an
early alpha version of Postfix, claiming that qmail was susceptible
to denial-of-service attacks.  This might be why Dan dropped official
support for running out of inetd from qmail-1.03, since tcpserver
prevents that kind of attack.  The second was the just announced
"problem" with qmail-pop3d, which is actually a security hole in a
3rd party add-on.  The original announcement on BUGTRAQ smelled like
a "get Dan" announcement, possibly because, since he's released
dnscache, his attention is turned to BIND and he is now finding holes
in it.

>
>-Pat
>
>I also have questions about setting up an appropriate development and
>debugging environment.   I figure that's a user issue, unrelated to the
>development of Linux so I'll ask in the user list.

--
Paul Schinder
schinder@pobox.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
