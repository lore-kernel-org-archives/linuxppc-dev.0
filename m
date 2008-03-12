Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id C2587DDE05
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Mar 2008 08:20:06 +1100 (EST)
Date: Thu, 13 Mar 2008 08:20:05 +1100
To: Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>
Subject: Re: [PATCH 1/4] Ensure that pmu_sys_suspended exists in appropriate
	configs.
Message-ID: <20080312212005.GU6887@bakeyournoodle.com>
References: <66e63844f95778cdc331d245889ff0ebfe17bbb4.1205279151.git.tony@bakeyournoodle.com>
	<20080312083857.GB19504@bogon.ms20.nix>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20080312083857.GB19504@bogon.ms20.nix>
From: tony@bakeyournoodle.com (Tony Breeds)
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 12, 2008 at 09:38:57AM +0100, Guido Günther wrote:
> Hi Tony,
> On Wed, Mar 12, 2008 at 10:48:48AM +1100, Tony Breeds wrote:
> > pmu_sys_suspended is declared extern when:
> > 	defined(CONFIG_PM_SLEEP) && defined(CONFIG_PPC32)
> > but only defined when:
> > 	defined(CONFIG_SUSPEND) && defined(CONFIG_PPC32)
> > which is wrong.  Lets fix that.
> As I wrote, this isn't defined in my config:
> 
> # CONFIG_SUSPEND is not set
> CONFIG_HIBERNATION=y

Hmm okay I thought I tested 
for you.

I don't know if I missed it in one of your original posts, can you
supply your .config and compiler error.  I can't see anywhere outside
of:
$ git grep -E -l pmu_sys_suspended --
drivers/macintosh/via-pmu-led.c
drivers/macintosh/via-pmu.c
include/linux/pmu.h

where pmu_sys_suspended is referenced and I'm having difficulty
understanding how CONFIG_HIBERNATION is affecting that.


Yours Tony

  linux.conf.au    http://www.marchsouth.org/
  Jan 19 - 24 2009 The Australian Linux Technical Conference!
