Return-Path: <lipovsky@cs.bu.edu>
Received: from cs3.bu.edu (cs3.bu.edu [128.197.12.8])
	by ozlabs.org (Postfix) with ESMTP id 663D0DDE08
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Sep 2007 11:10:24 +1000 (EST)
From: "Ilya Lipovsky" <lipovsky@cs.bu.edu>
To: "'Nguyen Nguyen'" <nnguyen@cs.umn.edu>
Subject: RE: futex priority based wakeup
Date: Tue, 11 Sep 2007 21:09:51 -0400
Message-ID: <000701c7f4d9$b124fba0$3a0d10ac@Radstone.Local>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0008_01C7F4B8.2A135BA0"
In-Reply-To: <1656e050709111714g1a84656bvd7823f5fc43345dd@mail.gmail.com>
Cc: "'Benedict, Michael'" <MBenedict@twacs.com>, linuxppc-embedded@ozlabs.org
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

------=_NextPart_000_0008_01C7F4B8.2A135BA0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Good info. Indeed, looks like this is what glibc actually does:

 

http://www.cygwin.com/ml/libc-alpha/2007-06/msg00097.html

 

 

 

  _____  

From: tinghich@gmail.com [mailto:tinghich@gmail.com] On Behalf Of Nguyen
Nguyen
Sent: Tuesday, September 11, 2007 8:15 PM
To: Ilya Lipovsky
Cc: Benedict, Michael; linuxppc-embedded@ozlabs.org
Subject: Re: futex priority based wakeup

 

I have seen something similar before.  Our fix was to use
pthread_attr_setinheritsched(&attr, PTHREAD_EXPLICIT_SCHED) so child threads
wouldn't inherit attribute from parent.  Hope it helps.



On 9/11/07, Ilya Lipovsky <lipovsky@cs.bu.edu> wrote:

Hmm. Just for kicks - inside the important thread could you add:

int curpolicy;
struct sched_param sp;
pthread_getschedparam (pthread_self (), &curpolicy, &sp)
printf("important's policy is %d and priority is %d\n", curpolicy, 
sp.__sched_priority);

before the very first futex syscall and after your "printf("important got
futex!\n");" line.

Do similar for the unimportant thread, and see if you get anything weird - 
e.g. priorities come out to be the same for threads.


-----Original Message-----
From: linuxppc-embedded-bounces+lipovsky=cs.bu.edu@ozlabs.org
[mailto: <mailto:linuxppc-embedded-bounces+lipovsky=cs.bu.edu@ozlabs.org>
linuxppc-embedded-bounces+lipovsky=cs.bu.edu@ozlabs.org] On Behalf
Of Benedict, Michael
Sent: Monday, September 10, 2007 5:41 PM
To: linuxppc-embedded@ozlabs.org 
Subject: RE: futex priority based wakeup

Ilya Lipovsky wrote:
> Your code looks correct to me, so if the kernel developers
> did their job
> correctly, the only potentially weak link is glibc. 
>

Well, either the kernel developers didn't do their job, or I am missing
something.  The following also fails, and it should be bypassing glibc:

#define _XOPEN_SOURCE 600

#include <linux/futex.h> 
#include <sys/time.h>
#include <asm/atomic.h>

#include <sys/syscall.h>
#include <unistd.h>

#include <sched.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

int myfutex = 0;

void *important(void *ign)
{
        sleep(1);
        printf("important waiting for futex\n");
        fflush(stdout);
        if(syscall(SYS_futex, &myfutex, FUTEX_WAIT, 0, NULL)) { 
                perror("futex");
                exit(1);
        } else {
                printf("important got futex!\n");
                fflush(stdout);
                syscall(SYS_futex, &myfutex, FUTEX_WAKE, 1, NULL); 
}

        return NULL;
}


void *unimportant(void *ign)
{
        printf("unimportant waiting for futex\n");
        fflush(stdout);
        if(syscall(SYS_futex, &myfutex, FUTEX_WAIT, 0, NULL)) { 
                perror("futex");
                exit(1);
        } else {
                printf("unimportant got futex!\n");
                fflush(stdout);
                syscall(SYS_futex, &myfutex, FUTEX_WAKE, 1, NULL); 
}

        return NULL;
}

int main()
{
        struct sched_param p;
        pthread_attr_t attr;
        pthread_t i, u;

        p.__sched_priority = sched_get_priority_min(SCHED_FIFO); 
        if(-1 == p.__sched_priority) {
                perror("sched_get_priority_min");
                return 1;
        }
        pthread_attr_init(&attr);
        pthread_attr_setschedpolicy(&attr, SCHED_FIFO); 
        pthread_attr_setschedparam(&attr, &p);
        pthread_create(&u, &attr, unimportant, NULL);

        p.__sched_priority = sched_get_priority_max(SCHED_FIFO);
        pthread_attr_setschedparam(&attr, &p); 
        pthread_create(&i, &attr, important, NULL);

        sleep(5);
        printf("futex FUTEX_WAKE\n");
        fflush(stdout);
        syscall(SYS_futex, &myfutex, FUTEX_WAKE, 1, NULL); 

        pthread_join(u, NULL);
        pthread_join(i, NULL);

        return 0;
}

Which produces:
unimportant waiting for futex
important waiting for futex
futex FUTEX_WAKE
unimportant got futex! 
important got futex!


Could someone with 2.6.22 please verify?

_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org  <mailto:Linuxppc-embedded@ozlabs.org> 
https://ozlabs.org/mailman/listinfo/linuxppc-embedded

_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded

 


------=_NextPart_000_0008_01C7F4B8.2A135BA0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:"MS Mincho";
	panose-1:2 2 6 9 4 2 5 8 3 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:"\@MS Mincho";
	panose-1:0 0 0 0 0 0 0 0 0 0;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:blue;
	text-decoration:underline;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:Arial;
	color:navy;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=3DEN-US link=3Dblue vlink=3Dblue>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Good info. Indeed, looks like this =
is what
glibc actually does:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><a
href=3D"http://www.cygwin.com/ml/libc-alpha/2007-06/msg00097.html">http:/=
/www.cygwin.com/ml/libc-alpha/2007-06/msg00097.html</a><o:p></o:p></span>=
</font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<div>

<div class=3DMsoNormal align=3Dcenter style=3D'text-align:center'><font =
size=3D3
face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>

<hr size=3D2 width=3D"100%" align=3Dcenter tabindex=3D-1>

</span></font></div>

<p class=3DMsoNormal><b><font size=3D2 face=3DTahoma><span =
style=3D'font-size:10.0pt;
font-family:Tahoma;font-weight:bold'>From:</span></font></b><font =
size=3D2
face=3DTahoma><span style=3D'font-size:10.0pt;font-family:Tahoma'>
tinghich@gmail.com [mailto:tinghich@gmail.com] <b><span =
style=3D'font-weight:
bold'>On Behalf Of </span></b>Nguyen Nguyen<br>
<b><span style=3D'font-weight:bold'>Sent:</span></b> Tuesday, September =
11, 2007
8:15 PM<br>
<b><span style=3D'font-weight:bold'>To:</span></b> Ilya Lipovsky<br>
<b><span style=3D'font-weight:bold'>Cc:</span></b> Benedict, Michael;
linuxppc-embedded@ozlabs.org<br>
<b><span style=3D'font-weight:bold'>Subject:</span></b> Re: futex =
priority based
wakeup</span></font><o:p></o:p></p>

</div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><font size=3D3
face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>I have seen =
something
similar before.&nbsp; Our fix was to use
pthread_attr_setinheritsched(&amp;attr, PTHREAD_EXPLICIT_SCHED) so child
threads wouldn't inherit attribute from parent.&nbsp; Hope it helps.<br>
<br>
<o:p></o:p></span></font></p>

<div>

<p class=3DMsoNormal><span class=3Dgmailquote><font size=3D3 =
face=3D"Times New Roman"><span
style=3D'font-size:12.0pt'>On 9/11/07, <b><span =
style=3D'font-weight:bold'>Ilya
Lipovsky</span></b> &lt;<a =
href=3D"mailto:lipovsky@cs.bu.edu">lipovsky@cs.bu.edu</a>&gt;
wrote:</span></font></span><o:p></o:p></p>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><font size=3D3
face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>Hmm. Just for =
kicks -
inside the important thread could you add:<br>
<br>
int curpolicy;<br>
struct sched_param sp;<br>
pthread_getschedparam (pthread_self (), &amp;curpolicy, &amp;sp)<br>
printf(&quot;important's policy is %d and priority is %d\n&quot;, =
curpolicy, <br>
sp.__sched_priority);<br>
<br>
before the very first futex syscall and after your =
&quot;printf(&quot;important
got<br>
futex!\n&quot;);&quot; line.<br>
<br>
Do similar for the unimportant thread, and see if you get anything weird =
- <br>
e.g. priorities come out to be the same for threads.<br>
<br>
<br>
-----Original Message-----<br>
From: linuxppc-embedded-bounces+lipovsky=3D<a =
href=3D"mailto:cs.bu.edu@ozlabs.org">cs.bu.edu@ozlabs.org</a><br>
[mailto:<a =
href=3D"mailto:linuxppc-embedded-bounces+lipovsky=3Dcs.bu.edu@ozlabs.org"=
>
linuxppc-embedded-bounces+lipovsky=3Dcs.bu.edu@ozlabs.org</a>] On =
Behalf<br>
Of Benedict, Michael<br>
Sent: Monday, September 10, 2007 5:41 PM<br>
To: <a =
href=3D"mailto:linuxppc-embedded@ozlabs.org">linuxppc-embedded@ozlabs.org=
</a>
<br>
Subject: RE: futex priority based wakeup<br>
<br>
Ilya Lipovsky wrote:<br>
&gt; Your code looks correct to me, so if the kernel developers<br>
&gt; did their job<br>
&gt; correctly, the only potentially weak link is glibc. <br>
&gt;<br>
<br>
Well, either the kernel developers didn't do their job, or I am =
missing<br>
something.&nbsp;&nbsp;The following also fails, and it should be =
bypassing
glibc:<br>
<br>
#define _XOPEN_SOURCE 600<br>
<br>
#include &lt;linux/futex.h&gt; <br>
#include &lt;sys/time.h&gt;<br>
#include &lt;asm/atomic.h&gt;<br>
<br>
#include &lt;sys/syscall.h&gt;<br>
#include &lt;unistd.h&gt;<br>
<br>
#include &lt;sched.h&gt;<br>
#include &lt;stdint.h&gt;<br>
#include &lt;stdio.h&gt;<br>
#include &lt;stdlib.h&gt;<br>
<br>
int myfutex =3D 0;<br>
<br>
void *important(void *ign)<br>
{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sleep(1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;printf(&quot;important =
waiting
for futex\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;fflush(stdout);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if(syscall(SYS_futex,
&amp;myfutex, FUTEX_WAIT, 0, NULL)) { <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;perror(&quot;futex&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;exit(1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;printf(&quot;important
got futex!\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;fflush(stdout);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;syscall(SYS_futex,
&amp;myfutex, FUTEX_WAKE, 1, NULL); <br>
}<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return NULL;<br>
}<br>
<br>
<br>
void *unimportant(void *ign)<br>
{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;printf(&quot;unimportant =
waiting
for futex\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;fflush(stdout);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if(syscall(SYS_futex,
&amp;myfutex, FUTEX_WAIT, 0, NULL)) { <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;perror(&quot;futex&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;exit(1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;printf(&quot;unimportant
got futex!\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;fflush(stdout);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;syscall(SYS_futex,
&amp;myfutex, FUTEX_WAKE, 1, NULL); <br>
}<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return NULL;<br>
}<br>
<br>
int main()<br>
{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;struct sched_param =
p;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;pthread_attr_t attr;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;pthread_t i, u;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;p.__sched_priority =3D
sched_get_priority_min(SCHED_FIFO); <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if(-1 =3D=3D =
p.__sched_priority) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;perror(&quot;sched_get_priority_min&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;return
1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;pthread_attr_init(&amp;at=
tr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;pthread_attr_setschedpoli=
cy(&amp;attr,
SCHED_FIFO); <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;pthread_attr_setschedpara=
m(&amp;attr,
&amp;p);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;pthread_create(&amp;u,
&amp;attr, unimportant, NULL);<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;p.__sched_priority =3D
sched_get_priority_max(SCHED_FIFO);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;pthread_attr_setschedpara=
m(&amp;attr,
&amp;p); <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;pthread_create(&amp;i,
&amp;attr, important, NULL);<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sleep(5);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;printf(&quot;futex
FUTEX_WAKE\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;fflush(stdout);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;syscall(SYS_futex,
&amp;myfutex, FUTEX_WAKE, 1, NULL); <br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;pthread_join(u, =
NULL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;pthread_join(i, =
NULL);<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return 0;<br>
}<br>
<br>
Which produces:<br>
unimportant waiting for futex<br>
important waiting for futex<br>
futex FUTEX_WAKE<br>
unimportant got futex! <br>
important got futex!<br>
<br>
<br>
Could someone with 2.6.22 please verify?<br>
<br>
_______________________________________________<br>
Linuxppc-embedded mailing list<br>
<a =
href=3D"mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org=
 </a><br>
<a =
href=3D"https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://oz=
labs.org/mailman/listinfo/linuxppc-embedded</a><br>
<br>
_______________________________________________<br>
Linuxppc-embedded mailing list<br>
<a =
href=3D"mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org=
</a><br>
<a =
href=3D"https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://oz=
labs.org/mailman/listinfo/linuxppc-embedded</a><o:p></o:p></span></font><=
/p>

</div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0008_01C7F4B8.2A135BA0--
