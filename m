Subject: RE: access memory mapped registers
From: Kenneth Johansson <ken@kieraypc01.tn.sw.ericsson.se>
To: "Muaddi, Cecilia" <cecilia.muaddi@alloptic.com>
Cc: "'Wolfgang Denk'" <wd@denx.de>,
	"linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <885489B3B89FB6449F93E525DF78777F064542@srvnt506.ALLOPTIC.COM>
References: <885489B3B89FB6449F93E525DF78777F064542@srvnt506.ALLOPTIC.COM>
Content-Type: text/plain; charset=ISO-8859-1
Date: 13 Jan 2003 16:14:27 +0100
Message-Id: <1042470867.663.34.camel@spawn>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 2003-01-10 at 01:46, Muaddi, Cecilia wrote:
>
> I can see if I mmap the internal 860 CPU registers, and screw up that, I
> will
> definitely screw up the system, and require it to be reboot.  BUt if the
> hardware we are mapping is outside the CPU internal memory and outside the
> RAM,
> shouldn't the failure be limited to the user application only then?
>
> for example, an ethernet switch chip in a layer 2 router is controlled
> by the PPC 860.  THe 860 is only used for configuration (not in the
> datapath)
> if I mmap
> only the memory regions that is mapped to the ethernet switching chip,
> even if I screw up on the hardware setup, shouldn't my kernel still be
> protected?  At most, the application faults and I should be able to restart
> the application without rebooting the system?
>

Yes you are safe. There is nothing wrong with doing things in userspace
if you can. I have designed our system like this and have a very simple
IRQ driver that signals to userspace that an interrupt is pending to get
response time down and avoid polling but that is the only part I have in
the kernel.

The only reason to put anything into the kernel is speed and protection
so the first option should be to try to do it in userspace failing that
move it or parts to the kernel.


--
Kenneth Johansson
Ericsson AB                       Tel: +46 8 404 71 83
Tellusborgsvägen  94              Fax: +46 8 404 72 72
126 25 Stockholm                  ken@switchboard.ericsson.se


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
