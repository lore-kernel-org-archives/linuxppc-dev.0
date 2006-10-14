Return-Path: <ratheeshreddy@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.176])
	by ozlabs.org (Postfix) with ESMTP id 4DF2567C25
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 14 Oct 2006 16:14:04 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id t32so1458021pyc
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Oct 2006 23:14:04 -0700 (PDT)
Message-ID: <c94019ff0610132314h4b8bb4e2w584c340d0303cd6c@mail.gmail.com>
Date: Sat, 14 Oct 2006 11:44:03 +0530
From: Ratheesh <ratheeshreddy@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: problem in running pthread application
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_51343_20997481.1160806443832"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_51343_20997481.1160806443832
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello everybody,
                         I have a problem in running a pthread based
application whose source is given below.
//sample.c
#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

void *thread1_function(void *);
void *thread2_function(void *);

int main(void)
{
 pthread_t thread1,thread2;
 char *message1 = "Thread 1";
 char *message2 = "Thread 2";
 int iret1,iret2;
 iret1 = pthread_create(&thread1,NULL,thread1_function,(void*)message1);
 iret2 = pthread_create(&thread2,NULL,thread2_function,(void*)message2);

 pthread_join(thread1,iret1);
 pthread_join(thread2,iret2);
 printf("Thread 1 returns: %d\n",iret1);
 printf("Thread 2 returns: %d\n",iret2);
 exit(0);
}

void *thread1_function(void *ptr)
{
 char *message;
 message = (char *) ptr;
 while(1)
 {
  printf("%s\n",message);
  sleep(5);
 }
}

void *thread2_function(void *ptr)
{
 char *message;
 message = (char *) ptr;
 while(1)
 {
  printf("%s\n",message);
  sleep(8);
 }
}
//end of sample.c

I compiled using the command $powerpc-linux-uclibc-gcc -lpthread -o sample
sample.c

when I run on my target board(MPC850 based custom board), I find multiple
copies of the same program(I am invoking only once) is running. ps -e
command show the following output.

PID  Uid     VmSize Stat Command
    1 root        392 S   init
    2 root            SW  [keventd]
    3 root            SWN [ksoftirqd_CPU0]
    4 root            SW  [kswapd]
    5 root            SW  [bdflush]
    6 root            SW  [kupdated]
    7 root            SW  [rpciod]
   36 root       1284 S   /bin/snmpd -Dagentx
   41 root       1024 S   /bin/bash
   42 root        372 S   /sbin/syslogd -n -m 0
   43 root        348 S   /sbin/klogd -n
   51 root        296 S   sample
   52 root        296 S   sample
   53 root        296 S   sample
   54 root        296 S   sample
   56 root        372 R   ps

Why is this program is running multiple copies in the memory? How to avoid
this.If I compile
the same program in PC(x86 with glibc) It is running fine(no multiple
copies). So how to avoid this what is wrong with my program? Please help me.

Regards,

Ratheesh

------=_Part_51343_20997481.1160806443832
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello everybody,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I have a problem in running a pthread based<br>application whose source is given below.<br>//sample.c<br>#include &lt;stdio.h&gt;<br>#include &lt;stdlib.h&gt;<br>#include &lt;pthread.h
&gt;<br><br>void *thread1_function(void *);<br>void *thread2_function(void *);<br><br>int main(void)<br>{<br>&nbsp;pthread_t thread1,thread2;<br>&nbsp;char *message1 = &quot;Thread 1&quot;;<br>&nbsp;char *message2 = &quot;Thread 2&quot;;
<br>&nbsp;int iret1,iret2;<br>&nbsp;iret1 = pthread_create(&amp;thread1,NULL,thread1_function,(void*)message1);<br>&nbsp;iret2 = pthread_create(&amp;thread2,NULL,thread2_function,(void*)message2);<br><br>&nbsp;pthread_join(thread1,iret1);<br>
&nbsp;pthread_join(thread2,iret2);<br>&nbsp;printf(&quot;Thread 1 returns: %d\n&quot;,iret1);<br>&nbsp;printf(&quot;Thread 2 returns: %d\n&quot;,iret2);<br>&nbsp;exit(0);<br>}<br><br>void *thread1_function(void *ptr)<br>{<br>&nbsp;char *message;<br>
&nbsp;message = (char *) ptr;<br>&nbsp;while(1)<br>&nbsp;{<br>&nbsp; printf(&quot;%s\n&quot;,message);<br>&nbsp; sleep(5);<br>&nbsp;}<br>}<br><br>void *thread2_function(void *ptr)<br>{<br>&nbsp;char *message;<br>&nbsp;message = (char *) ptr;<br>&nbsp;while(1)<br>&nbsp;{<br>
&nbsp; printf(&quot;%s\n&quot;,message);<br>&nbsp; sleep(8);<br>&nbsp;}<br>}<br>//end of sample.c<br><br>I compiled using the command $powerpc-linux-uclibc-gcc -lpthread -o sample sample.c<br><br>when I run on my target board(MPC850 based custom board), I find multiple copies of the same program(I am invoking only once)&nbsp;is running. ps -e command show the following output.
<br><br>PID&nbsp; Uid&nbsp;&nbsp;&nbsp;&nbsp; VmSize Stat Command<br>&nbsp;&nbsp;&nbsp; 1 root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 392 S&nbsp;&nbsp; init<br>&nbsp;&nbsp;&nbsp; 2 root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SW&nbsp; [keventd]<br>&nbsp;&nbsp;&nbsp; 3 root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SWN [ksoftirqd_CPU0]<br>&nbsp;&nbsp;&nbsp; 4 root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SW&nbsp; [kswapd]<br>&nbsp;&nbsp;&nbsp; 5 root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SW&nbsp; [bdflush]
<br>&nbsp;&nbsp;&nbsp; 6 root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SW&nbsp; [kupdated]<br>&nbsp;&nbsp;&nbsp; 7 root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SW&nbsp; [rpciod]<br>&nbsp;&nbsp; 36 root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1284 S&nbsp;&nbsp; /bin/snmpd -Dagentx<br>&nbsp;&nbsp; 41 root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1024 S&nbsp;&nbsp; /bin/bash<br>&nbsp;&nbsp; 42 root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 372 S&nbsp;&nbsp; /sbin/syslogd -n -m 0<br>
&nbsp;&nbsp; 43 root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 348 S&nbsp;&nbsp; /sbin/klogd -n<br>&nbsp;&nbsp; 51 root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 296 S&nbsp;&nbsp; sample<br>&nbsp;&nbsp; 52 root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 296 S&nbsp;&nbsp; sample<br>&nbsp;&nbsp; 53 root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 296 S&nbsp;&nbsp; sample<br>&nbsp;&nbsp; 54 root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 296 S&nbsp;&nbsp; sample<br>&nbsp;&nbsp; 56 root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 372 R&nbsp;&nbsp; ps<br><br>
Why is this program is running multiple copies in the memory? How to avoid this.If I compile<br>the same program in PC(x86 with glibc) It is running fine(no multiple<br>copies). So how to avoid this what is wrong with my program? Please help me.
<br><br>Regards,<br><br>Ratheesh<br>

------=_Part_51343_20997481.1160806443832--
