Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 89732679FF
	for <linuxppc-dev@ozlabs.org>; Sun, 30 Apr 2006 03:57:41 +1000 (EST)
Date: Sat, 29 Apr 2006 19:57:40 +0200 (MEST)
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
MIME-Version: 1.0
References: <1146174809.30710.14.camel@localhost.localdomain>
Subject: Re: Not coherent cache DMA for G3/G4 CPUs: clarification needed
Message-ID: <22904.1146333460@www017.gmx.net>
Content-Type: text/plain; charset="iso-8859-1"
Cc: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> --- Ursprüngliche Nachricht ---
> Von: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> An: "Mark A. Greer" <mgreer@mvista.com>
> Kopie: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org
> Betreff: Re: Not coherent cache DMA for G3/G4 CPUs: clarification needed
> Datum: Fri, 28 Apr 2006 07:53:29 +1000
> 
> > What Ben says is correct, there is that issue.  However, AFAIK, I have
> > not yet to run into it.
> 
> Hrm... well, I wouldn't rely on that tho.
> 
> > If that hardware workaround is not implemented, the options are:
> > a) 100% chance of a system hang with coherency on
> > or
> > b) < 0.0..1% chance of a system hang with coherency off (at least in my
> > experience to far).
> > 
> > The choice is simple.
> 
> I disagree. A solution that is known to have a hole in it is no good
> even if you haven't managed to trigger it so far. Now it's Gerhard's
> choice.
The choice isn't so simple (at least for me):

I read some old posts of AmigaOS4 developers in the last days. It seems they
just do cache flushes at the beginning/end and during (sync) a DMA transfer.
Also the memory used for DMA is marked as cacheable!? Only the memory used
for the PRD tables (for the IDE controller) is marked as cache inhibited.

I tried to get in contact with some OS4 developers, but I couldn't get an
answer yet. :-(

So I will try out the CONFIG_NOT_COHERENT_CACHE implementation first. As far
as I could understand OS4 does not use BATs for memory mapping, thus the
requisites are not really the same, but it's worth a try. On the other side
I don't understand why the PRD tables have to be in non cacheable memory and
I don't like the idea to modify the Linux IDE driver to do a cache
flush/invalidate for the PRD table memory area.

Thanks again for all your help!

Gerhard

-- 
"Feel free" - 10 GB Mailbox, 100 FreeSMS/Monat ...
Jetzt GMX TopMail testen: http://www.gmx.net/de/go/topmail
