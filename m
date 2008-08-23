Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id CD021DEE84
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Aug 2008 10:40:46 +1000 (EST)
Date: Fri, 22 Aug 2008 20:40:49 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: "Kevin Diggs" <kevdig@hypersurf.com>
Subject: Re: checkpatch nits ...
Message-ID: <20080822204049.49fcd22d@lappy.seanm.ca>
In-Reply-To: <48AF5818.7010802@hypersurf.com>
References: <48AF5818.7010802@hypersurf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 22 Aug 2008 17:21:44 -0700
"Kevin Diggs" <kevdig@hypersurf.com> wrote:

> Hi,
> 
> Can I ignore these checkpatch errors:
> 
> ERROR: do not initialise statics to 0 or NULL
> #829: FILE: powerpc/kernel/cpu/pll_if.c:61:
> +static unsigned int override_bus_clock = 0;
> 
> ERROR: do not initialise externals to 0 or NULL
> #1281: FILE: powerpc/kernel/cpu/pll_if.c:513:
> +int rval = 0;
> 
> Someone (Arnd?) told me this was due to an older compiler putting
> these in a strange section?

Older gcc, and in fact many (most?) compilers, put *all* initialized
variables in a data section rather than the bss. This means they took
up room in the executable. By not explicitly setting them to zero, they
where put in the bss and initialized to zero anyway.

Newer gccs will put them in the bss if they are zero. You could argue
that this is technically wrong.

I tend to remove the 0s or nulls just to cut down on the checkpatch
errors. You need to decide if it is worth it. I wouldn't submit a patch
with *just* these changes.

Cheers,
   Sean
