Message-ID: <3BA8E7D1.E986CD4B@acm.org>
Date: Wed, 19 Sep 2001 11:45:37 -0700
From: Ira Weiny <iweiny@acm.org>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>, andre@linux-ide.org
Subject: Re: IDE 1Gig Microdrive (Working!!)
References: <3BA82D10.5694BC63@acm.org> <20010919133806.12982@smtp.adsl.oleane.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:
>
>
> Andre, what do you think would be a good solution ?
>
> Temporarily masking out the interrupt with disable_irq(), even if it's
> shared, would be acceptable ? (Provided that it's only masked for a short
> period of time obviously). Can the problem be worked around by
> doing the request_irq earlier, and making sure the IDE handler always
> clear the interrupt condition even when no handler is attached when it's
> doing the probe ?

Well I am slowly getting my head around the IDE layer so I know what I
did is a hack.  Moving the request_irq() around seemed like a daunting
task which I probably could not do without messing something up, sorry.

However, my solution relys on the fact that the probe, as far as I could
tell, does not need the irq, as it polls.  So I just disabled it until
something happens, timeout or success.  I would think this would solve
the problem for all drives but I don't have a lot of test cases.  I have
tried all my CF cards and my Microdrive.  One thing I have not tried is
to simply disable the irq all the time in the probe to see what happens
on boot with my normal internal drive.  If this were to work for all
probes then I could get rid of the flag.

However, I do realize the error of my ways.  If there is something else
on this line which is important...  Anyway, I would think this is
something others would want to have working.  So if I can help with
testing or a solution, I would be happy to.

Thanks,
Ira Weiny
iweiny@acm.org

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
