Message-ID: <39CADD20.6D453DCF@mvista.com>
Date: Fri, 22 Sep 2000 00:16:32 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: paulus@linuxcare.com.au
CC: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: __ioremap_at() in 2.4.0-test9-pre2
References: <Pine.LNX.4.10.10009172058340.715-100000@cassiopeia.home>
		<14790.58502.25252.825448@argo.linuxcare.com.au>
		<20000919150621.A9826@cx258813-a.chnd1.az.home.com>
		<14791.61311.118516.747495@argo.linuxcare.com.au>
		<39C8DE1A.BC8EF0B6@mvista.com>
		<14793.18115.38314.912204@argo.linuxcare.com.au>
		<39C96EBC.6BE23535@mvista.com>
		<14793.29680.948198.119368@argo.linuxcare.com.au>
		<39C98739.B3656E8F@mvista.com>
		<14793.38735.809789.111193@argo.linuxcare.com.au>
		<39C9AFE2.25CB0ADA@mvista.com> <14794.54989.87038.231729@argo.linuxcare.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:

> I think the only thing that makes sense is to say that `n' is the
> value that the device sees on the PCI AD lines during the address
> cycle.  It's the value that gets compared with the value in the
> device's BARs.

Fine....

> So if I'm wrong, I'm in good company. :-)

You are not wrong today.  You can make something work within the
constraints chosen.  This discussion has taken place many times over
the past many years of compting history.  Fortunately, I will be
sitting on a beach and not worrying about it before 15 year old (or
more) technology gets re-invented here again :-).

> .....it is actually people like Dave Miller and Linus that you
> need to be convincing, and that this discussion should move to
> linux-kernel.

Not worth it....I have already spent too much time discussing it
here.

> Given how long I/O accesses take (hundreds of ns, at the minimum) the
> cost of adding a constant is truly negligible.

...until you realize the trick memory map is costing lots of time
in the TLB miss handler...If you can coerce the bridges to map nicely
into a single big TLB entry or BAT so all you have is a simple
arithmetic operation and bus cycle, this will work great.  With
busses increasing in speed, its way below hundreds of ns, and that
memory cycle to read the io base is going to be a large part of the
cycle time.

I'm done now...it was fun :-).


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
