Message-ID: <20040629025314.53379.qmail@web60401.mail.yahoo.com>
Date: Mon, 28 Jun 2004 19:53:14 -0700 (PDT)
From: Dieu Morales <dieumorales@yahoo.com>
Subject: Re: Asiliantfb (Frame Buffer) Driver
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <1087887950.1547.98.camel@newt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Adrian,

Thank you for your suggestion.  The dummy_console with
the fb_con.c driver built in was the combination that
worked.  Seems like I tried every combination except
that one.  Also, the driver works whether or not the
firmware initializes the CT69000, which is good.
Thanks again.

-Michael Morales

--- Adrian Cox <adrian@humboldt.co.uk> wrote:
> On Mon, 2004-06-21 at 22:21, Dieu Morales wrote:
> > My firmware does initialize the CT69000 as an
> > environment option that allows what looks like VGA
> > mode consisting of a simple black screen with
> > white text.  As per some suggestions I have
> removed
> > vga_con and added fb_con but received
> different(worse)
> > results.  Without conswitchp = &fb_con I get an
> > exception shortly after the asiliant driver has
> been
> > initialized. And with conswitchp = &fb_con the
> system
> > hangs immediately after ppc.md.setup_arch in
> setup.c.
>
> What I do is to have this in my platform setup code:
>
> #ifdef CONFIG_DUMMY_CONSOLE
> 	conswitchp = &dummy_con;
> #endif
>
> Then I select the console from the command line.
>
> I can't vouch for the modified version in the kernel
> tree. My original
> driver for the 69030 had a bug that made it fail if
> the VGA firmware had
> already initialised the card. That wasn't a problem
> on the target
> platform, but it is why I never submitted the driver
> to the kernel.
>
>
> - Adrian Cox
> Humboldt Solutions Ltd
>
>
>




Yahoo! Mail - 50x more storage than other providers!
http://promotions.yahoo.com/new_mail

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
