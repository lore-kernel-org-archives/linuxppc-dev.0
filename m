From: Paul Mackerras <paulus@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14785.38057.405663.414104@argo.linuxcare.com.au>
Date: Fri, 15 Sep 2000 14:16:57 +1100 (EST)
To: Takashi Oe <toe@unlserve.unl.edu>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: ld bug?
In-Reply-To: <Pine.A41.3.96LJ1.1b7.1000914205905.93706A-100000@unlserve.unl.edu>
References: <Pine.LNX.4.10.10009132130250.452-100000@cassiopeia.home>
	<Pine.A41.3.96LJ1.1b7.1000914205905.93706A-100000@unlserve.unl.edu>
Reply-To: paulus@linuxcare.com.au
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Takashi Oe writes:

> Well, I've just had a kernel hang at "Freeing unused kernel memory:..."
> with linux-2.4.0-test8 + numerous patches, and I've traced the hang to
> what apears (to me) to be a ld bug.

Don't think so, see below...

> The kernel hangs at the call to spin_unlock_irq() in schedule() of
> kernel/sched.c.  For me (UP kernel), spin_unlock_irq() is defined to be

That sounds to me like an unhandled interrupt, endlessly repeated.

> So, if I'm reading this correctly, the compiler is generating correct
> assembly.  Now, objdump output of vmlinux (kernel) for the same segment
> says:
>
> c02164c4:       3d 20 c0 3a     lis     r9,-16326
> c02164c8:       80 09 c3 e4     lwz     r0,-15388(r9)
> c02164cc:       7c 08 03 a6     mtlr    r0
> c02164d0:       4e 80 00 21     blrl
>
> However, from "nm vmlinux | grep int_control", "int_control" is at
>
> c039c3e0 D int_control

No, it's right, the thing is that the -15388 in the lwz instruction is
sign-extended.  So the address it uses is 0xc03a0000 - 15388 (or put
another way, 0xc03a0000 + 0xffffc3e4) which is in 0xc039c3e0.

Paul.

--
Paul Mackerras, Senior Open Source Researcher, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
