Return-Path: <0x0000@163.com>
Received: from m12-11.163.com (m12-11.163.com [220.181.12.11])
	by ozlabs.org (Postfix) with SMTP id AF66EDDE0A
	for <linuxppc-dev@ozlabs.org>; Mon, 11 May 2009 22:52:48 +1000 (EST)
Date: Mon, 11 May 2009 20:36:58 +0800
From: "0x0000" <0x0000@163.com>
To: "linuxppc-dev" <linuxppc-dev@ozlabs.org>
Subject: some questions about the implementation of oprofile of mpc8560 in
	linux kernel source code
Message-ID: <200905112036570173816@163.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="=====003_Dragon502454831168_====="
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This is a multi-part message in MIME format.

--=====003_Dragon502454831168_=====
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dear All,

I am a user of oprofile. When I use oprofile, I find some problems. Could you please help me? 

I have some questions about the open source code of the implementation of oprofile in linux 
kernel 2.6.26, which is presented op_model_fsl_emb.c, and the path in linux kernel source 
tree is arch/powerpc/oprofile/op_model_fsl_emb.c. 

To present this question more clearly, It needs the following steps: 

1> I give some cpu event and its counter values, which finally will call the function fsl_emb_reg_setup 

2> I execute setup, which finally will call the function fsl_emb_cpu_setup 

3> I execute start, which finally will call the function fsl_emb_start 

4> After calling start, the MPC8560 CPU will continuing increasing the PMCn value until its value reach 
0x80000000. Basing on what metioned in E500CORERM.pdf, this value should cause a exception, and 
should goto the interrupt routine:fsl_emb_handle_interrupt. 
But in fact, It never goto this interrupt routine! It always cause a reboot without any information! 

But while we using MPC7450 CPU, this situation never happened, it works well. 


Basing on the information metioned above, my questions are: 
1> Is there any bug in op_model_fsl_emb.c and its related source code? 
2> If possible, could you please tell me what the reason it is? And How to use op_model_fsl_emb.c correctly? 


Any feedback is appreciated! 

Thanks & regards 
Jike

2009-05-11 



0x0000 

--=====003_Dragon502454831168_=====
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=Content-Type content="text/html; charset=us-ascii">
<META content="MSHTML 6.00.2900.3527" name=GENERATOR><LINK 
href="BLOCKQUOTE{margin-Top: 0px; margin-Bottom: 0px; margin-Left: 2em}" 
rel=stylesheet></HEAD>
<BODY style="FONT-SIZE: 10pt; MARGIN: 10px; FONT-FAMILY: verdana">
<DIV><FONT face=Verdana size=2>
<DIV><FONT face=Verdana size=2>Dear All,</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV style="TEXT-INDENT: 2em">I am a user of oprofile. When I use oprofile, I 
find some problems. Could you please help me? </DIV>
<DIV style="TEXT-INDENT: 2em">&nbsp;</DIV>
<DIV style="TEXT-INDENT: 2em">I have some questions about the open source code 
of the implementation of oprofile in linux </DIV>
<DIV style="TEXT-INDENT: 2em">kernel 2.6.26, which is presented 
op_model_fsl_emb.c, and the path in linux kernel source </DIV>
<DIV style="TEXT-INDENT: 2em">tree is arch/powerpc/oprofile/op_model_fsl_emb.c. 
</DIV>
<DIV style="TEXT-INDENT: 2em">&nbsp;</DIV>
<DIV style="TEXT-INDENT: 2em">To present this question more clearly, It needs 
the following steps: <BR><BR>1&gt; I give some cpu event and its counter values, 
which finally will call the function fsl_emb_reg_setup <BR><BR>2&gt; I execute 
setup, which finally will call the function fsl_emb_cpu_setup <BR><BR>3&gt; I 
execute start, which finally will call the function fsl_emb_start <BR><BR>4&gt; 
After calling start, the MPC8560 CPU will continuing increasing the PMCn value 
until its value reach <BR>0x80000000. Basing on what metioned in E500CORERM.pdf, 
this value should cause a exception, and <BR>should goto the interrupt 
routine:fsl_emb_handle_interrupt. <BR>But in fact, It never goto this interrupt 
routine! It always cause a reboot without any information! <BR><BR>But while we 
using MPC7450 CPU, this situation never happened, it works well. 
<BR><BR><BR>Basing on the information metioned above, my questions are: 
<BR>1&gt; Is there any bug in op_model_fsl_emb.c and its related source code? 
<BR>2&gt; If possible, could you please tell me what the reason it is? And How 
to use op_model_fsl_emb.c correctly? <BR><BR><BR>Any feedback is appreciated! 
<BR><BR>Thanks &amp; regards <BR>Jike</DIV></FONT></DIV>
<DIV><FONT face=Verdana size=2></FONT>&nbsp;</DIV>
<DIV align=left><FONT face=Verdana color=#c0c0c0 size=2>2009-05-11 
</FONT></DIV><FONT face=Verdana size=2>
<HR style="WIDTH: 122px; HEIGHT: 2px" align=left SIZE=2>

<DIV><FONT face=Verdana color=#c0c0c0 size=2><SPAN>0x0000</SPAN> 
</FONT></DIV></FONT></BODY></HTML>

--=====003_Dragon502454831168_=====--
