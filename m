Date: Mon, 24 Mar 2003 13:15:43 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Cc: "Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>,
	strauman@SLAC.Stanford.EDU
Subject: Re: dcbz works on 862 everywhere!
Message-ID: <20030324201543.GB14264@ip68-0-152-218.tc.ph.cox.net>
References: <IGEFJKJNHJDCBKALBJLLEEGBFLAA.joakim.tjernlund@lumentis.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <IGEFJKJNHJDCBKALBJLLEEGBFLAA.joakim.tjernlund@lumentis.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Mar 24, 2003 at 11:19:29AM +0100, Joakim Tjernlund wrote:

>
> Hi list
>
> I have been researching why I can't use dcbz and friends on 8xx CPU.
> Till Strauman found out long ago that the dcxx instuctions did not update
> the DAR register and that was the key I needed.
>
> After a lot of testing/reading I found a 2 instruction workaround
> that lets me use dcbz in copy_tofrom_user().
> I can also used dcbz in a user space app without problems. I even
> removed the TLB change bit hack by Tom Rini and everything works.
>
> By copying the MD_EPN register to the DAR register in the DTLB Miss handler
> just before MD_RPN is written everything just works. The only explanation that
> makes sense to me is that the MD_RPN has a undocumented dependency to the DAR
> register, the 20 msb of MD_EPN and DAR needs to be the same before MD_RPN is written.
>
> Does this make any sense to anyone?
> I can prepare a patch if somebody is interested to try it on their 8xx CPU.

Can you post a patch which does everything (remove the TLB change bit,
etc)?  Thanks.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
