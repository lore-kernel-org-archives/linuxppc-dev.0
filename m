Return-Path: <shaggy@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] 476: Set CCR2[DSTI] to prevent isync from flushing
	shadow TLB
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20100927150434.GA2888@zod.rchland.ibm.com>
References: <1285351297-9999-1-git-send-email-shaggy@linux.vnet.ibm.com>
	<1285351297-9999-2-git-send-email-shaggy@linux.vnet.ibm.com>
	<20100927150434.GA2888@zod.rchland.ibm.com>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Mon, 27 Sep 2010 10:26:45 -0500
Message-ID: <1285601205.17411.23.camel@shaggy-w500>
Mime-Version: 1.0
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2010-09-27 at 11:04 -0400, Josh Boyer wrote:
> On Fri, Sep 24, 2010 at 01:01:36PM -0500, Dave Kleikamp wrote:
> >When the DSTI (Disable Shadow TLB Invalidate) bit is set in the CCR2
> >register, the isync command does not flush the shadow TLB (iTLB & dTLB).
> >
> >However, since the shadow TLB does not contain context information, we
> >want the shadow TLB flushed in situations where we are switching context.
> >In those situations, we explicitly clear the DSTI bit before performing
> >isync, and set it again afterward.  We also need to do the same when we
> >perform isync after explicitly flushing the TLB.
> >
> >Th setting of the DSTI bit is dependent on
> >CONFIG_PPC_47x_DISABLE_SHADOW_TLB_INVALIDATE.  When we are confident that
> >the feature works as expected, the option can probably be removed.
> 
> You're defaulting it to 'y' in the Kconfig.  Technically someone could
> turn it off I guess, but practice mostly shows that nobody mucks with
> the defaults.  Do you want it to default 'n' for now if you aren't
> confident in it just quite yet?

I think I made it a config option at Ben's request when I first started
this work last year, before being sidetracked by other priorities.  I
could either remove the option, or default it to 'n'.  It might be best
to just hard-code the behavior to make sure it's exercised, since
there's no 47x hardware in production yet, but we can give Ben a chance
to weigh in with his opinion.

> (Linus also has some kind of gripe with new options being default 'y',
> but I don't recall all the details and I doubt he'd care about something
> in low-level PPC code.)
> 
> josh

-- 
Dave Kleikamp
IBM Linux Technology Center
