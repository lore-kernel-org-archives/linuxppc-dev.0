From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15612.18916.648386.173632@argo.ozlabs.ibm.com>
Date: Tue, 4 Jun 2002 15:02:28 +1000 (EST)
To: Dan Malek <dan@embeddededge.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: pt_regs.dbcr0/1
In-Reply-To: <3CFC16A4.7090902@embeddededge.com>
References: <15608.22230.504008.818858@argo.ozlabs.ibm.com>
	<3CFC16A4.7090902@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek writes:

> I believe they were moved because those registers are copied between
> the application context and the debugger.  I was part of making this
> work, but not for moving the registers :-)  IIRC, the reason was we
> wanted gdb to be '4xx-aware' so it could use more of the debug capabilities.

So has anyone done a 4xx-aware gdb yet?

> > If not, they are going.  If so, we can discuss it.
>
> You just can't toss them, they have to be context switched, but I think
> the thread struct is the proper place.  There are always problems with

I wasn't suggesting to get rid of them completely, I was saying that
they should not be in pt_regs.  I think we are in violent agreement. :)

> trying to run any combination of background debuggers, kgdb, or application
> gdb at the same time, which raises the discussion as to where these
> registers should be context switched.  I think we just resign ourselves
> to only one debug interface active at a time and simplify the kernel.

I think so too.  I think it will be basically impossible to do gdb +
external debugging or xmon/kgdb + external debugging.  gdb + xmon/kgdb
may be possible but we will have to see how complex it looks once we
know what the kernel support for gdb looks like.

Paul.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
