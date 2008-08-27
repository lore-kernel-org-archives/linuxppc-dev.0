Return-Path: <d.bosi@selcomgroup.com>
Received: from xseries02.selcomgroup.com (mail.selcomgroup.com [85.18.34.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5674EDE3AF
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Aug 2008 23:58:21 +1000 (EST)
Message-ID: <48B55D6F.3080101@selcomgroup.com>
Date: Wed, 27 Aug 2008 15:58:07 +0200
From: Daniele Bosi <d.bosi@selcomgroup.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Subject: Re: gdb problems with threads on mpc512x
References: <48B28A65.2050409@selcomgroup.com>
	<20080825182053.B804B248CA@gemini.denx.de>
In-Reply-To: <20080825182053.B804B248CA@gemini.denx.de>
Content-Type: text/html; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
I attach the listing of our program, I tried it on ELDK4.2 Freescale
(kernel 2.6.24.6 by Freescale, your rootfs) and it's still giving me
problems: if I issue<br>
br PrintHello<br>
then cont-inue for some times, after a while gdb stops responding and
is not even getting CTRL-C or CTRL-Z.<br>
<br>
Of course the same works fine on i686.<br>
<br>
I tried both gdbserver and gdb and even rebuilt the file with the
target gcc.<br>
<br>
Thank you,<br>
Daniele<br>
<br>
==== CUT HERE ====<br>
#include &lt;stdio.h&gt;<br>
#include &lt;stdlib.h&gt;<br>
#include &lt;unistd.h&gt;<br>
#include &lt;pthread.h&gt;<br>
<br>
#define NUM_THREADS&nbsp;&nbsp;&nbsp;&nbsp; 5<br>
<br>
void *PrintHello(void *threadid)<br>
{<br>
&nbsp;&nbsp;&nbsp; int c = 0;<br>
&nbsp;&nbsp; int tid;<br>
&nbsp;&nbsp; tid = (int)threadid;<br>
<br>
&nbsp;&nbsp; while (++c &lt; 100) {<br>
&nbsp;&nbsp; printf("Hello World! It's me, thread #%d!\n", tid);<br>
&nbsp;&nbsp; sleep (1);<br>
&nbsp;&nbsp; }<br>
&nbsp;&nbsp; pthread_exit(NULL);<br>
}<br>
<br>
int main (int argc, char *argv[])<br>
{<br>
&nbsp;&nbsp;&nbsp; printf ("Hello world\n");<br>
&nbsp;&nbsp; pthread_t threads[NUM_THREADS];<br>
&nbsp;&nbsp; int rc, t;<br>
&nbsp;&nbsp; for(t=0; t&lt;NUM_THREADS; t++){<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf("In main: creating thread %d\n", t);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rc = pthread_create(&amp;threads[t], NULL, PrintHello, (void *)t);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (rc){<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf("ERROR; return code from pthread_create() is %d\n", rc);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; exit(-1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp; }<br>
&nbsp;&nbsp; pthread_exit(NULL);<br>
}<br>
<br>
==== CUT HERE ====<br>
<br>
Wolfgang Denk ha scritto:
<blockquote cite="mid:20080825182053.B804B248CA@gemini.denx.de"
 type="cite">
  <pre wrap="">Dear Daniele Bosi,

In message <a class="moz-txt-link-rfc2396E" href="mailto:48B28A65.2050409@selcomgroup.com">&lt;48B28A65.2050409@selcomgroup.com&gt;</a> you wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">&lt;!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"&gt;
&lt;html&gt;
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Please post plain text only on mailing lists.

  </pre>
  <blockquote type="cite">
    <pre wrap="">I encountered several problem debugging multithreated software with gdb
on mpc512x, remotely (gdbserver) and locally.&lt;br&gt;
I built gdb 6.8 from scratch, but it's crashing when I stop execution
into a thread.&lt;br&gt;
&lt;br&gt;
Did anyone get it to work correctly?&lt;br&gt;
    </pre>
  </blockquote>
  <pre wrap=""><!---->
We use GDB 6.7 in our ELDK 4.2; we didn't encounter such problems in
our tests.

Best regards,

Wolfgang Denk

  </pre>
</blockquote>
<br>
<div class="moz-signature">-- <br>
<div class="Section1"><br>
<br>
<hr>
<h1><span style="font-size: 10pt;">Daniele Bosi<o:p></o:p></span></h1>
<p class="MsoNormal"><b><span
 style="font-size: 10pt; font-family: Verdana;">DIGITEK S.p.A.</span></b></p>
<p class="MsoNormal"><span style="font-size: 7pt; font-family: Verdana;">Via
L. Romagnoli 24, <br>
41033 Concordia sulla Secchia <br>
Modena (MO), Italy<o:p></o:p></span></p>
<p class="MsoNormal"><b><span
 style="font-size: 7pt; font-family: Verdana;" lang="EN-GB">Tel</span></b><span
 style="font-size: 7pt; font-family: Verdana;" lang="EN-GB">:
+39-(0)53556942 Fax. +39-(0)53554550<o:p></o:p></span></p>
<p class="MsoNormal"><b><span
 style="font-size: 7pt; font-family: Verdana;" lang="EN-GB">Web:<span
 style="">&nbsp;&nbsp;&nbsp; </span></span></b><span
 style="font-size: 7pt; font-family: Verdana;" lang="EN-GB"><span
 style="">&nbsp;</span></span><span
 style="font-size: 7pt; font-family: Verdana;"><a
 href="http://www.digitek.it"><span style="" lang="EN-GB">http://www.digitek.it</span></a></span><span
 style="font-size: 7pt; font-family: Verdana;" lang="EN-GB"><o:p></o:p></span></p>
<!--<p class=MsoNormal><b><span lang=EN-GB style='font-size:7.0pt;mso-bidi-font-size:
		15.0pt;font-family:Verdana;mso-ansi-language:EN-GB'>Mail to:</span></b><span
		lang=EN-GB style='font-size:7.0pt;mso-bidi-font-size:15.0pt;font-family:Verdana;
		mso-ansi-language:EN-GB'> </span><span style='font-size:7.0pt;mso-bidi-font-size:
		15.0pt;font-family:Verdana'><a href="mailto:danielebosi@digitek.it"><span
		lang=EN-GB style='mso-ansi-language:EN-GB'>danielebosi@digitek.it</span></a></span><span
		lang=EN-GB style='font-size:7.0pt;mso-bidi-font-size:12.0pt;mso-ansi-language:
		EN-GB'><o:p></o:p></span></p>-->
<p class="MsoNormal"><b><span
 style="font-size: 7pt; font-family: Verdana;" lang="EN-GB">Mail to:</span></b><span
 style="font-size: 7pt; font-family: Verdana;" lang="EN-GB"> </span><span
 style="font-size: 7pt; font-family: Verdana;"><a
 href="mailto:d.bosi@selcomgroup.com"><span style="" lang="EN-GB">d.bosi@selcomgroup.com</span></a></span><span
 style="font-size: 7pt;" lang="EN-GB"><o:p></o:p></span></p>
</div>
</div>
</body>
</html>
