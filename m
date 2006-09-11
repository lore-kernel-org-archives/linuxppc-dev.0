Return-Path: <bwarren@qstreams.com>
Received: from web309.biz.mail.mud.yahoo.com (web309.biz.mail.mud.yahoo.com
	[68.142.199.185]) by ozlabs.org (Postfix) with SMTP id EC27D67B6B
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 11 Sep 2006 14:56:29 +1000 (EST)
Message-ID: <20060911044947.81327.qmail@web309.biz.mail.mud.yahoo.com>
Date: Sun, 10 Sep 2006 21:49:47 -0700 (PDT)
From: Ben Warren <bwarren@qstreams.com>
Subject: Re: Stupid Telnet Question
To: "Martin, Tim" <tim.martin@viasat.com>, linuxppc-embedded@ozlabs.org
In-Reply-To: <821B2170E9E7F04FA38DF7EC21DE4871064A53C4@VCAEXCH01.hq.corp.viasat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Tim,

--- "Martin, Tim" <tim.martin@viasat.com> wrote:

<snip>

>  When I just telnet
> locally from the serial console to the board (using
> the loopback IP
> 127.0.0.1) the telnet daemon connects, but the login
> program doesn't
> give me a chance to type a username or login.  
> 
> Question: What stupid thing have I done to cause
> this and how can I fix
> it?
> 
> -------------------------------------------------
> This is what my console session looks like:
> 
> # telnet 127.0.0.1
> 
> Entering character mode
> Escape character is '^]'.
> 
> 
> Linux 2.6.14 (172.16.5.11) (17:13 on Tuesday, 22
> November 2011)
> 
> Login incorrect
> 
> Login incorrect
> 
> Login incorrect
> 
> 
> Login incorrect
> Connection closed by foreign host.
> 
> -------------------------------------------------
> And here's what syslog is saying:
> 
> Nov 22 17:15:08 172 authpriv.info xinetd[1025]:
> START: telnet pid=1037
> from=172.16.1.199
> Nov 22 17:15:08 172 authpriv.notice login: FAILED
> LOGIN 1 FROM
> 172.16.1.199 FOR (null), Authentication failure

For security reasons, Telnet is typically set up so
that you can't log in using 'root'.  This is because
the data channel isn't encrypted so passwords are
easily compromised.  If you don't have any other users
set up, it will give the behaviour that you're seeing.
 

It's been a while since I've done this, but I think
you need to edit /etc/xinetd.d/telnet to allow root
use.  Or add a user.  Or install SSH.

cheers,
Ben
