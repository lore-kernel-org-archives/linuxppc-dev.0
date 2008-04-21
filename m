Return-Path: <david-b@pacbell.net>
Received: from smtp117.sbc.mail.sp1.yahoo.com (smtp117.sbc.mail.sp1.yahoo.com
	[69.147.64.90]) by ozlabs.org (Postfix) with SMTP id A702EDE16F
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 08:19:06 +1000 (EST)
From: David Brownell <david-b@pacbell.net>
To: cbouatmailru@gmail.com
Subject: Re: [PATCH 4/5] [POWERPC] QE: implement support for the GPIO LIB API
Date: Mon, 21 Apr 2008 15:19:02 -0700
References: <20080418190632.GA32204@polina.dev.rtsoft.ru>
	<200804211301.13026.david-b@pacbell.net>
	<20080421213349.GA3833@zarina>
In-Reply-To: <20080421213349.GA3833@zarina>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200804211519.03199.david-b@pacbell.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 21 April 2008, Anton Vorontsov wrote:
> On Mon, Apr 21, 2008 at 01:01:12PM -0700, David Brownell wrote:

> > The way other platforms do this is to hav SOC-specific
> > init code, and have board-specific initcalls call the
> > relevant SOC-specific setup.
> 
> I don't know about other platforms other than PowerPC and some ARM,
> of course. For example, PXA boards don't call any SOC specific code.
> Instead, looking into reworked PXA code, I can see that there are
> separate arch_initcalls() for the pxa25x, pxa27x, and pxa3xx SOCs.

Exactly:  SOC-specific initcalls.


> > Among other things that facilitates kernels that handle
> > multiple SOCs (if they're closely-enough related).  That
> > may not be used by many distros (handhelds.org being at
> > least a partial exception), but it certainly helps cut
> > the number of configurations that need build-testing.
> 
> Is this about QE_GPIO being user-selectable?

No.  It's about "kernels that handle multiple SOCs".  Like
for example pxa{25,27,3x}x ... or omap{16xx,17xx,5912}.

Consider several ways to support a family of SOCs.

 - One way supports only one board at a time.  Testing
   builds after arch level changes means rebuilding kernels
   for each board ... quite possibly several dozen.

 - Another supports several boards, but only if they use
   the same SOC.  Testing builds here takes fewer kernels;
   one per SOC; better, but still routinely shortchanged.

 - Yet another way supports any number of boards, using
   a variety of mostly-compatible SOCs.  This allows test
   builds that support entire SOC families (e.g. OMAP1,
   or OMAP2/OMAP3, or PXA XScale, etc).

Test builds are a quality control thing.  If they're done
regularly, it's less likely you'll push code upstream
that can't build in some configuration.


> And well, I'm not objecting for placing qe gpio code under arch/, too.
> I'll resend this patch once again reverting its placement to arch/.

OK, good.  Then I don't really have to be involved with that.

- Dave
