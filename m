Date: Tue, 26 Oct 1999 18:03:54 -0400
From: Tom Vier <thomassr@erols.com>
To: Rob Barris <rbarris@quicksilver.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: question about altivec registers
Message-ID: <19991026180354.A6577@zero>
References: <199910252231.PAA08775@sade.ddi.com> <Pine.LNX.4.10.9910251916060.5902-100000@modemcable220.93-200-24.mtl.mc.vi deotron.net> <v03010d0cb43a9d52cd3e@[192.168.1.16]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <v03010d0cb43a9d52cd3e@[192.168.1.16]>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Oct 25, 1999 at 04:53:52PM -0700, Rob Barris wrote:

>    I worked this out once, the extra 512 bytes of register context,
> multiplied by (say) a thousand context switches per second only add up to
> about a MB of memory traffic per second - a fraction of a percent of the
> available memory bandwidth in a G4 machine.  Most of that will sit in cac=
he
> anyway depending on the working set size of the processes involved.

couldn't you just do lazy context saves? ie, disable the vector ops by 
default; when a proc tries to use a vector op catch the exception, mark the
proc as vector using and enable vectors. when a context switch occurs,
mark the proc as vector enable, disable vectors, continue (and re-enable
when you switch the proc's context back in). it's a little more complicated
when more than one proc wants vectors. in that case, before you re-enable
vectors, check to see if the vector regs need their context switched.

or maybe that complexity isn't worth bandwidth/latency it saves.
does linux/ppc do lazy FPU context saves this way?

if you don't do lazy vector saves, i would think it would raise context
switch times a sizable amount. there's four times as much data in those
128bit regs as there are in the 32bit GPRs.

-- 
Tom Vier - 0x27371A1C
thomassr@erols.com
http://users.erols.com/thomassr/zero/

DSA Key fingerprint:
42D4 82D6 6DF5 77EC 1251  30D2 D9E7 E858 2737 1A2C

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
