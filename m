Return-Path: <wd@denx.de>
Received: from mailout05.sul.t-online.com (mailout05.sul.t-online.com
	[194.25.134.82]) by ozlabs.org (Postfix) with ESMTP id D546268341
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Sep 2005 05:21:29 +1000 (EST)
To: David Jander <david.jander@protonic.nl>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 19 Sep 2005 19:26:12 +0200."
	<200509191926.12736.david.jander@protonic.nl>
Date: Mon, 19 Sep 2005 21:21:01 +0200
Sender: wd@denx.de
Message-Id: <20050919192101.C6267353BF3@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Which way to store log in flash on mpc8xx? 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <200509191926.12736.david.jander@protonic.nl> you wrote:
> 
> What happened: System boots, all fs are mounted. The first app that writes 
> something to the log-partition (in this case a config file that is 
> overwritten) causes the GC thread for that partition to crash with a BUG() in 
> line 139 of gc.c, and the application freezes forever. Since GC is dead, all 
> further write-accesses to that partition also hang forever.

Are you 100% sure your system is stable and wihout any memory errors?
Never seen any other erros or crashes?

> My big question: Is it at all possible that gc.c comes to that BUG() in line 
> 139 because of anything other than a bug in jffs2-code?

Yes, for example when your  SDRAM  initialization  is  broken  and/or
other memory corruption happens.

> I mean, if hardware really was a problem, then I should also get at least 
> CRC-errors from jffs2, shouldn't I? IMHO at least, jffs2 should be robust 
> enough to not crash on flash-errors, shouldn't it?

I don't think it's a flash error. If there is data  corruption,  then
it's more likely the SDRAM.

> The logs of almost all files in fs/jffs2/ which I have say that the actual 
> version corresponds to the CVS-snapshot of March 13, 2005, and that the 
> previous version of April 2004 is broken.
> Which files were modified _after_ March 13, 2005? 
> (A hint to what command options or tools to use to browse cvs-logs more easily 
> at this point is appreciated... I am using cervisia).

cvsps is really helpful, see http://www.cobite.com/cvsps/cvsps-2.1.tar.gz

Also there are web interfaces to our kernel tree;
for CVS see
	http://81.169.171.120/cgi-bin/cvsweb/
for git see
	http://81.169.171.120/cgi-bin/gitweb.cgi

Make sure to use at least the version tagged as LABEL_2005_05_09_1245
or later.

> I know about the problems jffs2 has with logfiles and alikes. I am still 
> thinking about what would be the most robust way of coping with this, and 
> until now, oversized partitions with log-rotation on size seems to do the 
> trick. I don't want to loose log-data on power-loss so I don't feel so 
> comfortable with buffering much of it in RAM.

The problem with your approach is the number of  erase  cycles  which
will cause the flash to die sooner than you may want.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
A dog always bit deepest on the veterinary hand.
                                    - Terry Pratchett, _Wyrd Sisters_
