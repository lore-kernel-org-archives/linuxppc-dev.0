Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao12.cox.net (fed1rmmtao12.cox.net [68.230.241.27])
	by ozlabs.org (Postfix) with ESMTP id 8472167A72
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Jan 2005 05:13:32 +1100 (EST)
Date: Tue, 18 Jan 2005 11:13:30 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>
Message-ID: <20050118181330.GJ28724@smtp.west.cox.net>
References: <41EC29A8.1040703@mvista.com>
	<20050118161515.GI28724@smtp.west.cox.net>
	<93780AB0-696D-11D9-81BE-003065F9B7DC@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <93780AB0-696D-11D9-81BE-003065F9B7DC@embeddededge.com>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [RFC] Option to disable mapping genrtc calls to ppc_md calls
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 18, 2005 at 11:25:33AM -0500, Dan Malek wrote:
> 
> On Jan 18, 2005, at 11:15 AM, Tom Rini wrote:
> 
> >On Mon, Jan 17, 2005 at 02:10:00PM -0700, Mark A. Greer wrote:
> 
> >>There are 2 reasons to not use the ppc_md.get_rtc_time() et. al. 
> >>interfaces:
> >>1) They are called before the i2c driver is initialized and even 
> >>loaded
> >>if its a module.
> 
> There are three reasons.  You don't want to use an I2c rtc clock at
> all in these functions because they get can get called from the
> clock interrupt to update the time in the rtc.  If it does happen to 
> work,
> it creates long latencies in the timer interrupt.  If the i2c requires 
> an
> interrupt, they system will crash or hang.

I think one of us wasn't clear.  I'm not arguing for nuking
ppc_md.{get,set}_rtc_time(), I'm arguing for nuking
get_rtc_time()/set_rtc_time() inlines from <asm-ppc/rtc.h> (which are
used by drivers/char/genrtc.c) in favor of todc_time et al providing the
functions for genrtc.  So all of the other places we use
ppc_md.{get,set}_rtc_time() are unchanged.

-- 
Tom Rini
http://gate.crashing.org/~trini/
