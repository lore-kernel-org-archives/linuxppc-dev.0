Message-ID: <3FC3BA6C.3030201@mvista.com>
Date: Tue, 25 Nov 2003 13:24:12 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Benjamin Davis <bmdavis@arlut.utexas.edu>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: gt-64260 Question
References: <3FC3945E.9090506@arlut.utexas.edu> <3FC39A87.4060701@mvista.com> <3FC39F16.5040208@arlut.utexas.edu>
In-Reply-To: <3FC39F16.5040208@arlut.utexas.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Benjamin Davis wrote:

> Errata 9 of
> http://e-www.motorola.com/files/32bit/doc/errata/MPC7455CE.pdf
> talks about some issues with QACK,

Okay.

> I further noticed how in arch/ppc/platform/pmac_feature.c, in
> probe_uninorth:
>     if (uninorth_rev < 0x11) {
>         actrl = UN_IN(UNI_N_ARB_CTRL) & ~UNI_N_ARB_CTRL_QACK_DELAY_MASK;
>         actrl |= ((uninorth_rev < 3) ? UNI_N_ARB_CTRL_QACK_DELAY105 :
>             UNI_N_ARB_CTRL_QACK_DELAY) <<
> UNI_N_ARB_CTRL_QACK_DELAY_SHIFT;
>         UN_OUT(UNI_N_ARB_CTRL, actrl);
>
> It would appear to me that a QACK delay is being set by communication
> with the uninorth.  I will say now though this is my first experiance
> with the kernel.
> I was kinda thinking they might have gotten around the errata by
> extending the delay of the QACK.  This QACK is the system saying it is
> time to get out of nap, and snoop.

I don't see any reference in the 64260 manual that lets you control
this.  Are you sure that you need to nap/snooze?  IOW, are you sure
you're not solving a problem you don't have?

Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
