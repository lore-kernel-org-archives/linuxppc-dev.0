Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 8506C68309
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Sep 2005 19:17:48 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by protonic.prtnl (Postfix) with ESMTP id DD9D029EC9
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Sep 2005 11:14:37 +0200 (CEST)
Received: from protonic.prtnl ([127.0.0.1])
	by localhost (protonic [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 30339-03 for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Sep 2005 11:14:37 +0200 (CEST)
Received: from linux.local (linux.prtnl [192.168.1.97])
	by protonic.prtnl (Postfix) with ESMTP id 1972329EC6
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Sep 2005 11:14:37 +0200 (CEST)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-embedded@ozlabs.org
Date: Tue, 20 Sep 2005 11:17:39 +0200
References: <20050919192101.C6267353BF3@atlas.denx.de>
In-Reply-To: <20050919192101.C6267353BF3@atlas.denx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200509201117.40454.david.jander@protonic.nl>
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


Hi again,

On Monday 19 September 2005 21:21, Wolfgang Denk wrote:
>[...]
> Are you 100% sure your system is stable and wihout any memory errors?
> Never seen any other erros or crashes?

It has been running for several weeks without reboot processing data, and we 
have never had any other strange things, nor data corruption, crashes, or 
whatever.

> > My big question: Is it at all possible that gc.c comes to that BUG() in
> > line 139 because of anything other than a bug in jffs2-code?
>
> Yes, for example when your  SDRAM  initialization  is  broken  and/or
> other memory corruption happens.

Then you would expect to have other symptoms too, don't you? Well, we don't 
have any other symptoms of SDRAM errors. Although, I have seen PC's with 
faulty SDRAM that behave as if the HD was broken, but the fine tool 
"memtest86" finally revealed the truth ;-)
Is there something like memtest86 for linux-ppc (i.e. written in portable C)?

>[...]
> I don't think it's a flash error. If there is data  corruption,  then
> it's more likely the SDRAM.

Hmm, but.... there is no data corruption. I have not seen one file on flash 
that had other data than intended, and that inspite of the GC freaking out.

> > The logs of almost all files in fs/jffs2/ which I have say that the
> > actual version corresponds to the CVS-snapshot of March 13, 2005, and
> > that the previous version of April 2004 is broken.
> > Which files were modified _after_ March 13, 2005?
> > (A hint to what command options or tools to use to browse cvs-logs more
> > easily at this point is appreciated... I am using cervisia).
>
> cvsps is really helpful, see http://www.cobite.com/cvsps/cvsps-2.1.tar.gz
>
> Also there are web interfaces to our kernel tree;
> for CVS see
> 	http://81.169.171.120/cgi-bin/cvsweb/
> for git see
> 	http://81.169.171.120/cgi-bin/gitweb.cgi

Thanks for the tips. The gitweb interface looked quite impressive!

> Make sure to use at least the version tagged as LABEL_2005_05_09_1245
> or later.

We have that version. I have been trying to figure out what changed up until 
that label, but the only thing I found that looked relevant was: 
"Re-implement PatchSets 260, 263 and 303"
That commit only changed 3 files, non of them directly related to jffs2 code, 
and only seemed to add support for FUJITSU flash chips. What am I missing?
MTD developers say that cvs from march-2005 _is_ broken, so there must be some 
evident bug-fixes in your tree since then.... otherwise it is still broken 
(whatever it was).
Of course, maybe I'm just blind ;-)

> > I know about the problems jffs2 has with logfiles and alikes. I am still
> > thinking about what would be the most robust way of coping with this, and
> > until now, oversized partitions with log-rotation on size seems to do the
> > trick. I don't want to loose log-data on power-loss so I don't feel so
> > comfortable with buffering much of it in RAM.
>
> The problem with your approach is the number of  erase  cycles  which
> will cause the flash to die sooner than you may want.

That's true, but under normal use, you'll have maybe 5..10 lines a day added 
to a given logfile, maybe even less, and since the partition is relatively 
huge, wear-levelling in the jffs2 driver should do the obvious I believe.
It's not optimal, but it should work reliably AFAICT.

Regards,

-- 
David Jander
Protonic Holland.
