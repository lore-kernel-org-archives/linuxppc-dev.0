Date: Thu, 9 Dec 1999 10:14:06 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: David Monro <davidm@amberdata.demon.co.uk>
cc: linuxppc-workstation@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: IRQ problems on IBM 850
In-Reply-To: <384E9672.7632BAB9@amberdata.demon.co.uk>
Message-ID: <Pine.HPX.4.10.9912090952120.2753-101000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="2000143827-1895335937-944730846=:2753"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--2000143827-1895335937-944730846=:2753
Content-Type: TEXT/PLAIN; charset=US-ASCII



On Wed, 8 Dec 1999, David Monro wrote:

> 
> Sorry to reply so late, but I went on holiday.
> 
> Gabriel Paubert wrote:
> > 
> > On Thu, 4 Nov 1999, Hollis R Blanchard wrote:
> > 
> [..]
> > 
> > Using interrupt 13 is strange, to say the least. It was reserved for FPU
> > errors on x86 processors. In your case obviously the interrupts are
> > expected (since you have a timeout) but have stayed masked for some
> > reason. We have to find where this happens. Some code paths might have an
> > unbalanced enable/disable_irq but I suspect that it will be hard to find.
> > 
> 
> Umm. Possible data point which may help here - I cannot cause my machine
> to do anything silly unless I hit two interrupt sources at the same
> time. I can compile kernels on the IDE disk (irq 13) till the cows come
> home if I don't have the ethernet enabled and don't play with the mouse
> too much. If I enable the ethernet (irq 15 I think), or play with the
> mouse a lot (irq 12), sooner or later I die. My (very uneducated) guess
> is that it has something to do with getting two interrupts in a very
> short space of time. I guess I should try thrashing one of the lower 8
> interrupts (serial mouse I guess would do it) and see if that can cause
> problems, or whether it is restricted to the second controller.

Ok, you are definitely on something. The problem is that on my machines I
only ever use one of the high (8-15) interrupts: the mouse. All the other
are routed through the OpenPIC...

Now we have to find where and how these interrutps become masked, this is
likely a stupid blunder.

Could you replace your arch/ppc/kernel/{irq,i8259}.c by the ones included
in the attached tarball ?

It adds a line in /proc/interrupts to check the state of the 8259
registers: 
[root@vcorr1 linux]# cat /proc/interrupts 
           CPU0       
  1:       4201   i8259         keyboard
  2:          0   i8259         82c59 secondary cascade
  4:        198   i8259         serial
 12:         48   i8259         PS/2 Mouse
 16:          0   OpenPIC       82c59 cascade
 18:    4705191   OpenPIC       DC21140 (eth0)
 19:     160631   OpenPIC       ncr53c8xx
BAD:          1
8259 IMR/ISR/IRR = efe9/0000/0040
                   ^^^^
that one is interesting to see if some interrupts become masked
forever. 

	Gabriel.

--2000143827-1895335937-944730846=:2753
Content-Type: APPLICATION/octet-stream; name="testirq.tar.gz"
Content-ID: <Pine.HPX.4.10.9912091014060.2753@gra-ux1.iram.es>
Content-Description: Tarball to get more /proc info about i8259 state.
Content-Disposition: attachment; filename="testirq.tar.gz"
Content-Transfer-Encoding: BASE64

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
--2000143827-1895335937-944730846=:2753--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
