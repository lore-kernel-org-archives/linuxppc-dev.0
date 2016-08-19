Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@armlinux.org.uk>
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk
 [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sG07W260SzDqd7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 20:48:37 +1000 (AEST)
Date: Fri, 19 Aug 2016 11:48:21 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
 alexander.shishkin@linux.intel.com, treeze.taeung@gmail.com,
 naveen.n.rao@linux.vnet.ibm.com, markus@trippelsdorf.de,
 chris.ryder@arm.com, pawel.moll@arm.com, mhiramat@kernel.org,
 jolsa@kernel.org, mpe@ellerman.id.au, hemant@linux.vnet.ibm.com,
 namhyung@kernel.org
Subject: Re: [PATCH v5 2/7] perf annotate: Add cross arch annotate support
Message-ID: <20160819104821.GL1041@n2100.armlinux.org.uk>
References: <1471584546-11080-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <1471584546-11080-3-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <20160819075034.GG1041@n2100.armlinux.org.uk>
 <57B6E1F7.30005@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <57B6E1F7.30005@linux.vnet.ibm.com>
Sender: Russell King - ARM Linux <linux@armlinux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 19, 2016 at 04:09:51PM +0530, Ravi Bangoria wrote:
> Thanks Russell for reviewing.
> 
> On Friday 19 August 2016 01:20 PM, Russell King - ARM Linux wrote:
> > On Fri, Aug 19, 2016 at 10:59:01AM +0530, Ravi Bangoria wrote:
> >> -static struct ins instructions[] = {
> >> +static struct ins instructions_x86[] = {
> >>  	{ .name = "add",   .ops  = &mov_ops, },
> >>  	{ .name = "addl",  .ops  = &mov_ops, },
> >>  	{ .name = "addq",  .ops  = &mov_ops, },
> >>  	{ .name = "addw",  .ops  = &mov_ops, },
> >>  	{ .name = "and",   .ops  = &mov_ops, },
> >> -#ifdef __arm__
> >> -	{ .name = "b",     .ops  = &jump_ops, }, // might also be a call
> >> -	{ .name = "bcc",   .ops  = &jump_ops, },
> >> -	{ .name = "bcs",   .ops  = &jump_ops, },
> >> -	{ .name = "beq",   .ops  = &jump_ops, },
> >> -	{ .name = "bge",   .ops  = &jump_ops, },
> >> -	{ .name = "bgt",   .ops  = &jump_ops, },
> >> -	{ .name = "bhi",   .ops  = &jump_ops, },
> >> -	{ .name = "bl",    .ops  = &call_ops, },
> >> -	{ .name = "bls",   .ops  = &jump_ops, },
> >> -	{ .name = "blt",   .ops  = &jump_ops, },
> >> -	{ .name = "blx",   .ops  = &call_ops, },
> >> -	{ .name = "bne",   .ops  = &jump_ops, },
> >> -#endif
> > Notice that ARM includes a lot of other instructions from this table,
> > not just those above.
> >
> >>  	{ .name = "bts",   .ops  = &mov_ops, },
> >>  	{ .name = "call",  .ops  = &call_ops, },
> >>  	{ .name = "callq", .ops  = &call_ops, },
> >> @@ -456,6 +444,21 @@ static struct ins instructions[] = {
> >>  	{ .name = "retq",  .ops  = &ret_ops, },
> >>  };
> >>  
> >> +static struct ins instructions_arm[] = {
> >> +	{ .name = "b",     .ops  = &jump_ops, }, /* might also be a call */
> >> +	{ .name = "bcc",   .ops  = &jump_ops, },
> >> +	{ .name = "bcs",   .ops  = &jump_ops, },
> >> +	{ .name = "beq",   .ops  = &jump_ops, },
> >> +	{ .name = "bge",   .ops  = &jump_ops, },
> >> +	{ .name = "bgt",   .ops  = &jump_ops, },
> >> +	{ .name = "bhi",   .ops  = &jump_ops, },
> >> +	{ .name = "bl",    .ops  = &call_ops, },
> >> +	{ .name = "bls",   .ops  = &jump_ops, },
> >> +	{ .name = "blt",   .ops  = &jump_ops, },
> >> +	{ .name = "blx",   .ops  = &call_ops, },
> >> +	{ .name = "bne",   .ops  = &jump_ops, },
> >> +};
> >> +
> > ...
> >> +	if (!strcmp(norm_arch, NORM_X86)) {
> >> +		instructions = instructions_x86;
> >> +		nmemb = ARRAY_SIZE(instructions_x86);
> >> +	} else if (!strcmp(norm_arch, NORM_ARM)) {
> >> +		instructions = instructions_arm;
> >> +		nmemb = ARRAY_SIZE(instructions_arm);
> > But these changes result in _only_ the ones that were in the #if __arm__
> > being matched.  This is wrong.
> >
> > If we want to go that way, we need to add _all_ arm instructions to
> > instructions_arm, not just those within the #if.
> 
> Yes, I've mentioned same in cover letter as well.
> 
> Can I add all x86 instructions for arm as well? If not, can you please
> provide a list of arm instructions that needs to be added here.

If it were me doing a change like this, I'd be trying to preserve the
current behaviour to avoid causing regressions, which would mean
ensuring that all the instructions that were visible before the change
remain visible after the change, even those which are obviously x86
specific but were still in the table anyway.  It then becomes a cleanup
matter later to remove those which aren't relevent, rather than having
to chase around wondering why the tool broke.

I'm afraid I don't have time to look at this (I'm chasing regressions
and bugs in the kernel) so I'd suggest you try to avoid causing
regressions in this tool...

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
