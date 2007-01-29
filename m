Return-Path: <efault@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id C27A2DDE09
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 17:26:19 +1100 (EST)
Subject: Re: 2.6.20-rc6: known unfixed regressions (v2) (part 2)
From: Mike Galbraith <efault@gmx.de>
To: Uwe Bugla <uwe.bugla@gmx.de>
In-Reply-To: <20070128133344.214070@gmx.net>
References: <Pine.LNX.4.64.0701241847360.25027@woody.linux-foundation.org>
	<20070127174230.GN6017@stusta.de>  <20070128133344.214070@gmx.net>
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Jan 2007 07:26:03 +0100
Message-Id: <1170051963.6454.7.camel@Homer.simpson.net>
Mime-Version: 1.0
Cc: akpm@osdl.org, nickpiggin@yahoo.com.au, linux-ide@vger.kernel.org,
	petero2@telia.com, linux-kernel@vger.kernel.org,
	livio@eecg.toronto.edu, Adrian Bunk <bunk@stusta.de>,
	B.Zolnierkiewicz@elka.pw.edu.pl, linuxppc-dev@ozlabs.org,
	paulus@samba.org, anton@samba.org, gd@spherenet.de,
	cijoml@volny.cz, ttb@tentacle.dhs.org, rml@novell.com,
	torvalds@linux-foundation.org, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2007-01-28 at 14:33 +0100, Uwe Bugla wrote:
> -------- Original-Nachricht --------
> Datum: Sat, 27 Jan 2007 18:42:30 +0100
> Von: Adrian Bunk <bunk@stusta.de>
> An: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@osdl.org>
> Betreff: 2.6.20-rc6: known unfixed regressions (v2) (part 2)
> 
> > This email lists some known regressions in 2.6.20-rc6 compared to 2.6.19
> > that are not yet fixed in Linus' tree.
> > 
> > If you find your name in the Cc header, you are either submitter of one
> > of the bugs, maintainer of an affectected subsystem or driver, a patch
> > of you caused a breakage or I'm considering you in any other way possibly
> > involved with one or more of these issues.
> > 
> > Due to the huge amount of recipients, please trim the Cc when answering.
> > 
> > 
> > Subject    : problems with CD burning
> > References : http://www.spinics.net/lists/linux-ide/msg06545.html
> > Submitter  : Uwe Bugla <uwe.bugla@gmx.de>
> > Status     : unknown
 
<snip>

> Hi everybody,
> the problem I already reported for earlier release candidates of kernel 2.6.20
> (rc1 – 5) unfortunately stills persists.
> 
> The regression has become more extreme: While in earlier release candidates nerolinux recognized my burning devices at least after the first start and then never again after all following starts the situation in rc6 is different from that:
> 
> The CD and DVD burning devices aren´t recognized even once and the drive seek errors I already reported are still there.
> 
> nerolinux runs excellently with kernel 2.6.19.2, but only shows an “image recorder” (i. e. no burning device at all) in kernel 2.6.20-rc6.
> 
> Still hope that this terrible bug will not be part of the final version of 2.6.20!
> 
> Regards
> 
> Uwe

FWIW, I just tried it with 2.6.20-rc6, and can confirm.  Once nero is
run, the kernel never gives up retrying whatever command failed, so I
get...

[ 4362.972995] hdd: status error: status=0x58 { DriveReady SeekComplete
DataRequest }
[ 4362.981475] ide: failed opcode was: unknown
[ 4362.986183] hdd: drive not ready for command

endlessly.

	-Mike
