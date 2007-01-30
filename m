Return-Path: <recon_pje@yahoo.com>
Received: from web58805.mail.re1.yahoo.com (web58805.mail.re1.yahoo.com
	[66.196.100.219]) by ozlabs.org (Postfix) with SMTP id DA43DDDF8C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 Jan 2007 06:41:27 +1100 (EST)
Date: Tue, 30 Jan 2007 11:41:25 -0800 (PST)
From: Paul Eaton <recon_pje@yahoo.com>
Subject: Re: MPC8248 poor performance
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <A2F6DE21-4303-41A5-AA2E-AC854981976C@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1626955397-1170186085=:71958"
Message-ID: <566482.71958.qm@web58805.mail.re1.yahoo.com>
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

--0-1626955397-1170186085=:71958
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Thanks Kumar for your suggestion to look into the I-cache and D-cache initialization.
   
  I verified that neither the IBAT or DBAT tables are initialized. It appears this operation is not handled by u-boot but rather the OS is expected to configure the cache parameters. This is a problem for my application given that we don't boot an OS after u-boot completes.
   
  I've attempted to poke in the values that I feel are needed for the BAT registers as well as HID0 with an Abatron, but my card resets when I attempt to run after the values are loaded.
   
  Would you happen to know what linux module is used to set up cache parameters on a MPC8248 (8260 class) processor? I'd like to look over how Linux handles it to see if I'm missing something in the initialization sequence.
   
  I don't see the sequence documented anywhere in the Freescale documents and the trial and error method with the Abatron is getting old.
   
  Paul
  

Kumar Gala <galak@kernel.crashing.org> wrote:
  
On Jan 26, 2007, at 1:42 PM, Paul Eaton wrote:

> Hi,
>
> We have a custom 8248 card that we are testing.
> The core is running at 400MHz and the system bus is 80Mhz (measured 
> and verified), 32 bit wide memory interface.
> There is nothing connected to the CPM except 1 RS232 port which is 
> not used in our test loop.
>
> We are running a small test C loop (with approx. 60 assembly 
> language instructions) at the end of u-boot as in the Hello World 
> example. The loop runs fine but upon closer analisis I found that 
> each loop takes 6uS. This averages out to 100nS/instruction = 
> 10MIPS = sad performance. I would have expected at least 100MIPS or 
> more.
>
> I've checked the HID0 SPR register to verify that the instruction 
> cache is enabled.
>
> I've also stepped thru the code to verify that the code stays 
> within the loop (no async branches or irqs). Looking at the adr and 
> data lines with an analyzer the loop appears to do the correct 
> amount of I/O to SDRAM but the amount of time of between SDRAM 
> accesses seem longer than I would expect if caching, pipelining, 
> snooping, etc are enabled.
>
> Any ideas on what could be slowing the CPU down are greatly 
> appreciated.
>

Is the code doing any d-side access? is the d-cache enabled? How are 
the BATs setup for memory locations you are accessing.

- k





 
---------------------------------
TV dinner still cooling?
Check out "Tonight's Picks" on Yahoo! TV.
--0-1626955397-1170186085=:71958
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<DIV>Thanks Kumar for your suggestion to look into the I-cache and D-cache initialization.</DIV>  <DIV>&nbsp;</DIV>  <DIV>I verified that neither the IBAT or DBAT tables are initialized. It appears this operation is not handled by u-boot but rather the OS is expected to configure the cache parameters. This is a problem for my application given that we don't boot an OS after u-boot completes.</DIV>  <DIV>&nbsp;</DIV>  <DIV>I've attempted to poke in the values that I feel are needed for the BAT registers&nbsp;as well as&nbsp;HID0&nbsp;with an Abatron, but my card resets when I attempt to run after the values are loaded.</DIV>  <DIV>&nbsp;</DIV>  <DIV>Would you happen to&nbsp;know what linux module is used to set up cache parameters on a MPC8248 (8260 class) processor? I'd like to look&nbsp;over how Linux handles it to see if I'm missing something in the initialization sequence.</DIV>  <DIV>&nbsp;</DIV>  <DIV>I don't see the sequence documented anywhere&nbsp;in the Freescale
 documents and the trial and error method with the Abatron is getting old.</DIV>  <DIV>&nbsp;</DIV>  <DIV>Paul</DIV>  <DIV><BR><BR><B><I>Kumar Gala &lt;galak@kernel.crashing.org&gt;</I></B> wrote:</DIV>  <BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid"><BR>On Jan 26, 2007, at 1:42 PM, Paul Eaton wrote:<BR><BR>&gt; Hi,<BR>&gt;<BR>&gt; We have a custom 8248 card that we are testing.<BR>&gt; The core is running at 400MHz and the system bus is 80Mhz (measured <BR>&gt; and verified), 32 bit wide memory interface.<BR>&gt; There is nothing connected to the CPM except 1 RS232 port which is <BR>&gt; not used in our test loop.<BR>&gt;<BR>&gt; We are running a small test C loop (with approx. 60 assembly <BR>&gt; language instructions) at the end of u-boot as in the Hello World <BR>&gt; example. The loop runs fine but upon closer analisis I found that <BR>&gt; each loop takes 6uS. This averages out to 100nS/instruction = <BR>&gt;
 10MIPS = sad performance. I would have expected at least 100MIPS or <BR>&gt; more.<BR>&gt;<BR>&gt; I've checked the HID0 SPR register to verify that the instruction <BR>&gt; cache is enabled.<BR>&gt;<BR>&gt; I've also stepped thru the code to verify that the code stays <BR>&gt; within the loop (no async branches or irqs). Looking at the adr and <BR>&gt; data lines with an analyzer the loop appears to do the correct <BR>&gt; amount of I/O to SDRAM but the amount of time of between SDRAM <BR>&gt; accesses seem longer than I would expect if caching, pipelining, <BR>&gt; snooping, etc are enabled.<BR>&gt;<BR>&gt; Any ideas on what could be slowing the CPU down are greatly <BR>&gt; appreciated.<BR>&gt;<BR><BR>Is the code doing any d-side access? is the d-cache enabled? How are <BR>the BATs setup for memory locations you are accessing.<BR><BR>- k<BR><BR><BR><BR></BLOCKQUOTE><BR><p>&#32;

<hr size=1>TV dinner still cooling?<br><a href="http://us.rd.yahoo.com/evt=49979/*http://tv.yahoo.com/">Check out "Tonight's Picks"</a> on Yahoo! TV.
--0-1626955397-1170186085=:71958--
