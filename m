MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Can't set the schedual parameter of threads in linux
Date: Thu, 11 Mar 2004 10:22:24 -0500
Message-ID: <AB5AF73EAF23304EA1B932174137CED70304B4@m5tmail.m5t.com>
From: "Jean-Denis Boyer" <jdboyer@m5t.com>
To: "yang" <wchyang_hn@sina.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Your program logic is absolutely correct.
I ran it in my embedded PPC environment (as root) and got the following results:

policy: 2       priority: 20

The problem is elsewhere...

--------------------------------------------
 Jean-Denis Boyer, Eng.
 M5T Centre d'Excellence en Télécoms Inc.
 4283 Garlock Street
 Sherbrooke (Québec)
 J1L 2C8  CANADA
 (819)829-3972 x241
--------------------------------------------
> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of yang
> Sent: 10 mars, 2004 20:07
> To: linuxppc-embedded@lists.linuxppc.org
> Subject: Can't set the schedual parameter of threads in linux
>
>
>
> Hello,
>     I encounter a problem when I transplant application.
>     There is no effect to the pthread when I call
> pthread_setschedparam() function in test program,  and it's
> policy and priority are stilll zero, not what I expected,
> after call pthread_getschedparam(). The codes  is as the follow:
>
> #include <sched.h>
> #include <pthread.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <sys/types.h>
> #include <linux/ipc.h>
> #include <linux/msg.h>
> #include <errno.h>
> #include <stddef.h>
> #include <string.h>
>
> void * func()
> {
>         while (1);
>     return;
> }
>
> int main()
> {
>     pthread_attr_t tattr;
>     pthread_t tid;
>     int policy;
>     int ret;
>     int newprio = 20;
>     struct sched_param param;
>
>     ret = pthread_attr_init (&tattr);
>     if (ret != 0)
>     {
>         printf("Error in init: %s\n", strerror(errno));
>     }
>
>     ret = pthread_attr_getschedparam (&tattr, &param);
>     if (ret != 0)
>     {
>         printf("Error in get after init: %s\n", strerror(errno));
>     }
>     ret = pthread_attr_setdetachstate(&tattr,
> PTHREAD_CREATE_DETACHED);
>    if (ret != 0)
>     {
>         printf("Error in setdea: %s\n", strerror(errno));
>     }
>     ret = pthread_attr_setschedpolicy(&tattr, SCHED_RR);
>     if (ret != 0)
>     {
>         printf("Error in setpolicy: %s\n", strerror(errno));
>     }
>
>     param.sched_priority = newprio;
>     ret = pthread_attr_setschedparam (&tattr, &param);
>     if (ret != 0)
>     {
>         printf("Error in set: %s\n", strerror(errno));
>     }
>
>     ret = pthread_create (&tid, &tattr, (int*) func, NULL);
>     if (ret != 0)
>     {
>         printf("Error in create: %s\n", strerror(errno));
>     }
>
>     param.sched_priority = -1;
>     ret = pthread_getschedparam (tid, &policy, &param);
>     if (ret != 0)
>     {
>         printf("Error in get after create: %d %s\n", ret,
> strerror(errno));
>     }
>
>     printf("policy: %d\tpriority: %d\n", policy,
> param.sched_priority);
>
>     return 0;
>
> }
>
>     The output is :
>     policy: 0    priority: 0
>
>     Would you like to tell me how to set the policy and
> priority to pthreads in Red Hat.? Thank you very much!
>     Best regards,
>                                      yang
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
