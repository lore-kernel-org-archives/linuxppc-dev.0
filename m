Mime-Version: 1.0
Message-Id: <p04320400b61508915079@[172.21.170.210]>
In-Reply-To: <Pine.LNX.4.21.0010191246070.6734-100000@like.mine.nu>
References: <Pine.LNX.4.21.0010191246070.6734-100000@like.mine.nu>
Date: Thu, 19 Oct 2000 16:51:44 -0400
To: phandel@cise.ufl.edu
From: Scott Hankin <shankin@rational.com>
Subject: Re: 2.4.0-test10 boot failure on Powerbook G3
Cc: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 1:06 PM -0700 10/19/00, phandel@cise.ufl.edu wrote:
>On Thu, 19 Oct 2000, Scott Hankin wrote:
>
>>  vector: 300 at pc = c016d060, lr = c016c8f4, msr = 9032, sp = c07b1cc0
>>  [c07b1c10]
>>  dar = 7ac, dsisr = 40000000
>>  current = c07b0000, pid = 1, comm = swapper
>>  mon>
>
>As Ben has suggested, take a look in the System.map file that was created
>to see where the problem is.  I've seen the same thing on my PowerCenter,
>and it turned out to be in do_fork(), but I haven't had the time to check
>out why that is dying.

It turned out that the pc was in do_install_cmap, and lr was in
atyfb_set_var.  The latter calls the former near the end of the
routine (check out drivers/video/atyfb.c:2940) but as to why it's
bombing, I have no clue.

Ben suggested:
>Looks like the driver is beeing passed garbage for the console number or
>the currcon. You can try adding some debug xmon_printf to atyfb.c to
>locate what's going on. I suspect a latent bug that is always present but
>will appear or not depending on the random content of memory.

I'm in the process of adding xmon_printf statements to see what is
coming in.  I'll try and take it from there.  Is there a way of
forcing a mon> dump?

- Scott

-----------------------------
Scott Hankin (shankin@rational.com)  In the beginning, there was nothing, then
Rational Software                    God said, "Let there be light."  And there
20 Maguire Road                      was light.  There was still nothing, but
Lexington, MA 02421                  you could see it a lot better.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
