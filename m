To: Matt Porter <porter@cox.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Ebony crash fix & 440GP cleanup step one
References: <20020524134731.A21503@home.com> <523cwcudy1.fsf_-_@topspin.com>
	<20020529154551.C3960@home.com>
From: Roland Dreier <roland@topspin.com>
Date: 30 May 2002 16:00:47 -0700
In-Reply-To: <20020529154551.C3960@home.com>
Message-ID: <52d6vdnsv4.fsf@topspin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>>>>> "Matt" == Matt Porter <porter@cox.net> writes:

    Matt> Looks great, pushed.  There's still more work to do in the
    Matt> includes but it's a good start.  I'm moving the PCIX
    Matt> initialization to a common library, so don't overlap there
    Matt> if you wander out of moving headers around.

Cool.  I'm starting to think about the best way to organize the code
in ebony.c.  It seems like maybe ebony.c should become ppc440_setup.c
with the Ebony-specific stuff inside #ifdef CONFIG_EBONY (and if we do
that, maybe ppc4xx_setup.c should be split into ppc40x_setup.c and
really generic stuff in ppc4xx_setup.c).  Another option would be to
keep ebony.c but move most of the code into library functions in a new
ppc440_setup.c file.

My motivation is that I'm going to have a few 440GP-based boards to
deal with soon, and I'd like to minimize the amount of code that has
to be copied or duplicated to support a new board.  I'd like to do
this in a way that fits in well with the kernel so it's easy for me to
keep our kernel tree in sync with the main tree.

What are your thoughts?

Thanks,
Roland

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
