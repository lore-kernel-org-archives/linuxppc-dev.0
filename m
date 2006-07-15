Return-Path: <ntl@pobox.com>
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by ozlabs.org (Postfix) with ESMTP id A7B0367B7D
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Jul 2006 18:03:27 +1000 (EST)
Date: Sat, 15 Jul 2006 03:03:02 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Mike Kravetz <kravetz@us.ibm.com>
Subject: Re: [PATCH 2/3] powerpc: Instrument Hypervisor Calls: add wrappers
Message-ID: <20060715080302.GL19076@localdomain>
References: <20060714233739.GA11487@monkey.ibm.com>
	<20060714234034.GC11487@monkey.ibm.com>
	<20060715001545.GK19076@localdomain>
	<20060715004156.GJ6824@monkey.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060715004156.GJ6824@monkey.ibm.com>
Cc: Bryan Rosenburg <rosnbrg@us.ibm.com>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, Arnd Bergmann <arnd@arndb.de>,
	Christopher Yeoh <cyeoh@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mike Kravetz wrote:
> On Fri, Jul 14, 2006 at 07:15:45PM -0500, Nathan Lynch wrote:
> > Hmm, isn't it possible that the stats could be corrupted if we process
> > an interrupt/softirq which does an hcall while the stats are being
> > updated?  Maybe it's not a show-stopper, but it seems to me that
> > accuracy could suffer under some workloads.
> 
> Yes, they can become inaccurate.  Is this what you mean by 'corrupted' or
> you thinking of something worse?

Yes, "corrupted" was perhaps too strong, but we could lose the
accounting for hcalls from interrupts that we take at exactly the
wrong time.  I guess it's a pretty tiny risk.

I just wanted to make sure this had been considered, but if you're
comfortable with the overhead/accuracy tradeoff, then okay.
