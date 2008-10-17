Return-Path: <BenGardiner@nanometrics.ca>
Message-ID: <48F88F27.4040107@nanometrics.ca>
Date: Fri, 17 Oct 2008 09:12:07 -0400
From: Ben Gardiner <BenGardiner@nanometrics.ca>
MIME-Version: 1.0
To: Ganesh Kumar N M <ganeshkumar@signal-networks.com>
Subject: Re: Loadable module crashes at kernel stack overflow or machine check
References: <004c01c92f92$bca991d0$0d01a8c0@signet>
In-Reply-To: <004c01c92f92$bca991d0$0d01a8c0@signet>
Content-Type: multipart/alternative;
	boundary="------------090406010005070500090005"
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------090406010005070500090005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ganesh Kumar N M wrote:
> *Hi All,*
> ** 
> *    I'm working on MPC860 with Montavista linux 2.4.18*
> *We have a Linux kernel loadable module which on loading*
> *panicks after some random time say 8 hours, 4 hours or so*
> *the oops outputs say either machine check exception or *
> *kernel stack overflow (randomly both show up) a**re as below:* 
I don't know for sure what could be causing your problem. I can only 
suggest some patches that have helped us in the past.

I'm not familiar with Montavista's kernel versions; but I know our 
2.4.24 kernel did not have the 'separate I-TLB error and miss handling' 
patch ( 
http://ozlabs.org/pipermail/linuxppc-embedded/2005-January/016382.html ) 
which caused our applications to segfault for not apparent reason.

I also suggest applying the CPU15 fix ( 
http://git.denx.de/?p=linuxppc_2_4_devel.git;a=commit;h=baf9a6caca75b1f338ae370669e5882809000164 
and 
http://git.denx.de/?p=linuxppc_2_4_devel.git;a=commit;h=3ad403717f1d9c6a09ec41a5b016ac5245591122 
) and enabling it temporarily to see if the problem could be the unlucky 
placement of a branch instruction at the end of a page; but evaluate the 
performance of your application carefully if you are considering running 
production code with the patch enabled as it introduces significant 
overhead.

Regards,

Ben Gardiner
Nanometrics Seismological Instruments
250 Herzberg Rd., Kanata, ON, CA, K2K 2A1

--------------090406010005070500090005
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Ganesh Kumar N M wrote:
<blockquote cite="mid:004c01c92f92$bca991d0$0d01a8c0@signet" type="cite">
  <meta http-equiv="Content-Type" content="text/html; ">
  <meta content="MSHTML 6.00.6000.16640" name="GENERATOR">
  <style></style>
  <div><strong><font face="Courier New" size="2">Hi All,</font></strong></div>
  <div><strong></strong>&nbsp;</div>
  <div><strong><font face="Courier New" size="2">&nbsp;&nbsp;&nbsp; I'm working on
MPC860 with Montavista linux 2.4.18</font></strong></div>
  <div><strong><font face="Courier New" size="2">We have a Linux kernel
loadable module which on loading</font></strong></div>
  <div><strong><font face="Courier New" size="2">panicks after some
random time say 8 hours, 4 hours or so</font></strong></div>
  <div><strong><font face="Courier New" size="2">the oops outputs say
either machine check exception or </font></strong></div>
  <div><strong><font face="Courier New" size="2">kernel stack overflow
(randomly both show up)&nbsp;a</font></strong><strong><font
 face="Courier New" size="2">re as below:</font></strong>&nbsp;</div>
</blockquote>
I don't know for sure what could be causing your problem. I can only
suggest some patches that have helped us in the past.<br>
<br>
I'm not familiar with Montavista's kernel versions; but I know our
2.4.24 kernel did not have the 'separate I-TLB error and miss handling'
patch (
<a class="moz-txt-link-freetext" href="http://ozlabs.org/pipermail/linuxppc-embedded/2005-January/016382.html">http://ozlabs.org/pipermail/linuxppc-embedded/2005-January/016382.html</a>
) which caused our applications to segfault for not apparent reason. <br>
<br>
I also suggest applying the CPU15 fix (
<a class="moz-txt-link-freetext" href="http://git.denx.de/?p=linuxppc_2_4_devel.git;a=commit;h=baf9a6caca75b1f338ae370669e5882809000164">http://git.denx.de/?p=linuxppc_2_4_devel.git;a=commit;h=baf9a6caca75b1f338ae370669e5882809000164</a>
and
<a class="moz-txt-link-freetext" href="http://git.denx.de/?p=linuxppc_2_4_devel.git;a=commit;h=3ad403717f1d9c6a09ec41a5b016ac5245591122">http://git.denx.de/?p=linuxppc_2_4_devel.git;a=commit;h=3ad403717f1d9c6a09ec41a5b016ac5245591122</a>
) and enabling it temporarily to see if the problem could be the
unlucky placement of a branch instruction at the end of a page; but
evaluate the performance of your application carefully if you are
considering running production code with the patch enabled as it
introduces significant overhead.<br>
<br>
Regards,<br>
<br>
Ben Gardiner<br>
Nanometrics Seismological Instruments<br>
250 Herzberg Rd., Kanata, ON, CA, K2K 2A1<br>
</body>
</html>

--------------090406010005070500090005--
