Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id DBBD4DDDF5
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Feb 2008 01:47:48 +1100 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Sun, 24 Feb 2008 15:47:45 +0100
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <1203719521.6976.30.camel@pasglop>
Message-ID: <20080224144745.202740@gmx.net>
MIME-Version: 1.0
References: <ebff4ecb45908616728fb5c8ede8b0bf@bga.com>	
	<20080222190531.103050@gmx.net> <1203719521.6976.30.camel@pasglop>
Subject: Re: How to dynamically disable/enable CPU features?
To: benh@kernel.crashing.org
Cc: linuxppc-dev@ozlabs.org, miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


-------- Original-Nachricht --------
> Datum: Sat, 23 Feb 2008 09:32:01 +1100
> Von: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> An: Gerhard Pircher <gerhard_pircher@gmx.net>
> CC: Milton Miller <miltonm@bga.com>, linuxppc-dev@ozlabs.org
> Betreff: Re: How to dynamically disable/enable CPU features?

> > The flag is in POSSIBLE. I now use this code in the platform probe
> > function to nop out the code affected by the flag:
> > 
> > cur_cpu_spec->cpu_features &= ~CPU_FTR_NEED_COHERENT;
> > /* Patch out unwanted feature. */
> > do_feature_fixups(cur_cpu_spec->cpu_features,
> > 		  PTRRELOC(&__start___ftr_fixup),
> > 		  PTRRELOC(&__stop___ftr_fixup));
> > 
> > It seems to work so far, but I would like to know if this is the right
> > way to do it, or if calling do_feature_fixups() more than once can have
> > any side effects.
> 
> It's a bit hairy... Things -could- have been nop'ed out by the first
> call as a result of CPU_FTR_NEED_COHERENT being set and the second
> call will not be able to put them back in... now that may not be the
> case (depends what kind of patching is done with that flag) and so
> 'happen' to work for this specific bit but it isn't a nice solution...
I checked this now. Looks like it only needs to nop out some code (mainly
in the hash table code).

> A better long term approach is to look at moving the fixup to after
> the machine probe() after carefully checking whether that can cause
> any problem...
Well, that's a job for an more experienced kernel developer. :)

Thanks!

Gerhard
-- 
Psssst! Schon vom neuen GMX MultiMessenger gehört?
Der kann`s mit allen: http://www.gmx.net/de/go/multimessenger
