Return-Path: <Marc.Howard@KLA-Tencor.com>
Received: from ca1mail04.kla-tencor.com (mailout04.kla-tencor.com
	[192.146.1.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0CE74679E6
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Apr 2006 13:43:08 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C65D19.FB2D40CF"
Subject: RE: Create permanent mapping from PCI bus to region of physical memory
Date: Mon, 10 Apr 2006 20:42:39 -0700
Message-ID: <91B22F93A880FA48879475E134D6F0BE386FBD@CA1EXCLV02.adcorp.kla-tencor.com>
References: <91B22F93A880FA48879475E134D6F0BE026CD163@CA1EXCLV02.adcorp.kla-tencor.com>
	<443B0718.3050001@ovro.caltech.edu>
	<91B22F93A880FA48879475E134D6F0BE386FBC@CA1EXCLV02.adcorp.kla-tencor.com>
	<443B1EE9.5030104@ovro.caltech.edu>
From: "Howard, Marc" <Marc.Howard@KLA-Tencor.com>
To: "David Hawkins" <dwh@ovro.caltech.edu>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C65D19.FB2D40CF
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

>> The periperal is an FPGA.  No, there is no internal processor;
>> everything is coded in Verilog.
>>
>> Scatter/gather isn't a viable option because of this.=20

>Er, why not, its an FPGA, everything is possible :)

Not if you're tight on routing resouces and/or design time ;-)

>So you have a PCI core, since you are planning to write to
>the host memory space, its a Bus Master PCI core.
>Who's FPGA, Altera, Xilinx, or someone else?

Xilinx Virtex 4, no internal PPC.  The vendor really isn't
germain to the problem at hand however.

>> Additionally non-contiguous memory would reduce bandwidth=20
>> and increase FPGA design complexity.=20

>Not necessarily. If the target is using bus master DMA to
>write to the host memory, then you can hit pretty close
>to the bandwidth of the PCI bus. If you are DMAing in
>big blocks, the overhead of a block change isn't too much.
>I did tests with the 440EP using a DMA controller on an
>adapter board and found that the PCI bridge in the 440EP
>was the limiting factor, i.e., for a 33MHz 32-bit bus
>with a potential for 132MB/s, the *best* you can do is
>about 40MB/s since the bridge only accepts data in cache
>line sizes before sending a retry to the target. I can
>send you those results.

Dave, I appreciate your input but scatter/gather just isn't
an option here for a variety of reasons.  Bandwidth/complexity/
latency/time to design/time to debug/FPGA density all
factor into this decision.  BTW we're talking 66/64 PCI-X;
33/32 PCI isn't nearly fast enough.

>Randomly accessible from where; the host or an I/O interface
>at the FPGA. The pages can be made to appear contiguous to
>a host processor user-space process using the nopage callback
>of the VMA.

>From the point of view of the FPGA.

>> I realize this isn't a standard linux request but having
>> fixed, linear memory is quite common in embedded apps.  There
>> should be a way to create this mapping in the 440GX's hardware
>> and I'm just looking for a system call (if there is one) to
>> implement it.

>Alas, this is one of the concessions one must make if you
>want to use a processor that enables the MMU.=20

Nope, I disagree.  The MMU isn't involved here at all.  I'm
talking about setting up the PIM (PCI Inbound Map) via
a system call as opposed to just writing it directly.

>However,
>I don't see any fundamental limitation in the design
>that would preclude a little extra work on the FPGA.
>But, it does require additional Verilog to support
>the flexibility. The long-term advantage is that you
>don't have to provide a hack (eg. reserve a block of
>high-memory under Linux).

I really can't go into detail about my application for a
variety of reasons (both technical and legal) but suffice
it to say that 16 MB is just the starting point.

I guess I'll dig a little deeper into the source to see
where the kernel does the PIM mapping.  Re-architecting
our app at this stage just isn't a practical consideration.

Thanks again,

Marc=20






------_=_NextPart_001_01C65D19.FB2D40CF
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7638.1">
<TITLE>RE: Create permanent mapping from PCI bus to region of physical =
memory</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>&gt;&gt; The periperal is an FPGA.&nbsp; No, there is =
no internal processor;<BR>
&gt;&gt; everything is coded in Verilog.<BR>
&gt;&gt;<BR>
&gt;&gt; Scatter/gather isn't a viable option because of this.<BR>
<BR>
&gt;Er, why not, its an FPGA, everything is possible :)<BR>
<BR>
Not if you're tight on routing resouces and/or design time ;-)<BR>
<BR>
&gt;So you have a PCI core, since you are planning to write to<BR>
&gt;the host memory space, its a Bus Master PCI core.<BR>
&gt;Who's FPGA, Altera, Xilinx, or someone else?<BR>
<BR>
Xilinx Virtex 4, no internal PPC.&nbsp; The vendor really isn't<BR>
germain to the problem at hand however.<BR>
<BR>
&gt;&gt; Additionally non-contiguous memory would reduce bandwidth<BR>
&gt;&gt; and increase FPGA design complexity.<BR>
<BR>
&gt;Not necessarily. If the target is using bus master DMA to<BR>
&gt;write to the host memory, then you can hit pretty close<BR>
&gt;to the bandwidth of the PCI bus. If you are DMAing in<BR>
&gt;big blocks, the overhead of a block change isn't too much.<BR>
&gt;I did tests with the 440EP using a DMA controller on an<BR>
&gt;adapter board and found that the PCI bridge in the 440EP<BR>
&gt;was the limiting factor, i.e., for a 33MHz 32-bit bus<BR>
&gt;with a potential for 132MB/s, the *best* you can do is<BR>
&gt;about 40MB/s since the bridge only accepts data in cache<BR>
&gt;line sizes before sending a retry to the target. I can<BR>
&gt;send you those results.<BR>
<BR>
Dave, I appreciate your input but scatter/gather just isn't<BR>
an option here for a variety of reasons.&nbsp; Bandwidth/complexity/<BR>
latency/time to design/time to debug/FPGA density all<BR>
factor into this decision.&nbsp; BTW we're talking 66/64 PCI-X;<BR>
33/32 PCI isn't nearly fast enough.<BR>
<BR>
&gt;Randomly accessible from where; the host or an I/O interface<BR>
&gt;at the FPGA. The pages can be made to appear contiguous to<BR>
&gt;a host processor user-space process using the nopage callback<BR>
&gt;of the VMA.<BR>
<BR>
>From the point of view of the FPGA.<BR>
<BR>
&gt;&gt; I realize this isn't a standard linux request but having<BR>
&gt;&gt; fixed, linear memory is quite common in embedded apps.&nbsp; =
There<BR>
&gt;&gt; should be a way to create this mapping in the 440GX's =
hardware<BR>
&gt;&gt; and I'm just looking for a system call (if there is one) to<BR>
&gt;&gt; implement it.<BR>
<BR>
&gt;Alas, this is one of the concessions one must make if you<BR>
&gt;want to use a processor that enables the MMU.<BR>
<BR>
Nope, I disagree.&nbsp; The MMU isn't involved here at all.&nbsp; =
I'm<BR>
talking about setting up the PIM (PCI Inbound Map) via<BR>
a system call as opposed to just writing it directly.<BR>
<BR>
&gt;However,<BR>
&gt;I don't see any fundamental limitation in the design<BR>
&gt;that would preclude a little extra work on the FPGA.<BR>
&gt;But, it does require additional Verilog to support<BR>
&gt;the flexibility. The long-term advantage is that you<BR>
&gt;don't have to provide a hack (eg. reserve a block of<BR>
&gt;high-memory under Linux).<BR>
<BR>
I really can't go into detail about my application for a<BR>
variety of reasons (both technical and legal) but suffice<BR>
it to say that 16 MB is just the starting point.<BR>
<BR>
I guess I'll dig a little deeper into the source to see<BR>
where the kernel does the PIM mapping.&nbsp; Re-architecting<BR>
our app at this stage just isn't a practical consideration.<BR>
<BR>
Thanks again,<BR>
<BR>
Marc<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C65D19.FB2D40CF--
