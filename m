Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f194.google.com (mail-yw0-f194.google.com
	[209.85.211.194]) by ozlabs.org (Postfix) with ESMTP id 0CDEAB7B73
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Sep 2009 23:44:42 +1000 (EST)
Received: by ywh32 with SMTP id 32so1175335ywh.15
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Sep 2009 06:44:40 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <fa686aa40909180636jb2f8676k94a50b176319c249@mail.gmail.com>
References: <4AB1B84F.8080606@embedded-sol.com>
	<fa686aa40909180636jb2f8676k94a50b176319c249@mail.gmail.com>
Date: Fri, 18 Sep 2009 07:44:39 -0600
Message-ID: <fa686aa40909180644w4b771419y3402ccd201a2159@mail.gmail.com>
Subject: Re: FPGA access over PCI-E on MPC8536
From: Grant Likely <grant.likely@secretlab.ca>
To: Felix Radensky <felix@embedded-sol.com>
Content-Type: multipart/alternative; boundary=000e0cd5c7c8641eda0473da5502
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--000e0cd5c7c8641eda0473da5502
Content-Type: text/plain; charset=ISO-8859-1

Can you access fpga memory from u-boot?

Could very well be an fpga problem.  Same thing can happen on xilinx parts
when accessing an undefined register address via pci bridge --> plb bus -->
ipif register block --> bad address.  The pci core goes into some kind of
retry loop with the plb bus (I'm wasn't the one to look at the pci analyzer,
so I don't know the details), and it completely locks up.

g.

On Sep 16, 2009 11:02 PM, "Felix Radensky" <felix@embedded-sol.com> wrote:

Hi,

On my custom MPC8536 based board running 2.6.31 kernel
FPGA is connected via x2 PCI-E lane. FPGA is identified
during PCI scan and is visible via lspci.

0000:01:00.0 Class ff00: Altera Corporation Unknown device 0004 (rev 01)
       Subsystem: Altera Corporation Unknown device 0004
       Flags: fast devsel, IRQ 16
       Memory at 98000000 (32-bit, non-prefetchable) [disabled] [size=1M]
       Capabilities: [50] Message Signalled Interrupts: Mask+ 64bit+
Queue=0/5 Enable-
       Capabilities: [78] Power Management version 3
       Capabilities: [80] Express Endpoint IRQ 0
       Capabilities: [100] Virtual Channel


However when I attempt to access FPGA memory my mmapping it in userspace the
read hangs. The same happens in kernel space. Does it happen because FPGA
memory is marked as disabled, or because FPGA code is doing something wrong
?

Another question is what can cause PCI device memory be marked as
disabled.

Thanks a lot.

Felix.

_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@lists.ozlabs.org
https://lists.ozlabs.org/listinfo/linuxppc-dev

--000e0cd5c7c8641eda0473da5502
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p>Can you access fpga memory from u-boot?</p>
<p>Could very well be an fpga problem.=A0 Same thing can happen on xilinx p=
arts when accessing an undefined register address via pci bridge --&gt; plb=
 bus --&gt; ipif register block --&gt; bad address.=A0 The pci core goes in=
to some kind of retry loop with the plb bus (I&#39;m wasn&#39;t the one to =
look at the pci analyzer, so I don&#39;t know the details), and it complete=
ly locks up.</p>

<p>g.</p>
<p><blockquote type=3D"cite">On Sep 16, 2009 11:02 PM, &quot;Felix Radensky=
&quot; &lt;<a href=3D"mailto:felix@embedded-sol.com">felix@embedded-sol.com=
</a>&gt; wrote:<br><br>Hi,<br>
<br>
On my custom MPC8536 based board running 2.6.31 kernel<br>
FPGA is connected via x2 PCI-E lane. FPGA is identified<br>
during PCI scan and is visible via lspci.<br>
<br>
0000:01:00.0 Class ff00: Altera Corporation Unknown device 0004 (rev 01)<br=
>
 =A0 =A0 =A0 =A0Subsystem: Altera Corporation Unknown device 0004<br>
 =A0 =A0 =A0 =A0Flags: fast devsel, IRQ 16<br>
 =A0 =A0 =A0 =A0Memory at 98000000 (32-bit, non-prefetchable) [disabled] [s=
ize=3D1M]<br>
 =A0 =A0 =A0 =A0Capabilities: [50] Message Signalled Interrupts: Mask+ 64bi=
t+ Queue=3D0/5 Enable-<br>
 =A0 =A0 =A0 =A0Capabilities: [78] Power Management version 3<br>
 =A0 =A0 =A0 =A0Capabilities: [80] Express Endpoint IRQ 0<br>
 =A0 =A0 =A0 =A0Capabilities: [100] Virtual Channel<br>
<br>
<br>
However when I attempt to access FPGA memory my mmapping it in userspace th=
e read hangs. The same happens in kernel space. Does it happen because FPGA=
 memory is marked as disabled, or because FPGA code is doing something wron=
g ?<br>

<br>
Another question is what can cause PCI device memory be marked as<br>
disabled.<br>
<br>
Thanks a lot.<br>
<br>
Felix.<br>
<br>
_______________________________________________<br>
Linuxppc-dev mailing list<br>
<a href=3D"mailto:Linuxppc-dev@lists.ozlabs.org" target=3D"_blank">Linuxppc=
-dev@lists.ozlabs.org</a><br>
<a href=3D"https://lists.ozlabs.org/listinfo/linuxppc-dev" target=3D"_blank=
">https://lists.ozlabs.org/listinfo/linuxppc-dev</a><br>
</blockquote></p>

--000e0cd5c7c8641eda0473da5502--
