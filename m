Date: Wed, 5 Jun 2002 01:18:32 -0400
From: Bill Fink <billfink@mindspring.com>
To: LinuxPPC Developers <linuxppc-dev@lists.linuxppc.org>
Cc: Bill Fink <billfink@mindspring.com>
Subject: Re: Debugging Network Performance
Message-Id: <20020605011832.63bf4ff5.billfink@mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 4 Jun 2002, Allen Curtis wrote:

> > If you think it is a kernel problem some benchmarks may help you narrow
> > down the problem. Networks are pretty fluid and sometimes hard to get
> > reproducible results. When I try to determine driver/kernel network
> > perfomance I try to use an isolated network where I have control over all
> > traffic or I use test hardware such as IXIA or Smartbits.
>
> All testing is done on an isolated network. I do not believe that the
> problem is in the driver itself. The driver has not changed significantly. I
> do need to check the error path since it appears that errors actually help
> performance.
>
> What is the best way to track packet processing through the kernel?

When I was helping to investigate a performance problem with the SUNGEM
driver versus the GMAC driver, Anton Blanchard made the following suggestion:

    "It would be interesting to see where the cpu is being used. Could you
    boot with profile=2 and use readprofile to find the worst cpu hogs
    during a run?"

I actually never tried doing this as the problem was resolved through
other methods, but it sounded like something possibly useful to try.

The problem with the poor SUNGEM performance turned out to be lots of
extraneous unnecessary interrupts, so you might want to check out the
eth0 interrupts in /proc/interrupts, comparing the two cases.

						-Bill

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
