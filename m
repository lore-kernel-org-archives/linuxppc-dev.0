MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Serial port text corruption
Date: Tue, 18 May 2004 06:31:50 -0600
Message-ID: <065ACD8E84315E4394C835E398C8D5EB089D46@cossmgmbx02.email.corp.tld>
From: "VanBaren, Gerald (AGRE)" <Gerald.VanBaren@smiths-aerospace.com>
To: "Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I would look at the SMC1 buffering and handling of caches (either snooping, not caching the buffers, or flushing before transmitting).

Another possiblility is sending data that is stored on the stack in a subroutine which subsequently returns before the data is actually transmitted -- when you are lucky, the data hasn't changed when the Tx occurs, when you are unlucky, a call sequence has overwritten the string on the stack.  Since this is (presumably) standard linux and that sort of a problem would have been found and fixed loooong ago in the linux core code, I would concentrate on your low level code.

Just to eliminate variables, you should hook a logic analyzer or 'scope to the board's Tx line and verify the baud rate hasn't changed when you get the garbage characters.  If the baud rate has changed, it will be a clocking problem.

gvb


> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Joakim
> Tjernlund
> Sent: Tuesday, May 18, 2004 6:03 AM
> To: Linuxppc-Embedded@Lists. Linuxppc. Org
> Subject: Serial port text corruption
>
>
>
> Details:
> Sometimes when connecting the RS323 port between a laptop on
> our custom board
> to login into a bash shell it looks like this:
>
> Press return to get a login prompt, type username(root), hit
> return. Now
> I expect to see the "Password: " prompt, but instead I see
> random crap chars. Wait until the login timeouts, about 60
> seconds, the timeout message
> is also crap chars, but the following login prompt displays OK and now
> I can login without any crap chars.
>
> This is very confusing and I would fix it but I don't know
> where to start.
> Any guesses as to where the problem is? Kernel serial layer,
> the 8xx uart.c driver,
> the user space login program or somewhere else?
>
> SMC1 is the serial HW used on a 860/862 CPU.
> Kernel: linuxppc_2_4_devel from around 2.4.21-rc6 with all
> 8xx_io/uart.c patched to
> current 2.4 version.
> Userspace progs are from MontaVista hardhat 2.0. Login uses PAM.
>
>  Jocke
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
