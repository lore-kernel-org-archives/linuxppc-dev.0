Return-Path: <walt.wimer@timesys.com>
Received: from exchange.timesys.com (mail.timesys.com [65.117.135.102])
	by ozlabs.org (Postfix) with ESMTP id 06EE667A6F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Mar 2005 02:24:20 +1000 (EST)
From: "Walter L. Wimer III" <walt.wimer@timesys.com>
To: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <4a399aeb5127923823feb2ced5eb0e1d@freescale.com>
References: <1112026020.25896.8.camel@excalibur.timesys.com>
	<4a399aeb5127923823feb2ced5eb0e1d@freescale.com>
Content-Type: multipart/alternative; boundary="=-f73AD8Ds9y5jYawdsNFW"
Date: Mon, 28 Mar 2005 11:24:18 -0500
Message-Id: <1112027058.25896.10.camel@excalibur.timesys.com>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Problem running Linux 2.6.11 on MPC8272ADS
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--=-f73AD8Ds9y5jYawdsNFW
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


I'll submit one once I get everything else working on this board that I
need....  :-)


Walt



On Mon, 2005-03-28 at 10:21 -0600, Kumar Gala wrote:

> A patch to make this work properly would be appreciated.
> 
> - kumar
> 
> On Mar 28, 2005, at 10:06 AM, Walter L. Wimer III wrote:
> 
> >
> >
> > Hi Mike,
> >
> > I had the same "hang" experience.  The file arch/ppc/platforms/pq2ads.c
> > contains the following function:
> >
> >   void __init
> >    m82xx_board_setup(void)
> >   {
> >          /* Enable the 2nd UART port */
> >          *(volatile uint *)(BCSR_ADDR + 4) &= ~BCSR1_RS232_EN2;
> >   }
> >
> >
> >
> > I had to ifdef-out the assignment statement above.  It appears that the
> >  definition for BCSR_ADDR in the kernel code differs from what U-Boot 
> > is
> >  using, and that area of memory isn't properly mapped into the kernel
> >  address space this early in the boot sequence.  As a result, I was
> >  getting an Oops() before the console was even enabled (I could see the
> >  Oops message by examining the kernel's printk log buffer using a
> >  BDI-2000 hardware debugger).
> >
> >
> >
> >
> > Good luck,
> >
> > Walt Wimer
> >  TimeSys Corporation
> >
> >
> >
> >
> >
> > On Sun, 2005-03-27 at 11:31 +0200, Mike Rapoport wrote:
> >  > Hi,
> >  > I'm trying to bring up the Linux 2.6.11 on MPC8272ADS and it seem to
> > > hang up at the very beginning.
> >  > I use ads8272_defconfig and then enable console on SCC:
> >  >
> > > CONFIG_SERIAL_CPM=y
> > > CONFIG_SERIAL_CPM_CONSOLE=y
> > > CONFIG_SERIAL_CPM_SCC1=y
> > >
> > >
> > > when I boot the kernel from the u-boot the system hangs up right 
> > after
> > > the kernel decompression.
> > >
> >
> >  _______________________________________________
> > Linuxppc-embedded mailing list
> >  Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 

--=-f73AD8Ds9y5jYawdsNFW
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.3.2">
</HEAD>
<BODY>
<BR>
I'll submit one once I get everything else working on this board that I need....&nbsp; :-)<BR>
<BR>
<BR>
Walt<BR>
<BR>
<BR>
<BR>
On Mon, 2005-03-28 at 10:21 -0600, Kumar Gala wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">A patch to make this work properly would be appreciated.</FONT>

<FONT COLOR="#000000">- kumar</FONT>

<FONT COLOR="#000000">On Mar 28, 2005, at 10:06 AM, Walter L. Wimer III wrote:</FONT>

<FONT COLOR="#000000">&gt;</FONT>
<FONT COLOR="#000000">&gt;</FONT>
<FONT COLOR="#000000">&gt; Hi Mike,</FONT>
<FONT COLOR="#000000">&gt;</FONT>
<FONT COLOR="#000000">&gt; I had the same &quot;hang&quot; experience.&nbsp; The file arch/ppc/platforms/pq2ads.c</FONT>
<FONT COLOR="#000000">&gt; contains the following function:</FONT>
<FONT COLOR="#000000">&gt;</FONT>
<FONT COLOR="#000000">&gt; &nbsp; void __init</FONT>
<FONT COLOR="#000000">&gt;  &nbsp; m82xx_board_setup(void)</FONT>
<FONT COLOR="#000000">&gt; &nbsp; {</FONT>
<FONT COLOR="#000000">&gt;  &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Enable the 2nd UART port */</FONT>
<FONT COLOR="#000000">&gt;  &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *(volatile uint *)(BCSR_ADDR + 4) &amp;= ~BCSR1_RS232_EN2;</FONT>
<FONT COLOR="#000000">&gt; &nbsp; }</FONT>
<FONT COLOR="#000000">&gt;</FONT>
<FONT COLOR="#000000">&gt;</FONT>
<FONT COLOR="#000000">&gt;</FONT>
<FONT COLOR="#000000">&gt; I had to ifdef-out the assignment statement above.&nbsp; It appears that the</FONT>
<FONT COLOR="#000000">&gt;  definition for BCSR_ADDR in the kernel code differs from what U-Boot </FONT>
<FONT COLOR="#000000">&gt; is</FONT>
<FONT COLOR="#000000">&gt;  using, and that area of memory isn't properly mapped into the kernel</FONT>
<FONT COLOR="#000000">&gt;  address space this early in the boot sequence.&nbsp; As a result, I was</FONT>
<FONT COLOR="#000000">&gt;  getting an Oops() before the console was even enabled (I could see the</FONT>
<FONT COLOR="#000000">&gt;  Oops message by examining the kernel's printk log buffer using a</FONT>
<FONT COLOR="#000000">&gt;  BDI-2000 hardware debugger).</FONT>
<FONT COLOR="#000000">&gt;</FONT>
<FONT COLOR="#000000">&gt;</FONT>
<FONT COLOR="#000000">&gt;</FONT>
<FONT COLOR="#000000">&gt;</FONT>
<FONT COLOR="#000000">&gt; Good luck,</FONT>
<FONT COLOR="#000000">&gt;</FONT>
<FONT COLOR="#000000">&gt; Walt Wimer</FONT>
<FONT COLOR="#000000">&gt;  TimeSys Corporation</FONT>
<FONT COLOR="#000000">&gt;</FONT>
<FONT COLOR="#000000">&gt;</FONT>
<FONT COLOR="#000000">&gt;</FONT>
<FONT COLOR="#000000">&gt;</FONT>
<FONT COLOR="#000000">&gt;</FONT>
<FONT COLOR="#000000">&gt; On Sun, 2005-03-27 at 11:31 +0200, Mike Rapoport wrote:</FONT>
<FONT COLOR="#000000">&gt;  &gt; Hi,</FONT>
<FONT COLOR="#000000">&gt;  &gt; I'm trying to bring up the Linux 2.6.11 on MPC8272ADS and it seem to</FONT>
<FONT COLOR="#000000">&gt; &gt; hang up at the very beginning.</FONT>
<FONT COLOR="#000000">&gt;  &gt; I use ads8272_defconfig and then enable console on SCC:</FONT>
<FONT COLOR="#000000">&gt;  &gt;</FONT>
<FONT COLOR="#000000">&gt; &gt; CONFIG_SERIAL_CPM=y</FONT>
<FONT COLOR="#000000">&gt; &gt; CONFIG_SERIAL_CPM_CONSOLE=y</FONT>
<FONT COLOR="#000000">&gt; &gt; CONFIG_SERIAL_CPM_SCC1=y</FONT>
<FONT COLOR="#000000">&gt; &gt;</FONT>
<FONT COLOR="#000000">&gt; &gt;</FONT>
<FONT COLOR="#000000">&gt; &gt; when I boot the kernel from the u-boot the system hangs up right </FONT>
<FONT COLOR="#000000">&gt; after</FONT>
<FONT COLOR="#000000">&gt; &gt; the kernel decompression.</FONT>
<FONT COLOR="#000000">&gt; &gt;</FONT>
<FONT COLOR="#000000">&gt;</FONT>
<FONT COLOR="#000000">&gt;  _______________________________________________</FONT>
<FONT COLOR="#000000">&gt; Linuxppc-embedded mailing list</FONT>
<FONT COLOR="#000000">&gt;  <A HREF="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</A></FONT>
<FONT COLOR="#000000">&gt; <A HREF="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</A></FONT>

</PRE>
</BLOCKQUOTE>
</BODY>
</HTML>

--=-f73AD8Ds9y5jYawdsNFW--
