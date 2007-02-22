Return-Path: <Manjunath.AM@Lntemsys.com>
In-Reply-To: <556445368AFA1C438794ABDA8901891C03445716@usa0300ms03.na.xerox.net>
To: "Leisner, Martin" <Martin.Leisner@xerox.com>
Subject: RE: enabling two eths
MIME-Version: 1.0
Message-ID: <OFBE288479.DC0A765B-ON6525728A.0017B972-6525728A.00180C87@lntemsys.com>
From: Manjunath AM <Manjunath.AM@Lntemsys.com>
Date: Thu, 22 Feb 2007 09:54:21 +0530
Content-Type: multipart/alternative;
	boundary="=_alternative 00180C866525728A_="
Cc: linuxppc-embedded-bounces+manjunath.am=lntemsys.com@ozlabs.org,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.
--=_alternative 00180C866525728A_=
Content-Type: text/plain; charset="US-ASCII"

Hi Martin,

Thanks for your reply,Yes I tried swapping the assignments,same thing is 
happening in both cases..ifconfig and route -n results are as below:


ifconfig

eth0      Link encap:Ethernet  HWaddr 00:99:23:C4:AD:DE
          inet addr:192.168.33.64  Bcast:192.168.33.255 Mask:255.255.248.0
          inet6 addr: fe80::299:23ff:fec4:adde/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:0 (0.0 b)  TX bytes:308 (308.0 b)
          Base address:0x8400

eth1      Link encap:Ethernet  HWaddr 00:99:23:44:AD:DE
          inet addr:192.168.178.124  Bcast:192.168.178.255 
Mask:255.255.255.0
          inet6 addr: fe80::299:23ff:fe44:adde/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:22790 errors:0 dropped:0 overruns:0 frame:0
          TX packets:9218 errors:0 dropped:0 overruns:0 carrier:8830
          collisions:0 txqueuelen:1000
          RX bytes:14916045 (14.2 MiB)  TX bytes:1463093 (1.3 MiB)
          Base address:0x8500

lo        Link encap:Local Loopback
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)

route -n
Destination     Gateway         Genmask         Flags Metric Ref    Use 
Iface
192.168.178.0   0.0.0.0         255.255.255.0   U     0      0        0 
eth1
192.168.32.0    0.0.0.0         255.255.248.0   U     0      0        0 
eth0
0.0.0.0         192.168.178.47  0.0.0.0         UG    0      0        0 
eth1



Thanks & Regards
 MANJUNATH AM
 Senior Software Engineer
 Emsys
 Larsen & Toubro Limited
 Mysore-570018
 Mobile:9886375926




"Leisner, Martin" <Martin.Leisner@xerox.com> 
Sent by: linuxppc-embedded-bounces+manjunath.am=lntemsys.com@ozlabs.org
02/21/2007 09:58 PM

To
"Manjunath AM" <Manjunath.AM@Lntemsys.com>, "Vitaly Bordug" 
<vbordug@ru.mvista.com>
cc
linuxppc-embedded@ozlabs.org
Subject
RE: enabling two eths






 
Send the results of 
ifconfig
and
route -n
 
I take it eth0 works fine...
 
Have you tried swapping the assignments and see if eth1 works (to 
eliminate faulty hardware).
 
marty

From: linuxppc-embedded-bounces+martin.leisner=xerox.com@ozlabs.org 
[mailto:linuxppc-embedded-bounces+martin.leisner=xerox.com@ozlabs.org] On 
Behalf Of Manjunath AM
Sent: Tuesday, February 20, 2007 11:50 PM
To: Vitaly Bordug
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: enabling two eths


Hi, Thanks for your kind reply, Yes i have used different * IP Subnets* 

The IPs and subnet details I use is 
1. eth0(configured through u-boot env settings)->> 192.168.174.231 and 
subnet is 255.255.255.0 
2. eth1(configured after kernel is up)--> 192.168.33.64 and subnet is 
255.255.248.0 

Even i tried by connecting second eth to host PC using cross cable as a 
stand-alone network but even "ping" did not work.. 



Thanks & Regards
MANJUNATH AM
Senior Software Engineer
Emsys
Larsen & Toubro Limited
Mysore-570018
Mobile:9886375926



Vitaly Bordug <vbordug@ru.mvista.com> 
02/20/2007 09:30 PM 


To
Alex Zeffertt <ajz@cambridgebroadband.com> 
cc
Manjunath AM <Manjunath.AM@Lntemsys.com>, linuxppc-embedded@ozlabs.org 
Subject
Re: enabling two eths








On Tue, 20 Feb 2007 15:31:54 +0000
Alex Zeffertt <ajz@cambridgebroadband.com> wrote:

> 
> Manjunath AM wrote:
> > 
> > Hi,
> > 
> > We are using MPC8272 based target board, we use montavista Linux 
version 
> > 2.6.10 kernel image (with NFS enabled) to our target board,
> > 
> > Our board has  2 FCCs (eth0 and eth1). bot the eth's works perfectly 
> > when we use them independently, but when we are trying to enable 
second 
> > one after the kernel is up using linux command  "ifconfig eth1 
> > 192.168.33.64 up"(IP address)nothing is working.
> > Please suggest how to enable second eth (either 0 or 1) once the 
kernel 
> > is up with NFS file system
> 
> 
> Have you made sure that eth0 and eth1 are on *different* IP subnets?
> If they are on the same subnet, or intersecting subnets, your routing
> will get confused.
> 
It depends :)

I used to test functionality such a way to have two enets in same subnet, 
then ifdown one of them.

At least with mvista RFS, one enet  handles NFS, other is up but all the 
packets are routed to it via
the first one. And when the first one got ifdown, routing switches to the 
remaining enet...
-- 
Sincerely, 
Vitaly
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded

--=_alternative 00180C866525728A_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">Hi Martin,</font>
<br>
<br><font size=2 face="sans-serif">Thanks for your reply,Yes I tried swapping
the assignments,same thing is happening in both cases..ifconfig and route
-n results are as below:</font>
<br>
<br>
<br><font size=2 color=blue face="Arial"><b>ifconfig</b></font>
<br>
<br><font size=2 face="sans-serif">eth0 &nbsp; &nbsp; &nbsp;Link encap:Ethernet
&nbsp;HWaddr 00:99:23:C4:AD:DE</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; inet
addr:192.168.33.64 &nbsp;Bcast:192.168.33.255 &nbsp;Mask:255.255.248.0</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; inet6
addr: fe80::299:23ff:fec4:adde/64 Scope:Link</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; UP
BROADCAST RUNNING MULTICAST &nbsp;MTU:1500 &nbsp;Metric:1</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; RX
packets:0 errors:0 dropped:0 overruns:0 frame:0</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; TX
packets:0 errors:0 dropped:0 overruns:0 carrier:0</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; collisions:0
txqueuelen:1000</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; RX
bytes:0 (0.0 b) &nbsp;TX bytes:308 (308.0 b)</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Base
address:0x8400</font>
<br>
<br><font size=2 face="sans-serif">eth1 &nbsp; &nbsp; &nbsp;Link encap:Ethernet
&nbsp;HWaddr 00:99:23:44:AD:DE</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; inet
addr:192.168.178.124 &nbsp;Bcast:192.168.178.255 &nbsp;Mask:255.255.255.0</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; inet6
addr: fe80::299:23ff:fe44:adde/64 Scope:Link</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; UP
BROADCAST RUNNING MULTICAST &nbsp;MTU:1500 &nbsp;Metric:1</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; RX
packets:22790 errors:0 dropped:0 overruns:0 frame:0</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; TX
packets:9218 errors:0 dropped:0 overruns:0 carrier:8830</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; collisions:0
txqueuelen:1000</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; RX
bytes:14916045 (14.2 MiB) &nbsp;TX bytes:1463093 (1.3 MiB)</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Base
address:0x8500</font>
<br>
<br><font size=2 face="sans-serif">lo &nbsp; &nbsp; &nbsp; &nbsp;Link encap:Local
Loopback</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; inet6
addr: ::1/128 Scope:Host</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; UP
LOOPBACK RUNNING &nbsp;MTU:16436 &nbsp;Metric:1</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; RX
packets:0 errors:0 dropped:0 overruns:0 frame:0</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; TX
packets:0 errors:0 dropped:0 overruns:0 carrier:0</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; collisions:0
txqueuelen:0</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; RX
bytes:0 (0.0 b) &nbsp;TX bytes:0 (0.0 b)</font>
<br>
<br><font size=2 color=blue face="Arial"><b>route -n</b></font>
<br><font size=2 face="sans-serif">Destination &nbsp; &nbsp; Gateway &nbsp;
&nbsp; &nbsp; &nbsp; Genmask &nbsp; &nbsp; &nbsp; &nbsp; Flags Metric Ref
&nbsp; &nbsp;Use Iface</font>
<br><font size=2 face="sans-serif">192.168.178.0 &nbsp; 0.0.0.0 &nbsp;
&nbsp; &nbsp; &nbsp; 255.255.255.0 &nbsp; U &nbsp; &nbsp; 0 &nbsp; &nbsp;
&nbsp;0 &nbsp; &nbsp; &nbsp; &nbsp;0 eth1</font>
<br><font size=2 face="sans-serif">192.168.32.0 &nbsp; &nbsp;0.0.0.0 &nbsp;
&nbsp; &nbsp; &nbsp; 255.255.248.0 &nbsp; U &nbsp; &nbsp; 0 &nbsp; &nbsp;
&nbsp;0 &nbsp; &nbsp; &nbsp; &nbsp;0 eth0</font>
<br><font size=2 face="sans-serif">0.0.0.0 &nbsp; &nbsp; &nbsp; &nbsp;
192.168.178.47 &nbsp;0.0.0.0 &nbsp; &nbsp; &nbsp; &nbsp; UG &nbsp; &nbsp;0
&nbsp; &nbsp; &nbsp;0 &nbsp; &nbsp; &nbsp; &nbsp;0 eth1</font>
<br>
<br>
<br>
<br><font size=2 face="sans-serif">Thanks &amp; Regards<br>
 MANJUNATH AM<br>
 Senior Software Engineer<br>
 Emsys<br>
 Larsen &amp; Toubro Limited<br>
 Mysore-570018<br>
 Mobile:9886375926<br>
</font>
<br>
<br>
<br>
<table width=100%>
<tr valign=top>
<td width=40%><font size=1 face="sans-serif"><b>&quot;Leisner, Martin&quot;
&lt;Martin.Leisner@xerox.com&gt;</b> </font>
<br><font size=1 face="sans-serif">Sent by: linuxppc-embedded-bounces+manjunath.am=lntemsys.com@ozlabs.org</font>
<p><font size=1 face="sans-serif">02/21/2007 09:58 PM</font>
<td width=59%>
<table width=100%>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">To</font></div>
<td><font size=1 face="sans-serif">&quot;Manjunath AM&quot; &lt;Manjunath.AM@Lntemsys.com&gt;,
&quot;Vitaly Bordug&quot; &lt;vbordug@ru.mvista.com&gt;</font>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">cc</font></div>
<td><font size=1 face="sans-serif">linuxppc-embedded@ozlabs.org</font>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">Subject</font></div>
<td><font size=1 face="sans-serif">RE: enabling two eths</font></table>
<br>
<table>
<tr valign=top>
<td>
<td></table>
<br></table>
<br>
<br>
<br><font size=3>&nbsp;</font>
<br><font size=2 color=blue face="Arial">Send the results of </font>
<br><font size=2 color=blue face="Arial">ifconfig</font>
<br><font size=2 color=blue face="Arial">and</font>
<br><font size=2 color=blue face="Arial">route -n</font>
<br><font size=3>&nbsp;</font>
<br><font size=2 color=blue face="Arial">I take it eth0 works fine...</font>
<br><font size=3>&nbsp;</font>
<br><font size=2 color=blue face="Arial">Have you tried swapping the assignments
and see if eth1 works (to eliminate faulty hardware).</font>
<br><font size=3>&nbsp;</font>
<br><font size=2 color=blue face="Arial">marty</font>
<br>
<br>
<hr><font size=2 face="Tahoma"><b>From:</b> linuxppc-embedded-bounces+martin.leisner=xerox.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+martin.leisner=xerox.com@ozlabs.org]
<b>On Behalf Of </b>Manjunath AM<b><br>
Sent:</b> Tuesday, February 20, 2007 11:50 PM<b><br>
To:</b> Vitaly Bordug<b><br>
Cc:</b> linuxppc-embedded@ozlabs.org<b><br>
Subject:</b> Re: enabling two eths</font><font size=3><br>
</font>
<br><font size=2 face="sans-serif"><br>
Hi, Thanks for your kind reply, Yes i have used different * IP Subnets*</font><font size=3>
<br>
</font><font size=2 face="sans-serif"><br>
The IPs and subnet details I use is</font><font size=3> </font><font size=2 face="sans-serif"><br>
1. eth0(configured through u-boot env settings)-&gt;&gt; 192.168.174.231
and subnet is 255.255.255.0 <br>
2. eth1(configured after kernel is up)--&gt; 192.168.33.64 and subnet is
255.255.248.0</font><font size=3> <br>
</font><font size=2 face="sans-serif"><br>
Even i tried by connecting second eth to host PC using cross cable as a
stand-alone network but even &quot;ping&quot; did not work.. </font><font size=3><br>
<br>
<br>
</font><font size=2 face="sans-serif"><br>
Thanks &amp; Regards<br>
MANJUNATH AM<br>
Senior Software Engineer<br>
Emsys<br>
Larsen &amp; Toubro Limited<br>
Mysore-570018<br>
Mobile:9886375926</font><font size=3><br>
<br>
<br>
</font>
<table width=100%>
<tr valign=top>
<td width=34%><font size=1 face="sans-serif"><b>Vitaly Bordug &lt;vbordug@ru.mvista.com&gt;</b>
</font>
<p><font size=1 face="sans-serif">02/20/2007 09:30 PM</font><font size=3>
</font>
<td width=65%>
<br>
<table width=100%>
<tr valign=top>
<td width=8%>
<div align=right><font size=1 face="sans-serif">To</font></div>
<td width=91%><font size=1 face="sans-serif">Alex Zeffertt &lt;ajz@cambridgebroadband.com&gt;</font><font size=3>
</font>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">cc</font></div>
<td><font size=1 face="sans-serif">Manjunath AM &lt;Manjunath.AM@Lntemsys.com&gt;,
linuxppc-embedded@ozlabs.org</font><font size=3> </font>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">Subject</font></div>
<td><font size=1 face="sans-serif">Re: enabling two eths</font></table>
<br>
<br>
<table width=100%>
<tr valign=top>
<td width=50%>
<td width=50%></table>
<br></table>
<br><font size=3><br>
<br>
</font><font size=2><tt><br>
On Tue, 20 Feb 2007 15:31:54 +0000<br>
Alex Zeffertt &lt;ajz@cambridgebroadband.com&gt; wrote:<br>
<br>
&gt; <br>
&gt; Manjunath AM wrote:<br>
&gt; &gt; <br>
&gt; &gt; Hi,<br>
&gt; &gt; <br>
&gt; &gt; We are using MPC8272 based target board, we use montavista Linux
version <br>
&gt; &gt; 2.6.10 kernel image (with NFS enabled) to our target board,<br>
&gt; &gt; <br>
&gt; &gt; Our board has &nbsp;2 FCCs (eth0 and eth1). bot the eth's works
perfectly <br>
&gt; &gt; when we use them independently, but when we are trying to enable
second <br>
&gt; &gt; one after the kernel is up using linux command &nbsp;&quot;ifconfig
eth1 <br>
&gt; &gt; 192.168.33.64 up&quot;(IP address)nothing is working.<br>
&gt; &gt; Please suggest how to enable second eth (either 0 or 1) once
the kernel <br>
&gt; &gt; is up with NFS file system<br>
&gt; <br>
&gt; <br>
&gt; Have you made sure that eth0 and eth1 are on *different* IP subnets?<br>
&gt; If they are on the same subnet, or intersecting subnets, your routing<br>
&gt; will get confused.<br>
&gt; <br>
It depends :)<br>
<br>
I used to test functionality such a way to have two enets in same subnet,
then ifdown one of them.<br>
<br>
At least with mvista RFS, one enet &nbsp;handles NFS, other is up but all
the packets are routed to it via<br>
the first one. And when the first one got ifdown, routing switches to the
remaining enet...<br>
-- <br>
Sincerely, <br>
Vitaly</tt></font><font size=3><br>
</font><font size=2><tt>_______________________________________________<br>
Linuxppc-embedded mailing list<br>
Linuxppc-embedded@ozlabs.org<br>
https://ozlabs.org/mailman/listinfo/linuxppc-embedded</tt></font>
<br>
--=_alternative 00180C866525728A_=--
