Date: Mon, 5 May 2003 11:41:41 +1000
From: Erik Christiansen <erik@dd.nec.com.au>
To: Jerry Walden <jwalden@digitalatlantic.com>
Cc: Linux PPC embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Stack Frame Calc Problem in head_4xx.S
Message-ID: <20030505014141.GB712@dd.nec.com.au>
References: <EGEGIJHKDKJGAJMGIDPNGEOPCLAA.jwalden@digitalatlantic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <EGEGIJHKDKJGAJMGIDPNGEOPCLAA.jwalden@digitalatlantic.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sat, May 03, 2003 at 05:20:51PM -0400, Jerry Walden wrote:
>
> After line 15 executes r1 = 0xc00f4ff0
> which seems fine so far (according to the map file it is pointing to the
> proper location)
>
> After line 16 executes r1=0xc00f6ff0
> which is still within the bounds of init_task_union
>
> After line 17 execute r1 = 0xc00f6fe0 which seems like a problem to me,

   The code seems to be doing exactly what you ask it to.

   stwu updates r1 by the offset, after completing the store. (That's
   what the "u" is for.)

   Given:

> STACK_FRAME_OVERHEAD = 16

   How can you expect any other result?:

> 17	stwu	r0,-STACK_FRAME_OVERHEAD(r1)

   If this is as intended, then your problem lies earlier, it appears.
   (But it sounds a little like you're unaware that you're modifying the
   stack pointer, not just indexing from it.)

Regards,
Erik

--
 _,-_|\    Erik Christiansen
/      \   Registered (Debian) Linux User #216862
\_,-.__/
      v

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
