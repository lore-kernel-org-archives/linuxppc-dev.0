Return-Path: <rje@valleytech.com>
Received: from theodore.atlantic.net (theodore.atlantic.net [209.208.106.130])
	by ozlabs.org (Postfix) with SMTP id 550C1DDE19
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  9 Dec 2007 13:55:03 +1100 (EST)
Message-ID: <475B5680.30303@valleytech.com>
Date: Sat, 08 Dec 2007 21:44:16 -0500
From: "R. Ebersole (VTI - new)" <rje@valleytech.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: mmap + segfaults on MPC8349E
Content-Type: multipart/alternative;
	boundary="------------040501020707070505080300"
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
--------------040501020707070505080300
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Hi.

We've run into an .... interesting (and frustrating) occurance recently 
while testing
out a new board (and BSP).   We were wondering if anybody has seen anything
like this.

A description follows:

We wrote some simple drivers/modules to mmap() FPGA registers to user space.
At the moment, for testing, we reserve the upper x-MB of RAM, and mmap() 
there, instead.

We open 4 such devices, and mmap() 64KB of space (memory, in this case) 
for each.
Accessing the first device opened & mmapped was fine.  But accesssing 
the 2nd device
yielded some odd behavior.  We could read and write the first and 3rd 4K 
regions fine, but
if we read from the 2nd one (at offset 0x1000) before we wrote to it, we 
get a segmentation
fault.  If, however, we wrote first (to the 2nd region), then things 
were OK.

Addendum: With the real device, this same behavior happens at the 10th 
4-KB region of the device.
 Without any of the others mmap()-ed.  If we mmap() just that 4-KB 
region, things are fine.  We
can access the region with ioremap() in the driver w/o issues.

We are running on an MPC8349-E.

Any thoughts or ideas?


vti

--

This message contains confidential information and is intended only for the
individual named.  If you are not the intended recipient you should not
disseminate, distribute or copy this e-mail.  Please notify the sender
immediately by e-mail if you have received this e-mail by mistake and delete
this e-mail from your system.



--------------040501020707070505080300
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1">
  <title></title>
</head>
<body text="#000000" bgcolor="#ffffff">
<meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1">
<title></title>
<br>
Hi.<br>
<br>
We've run into an .... interesting (and frustrating) occurance recently
while testing<br>
out a new board (and BSP).&nbsp;&nbsp; We were wondering if anybody has seen
anything <br>
like this.<br>
<br>
A description follows:<br>
<br>
We wrote some simple drivers/modules to mmap() FPGA registers to user
space.<br>
At the moment, for testing, we reserve the upper x-MB of RAM, and
mmap() there, instead.<br>
<br>
We open 4 such devices, and mmap() 64KB of space (memory, in this case)
for each.<br>
Accessing the first device opened &amp; mmapped was fine.&nbsp; But
accesssing the 2nd device<br>
yielded some odd behavior.&nbsp; We could read and write the first and 3rd
4K regions fine, but<br>
if we <i>read</i> from the 2nd one (at offset 0x1000) before we wrote
to it, we get a segmentation<br>
fault.&nbsp; If, however, we wrote first (to the 2nd region), then things
were OK.<br>
<br>
Addendum: With the real device, this same behavior happens at the 10th
4-KB region of the device.<br>
&nbsp;Without any of the others mmap()-ed.&nbsp; If we mmap() just that 4-KB
region, things are fine.&nbsp; We<br>
can access the region with ioremap() in the driver w/o issues.<br>
<br>
We are running on an MPC8349-E.<br>
<br>
Any thoughts or ideas?<br>
<br>
<br>
vti<br>
<br>
<pre class="moz-signature" cols="132">--

This message contains confidential information and is intended only for the
individual named.  If you are not the intended recipient you should not
disseminate, distribute or copy this e-mail.  Please notify the sender
immediately by e-mail if you have received this e-mail by mistake and delete
this e-mail from your system.

</pre>
</body>
</html>

--------------040501020707070505080300--
