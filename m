Message-ID: <00b701c38988$02a19f90$2803050a@JackyLam>
From: "Jacky Lam" <jackylam@astri.org>
To: <linuxppc-embedded@lists.linuxppc.org>
References: <F886A68DA978614991E47D82EA26B542131C76@csy-exchange1.giat.intra>
Subject: Re: Queston about Walnut
Date: Fri, 3 Oct 2003 16:26:06 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


----- Original Message -----
From: "ARIBAUD Albert" <a.aribaud@giat-industries.fr>
To: <linuxppc-embedded@lists.linuxppc.org>
Sent: Friday, October 03, 2003 3:57 PM
Subject: RE: Queston about Walnut


>
> (disclaimer : I work on 8xx, not 4xx)
>
> I would suggest inspecting the timings for memory access.
> If this is SDRAM, you must have had to program the UPM for
> it, I suppose. Might be that VxWorks has it right, and you
> have set it up differently.
>
> Also, writing to address 0 might be a Bad Ideam (tm), if you
> have set this area to hold interrupt vectors.
>
> Did you try single write (say, "mw 100000 0") ?

    Thanks for you suggestion. Not only single write, I can now write to
anywhere except the first 1MB of SDRAM. I think it is occupied by u-boot?
So, I think memory is ok now.

    Do you have any idea it hangs at __sti()?

        mfmsr   r3              /* Get current state */
        ori     r3,r3,MSR_EE    /* Turn on 'EE' bit */
        SYNC                   /* Some chip revs have problems here... */
        mtmsr   r3        <------Hangs after executing it      /* Update
machine state */
        blr

    Is there any relationship with the previous instruction "SYNC"? What
revision will have problem there?

    Thanks.


>
> Albert.
>
> P.S. I think that if you write directly to linuxppc-embedded,
> Wolfgang will cease receiving you mails twice (which he probably
> does now since you e-mail him *and* CC: to the list).

    Thanks for remind me. I will be careful next time.

Best regards,
Jacky


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
