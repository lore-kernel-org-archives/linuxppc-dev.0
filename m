Date: Fri, 28 Sep 2001 11:34:14 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "David A. Gatwood" <dgatwood@apple.com>
Cc: Olaf Hering <olh@suse.de>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Problem serial.c on module
Message-ID: <20010928113414.C30416@cpe-24-221-152-185.az.sprintbbd.net>
References: <20010928110558.A30416@cpe-24-221-152-185.az.sprintbbd.net> <507762B4-B43E-11D5-9A74-003065B90BBC@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <507762B4-B43E-11D5-9A74-003065B90BBC@apple.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Sep 28, 2001 at 11:26:20AM -0700, David A. Gatwood wrote:
> On Friday, September 28, 2001, at 11:05 AM, Tom Rini wrote:
>
> >On Fri, Sep 28, 2001 at 10:41:23AM -0700, David A. Gatwood wrote:
> >>On Friday, September 28, 2001, at 08:15 AM, Tom Rini wrote:
> >>
> >>>On Fri, Sep 28, 2001 at 02:33:01PM +0900, KOBAYASHI R. Taizo wrote:
> >>>
> >>>>I examined this problem and had a question.
> >>>>Dose it need following branch?
> >>>>================L5375==
> >>>>#ifdef CONFIG_ALL_PPC
> >>>>       /* early PowerMacs would machine check */
> >>>>       if (_machine == _MACH_Pmac) {
> >>>>               printk(KERN_INFO "serial.c: nothing to do on
> >>>>PowerMacs.\n");
> >>>>               return 0;
> >>>>       }
> >>>>#endif
> >>>>=======================
> >>>
> >>>Some older machines apparently do.  The current 'workaround' in 2_4 is
> >>>#if defined(CONFIG_ALL_PPC) && !defined(MODULE).
> >>
> >>That's disgusting.  This should be doing the Linux equivalent of setjmp
> >>and trapping the machine check and returning 0.  Hardware probes
> >>shouldn't need hacks like this.  Just my $0.02.
> >
> >Thats what should be happening.  But apparently it still doesn't on a
> >few
> >older machines.   Or it didn't the last time I got an answer out of
> >Olaf@SuSE.
>
> Sounds like a lowmem_vectors problem or similar.  What machine and
> processor?

I think it was a 7x00 with a 601.  But I'm not sure.  Olaf?  Is this a problem
still even?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
