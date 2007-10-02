Return-Path: <Bernard.Willaert@barco.com>
Received: from kuuvir01.barco.com (kuumail.barco.com [32.58.34.195])
	by ozlabs.org (Postfix) with SMTP id 72195DDECC
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 17:48:00 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C804C7.A45DC099"
Subject: Stdout console clogging => 300ms blocked
Date: Tue, 2 Oct 2007 09:41:28 +0200
Message-ID: <8D433CD511BE4646B47F8B31C900818ECB97AF@kndmex01.barco.com>
From: "Willaert, Bernard" <Bernard.Willaert@barco.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C804C7.A45DC099
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

System details:
Freescale MPC8347@200MHz
Kernel 2.6.18

Problem:
When we log debug output via the serial console on a multithreaded
application, the console throughput may get clogged and then we
experience a >300ms deadlock.

Quick and dirty test program: threadtest.c:
//----------------------------------------------------------------------
-------------------------
#include <pthread.h>
#include <stdio.h>
#include <sys/time.h>

#define THREAD_DELAY 1000

void* thread_1(void* unused)
{
	while (1)
	{
		usleep(THREAD_DELAY);
		fprintf(stdout," <----- thread 1\n");
	}
	return NULL;
}

void* thread_2(void* unused)
{
	static long ts_old;
	long ts;
	struct timeval tv;

	while (1)
	{
		usleep(THREAD_DELAY);
		fprintf(stdout," <----- thread 2\n");

		gettimeofday (&tv, NULL);
		ts =3D (tv.tv_sec * 1000L) + (tv.tv_usec / 1000L);
		if ((ts - ts_old) > 100)
		{
			fprintf(stdout, "!!!!!!!!!!! thread2 interval
timeout =3D %d ms\n",(int)(ts - ts_old));
		}
		ts_old =3D ts;
	}
	return NULL;		=09

}



int main()
{
	pthread_t pthread_id_1, pthread_id_2;
=09
	pthread_create(&pthread_id_1,NULL,&thread_1,NULL);
	pthread_create(&pthread_id_2,NULL,&thread_2,NULL);
	while (1)
	{
	}
	return 0;

}

//----------------------------------------------------------------------
-------------------------

Build command on our platform:=20
powerpc-linux-uclibc-gcc threadtest.c  -lpthread -o threadtest
Execute: ./threadtest > /dev/console &

Uboot settings for the serial console:
consoledev=3DttyS0
baudrate=3D115200
stdin=3Dserial
stdout=3Dserial
stderr=3Dserial
boot_go=3Dsetenv bootargs console=3D$consoledev,$baudrate $args_rtc
$args_mtd $args_nfs $args_debug;bootm $addr_kernel $addr_root $addr_dtb


Expected output [snippet] on the console:
.... /\ ........
 <----- thread 1
 <----- thread 2
 <----- thread 1
 <----- thread 2
 <----- thread 1
 <----- thread 2
 <----- thread 1
 <----- thread 2
 <----- thread 1
 <----- thread 2
 <----- thread 1
.... /\ ........

Real output on the console:

.... /\ ........
 <----- thread 1
 <----- thread 2
 <----- thread 1
 <----- thread 2
 <----- thread 1
 <----- thread 2
!!!!!!!!!!! thread2 interval timeout =3D 335 ms
 <----- thread 1
 <----- thread 2
 <----- thread 1
 <----- thread 2
 <----- thread 1
.... /\ ........=20

This timeout shows up around every second and has always about the same
value of 335 ms.
Can somebody reproduce this behaviour ( the console speed and/or thread
interval may have to be tweaked to clog the serial output) ?
Thank you in advance for your help.
Bernard




-----------------------------------------------------------
Bernard Willaert
Software Development Engineer Modality OEM Solutions
BARCO Medical Imaging Division
President Kennedypark 35 - B-8500 KORTRIJK - BELGIUM
Tel.  +32 56 233 439  Fax +32 56 233 457
www.barco.com/medical
mailto:bernard.willaert@barco.com





DISCLAIMER:
Unless indicated otherwise, the information contained in this message is =
privileged and confidential, and is intended only for the use of the =
addressee(s) named above and others who have been specifically =
authorized to receive it. If you are not the intended recipient, you are =
hereby notified that any dissemination, distribution or copying of this =
message and/or attachments is strictly prohibited. The company accepts =
no liability for any damage caused by any virus transmitted by this =
email. Furthermore, the company does not warrant a proper and complete =
transmission of this information, nor does it accept liability for any =
delays. If you have received this message in error, please contact the =
sender and delete the message. Thank you.

------_=_NextPart_001_01C804C7.A45DC099
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7652.24">
<TITLE>Stdout console clogging =3D&gt; 300ms blocked</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Arial">System details:</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Freescale MPC8347@200MHz</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Kernel 2.6.18</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Problem:</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">When we log debug output via the =
serial console on a multithreaded application, the console throughput =
may get clogged and then we experience a &gt;300ms deadlock.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Quick and dirty test program: =
threadtest.c:</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">//--------------------------------------------------------=
---------------------------------------</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">#include &lt;pthread.h&gt;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">#include &lt;stdio.h&gt;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">#include &lt;sys/time.h&gt;</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">#define THREAD_DELAY 1000</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">void* thread_1(void* unused)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">{</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Arial">while (1)</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Arial">{</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Arial">usleep(THREAD_DELAY);</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Arial">fprintf(stdout,&quot; &lt;----- thread 1\n&quot;);</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Arial">}</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Arial">return NULL;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">}</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">void* thread_2(void* unused)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">{</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Arial">static long ts_old;</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Arial">long ts;</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Arial">struct timeval tv;</FONT>
</P>

<P>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Arial">while (1)</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Arial">{</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Arial">usleep(THREAD_DELAY);</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Arial">fprintf(stdout,&quot; &lt;----- thread 2\n&quot;);</FONT>
</P>

<P>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Arial">gettimeofday (&amp;tv, NULL);</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Arial">ts =3D (tv.tv_sec * 1000L) + (tv.tv_usec / 1000L);</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Arial">if ((ts - ts_old) &gt; 100)</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Arial">{</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Arial">fprintf(stdout, &quot;!!!!!!!!!!! thread2 interval =
timeout =3D %d ms\n&quot;,(int)(ts - ts_old));</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Arial">}</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Arial">ts_old =3D ts;</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Arial">}</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Arial">return NULL;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">}</FONT>
</P>
<BR>
<BR>

<P><FONT SIZE=3D2 FACE=3D"Arial">int main()</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">{</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Arial">pthread_t pthread_id_1, pthread_id_2;</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Arial">pthread_create(&amp;pthread_id_1,NULL,&amp;thread_1,NULL);=
</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Arial">pthread_create(&amp;pthread_id_2,NULL,&amp;thread_2,NULL);=
</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Arial">while (1)</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Arial">{</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Arial">}</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Arial">return 0;</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">}</FONT>
</P>

<P><FONT SIZE=3D2 =
FACE=3D"Arial">//--------------------------------------------------------=
---------------------------------------</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">Build command on our platform: =
</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">powerpc-linux-uclibc-gcc =
threadtest.c&nbsp; -lpthread -o threadtest</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">Execute: ./threadtest &gt; =
/dev/console &amp;</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">Uboot settings for the serial =
console:</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">consoledev=3DttyS0</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">baudrate=3D115200</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">stdin=3Dserial</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">stdout=3Dserial</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">stderr=3Dserial</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">boot_go=3Dsetenv bootargs =
console=3D$consoledev,$baudrate $args_rtc $args_mtd $args_nfs =
$args_debug;bootm $addr_kernel $addr_root $addr_dtb</FONT></P>
<BR>

<P><FONT SIZE=3D2 FACE=3D"Courier New">Expected output [snippet] on the =
console:</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">.... /\ ........</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&lt;----- thread 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&lt;----- thread 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&lt;----- thread 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&lt;----- thread 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&lt;----- thread 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&lt;----- thread 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&lt;----- thread 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&lt;----- thread 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&lt;----- thread 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&lt;----- thread 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&lt;----- thread 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">.... /\ ........</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">Real output on the =
console:</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">.... /\ ........</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&lt;----- thread 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&lt;----- thread 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&lt;----- thread 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&lt;----- thread 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&lt;----- thread 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&lt;----- thread 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">!!!!!!!!!!! thread2 interval =
timeout =3D 335 ms</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&lt;----- thread 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&lt;----- thread 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&lt;----- thread 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&lt;----- thread 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&lt;----- thread 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">.... /\ ........ </FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">This timeout shows up around =
every second and has always about the same value of 335 ms.</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">Can somebody reproduce this =
behaviour ( the console speed and/or thread interval may have to be =
tweaked to clog the serial output) ?</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">Thank you in advance for your =
help.</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">Bernard</FONT>
</P>
<BR>
<BR>
<BR>

<P><B><FONT SIZE=3D1 =
FACE=3D"Verdana">--------------------------------------------------------=
---</FONT></B>

<BR><B><SPAN LANG=3D"fr-be"><FONT SIZE=3D1 FACE=3D"Verdana">Bernard =
Willaert<BR>
</FONT></SPAN></B><SPAN LANG=3D"fr-be"></SPAN><SPAN LANG=3D"en-us"><FONT =
COLOR=3D"#808080" SIZE=3D1 FACE=3D"Verdana">Software Development =
Engineer Modality OEM Solutions</FONT></SPAN>

<BR><SPAN LANG=3D"fr-be"><FONT SIZE=3D1 FACE=3D"Verdana">BARCO Medical =
Imaging Division<BR>
</FONT><FONT COLOR=3D"#808080" SIZE=3D1 FACE=3D"Verdana">President =
Kennedypark 35 - B-8500 KORTRIJK - BELGIUM<BR>
Tel.&nbsp; +32 56 233 439&nbsp; Fax +32 56 233 457<BR>
</FONT></SPAN><A HREF=3D"file://www.barco.com/medical"><SPAN =
LANG=3D"fr-be"><U></U><U><FONT COLOR=3D"#0000FF" SIZE=3D1 =
FACE=3D"Verdana">www.barco.com/medical</FONT></U></SPAN></A><SPAN =
LANG=3D"fr-be"><BR>
</SPAN><A HREF=3D"mailto:bernard.willaert@barco.com"><SPAN =
LANG=3D"fr-be"><U></U><U><FONT COLOR=3D"#0000FF" SIZE=3D1 =
FACE=3D"Verdana">mailto:bernard.willaert@barco.com</FONT></U></SPAN></A><=
SPAN LANG=3D"fr-be"></SPAN>
</P>
<BR>
<BR>

<p></p><p>DISCLAIMER:<br>Unless indicated otherwise, the information =
contained in this message is privileged and confidential, and is =
intended only for the use of the addressee(s) named above and others who =
have been specifically authorized to receive it. If you are not the =
intended recipient, you are hereby notified that any dissemination, =
distribution or copying of this message and/or attachments is strictly =
prohibited. The company accepts no liability for any damage caused by =
any virus transmitted by this email. Furthermore, the company does not =
warrant a proper and complete transmission of this information, nor does =
it accept liability for any delays. If you have received this message in =
error, please contact the sender and delete the message. Thank =
you.</BODY>
</HTML>
------_=_NextPart_001_01C804C7.A45DC099--
