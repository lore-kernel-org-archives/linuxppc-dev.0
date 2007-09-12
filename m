Return-Path: <tinghich@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.178])
	by ozlabs.org (Postfix) with ESMTP id E3AC4DDD06
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Sep 2007 10:14:48 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id a29so68417pyi
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Sep 2007 17:14:47 -0700 (PDT)
Message-ID: <1656e050709111714g1a84656bvd7823f5fc43345dd@mail.gmail.com>
Date: Tue, 11 Sep 2007 19:14:44 -0500
From: "Nguyen Nguyen" <nnguyen@cs.umn.edu>
Sender: tinghich@gmail.com
To: "Ilya Lipovsky" <lipovsky@cs.bu.edu>
Subject: Re: futex priority based wakeup
In-Reply-To: <000001c7f4c7$7a7ab5c0$3a0d10ac@Radstone.Local>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_16596_12916495.1189556084945"
References: <BAF8B1E0BB28024A90895E746A3B610D1C2BE7@twx-exch01.twacs.local>
	<000001c7f4c7$7a7ab5c0$3a0d10ac@Radstone.Local>
Cc: "Benedict, Michael" <MBenedict@twacs.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_16596_12916495.1189556084945
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I have seen something similar before.  Our fix was to use
pthread_attr_setinheritsched(&attr, PTHREAD_EXPLICIT_SCHED) so child threads
wouldn't inherit attribute from parent.  Hope it helps.


On 9/11/07, Ilya Lipovsky <lipovsky@cs.bu.edu> wrote:
>
> Hmm. Just for kicks - inside the important thread could you add:
>
> int curpolicy;
> struct sched_param sp;
> pthread_getschedparam (pthread_self (), &curpolicy, &sp)
> printf("important's policy is %d and priority is %d\n", curpolicy,
> sp.__sched_priority);
>
> before the very first futex syscall and after your "printf("important got
> futex!\n");" line.
>
> Do similar for the unimportant thread, and see if you get anything weird -
> e.g. priorities come out to be the same for threads.
>
>
> -----Original Message-----
> From: linuxppc-embedded-bounces+lipovsky=cs.bu.edu@ozlabs.org
> [mailto:linuxppc-embedded-bounces+lipovsky=cs.bu.edu@ozlabs.org] On Behalf
> Of Benedict, Michael
> Sent: Monday, September 10, 2007 5:41 PM
> To: linuxppc-embedded@ozlabs.org
> Subject: RE: futex priority based wakeup
>
> Ilya Lipovsky wrote:
> > Your code looks correct to me, so if the kernel developers
> > did their job
> > correctly, the only potentially weak link is glibc.
> >
>
> Well, either the kernel developers didn't do their job, or I am missing
> something.  The following also fails, and it should be bypassing glibc:
>
> #define _XOPEN_SOURCE 600
>
> #include <linux/futex.h>
> #include <sys/time.h>
> #include <asm/atomic.h>
>
> #include <sys/syscall.h>
> #include <unistd.h>
>
> #include <sched.h>
> #include <stdint.h>
> #include <stdio.h>
> #include <stdlib.h>
>
> int myfutex = 0;
>
> void *important(void *ign)
> {
>         sleep(1);
>         printf("important waiting for futex\n");
>         fflush(stdout);
>         if(syscall(SYS_futex, &myfutex, FUTEX_WAIT, 0, NULL)) {
>                 perror("futex");
>                 exit(1);
>         } else {
>                 printf("important got futex!\n");
>                 fflush(stdout);
>                 syscall(SYS_futex, &myfutex, FUTEX_WAKE, 1, NULL);
> }
>
>         return NULL;
> }
>
>
> void *unimportant(void *ign)
> {
>         printf("unimportant waiting for futex\n");
>         fflush(stdout);
>         if(syscall(SYS_futex, &myfutex, FUTEX_WAIT, 0, NULL)) {
>                 perror("futex");
>                 exit(1);
>         } else {
>                 printf("unimportant got futex!\n");
>                 fflush(stdout);
>                 syscall(SYS_futex, &myfutex, FUTEX_WAKE, 1, NULL);
> }
>
>         return NULL;
> }
>
> int main()
> {
>         struct sched_param p;
>         pthread_attr_t attr;
>         pthread_t i, u;
>
>         p.__sched_priority = sched_get_priority_min(SCHED_FIFO);
>         if(-1 == p.__sched_priority) {
>                 perror("sched_get_priority_min");
>                 return 1;
>         }
>         pthread_attr_init(&attr);
>         pthread_attr_setschedpolicy(&attr, SCHED_FIFO);
>         pthread_attr_setschedparam(&attr, &p);
>         pthread_create(&u, &attr, unimportant, NULL);
>
>         p.__sched_priority = sched_get_priority_max(SCHED_FIFO);
>         pthread_attr_setschedparam(&attr, &p);
>         pthread_create(&i, &attr, important, NULL);
>
>         sleep(5);
>         printf("futex FUTEX_WAKE\n");
>         fflush(stdout);
>         syscall(SYS_futex, &myfutex, FUTEX_WAKE, 1, NULL);
>
>         pthread_join(u, NULL);
>         pthread_join(i, NULL);
>
>         return 0;
> }
>
> Which produces:
> unimportant waiting for futex
> important waiting for futex
> futex FUTEX_WAKE
> unimportant got futex!
> important got futex!
>
>
> Could someone with 2.6.22 please verify?
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>

------=_Part_16596_12916495.1189556084945
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I have seen something similar before.&nbsp; Our fix was to use pthread_attr_setinheritsched(&amp;attr, PTHREAD_EXPLICIT_SCHED) so child threads wouldn&#39;t inherit attribute from parent.&nbsp; Hope it helps.<br><br><br><div><span class="gmail_quote">
On 9/11/07, <b class="gmail_sendername">Ilya Lipovsky</b> &lt;<a href="mailto:lipovsky@cs.bu.edu">lipovsky@cs.bu.edu</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hmm. Just for kicks - inside the important thread could you add:<br><br>int curpolicy;<br>struct sched_param sp;<br>pthread_getschedparam (pthread_self (), &amp;curpolicy, &amp;sp)<br>printf(&quot;important&#39;s policy is %d and priority is %d\n&quot;, curpolicy,
<br>sp.__sched_priority);<br><br>before the very first futex syscall and after your &quot;printf(&quot;important got<br>futex!\n&quot;);&quot; line.<br><br>Do similar for the unimportant thread, and see if you get anything weird -
<br>e.g. priorities come out to be the same for threads.<br><br><br>-----Original Message-----<br>From: linuxppc-embedded-bounces+lipovsky=<a href="mailto:cs.bu.edu@ozlabs.org">cs.bu.edu@ozlabs.org</a><br>[mailto:<a href="mailto:linuxppc-embedded-bounces+lipovsky=cs.bu.edu@ozlabs.org">
linuxppc-embedded-bounces+lipovsky=cs.bu.edu@ozlabs.org</a>] On Behalf<br>Of Benedict, Michael<br>Sent: Monday, September 10, 2007 5:41 PM<br>To: <a href="mailto:linuxppc-embedded@ozlabs.org">linuxppc-embedded@ozlabs.org</a>
<br>Subject: RE: futex priority based wakeup<br><br>Ilya Lipovsky wrote:<br>&gt; Your code looks correct to me, so if the kernel developers<br>&gt; did their job<br>&gt; correctly, the only potentially weak link is glibc.
<br>&gt;<br><br>Well, either the kernel developers didn&#39;t do their job, or I am missing<br>something.&nbsp;&nbsp;The following also fails, and it should be bypassing glibc:<br><br>#define _XOPEN_SOURCE 600<br><br>#include &lt;linux/futex.h&gt;
<br>#include &lt;sys/time.h&gt;<br>#include &lt;asm/atomic.h&gt;<br><br>#include &lt;sys/syscall.h&gt;<br>#include &lt;unistd.h&gt;<br><br>#include &lt;sched.h&gt;<br>#include &lt;stdint.h&gt;<br>#include &lt;stdio.h&gt;<br>
#include &lt;stdlib.h&gt;<br><br>int myfutex = 0;<br><br>void *important(void *ign)<br>{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sleep(1);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;printf(&quot;important waiting for futex\n&quot;);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;fflush(stdout);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if(syscall(SYS_futex, &amp;myfutex, FUTEX_WAIT, 0, NULL)) {
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;perror(&quot;futex&quot;);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;exit(1);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} else {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;printf(&quot;important got futex!\n&quot;);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;fflush(stdout);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;syscall(SYS_futex, &amp;myfutex, FUTEX_WAKE, 1, NULL);
<br>}<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return NULL;<br>}<br><br><br>void *unimportant(void *ign)<br>{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;printf(&quot;unimportant waiting for futex\n&quot;);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;fflush(stdout);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if(syscall(SYS_futex, &amp;myfutex, FUTEX_WAIT, 0, NULL)) {
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;perror(&quot;futex&quot;);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;exit(1);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} else {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;printf(&quot;unimportant got futex!\n&quot;);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;fflush(stdout);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;syscall(SYS_futex, &amp;myfutex, FUTEX_WAKE, 1, NULL);
<br>}<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return NULL;<br>}<br><br>int main()<br>{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;struct sched_param p;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;pthread_attr_t attr;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;pthread_t i, u;<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;p.__sched_priority = sched_get_priority_min(SCHED_FIFO);
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if(-1 == p.__sched_priority) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;perror(&quot;sched_get_priority_min&quot;);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return 1;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;pthread_attr_init(&amp;attr);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;pthread_attr_setschedpolicy(&amp;attr, SCHED_FIFO);
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;pthread_attr_setschedparam(&amp;attr, &amp;p);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;pthread_create(&amp;u, &amp;attr, unimportant, NULL);<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;p.__sched_priority = sched_get_priority_max(SCHED_FIFO);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;pthread_attr_setschedparam(&amp;attr, &amp;p);
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;pthread_create(&amp;i, &amp;attr, important, NULL);<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sleep(5);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;printf(&quot;futex FUTEX_WAKE\n&quot;);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;fflush(stdout);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;syscall(SYS_futex, &amp;myfutex, FUTEX_WAKE, 1, NULL);
<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;pthread_join(u, NULL);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;pthread_join(i, NULL);<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return 0;<br>}<br><br>Which produces:<br>unimportant waiting for futex<br>important waiting for futex<br>futex FUTEX_WAKE<br>unimportant got futex!
<br>important got futex!<br><br><br>Could someone with 2.6.22 please verify?<br><br>_______________________________________________<br>Linuxppc-embedded mailing list<br><a href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org
</a><br><a href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a><br><br>_______________________________________________<br>Linuxppc-embedded mailing list<br>
<a href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a><br><a href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a><br><br></blockquote>
</div><br>

------=_Part_16596_12916495.1189556084945--
