Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.123]) by ozlabs.org (Postfix) with ESMTP id 3F5F8DDFF9
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 14:00:19 +1000 (EST)
Date: Tue, 19 Aug 2008 00:00:17 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Subject: Re: ftrace introduces instability into kernel 2.6.27(-rc2,-rc3)
In-Reply-To: <20080819033618.GA24085@Krystal>
Message-ID: <alpine.DEB.1.10.0808182359290.13401@gandalf.stny.rr.com>
References: <48A9901B.1080900@redhat.com> <20080818154746.GA26835@Krystal>
	<48A9AFA7.8080508@freescale.com>
	<alpine.DEB.1.10.0808181425090.796@gandalf.stny.rr.com>
	<1219110814.8062.2.camel@pasglop>
	<alpine.DEB.1.10.0808182208110.13401@gandalf.stny.rr.com>
	<1219113549.8062.13.camel@pasglop>
	<alpine.DEB.1.10.0808182240330.13401@gandalf.stny.rr.com>
	<20080819024707.GA22659@Krystal>
	<alpine.DEB.1.10.0808182329220.13401@gandalf.stny.rr.com>
	<20080819033618.GA24085@Krystal>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Steven Rostedt <srostedt@redhat.com>, Scott Wood <scottwood@freescale.com>,
	Eran Liberty <liberty@extricom.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 18 Aug 2008, Mathieu Desnoyers wrote:
> > > > 
> > > 
> > > Argh. See text_poke(). It's there exactly for this purpose on x86.
> > 
> > Ouch, I just did. text_poke is quite heavy. It would be interesting to see 
> > that performed on 20,000 locations at one time. I could play with it, but 
> > I'm a bit nervous.
> > 
> 
> It's alread used to modify the LOCK prefixes in alternative.c and did
> not seem to be too slow for that.. it should therefore be ok.

There's a lot more functions than locks ;-)

Anyway, this is only needed after system boot up. But then we do it ever 
time we start or stop tracing. I'll try it out and see if it is noticable.

-- Steve
