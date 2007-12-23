Return-Path: <cbouatmailru@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.169])
	by ozlabs.org (Postfix) with ESMTP id A8F00DDE1F
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Dec 2007 23:36:11 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so972343uge.0
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Dec 2007 04:36:09 -0800 (PST)
Date: Sun, 23 Dec 2007 15:25:08 +0300
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 1/3] [POWERPC] FSL UPM: routines to manage FSL UPMs
Message-ID: <20071223122508.GA5872@zarina>
References: <20071221203552.GA4738@localhost.localdomain>
	<20071221203925.GA4829@localhost.localdomain>
	<20071223132457.a40e8100.sfr@canb.auug.org.au>
	<20071223115935.GB5643@zarina> <20071223121735.GA5831@zarina>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20071223121735.GA5831@zarina>
Cc: linuxppc-dev@ozlabs.org
Reply-To: cbouatmailru@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Dec 23, 2007 at 03:17:35PM +0300, Anton Vorontsov wrote:
> On Sun, Dec 23, 2007 at 02:59:35PM +0300, Anton Vorontsov wrote:
> [..]
> > > > +static inline void fsl_upm_start_pattern(struct fsl_upm *upm, u32 pat_offset)
> > > > +{
> > > > +	spin_lock_irqsave(&upm_lock, upm_lock_flags);
> > > 
> > > I may be wrong, but don't we need the "flags" argument to
> > > spin_lock_irqsave to be on the stack?  And the save and restore to be in
> > > the same function?
> > 
> > In general case, yes. Here, not exactly. We have to grab a lock at the
> > start(), do runs(), and release a lock at the end():
> 
> Ugh, that's stupid of course. flags are indeed should be on the stack.
> So, what I can use here is a mutex, and thus forbid using these
> routines from the isrs. Another option would be disabling interrupts
> and getting plain lock, but that is ugly. So will use a mutex.

Ignore me please, I should had more sleep today. For God's sake,
why I've just said a "mutex"?.. I should just get a plain lock and
forget about isrs.

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
