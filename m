Return-Path: <Misbahullah.Khan@Lntemsys.com>
Received: from mail87.messagelabs.com (mail87.messagelabs.com [216.82.250.19])
	by ozlabs.org (Postfix) with SMTP id 9071EDE138
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 03:08:03 +1100 (EST)
Subject: Re: When do i need to allocate DMA buffer
From: Misbahullah Khan <Misbahullah.Khan@Lntemsys.com>
To: wael showair <showair2003@yahoo.com>
Date: Wed, 14 Jan 2009 21:45:29 +0530
Message-ID: <OFEF41CADE.F2DA82A5-ON6525753E.00594EF1-6525753E.00594EF5@lntemsys.com>
MIME-Version: 1.0
Content-Type: text/html;
	charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

<FONT face=3D"Default Sans Serif,Verdana,Arial,Helvetica,sans-serif" size=
=3D2><DIV>&nbsp;<DIV><FONT face=3D"Default Monospace,Courier New,Courier,mo=
nospace">Hi Showair , </FONT></DIV><DIV><FONT face=3D"Default Monospace,Cou=
rier New,Courier,monospace"></FONT> </DIV><DIV> </DIV><DIV><FONT face=3D"De=
fault Monospace,Courier New,Courier,monospace">&gt;&gt; <FONT face=3D"Defau=
lt Monospace,Courier New,Courier,monospace">Note that my target is to trans=
fer data from memory location to another <BR>&gt;&gt;memory location &amp; =
it will be an overhead if i copy the data from the &gt;&gt;src to <BR>&gt;&=
gt;the DMA buffer then from the DMA buffer to the Destination. <BR>&gt;&gt;=
isn't there any other way to avoid using that DMA buffer &amp; to copy data=
 &gt;&gt;from <BR>&gt;&gt;src to dest directly? </FONT><BR></FONT></DIV><DI=
V><FONT face=3D"Default Monospace,Courier New,Courier,monospace">I doubt th=
at your concept of dma transfer and dma memory operation is not very clear =
.Please excuse me thats what i got reading your concern . </FONT></DIV><DIV=
><FONT face=3D"Default Monospace,Courier New,Courier,monospace"></FONT> </D=
IV><DIV><FONT face=3D"Default Monospace,Courier New,Courier,monospace">you =
dont need to copy the data from&nbsp;src to destination&nbsp;that the dma e=
ngine would take care . i dont think there could be a better way of impleme=
nting the same in other way .The engine would copy the data block to the de=
stination and&nbsp;generate an end of transfer interrupt .I dont think you =
have to allocate memory for that you just have to give the virtual address =
corresponding to the physical address using ioremap() and size to the dma e=
ngine and it will transfer the data from source to destination offcource ot=
her channel and EOT&nbsp;configuration needs to be done in driver init or e=
lse where .&nbsp;</FONT></DIV><DIV><FONT face=3D"Default Monospace,Courier =
New,Courier,monospace"></FONT><BR>&nbsp;</DIV><DIV>&nbsp;Thanks&nbsp;&amp;&=
nbsp;Regards,<BR>&nbsp;Misbah<BR>=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F<BR>&n=
bsp;&nbsp;EmSyS&nbsp;Division,<BR>&nbsp;&nbsp;Larsen&nbsp;&amp;&nbsp;Toubro=
&nbsp;Limited,<BR>&nbsp;&nbsp;KIADB&nbsp;indusrial&nbsp;area,&nbsp;Hebbal,H=
ootagalli.<BR>&nbsp;&nbsp;Mysore,&nbsp;<BR>&nbsp;&nbsp;India&nbsp;570018<BR=
>&nbsp;&nbsp;Phone:&nbsp;08212405398&nbsp;&nbsp;Extn:&nbsp;5172<BR>=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F<BR><BR>This&nbsp;mail&nbsp;is&nbsp;classifie=
d&nbsp;as&nbsp;:<BR>(X)&nbsp;L&amp;T&nbsp;EmSyS&nbsp;Proprietary&nbsp;<BR>(=
&nbsp;&nbsp;)&nbsp;L&amp;T&nbsp;EmSyS&nbsp;Confidential<BR>(&nbsp;&nbsp;)&n=
bsp;L&amp;T&nbsp;EmSyS&nbsp;Internal&nbsp;Use&nbsp;<BR>(&nbsp;&nbsp;)&nbsp;=
L&amp;T&nbsp;EmSyS&nbsp;General&nbsp;Business<BR><DIV><BR></DIV><FONT color=
=3D#990099>-----linuxppc-dev-bounces+misbahullah.khan=3Dlntemsys.com@ozlabs=
.org wrote: -----<BR><BR></FONT><blockquote style=3D"PADDING-RIGHT: 0px; PA=
DDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #000000 2px solid; MARGIN-R=
IGHT: 0px">To: linuxppc-dev@ozlabs.org<BR>From: wael showair &lt;showair200=
3@yahoo.com&gt;<BR>Sent by: linuxppc-dev-bounces+misbahullah.khan=3Dlntemsy=
s.com@ozlabs.org<BR>Date: 01/12/2009 05:33PM<BR>Subject: When do i need to =
allocate DMA buffer<BR><BR><FONT face=3D"Default Monospace,Courier New,Cour=
ier,monospace" size=3D2  ><BR>Hi All,<BR>i have MPC8555 processor, also i h=
ave linux-kernel 2.6.19-rc5 on my board.i<BR>want to use the DMA on my boar=
d, just a simple example is enough for me but<BR>during my reading on how t=
o use the DMA i have some questions:<BR>1. The DMA buffer is always needed =
for all kind of buses or not? (I think<BR>this is valid in the ISA bus but =
not in the PCI bus, plz correct me if i m<BR>wrong?)<BR>Note that my target=
 is to transfer data from memory location to another<BR>memory location &am=
p; it will be an overhead if i copy the data from the src to<BR>the DMA buf=
fer then from the DMA buffer to the Destination.<BR>isn't there any other w=
ay to avoid using that DMA buffer &amp; to copy data from<BR>src to dest di=
rectly?<BR>i read the documentation of my board &amp; it tells me that it c=
ontain DMA<BR>engine which "is capable of transferring blocks of data from =
any legal<BR>address range to any<BR>other legal address range."<BR><BR>2. =
i have read DMA-API.txt in the linux Documentation folder but i m little<BR=
>confused about the APIs that exist in this file. Actually, it is stated in=
<BR>this file the following:<BR>"This document describes the DMA API.This A=
PI is split into two pieces. <BR>Part I describes the API and the correspon=
ding pci=5F API".<BR><BR>so if the DMA controller is connected to the PCI b=
us, am i obligated to use<BR>the pci=5FAPI &amp; for any other case (like I=
SA bus or any other bus types) shall<BR>i use this generic API?<BR>also wha=
t r the benefits of these APIs over the normal kmalloc? specially<BR>that i=
 have read the following section in the DMA-mapping.txt:<BR>"If you acquire=
d your memory via the page allocator<BR>(i.e. =5F=5Fget=5Ffree=5Fpage*()) o=
r the generic memory allocators<BR>(i.e. kmalloc() or kmem=5Fcache=5Falloc(=
)) then you may DMA to/from<BR>that memory using the addresses returned fro=
m those routines."<BR><BR>thanks in advance for ur help<BR>-- <BR>View this=
 message in context: <A href=3D"http://www.nabble.com/When-do-i-need-to-all=
ocate-DMA-buffer-tp21413193p21413193.html"   target=3Dblank  >http://www.na=
bble.com/When-do-i-need-to-allocate-DMA-buffer-tp21413193p21413193.html</A>=
<BR>Sent from the linuxppc-dev mailing list archive at Nabble.com.<BR><BR>=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F<BR>Linux=
ppc-dev mailing list<BR>Linuxppc-dev@ozlabs.org<BR><A href=3D"https://ozlab=
s.org/mailman/listinfo/linuxppc-dev" target=3Dblank >https://ozlabs.org/mai=
lman/listinfo/linuxppc-dev</A><BR></FONT></blockquote><br></DIV></DIV></FON=
T>=
