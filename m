Date: Thu, 19 Apr 2001 13:06:46 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Steven Hein <ssh@sgi.com>
Cc: Dan Malek <dan@mvista.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: 860 RTC support
Message-ID: <20010419130646.P13403@opus.bloom.county>
References: <3ADE0222.BF7F539C@sgi.com> <3ADE0501.321052F9@mvista.com> <3ADF1377.72242D3B@sgi.com> <3ADF3970.C015DB5D@mvista.com> <20010419124455.O13403@opus.bloom.county> <3ADF426A.5E9C0EBD@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3ADF426A.5E9C0EBD@sgi.com>; from ssh@sgi.com on Thu, Apr 19, 2001 at 02:54:18PM -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Apr 19, 2001 at 02:54:18PM -0500, Steven Hein wrote:
> Tom Rini wrote:
> >
> > I think I understand the question/problem too.  We'll see what else I've
> > got to work on as well. :)  Just checking, Steven have you tried to
> > enable the "PPC_RTC" driver and gotten this same incorrect behavior?
>
> Tom,
>
> The only place I see references to PPC_RTC is in some of the PPC
> "defconfig" files. I don't see any other places where that is
> references in the 2.4.3 kernel.....

Yes, I just noticed this myself when I went to try it on my rpx.
What you'll need to do is:
edit ./Makefile, and compile in drivers/macintosh/macintosh.o on
CONFIG_PPC, not CONFIG_ALL_PPC.
edit drivers/Makefile, and go into drivers/macintosh on CONFIG_PPC, not
CONFIG_ALL_PPC.
Finally, edit arch/ppc/config.in, and remove the test for !8xx around the
PPC_RTC question.  Then it'll either work or die at boot.  I'm not sure
yet :)  I should be able to test shortly tho.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
