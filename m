Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound1-ash-R.bigfish.com (outbound-ash.frontbridge.com
	[206.16.192.249])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 71B6567B96
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Aug 2006 12:01:55 +1000 (EST)
Message-ID: <44E12B03.6020503@am.sony.com>
Date: Mon, 14 Aug 2006 19:01:39 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Mike Kravetz <kravetz@us.ibm.com>
Subject: Re: [PATCH] powerpc: Instrument Hypervisor Calls
References: <20060814234146.GA17027@w-mikek2.ibm.com>
In-Reply-To: <20060814234146.GA17027@w-mikek2.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mike Kravetz wrote:
> On Mon, Aug 14, 2006 at 04:35:12PM -0700, Geoff Levand wrote:
>> Mike Kravetz wrote:
>> > +config HCALL_STATS
>> > +	bool "Hypervisor call instrumentation"
>> > +	depends on PPC_PSERIES && DEBUG_FS
>> > +	help
>> > +	  Adds code to keep track of the number of hypervisor calls made
> and
>> > +	  the amount of time spent in hypervisor calls: both wall time
> (based
>> > +	  on time base) and cpu time (based on PURR).  A directory named
>> > +	  hcall_inst is added at the root of the debugfs filesystem.
>> 
>> Could we keep this more generic and not mention platform specific
>> things like PURR?
> 
> Not sure if I follow.  PURR will be used/displayed if available.  Time
> based statistics will always be available.
> 
> I can change the description to make this clear.  Or, are you asking
> that this not be mentioned at all?  Based on previous discussions, I
> added the ability to display both wall and cpu time if available.

I want to hook my instrumentation into this config option also, but my
platform dosn't have PURR, so I would like you to remove the mention
of '(based on PURR)' in the description of the option.  This way we
can have a generic 'Hypervisor call instrumentation' option for users,
on whatever platform they are using.

Does it make sense?

-Geoff
