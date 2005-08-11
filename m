Return-Path: <murahari@samsung.com>
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	by ozlabs.org (Postfix) with ESMTP id 5356A67ED6
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Aug 2005 13:02:57 +1000 (EST)
Received: from ep_ms13_bk (mailout1.samsung.com [203.254.224.24])
	by mailout1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0IL1009S4EO6G3@mailout1.samsung.com> for
	linuxppc-dev@ozlabs.org; Thu, 11 Aug 2005 11:52:54 +0900 (KST)
Received: from ep_spt01 (ms13.samsung.com [203.254.225.109])
	by ms13.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTP id <0IL100L2HEO6NG@ms13.samsung.com> for
	linuxppc-dev@ozlabs.org; Thu, 11 Aug 2005 11:52:54 +0900 (KST)
Date: Thu, 11 Aug 2005 02:52:47 +0000 (GMT)
From: V MURAHARI <murahari@samsung.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Message-id: <0IL100L2IEO6NG@ms13.samsung.com>
MIME-version: 1.0
Content-type: text/html; charset=windows-1252
Subject: copy_from_user problem
Reply-To: murahari@samsung.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

<HTML><HEAD>
<META http-equiv=Content-Type content='text/html; charset=windows-1252'>
<title>Samsung Enterprise Portal mySingle</title>
<style> P, td, li {font-family:Arial, arial; font-size:9pt; margin-top:5px;margin-bottom:5px;}</style>
</HEAD><BODY><p><p>

Hello,
<p>I am working on a character driver for reading and writing the registers 
to FPGA in our system.</p>
<p>I am using driver ioctl to read/write to these registers of FPGA. As the 
function call to the ioctl is being made, the printk trace shows that the call 
goes to switch-&gt;copy_from_user. As soon as the call is made to copy_from_user, 
the kernel crashes</p>
<p>Can someone help me with this problem?</p>
<p>&nbsp;</p>
<p>***************************************************************************************************</p>
<p>&nbsp;Unhandled kernel unaligned access in unaligned.c::emulate_load_store_insn, 
line 483</p>
<p>:</p>
<p>$0 : 00000000 10001f00 8fbf0034 02a01021 801157a0 8fe8e000 10001f00 ffff00ff</p>
<p>$8 : 8fe8ffe0 00001f00 00000000 00000003 74652053 8fe9fed8 0000000a 50434942</p>
<p>$16: 10001f01 00000001 801157a0 0000000f 8fe8fee8 00000104 00000000 0000000f</p>
<p>$24: 00000000 2ac0fdb0 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;8fe8e000 
8fe8fe38 00000001 8012010c</p>
<p>Hi : 00000000</p>
<p>Lo : 00000000</p>
<p>epc &nbsp;: 8011f774 &nbsp;&nbsp;&nbsp;Tainted: GF</p>
<p>Status: 10001f02</p>
<p>Cause : 00800014</p>
<p>Process rsgbm (pid: 317, stackpage=8fe8e000)</p>
<p>Stack: &nbsp;&nbsp;&nbsp;802d920a 0000000a 10001f01 0000003c 10001f01 0000003c 
8012010c</p>
<p>&nbsp;80120104 caa8f356 8fe82008 8fe82000 0000000f 00000000 7fff7d00 7fff7d00</p>
<p>&nbsp;0000c001 00000003 10012808 ffffffff caa8e548 00004000 8fe9e272 00000150</p>
<p>&nbsp;7fff7d00 ffffffea 00000000 00000240 8fe82000 00000000 00000001 00000001</p>
<p>&nbsp;7ebff310 00000000 0000000f 8fef24e0 00000004 7ebff3e8 00000000 0000002e</p>
<p>&nbsp;80159c6c ...</p>
<p>Call Trace: &nbsp;&nbsp;[&lt;8012010c&gt;] [&lt;80120104&gt;] [&lt;caa8f356&gt;] 
[&lt;caa8e548&gt;] [&lt;80159c6c&gt;]</p>
<p>&nbsp;[&lt;8010a5c4&gt;] [&lt;80271dc4&gt;]</p>
<p>&nbsp;</p>
<p>Code: 8c820004 &nbsp;24110001 &nbsp;ac430000 &lt;ac620004&gt; ac800000 &nbsp;ac800004 
&nbsp;ac800000 &nbsp;ac800004</p>
<p>&nbsp;&nbsp;8f820004</p>
<p>&nbsp;</p>
<p>Unit Fault Handler !!! (INDEX=10)</p>
<p>**************************************************************************************************</p>
<p>int</p>
<p>chr1_ioctl(struct inode *ino, struct file *filp, unsigned int cmd,</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;unsigned long arg)</p>
<p>{</p>
<p>&nbsp;&nbsp;&nbsp;int ret = 0;</p>
<p>&nbsp;&nbsp;&nbsp;n2_debug_rw_reg *dw;</p>
<p>&nbsp;</p>
<p>&nbsp;&nbsp;&nbsp;switch(cmd)</p>
<p>&nbsp;&nbsp;&nbsp;{</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;case IOCTL_WIN_DEBUG_READ_CODE:</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{</p>
<p>&nbsp;&nbsp;&nbsp;n2_debug_rw_reg test;</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;printk(&quot;%s %d\n&quot;, 
current-&gt;comm, current-&gt;pid);</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;printk(&quot;%lx\n&quot;, 
arg);</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;copy_from_user(&amp;test, 
(n2_debug_rw_reg*)arg, sizeof(n2_debug_rw_reg));</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;printk(&quot;%lx %lx\n&quot;, 
((n2_debug_rw_reg*)arg)-&gt;data, ((n2_debug_rw_reg*)arg)-&gt;</p>
<p>addr);</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}</p>
<p>}</p>
<p>}</p>
<p>&nbsp;</p>
<p>Thanks &amp; Regards,</p>
<p>--Murahari</p></BODY></HTML>
