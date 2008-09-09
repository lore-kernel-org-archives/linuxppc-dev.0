Return-Path: <neerajg@cdac.in>
Received: from mx2.cdac.in (mx2.cdac.in [203.199.132.25])
	by ozlabs.org (Postfix) with ESMTP id E4C17DDF55
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  9 Sep 2008 18:26:04 +1000 (EST)
Received: from mailhub.cdac.in (mailhub [196.1.109.254])by mailhub.cdac.in
	(8.13.4/8.13.4) with ESMTP id m898Q1R1021347for
	<linuxppc-embedded@ozlabs.org>; Tue, 9 Sep 2008 13:56:01 +0530
Message-ID: <48C63317.7080709@cdac.in>
Date: Tue, 09 Sep 2008 13:55:59 +0530
From: Neeraj Garg <neerajg@cdac.in>
MIME-Version: 1.0
To: Georg Schardt <schardt@team-ctech.de>
Subject: Re: EDK10.1 and emaclite
References: <48C5F6ED.4000804@cdac.in> <48C62603.7080606@team-ctech.de>
In-Reply-To: <48C62603.7080606@team-ctech.de>
Content-Type: multipart/alternative;
	boundary=------------070909090004000300060902
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------070909090004000300060902
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


I am using Emac but the configuration is more or less same for the two.

Look at the messages that I am getting at startup

[    3.225313] xilinx_emac xilinx_emac.0: MAC address is now  0:a0:22: 
1: 1:f2
[    3.264036] XEmac: using fifo mode.
[    3.288583] XEmac: *Detected PHY at address 0, ManufID 0x0040, Rev. 
0x61e4*.
[    3.328138] eth0: Dropping NETIF_F_SG since no checksum feature.
[    3.368685] eth0: Xilinx 10/100 EMAC at 0x11000000 mapped to 
0xC3020000, irq=5
[    3.404090] eth0: XEmac id 1.4a, block id 128, type 1

Points that you cant check

First look at ethernet interface RJ45 connector that power is coming, 
LED should blink.

1) check whether IRQ is right, its zero in your case. If it is right 
then issue ping and read interrupts arriving on your ethernet interface 
(cat /proc/interrupts), If number of interrupts are increasing then its 
sure that your PHY is ok , the problem is with mode selection (10 MBPS, 
or 100 MBPS) if that is the issue let me know , I'll tell you where to 
make changes in driver files.

2) If nothing of the above works then there is problem with PHY address 
detection. You have to look in hardware specification (your hardware 
board ) to find out PHY address.


-------------------------------------------------------------------
Neeraj Garg



Georg Schardt wrote:
> Hi again,
>
> mmh, there is no kernel message with PHY detection, but all PHY 
> drivers are compiled in.
> i looked at my xps project and there is only one ip-core 
> "Ethernet_MAC" with type "xps_ethernetlite".
> is it possible that the phy connection is missing ? i use the base 
> system builder with the board support files supported from avnet.
>
> where can i look for the ethernet speed ? the ethernetlite ip has no 
> speed options
>
> thanks for your help
> georg
>
> Neeraj Garg wrote:
>> Hi Georg,
>>
>> Can you post linux bootup message where its says PHY is detected at 
>> paticular address, and check with your hardware what is actual 
>> address of PHY. Also I would like to know the configuration of your 
>> hardware whether its configured of 10MBPS OR 100MBPS.
>>
>>
>> ------------------------------------------------------------------------------------------ 
>>
>> -- 
>> Neeraj Garg
>>
>>
>>
>> Message: 3
>> Date: Mon, 08 Sep 2008 18:29:53 +0200
>> From: Georg Schardt <schardt@team-ctech.de>
>> Subject: EDK10.1 and emaclite
>> To: linuxppc-embedded@ozlabs.org
>> Message-ID: <48C55301.4070208@team-ctech.de>
>> Content-Type: text/plain; charset=ISO-8859-1; format=flowed
>>
>> Hi all,
>>
>> im trying to use the emaclite core which comes with the EDK10.1 with 
>> the 2.6.26 kernel from git.xilinx.com on virtex4fx12 minimodul. the 
>> emac is detect by the kernel:
>>
>> xilinx_emaclite xilinx_emaclite.0: MAC address is now  2: 0: 0: 0: 0: 0
>> xilinx_emaclite xilinx_emaclite.0: using fifo mode.
>> xilinx_emaclite xilinx_emaclite.0: Xilinx EMACLite at 0x81000000 
>> mapped to 0xC5060000, irq=0
>>
>> i can change the mac-address with ifconfig and i can give an 
>> ip-address to the device,
>> but a ping is not possible and arp is not working. i think that the 
>> phy is not working right.
>>
>> has someone others the same problem ? what can i changed ? i have 
>> tried out all possible phy driver in the linux  kernel
>>
>> a setup with the lltemac is working fine, but i want to use the emaclite
>>
>> thanks
>> regards
>> georg
>>

--------------070909090004000300060902
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
<br>
I am using Emac but the configuration is more or less same for the two.<br>
<br>
Look at the messages that I am getting at startup<br>
<br>
[&nbsp;&nbsp;&nbsp; 3.225313] xilinx_emac xilinx_emac.0: MAC address is now&nbsp; 0:a0:22:
1: 1:f2<br>
[&nbsp;&nbsp;&nbsp; 3.264036] XEmac: using fifo mode.<br>
[&nbsp;&nbsp;&nbsp; 3.288583] XEmac: <b>Detected PHY at address 0, ManufID 0x0040,
Rev. 0x61e4</b>.<br>
[&nbsp;&nbsp;&nbsp; 3.328138] eth0: Dropping NETIF_F_SG since no checksum feature.<br>
[&nbsp;&nbsp;&nbsp; 3.368685] eth0: Xilinx 10/100 EMAC at 0x11000000 mapped to
0xC3020000, irq=5<br>
[&nbsp;&nbsp;&nbsp; 3.404090] eth0: XEmac id 1.4a, block id 128, type 1<br>
<br>
Points that you cant check <br>
<br>
First look at ethernet interface RJ45 connector that power is coming,
LED should blink.<br>
<br>
1) check whether IRQ is right, its zero in your case. If it is right
then issue ping and read interrupts arriving on your ethernet interface
(cat /proc/interrupts), If number of interrupts are increasing then its
sure that your PHY is ok , the problem is with mode selection (10 MBPS,
or 100 MBPS) if that is the issue let me know , I'll tell you where to
make changes in driver files.<br>
<br>
2) If nothing of the above works then there is problem with PHY address
detection. You have to look in hardware specification (your hardware
board ) to find out PHY address.<br>
<br>
<div class="moz-signature">
<pre><!-- img src="file:///E:/htdg.jpg" border="0" alt="C-DAC"-->
-------------------------------------------------------------------
Neeraj Garg


</pre>
</div>
Georg Schardt wrote:
<blockquote cite="mid48C62603.7080606@team-ctech.de" type="cite">Hi
again,
  <br>
  <br>
mmh, there is no kernel message with PHY detection, but all PHY drivers
are compiled in.
  <br>
i looked at my xps project and there is only one ip-core "Ethernet_MAC"
with type "xps_ethernetlite".
  <br>
is it possible that the phy connection is missing ? i use the base
system builder with the board support files supported from avnet.
  <br>
  <br>
where can i look for the ethernet speed ? the ethernetlite ip has no
speed options
  <br>
  <br>
thanks for your help
  <br>
georg
  <br>
  <br>
Neeraj Garg wrote:
  <br>
  <blockquote type="cite">Hi Georg,
    <br>
    <br>
Can you post linux bootup message where its says PHY is detected at
paticular address, and check with your hardware what is actual address
of PHY. Also I would like to know the configuration of your hardware
whether its configured of 10MBPS OR 100MBPS.
    <br>
    <br>
    <br>
------------------------------------------------------------------------------------------
    <br>
--&nbsp;<br>
Neeraj Garg
    <br>
    <br>
    <br>
    <br>
Message: 3
    <br>
Date: Mon, 08 Sep 2008 18:29:53 +0200
    <br>
From: Georg Schardt <a class="moz-txt-link-rfc2396E" href="mailto:schardt@team-ctech.de">&lt;schardt@team-ctech.de&gt;</a>
    <br>
Subject: EDK10.1 and emaclite
    <br>
To: <a class="moz-txt-link-abbreviated" href="mailto:linuxppc-embedded@ozlabs.org">linuxppc-embedded@ozlabs.org</a>
    <br>
Message-ID: <a class="moz-txt-link-rfc2396E" href="mailto:48C55301.4070208@team-ctech.de">&lt;48C55301.4070208@team-ctech.de&gt;</a>
    <br>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
    <br>
    <br>
Hi all,
    <br>
    <br>
im trying to use the emaclite core which comes with the EDK10.1 with
the 2.6.26 kernel from git.xilinx.com on virtex4fx12 minimodul. the
emac is detect by the kernel:
    <br>
    <br>
xilinx_emaclite xilinx_emaclite.0: MAC address is now&nbsp; 2: 0: 0: 0: 0: 0
    <br>
xilinx_emaclite xilinx_emaclite.0: using fifo mode.
    <br>
xilinx_emaclite xilinx_emaclite.0: Xilinx EMACLite at 0x81000000 mapped
to 0xC5060000, irq=0
    <br>
    <br>
i can change the mac-address with ifconfig and i can give an ip-address
to the device,
    <br>
but a ping is not possible and arp is not working. i think that the phy
is not working right.
    <br>
    <br>
has someone others the same problem ? what can i changed ? i have tried
out all possible phy driver in the linux&nbsp; kernel
    <br>
    <br>
a setup with the lltemac is working fine, but i want to use the
emaclite
    <br>
    <br>
thanks
    <br>
regards
    <br>
georg
    <br>
    <br>
  </blockquote>
</blockquote>
</body>
</html>

--------------070909090004000300060902--
