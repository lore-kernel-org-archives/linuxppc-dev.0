Return-Path: <Marc.Howard@KLA-Tencor.com>
Received: from ca1mail04.kla-tencor.com (mailout04.kla-tencor.com
	[192.146.1.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 02B1567A62
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Apr 2006 12:56:41 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C65D13.7CA363EF"
Subject: RE: Create permanent mapping from PCI bus to region of physical memory
Date: Mon, 10 Apr 2006 19:56:10 -0700
Message-ID: <91B22F93A880FA48879475E134D6F0BE386FBC@CA1EXCLV02.adcorp.kla-tencor.com>
References: <91B22F93A880FA48879475E134D6F0BE026CD163@CA1EXCLV02.adcorp.kla-tencor.com>
	<443B0718.3050001@ovro.caltech.edu>
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

------_=_NextPart_001_01C65D13.7CA363EF
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Howard, Marc wrote:
>> Hi,
>>=20
>> I'm working on a PPC440GX based board in which a PCI based peripheral
>> communicates with the host via a shared region of processor memory.  =
The
>> peripheral will read and write this region autonomously.  Because of
>> this I need a fixed mapping FROM the PCI bus TO system memory.
>>
>> It's easy enough to rope off the top 16 MB or so of system physical
>> memory by lying to linux in the boot arguments.  What I can't seem =
find
>> is a system call to use to create a fixed, permanent mapping of PPC
>> memory as seen from the PCI bus.
>>=20
>> Has anyone out there done this and could share a code snippet with =
me?
>>=20

>Hi Marc,

>So the PPC440GX is the host, but what is the peripheral, and
>what restricts it to require a fixed address? Can it handle
>a set of fixed addresses, eg. a scatter-gather buffer setup
>by the host? Can the host and peripheral communicate in any
>other way, eg. when the peripheral changes something in the
>shared memory, surely it has to interrupt the host to let it
>know?

>Does the peripheral contain a CPU, if thats the case, then
>the host and peripheral could also maintain a smaller region
>that contains addresses of other pages, i.e., no need to
>restrict the design to a single block of memory, you just
>need a page of pointers to other shared blocks of pages.

Dave,

The periperal is an FPGA.  No, there is no internal processor;
everything is coded in Verilog.

Scatter/gather isn't a viable option because of this.  Additionally
non-contiguous memory would reduce bandwidth and increase
FPGA design complexity.  The data must be contignuous because
of these reasons and the need for the data to be randomly
accessible from the outside using simple address arithmetic.

I realize this isn't a standard linux request but having
fixed, linear memory is quite common in embedded apps.  There
should be a way to create this mapping in the 440GX's hardware
and I'm just looking for a system call (if there is one) to
implement it.

Thanks,

Marc




------_=_NextPart_001_01C65D13.7CA363EF
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

<P><FONT SIZE=3D2>Howard, Marc wrote:<BR>
&gt;&gt; Hi,<BR>
&gt;&gt;<BR>
&gt;&gt; I'm working on a PPC440GX based board in which a PCI based =
peripheral<BR>
&gt;&gt; communicates with the host via a shared region of processor =
memory.&nbsp; The<BR>
&gt;&gt; peripheral will read and write this region autonomously.&nbsp; =
Because of<BR>
&gt;&gt; this I need a fixed mapping FROM the PCI bus TO system =
memory.<BR>
&gt;&gt;<BR>
&gt;&gt; It's easy enough to rope off the top 16 MB or so of system =
physical<BR>
&gt;&gt; memory by lying to linux in the boot arguments.&nbsp; What I =
can't seem find<BR>
&gt;&gt; is a system call to use to create a fixed, permanent mapping of =
PPC<BR>
&gt;&gt; memory as seen from the PCI bus.<BR>
&gt;&gt;<BR>
&gt;&gt; Has anyone out there done this and could share a code snippet =
with me?<BR>
&gt;&gt;<BR>
<BR>
&gt;Hi Marc,<BR>
<BR>
&gt;So the PPC440GX is the host, but what is the peripheral, and<BR>
&gt;what restricts it to require a fixed address? Can it handle<BR>
&gt;a set of fixed addresses, eg. a scatter-gather buffer setup<BR>
&gt;by the host? Can the host and peripheral communicate in any<BR>
&gt;other way, eg. when the peripheral changes something in the<BR>
&gt;shared memory, surely it has to interrupt the host to let it<BR>
&gt;know?<BR>
<BR>
&gt;Does the peripheral contain a CPU, if thats the case, then<BR>
&gt;the host and peripheral could also maintain a smaller region<BR>
&gt;that contains addresses of other pages, i.e., no need to<BR>
&gt;restrict the design to a single block of memory, you just<BR>
&gt;need a page of pointers to other shared blocks of pages.<BR>
<BR>
Dave,<BR>
<BR>
The periperal is an FPGA.&nbsp; No, there is no internal processor;<BR>
everything is coded in Verilog.<BR>
<BR>
Scatter/gather isn't a viable option because of this.&nbsp; =
Additionally<BR>
non-contiguous memory would reduce bandwidth and increase<BR>
FPGA design complexity.&nbsp; The data must be contignuous because<BR>
of these reasons and the need for the data to be randomly<BR>
accessible from the outside using simple address arithmetic.<BR>
<BR>
I realize this isn't a standard linux request but having<BR>
fixed, linear memory is quite common in embedded apps.&nbsp; There<BR>
should be a way to create this mapping in the 440GX's hardware<BR>
and I'm just looking for a system call (if there is one) to<BR>
implement it.<BR>
<BR>
Thanks,<BR>
<BR>
Marc<BR>
<BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C65D13.7CA363EF--
