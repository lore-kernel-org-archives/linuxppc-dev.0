Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id B431867A2F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Mar 2005 15:14:17 +1000 (EST)
Date: Mon, 28 Mar 2005 21:14:14 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Tom Rini <trini@kernel.crashing.org>,
	Matt Porter <mporter@kernel.crashing.org>, linuxppc-embedded@ozlabs.org
Message-ID: <20050329051413.GA19132@gate.ebshome.net>
References: <20050321152728.GS8345@smtp.west.cox.net>
	<20050321174049.GA11734@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050321174049.GA11734@gate.ebshome.net>
Subject: Re: [PATCH] ppc44x: Remove PVR_440G* and change usages
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Mar 21, 2005 at 09:40:49AM -0800, Eugene Surovegin wrote:

[snip]

> > -	u32 pvr = mfspr(PVR);
> > -	if (pvr == PVR_440GX_RA || pvr == PVR_440GX_RB ||
> > -	    (pvr == PVR_440GX_RC && p->cpu > 667000000))
> > +	if (strcmp(cur_cpu_spec[0]->cpu_name, "440GX Rev. A") == 0 ||
> > +			strcmp(cur_cpu_spec[0]->cpu_name, "440GX Rev. B") == 0
> > +			|| (strcmp(cur_cpu_spec[0]->cpu_name, "440GX Rev. C")
> > +				== 0 && p->cpu > 667000000))
> 
> 
> While I applaud Tom's quest to eliminate _useless_ PVR defines I think 
> this change looks strange.
> 
> It substitutes simple and clear (for those who are reading this code) 
> check to something more involved without good reason, IMHO.
> 
> Also, it adds additional "point of failure" making this code more 
> fragile. We never used those CPU ID strings anywhere in the kernel 
> code before, people are used to the fact that they don't matter much 
> (maybe only for user-mode) and it's possible that during some future 
> "cleanup" code will break. One could say that we aren't allowed to 
> change such strings because something in user-mode could break, and 
> while I agree with that, I don't think it's good argument to _add_ 
> additional point where code could break.

While talking with galak today on IRC, he mentioned one of the reason, 
why we may want to use string comparison instead of PVR.

For some chips, e.g. for 8272 family, there is NO way (even if we use 
IMMR[16-31] and REV_NUM in addition to PVR) to detect correctly CPU 
(which I think is pretty lame, but I digress :). For such cases, board 
port can "fixup" CPU name, if this information can be implied by the 
board type/revision/etc.

So, I think having a way to specify/name/detect CPU which is more 
general and even can solve some real problems, is beneficial. 
Therefore, I don't object anymore to such changes :).

--
Eugene
