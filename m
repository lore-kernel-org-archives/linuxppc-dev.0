Message-ID: <F1BED55F35F4D3118C0F00E0295CFF4DFF9FEF@mail.mediatrix.com>
From: Jean-Denis Boyer <jdboyer@mediatrix.com>
To: "'Jim Thompson'" <jim@musenki.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Bogomips and loops_per_jiffy
Date: Mon, 6 May 2002 17:17:40 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jim,

I have found a fix for the hanging "Calibrating delay loop...".

I added the following line at the beginning of
the function "time_init" in arch/ppc/kernel/time.c

  set_tb(0, 0);

This resets the time base register and avoids the timer interrupt
to set the second decrementer value to a very large one.
It happens only when the TBL is large.

This is a quick fix. Because I think it should work
for any value of TB. It looks like that part of the code
does not correctly support the overflow.

Looking through the code, I wonder why the return value of
the function "tb_delta" is signed.


--------------------------------------------
 Jean-Denis Boyer, B.Eng., System Architect
 Mediatrix Telecom Inc.
 4229 Garlock Street
 Sherbrooke (Québec)
 J1L 2C8  CANADA
 (819)829-8749 x241
--------------------------------------------


> -----Original Message-----
> From: Jean-Denis Boyer [mailto:jdboyer@mediatrix.com]
> Sent: 22 avril, 2002 11:58
> To: 'Jim Thompson'
> Cc: linuxppc-embedded@lists.linuxppc.org
> Subject: RE: Bogomips and loops_per_jiffy
>
>
>
> Jim
>
> > I've noticed that about half the time, the kernels I build
> take what I
> > think is a long time (> 20 seconds) in calibrate_delay().
>
> I have exactly the same problem with my custom board using an 8260.
> At every 5-10 times I start the kernel, it hangs on
> 'Calibrating delay loop...' for about 1 minute, and then yields
> the same result (130.66 BogoMips).
>
> I begun to try to debug that problem, but without any success yet. :-(
> I've searched through the mailing lists, but did not find anything of
> interest.
>
> This problem is very annoying and I really want to fix it!
>
>
> --------------------------------------------
>  Jean-Denis Boyer, B.Eng., System Architect
>  Mediatrix Telecom Inc.
>  4229 Garlock Street
>  Sherbrooke (Québec)
>  J1L 2C8  CANADA
>  (819)829-8749 x241
> --------------------------------------------
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
