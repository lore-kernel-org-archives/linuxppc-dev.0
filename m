Date: Tue, 14 Mar 2000 10:56:46 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: "Mark S. Mathews" <mark@absoval.com>
cc: linuxppc-embedded@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: Byte swapped inw/outw again....
In-Reply-To: <Pine.LNX.3.96.1000313131056.12701A-100000@tristar.cc.absoval.com>
Message-ID: <Pine.HPX.4.10.10003141052080.14941-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 13 Mar 2000, Mark S. Mathews wrote:

>
> Hi Folks,
>
> Another driver port with inw/outw issues again.  I've looked through the
> linuxppc-dev archive and I'm not quite seeing the answer to my question
> (below).
>
> I'm porting a driver for a WLAN card whose interface is all 16-bit
> registers.  Sometimes the reads/writes are strictly a 16-bit integer
> quantity where the byte swapping in inw/outw wouldn't be too much of a
> problem.  Other times we're reading/writing buffer contents from/to the
> card 2-bytes at a time (swapping in this case is exceptionally bad).


Use in/out for 16 nit register accesses and insw/outsw for the buffer
acceses. This is provided you have a very recent kernel in which ins/outs
do not byte swap (until now they were wrongly swapping the bytes). As
you see, the issue is being addressed...

With older kernels you might want to access the buffer with
insw_ns/outsw_ns (no swapping needed), but this is PPC specific.

Hope this helps...

	Gabriel.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
