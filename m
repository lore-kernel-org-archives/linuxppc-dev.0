Message-ID: <38C83281.17BE9E03@embeddededge.com>
Date: Thu, 09 Mar 2000 18:23:45 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Coenraad Jacobsz <cjj@research.canon.com.au>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Modem control on 860/855
References: <38C82EFC.52068F01@research.canon.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Coenraad Jacobsz wrote:


> Has anybody implemented modem control for the 860/855 SCC/SMC?

Well, SMCs don't have any modem control on the 8xx.  Some board
designs, like Embedded Planet, route the signals to an external
control register so you could try to manage the ports in software.....

I left remnants of code in the uart driver where this is supposed to
happen for the SCCs, but haven't been back to visit.  With the exception
of one current project, that doesn't really need them for flow control
but rather device control, all of the applications I have done use the
SCCs for some purpose other than uarts.  Custom drivers were written
in those cases.

> .....  We need
> to use the CTS/RTS for standard flow control and possibly DSR/DTR/DCD
> lines as well.  If you could point me to existing source of offer any
> suggestions it would be appreciated.

The remnants are there.  Remove lots of '#if 0', find a place to generate
the proper control registers for the SCCs to make this happen, and you
should be close.


> How does an application read the values of DCD and other inputs?

Use ioctl()'s to tty devices.



	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
