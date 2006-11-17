Return-Path: <linas@austin.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4CFE267BC4
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Nov 2006 05:12:20 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kAHIC8fm017487
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 13:12:08 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kAHIBcB5133628
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 13:11:39 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kAHIBbTf013467
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 13:11:38 -0500
Date: Fri, 17 Nov 2006 12:11:33 -0600
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] Reorganise and then fixup the pseries cpu hotplug code
Message-ID: <20061117181133.GH23600@austin.ibm.com>
References: <20061116154051.GB2008@localdomain>
	<20061117033638.0E24B67BCE@ozlabs.org>
	<20061117153105.edca0777.sfr@canb.auug.org.au>
	<1163738640.16815.45.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1163738640.16815.45.camel@localhost.localdomain>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, ego@in.ibm.com,
	linuxppc-dev@ozlabs.org, ntl@pobox.com,
	Anton Blanchard <anton@samba.org>, srinivasa@in.ibm.com, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Nov 17, 2006 at 03:44:00PM +1100, Michael Ellerman wrote:
> On Fri, 2006-11-17 at 15:31 +1100, Stephen Rothwell wrote:
> > One small nit ...
> > 
> > On Fri, 17 Nov 2006 14:36:35 +1100 Michael Ellerman <michael@ellerman.id.au> wrote:
> > >
> > > +static int __init pseries_cpu_hotplug_init(void)
> > > +{
> > > +	rtas_stop_self_args.token = rtas_token("stop-self");
> > > +	qcss_tok = rtas_token("query-cpu-stopped-state");
> > > +
> > > +	if (rtas_stop_self_args.token == RTAS_UNKNOWN_SERVICE ||
> > > +			qcss_tok == RTAS_UNKNOWN_SERVICE)
> > > +		return 1;
> > 
> > initcall fucntions should return 0 or -<error>;  -ENODEV is ignored,
> > other nonzero values cause a log message if initcall debugging is enabled.
> 
> OK. I wanted to return an error, so there's something in the log to show
> that cpu hotplug was disabled - but I didn't check what to return. I'll
> fix it up on Monday to return -ENOENT.

I presume the default config from RedHat/SuSE is to have
CONFIG_HOTPLUG_CPU turned on. In this case, all sorts of 
pseries boxes will spew a warning. I suppose this is a 
form of subliminal advertising: "Hey Schmo, upgrade your 
box to something that supports CPU hotplug!". 

--linas
