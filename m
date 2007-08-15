Return-Path: <mail4mz@gmail.com>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.185])
	by ozlabs.org (Postfix) with ESMTP id 76EABDDE26
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Aug 2007 23:58:00 +1000 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so1488970rvf
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Aug 2007 06:57:59 -0700 (PDT)
Message-ID: <5c9cd53b0708150657k71531bdbl848375d5d80faf21@mail.gmail.com>
Date: Wed, 15 Aug 2007 09:57:59 -0400
From: "mike zheng" <mail4mz@gmail.com>
To: "Jon Loeliger" <jdl@freescale.com>
Subject: Re: System crash on boot_e500.S
In-Reply-To: <1187124014.32650.80.camel@ld0161-tx32>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_5504_23768597.1187186279408"
References: <5c9cd53b0708141314o57440c62waffb4cca3f2be0b9@mail.gmail.com>
	<1187124014.32650.80.camel@ld0161-tx32>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_5504_23768597.1187186279408
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Did you done similar work before? Current 2.6 code need many other files,  I
have following errors when I try to use the head_e500.S from 2.6 code:


/kernel->   powerpc-linux-gnuspe-gcc -m32 -Wp,-MD,arch/ppc/kernel/.entry.o.d
-nostdinc -isystem /opt/mtwk/usr/local/gcc-3_4-
e500-glibc-2.3.4-dp/powerpc-linux-gnuspe/lib/gcc/powerpc-linux-gnuspe/3.4.3/include
-D__KERNEL__ -Iinclude  -Iarch/ppc -D__ASSEMBLY__ -Iarch/ppc -Wa,-me500     -c
-o arch/ppc/kernel/entry.o arch/ppc/kernel/entry.S
arch/ppc/kernel/entry.S: Assembler messages:

entry.S:819: Error: unsupported relocation against CSRR0
entry.S:820: Error: unsupported relocation against CSRR1
entry.S:888: Error: unsupported relocation against MCSRR0
entry.S:889: Error: unsupported relocation against MCSRR1
entry.S:909: Error: unsupported relocation against CSRR0
entry.S:911: Error: unsupported relocation against CSRR1



entry.S

819   mtspr CSRR0, r11
820   mtspr CSRR1, r12





On 8/14/07, Jon Loeliger <jdl@freescale.com> wrote:
>
> On Tue, 2007-08-14 at 15:14, mike zheng wrote:
> > Hi All,
> >
> > I am trying to bring up MPC8548 CDS board on 2.4 kernel. I have
> > problem in the head
>
> Ow, it hurts when I do this!
>
> > _e500.S. The "mtspr SRR0, r7; mtspr SRR1 r6" does not work for me. The
> > content of R7 and R6 are not moved to SRR0 and SRR1.  I am using the
> > tool-chain from Freescale for 2.6 kernel.
> >
> > Any idea on this issue?
>
> Maybe use current 2.6 code?
>
> jdl
>
>
>

------=_Part_5504_23768597.1187186279408
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Did you done similar work before? Current 2.6 code need many other files,&nbsp;&nbsp;I have following errors when I try to use the head_e500.S from 2.6 code:</div>
<div>&nbsp;</div>
<div>
<div>
<p style="MARGIN: 0in 0in 0pt"><font face="Courier New" size="2">/kernel-&gt;<span>&nbsp;&nbsp; </span>powerpc-linux-gnuspe-gcc -m32 -Wp,-MD,arch/ppc/kernel/.entry.o.d -nostdinc -isystem /opt/mtwk/usr/local/gcc-3_4- e500-glibc-2.3.4-dp
 /powerpc-linux-gnuspe/lib/gcc/powerpc-linux-gnuspe/3.4.3/include -D__KERNEL__ -Iinclude<span>&nbsp; </span>-Iarch/ppc -D__ASSEMBLY__ -Iarch/ppc -Wa,-me500<span> &nbsp;&nbsp;&nbsp; </span>-c -o arch/ppc/kernel/entry.o arch/ppc/kernel/entry.S
<br>arch/ppc/kernel/entry.S: Assembler messages:</font></p><font face="Courier New" size="2">
<p style="MARGIN: 0in 0in 0pt"><font face="Courier New" size="2">entry.S:819: Error: unsupported relocation against CSRR0<br>entry.S:820: Error: unsupported relocation against CSRR1<br>entry.S:888: Error: unsupported relocation against MCSRR0 
<br>entry.S:889: Error: unsupported relocation against MCSRR1<br>entry.S:909: Error: unsupported relocation against CSRR0<br>entry.S:911: Error: unsupported relocation against CSRR1</font><br></p>
<p style="MARGIN: 0in 0in 0pt"><br><br></p></font><font size="2"><font face="Courier New"><span lang="PT-BR">entry.S<br><br>819<span>&nbsp;&nbsp; </span>mtspr CSRR0, r11<br></span>820<span>&nbsp;&nbsp; </span>mtspr CSRR1, r12</font></font><br>
<font size="2">&nbsp;</font></div><span></span><br>&nbsp;</div><br><br>
<div><span class="gmail_quote">On 8/14/07, <b class="gmail_sendername">Jon Loeliger</b> &lt;<a href="mailto:jdl@freescale.com">jdl@freescale.com</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">On Tue, 2007-08-14 at 15:14, mike zheng wrote:<br>&gt; Hi All,<br>&gt;<br>&gt; I am trying to bring up MPC8548 CDS board on 
2.4 kernel. I have<br>&gt; problem in the head<br><br>Ow, it hurts when I do this!<br><br>&gt; _e500.S. The &quot;mtspr SRR0, r7; mtspr SRR1 r6&quot; does not work for me. The<br>&gt; content of R7 and R6 are not moved to SRR0 and SRR1.&nbsp;&nbsp;I am using the
<br>&gt; tool-chain from Freescale for 2.6 kernel.<br>&gt;<br>&gt; Any idea on this issue?<br><br>Maybe use current 2.6 code?<br><br>jdl<br><br><br></blockquote></div><br>

------=_Part_5504_23768597.1187186279408--
