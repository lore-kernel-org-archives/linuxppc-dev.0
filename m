In-Reply-To: <Pine.GSO.4.21.0003212253160.22559-100000@turing.cs.hmc.edu>
Date: Wed, 22 Mar 2000 10:48:15 +0100
To: Matt Brubeck <mbrubeck@hmc.edu>, mvanderw@bart.nl,
        linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: aty128fb patch on iMac DV
Message-Id: <20000322104815.028317@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Mar 22, 2000, Matt Brubeck <mbrubeck@hmc.edu> wrote:

>> Note that it didn't work for me the first time round.  I had to specify
>> only 'video=aty128fb' without any more arguments for it to work.  For some
>> reason if I specify the res & bit depth my monitor goes black when
>> starting X.  OTOH I'm not exactly using a DV either, mine is a Blueberry
>> iMac 350, should be similar.  Using yaboot of course.
>
>Okay, I got it to (mostly) work. The culprits seemed to be
>CONFIG_FB_COMPAT_XPMAC; removing that option from my kernel config allowed
>me to properly switch to all color depths. The fb console has several
>weird effects when switching vts (displaying garbage briefly during the
>switch; cursor changing color), but Xfree 4.0 runs perfectly.
>
>Only other problem is that the geometry is off. The picture is shifted a
>couple pixels offscreen to the left in 16-bit mode, and even farther in
>32-bit. But this is definitely a big step forward.
>
>[I'm on a blueberry 350 iMac as well.]

Simply adding the XPMAC compat. option should not harm... I'll looks if I
see a bug related to it.

For the geometry problem, I beleive the modelines used by Apple for the
iMac are a bit different than the ones in the standard base we use. You
should be able to adjust your XFree modelines.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
