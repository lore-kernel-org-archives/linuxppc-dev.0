Date: Tue, 5 Mar 2002 04:47:50 -0500 (EST)
From: Bill Fink <billfink@mindspring.com>
To: yellowdog-general@lists.yellowdoglinux.com
Cc: linuxppc-dev@lists.linuxppc.org, <duanestites@cox.net>,
	Bill Fink <billfink@mindspring.com>
Subject: Re: Top No CPU Stats
Message-ID: <Pine.LNX.4.44.0203050430230.789-100000@gwiz.nasa.atd.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed Feb 20 2002, Duane wrote:

> My top does not display the "CPU states: 0.0% user, 0.3% system, 0.0% nice,
> 99.6% idle" information. I tried starting it up with the -C switch. This
> brings up the CPU stats line, but everything shows as 0.0% no mater what
> I am doing.
>
> This is a 7200/120 YD2.1 2.4.18-rc1 benh kernel (this also happened with
> the original kernel). Has anyone had this happen or know of a fix?

Hi Duane,

I had the same thing happen when I upgraded from a 2.4.6 to a
2.4.18-ben0 kernel.  I tracked this down to the following code
in top.c (top is part of the procps-2.0.7-4 RPM on YDL 2.1):

     nr_cpu = sysconf (_SC_NPROCESSORS_ONLN);

The problem is that sysconf is returning 0 for _SC_NPROCESSORS_ONLN.
As a simple workaround, I added the following line immediately after
the call to sysconf:

     if (nr_cpu < 1) nr_cpu = 1;

Now I once again get the "CPU states" line that includes the idle time.
This is obviously not the proper solution, but I don't have time to dig
any further into why the sysconf call isn't working.  I assume sysconf
is part of glibc.  Besides upgrading the kernel from 2.4.6 to 2.4.18-ben0,
I had also recently done a yup update which update glibc from glibc-2.2.1-0f
to glibc-2.2.4-19k, so I'm not sure which change is the culprit.

Perhaps someone else might have a clue as to why the sysconf call is
returning 0 for _SC_NPROCESSORS_ONLN, but at least the quick hack above
will get you a working top.

						-Bill


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
