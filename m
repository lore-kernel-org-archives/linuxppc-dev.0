Return-Path: <kpoole@mrv.com>
Received: from mailserver.corp.int.mrv.com (mx2.lb.mrv.com [66.43.110.200])
	by ozlabs.org (Postfix) with ESMTP id 5EEF6679EF
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Apr 2006 05:19:49 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6631D.02904B9D"
Subject: kernel 2.6.15: cpm_uart driver broken?
Date: Tue, 18 Apr 2006 15:19:41 -0400
Message-ID: <4D8794260B62C940BBA7150CC5EB3BD432D3A5@bosmail.BOS.int.mrv.com>
From: "Kenneth Poole" <kpoole@mrv.com>
To: <linuxppc-embedded@ozlabs.org>
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

------_=_NextPart_001_01C6631D.02904B9D
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

For David Jander and Vitaly Bordug:

Regarding DMA allocation for CPM uarts, we had a similar issue with our
MPC857T and MPC885 boards. I think the real problem is that
bus_to_virt() and virt_to_bus() don't work on 8xx platforms for
addresses allocated using dma_alloc_coherent(). We had a previous
discussion Pantelis Antoniou and he agreed that the use of bus_to_virt()
and virt_to_bus() should be deprecated. This is also recommended in the
whitepaper series that discussed porting device drivers from 2.4 to 2.6.

What we did was use dma_alloc_coherent() in cpm_uart_cpm1.c, saving
dma_addr in the pinfo structure. The in cpm_uart_core.c, we use dma_addr
as the base address for the cbd_bufaddr values in each of the
descriptors. The software, when accessing the DMA buffers, uses mem_addr
as the base, applying the same offset computed previously for the dma
addresses. This technique is used in other drivers all over 2.6.

This avoids the configuration dependencies on the conversion functions.

Ken Poole
kpoole@bos.mrv.com


------_=_NextPart_001_01C6631D.02904B9D
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7638.1">
<TITLE>kernel 2.6.15: cpm_uart driver broken?</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">For</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"> <FONT SIZE=3D2 FACE=3D"Arial">David</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Arial">Jander</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"> <FONT SIZE=3D2 FACE=3D"Arial">an</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">d</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"> Vitaly</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial"> Bordug</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">:</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">Regarding DMA allocation for CPM uarts, we had a similar =
issue with our MPC857T and MPC8</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">8</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">5 =
boards.</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"> I think the real problem =
is that bus_to_virt</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">(</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">) and virt_to_bus() don</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">&#8217;</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">t work</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Arial">o</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">n 8xx</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial"></FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"> <FONT SIZE=3D2 FACE=3D"Arial">platforms for addresses =
allocated using dma_alloc_coherent().</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial"></FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"> <FONT SIZE=3D2 FACE=3D"Arial">We had =
a</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT =
SIZE=3D2 FACE=3D"Arial"> previous discussion</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Arial">Pantelis Antoniou and he agreed that the use of =
bus_to_virt() and virt_to_bus() should be deprecated. This is also =
recommended in the whitepaper series that discussed porting device =
drivers</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"> =
<FONT SIZE=3D2 FACE=3D"Arial">from 2.4 to</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Arial">2.6.</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">What =
we did was</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"> <FONT SIZE=3D2 FACE=3D"Arial">use dma_alloc_coherent() =
in cpm_uart_cpm1.c, saving dma_addr in the pinfo</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Arial">structure</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">.</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial"> The in cpm_uart_core</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">.c</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">,</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Arial">we</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"> <FONT SIZE=3D2 FACE=3D"Arial">use dma_addr as the base =
address for the cbd_bufaddr values in each of the</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Arial">descriptors.</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial"> The software, when accessing the DMA buffers, uses =
mem_addr as the base, applying the same offset computed previously for =
the dma addresses.</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"> This technique is used in =
other drivers all over 2.6.</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">This =
avoids the configuration dependencies on the</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Arial">conversion functions.</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Ken =
Poole</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"></SPAN><A =
HREF=3D"mailto:kpoole@bos.mrv.com"><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><U><FONT COLOR=3D"#0000FF" SIZE=3D2 =
FACE=3D"Arial">kpoole@bos.mrv.com</FONT></U></SPAN><SPAN =
LANG=3D"en-us"></SPAN></A><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"></SPAN></P>

</BODY>
</HTML>
------_=_NextPart_001_01C6631D.02904B9D--
