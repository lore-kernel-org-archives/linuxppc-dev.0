Message-ID: <3857E7F7.8509A649@netx4.com>
Date: Wed, 15 Dec 1999 14:11:51 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: bsimon@ctam.com.au
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: linuxppc-embedded: /bin/sh wont run from nfsroot.
References: <19991215055541.23843.qmail@web301.mail.yahoo.com> <385725A3.A1C110DF@ctam.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Brendan Simon wrote:

> .......  What is the
> purpose of SASH and the implication of undefining it ?


The kernel handling of the "init" process slot is special.  If
you want to use just a simple shell for interactive development,
it is cumbersome because you can't get the tty signals delivered
to the process.  Two ways around this.  Start up inetd and other
network daemons and remote log in.  The second is to include the
"SASH" code I added.  This creates a shell that doesn't run in
the "init" process slot.  Things like ctl-C will then work to
kill a child process.  There are lots of other hacks around
here you can perform to customize a lightweight embedded working
environment.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
