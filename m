Message-ID: <3FC39F16.5040208@arlut.utexas.edu>
Date: Tue, 25 Nov 2003 12:27:34 -0600
From: Benjamin Davis <bmdavis@arlut.utexas.edu>
MIME-Version: 1.0
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: gt-64260 Question
References: <3FC3945E.9090506@arlut.utexas.edu> <3FC39A87.4060701@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Errata 9 of http://e-www.motorola.com/files/32bit/doc/errata/MPC7455CE.pdf
talks about some issues with QACK, I further noticed how in
arch/ppc/platform/pmac_feature.c, in probe_uninorth:
	if (uninorth_rev < 0x11) {
		actrl = UN_IN(UNI_N_ARB_CTRL) & ~UNI_N_ARB_CTRL_QACK_DELAY_MASK;
		actrl |= ((uninorth_rev < 3) ? UNI_N_ARB_CTRL_QACK_DELAY105 :
			UNI_N_ARB_CTRL_QACK_DELAY) << UNI_N_ARB_CTRL_QACK_DELAY_SHIFT;
		UN_OUT(UNI_N_ARB_CTRL, actrl);

It would appear to me that a QACK delay is being set by communication
with the uninorth.  I will say now though this is my first experiance
with the kernel.
I was kinda thinking they might have gotten around the errata by
extending the delay of the QACK.  This QACK is the system saying it is
time to get out of nap, and snoop.

thanks
--
--
Benjamin Davis


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
