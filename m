In-Reply-To: <001601c4076a$465d6470$5e1312ac@yang>
References: <002901c40705$65697ee0$5e1312ac@yang> <2176F658-7353-11D8-B73C-000A95B15278@aimsys.nl> <001601c4076a$465d6470$5e1312ac@yang>
Mime-Version: 1.0 (Apple Message framework v612)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <71979D08-736D-11D8-AD25-000A95B15278@aimsys.nl>
Cc: linuxppc-embedded@lists.linuxppc.org
From: Jaap-Jan Boor <jjboor@aimsys.nl>
Subject: Re: Can't set the schedual parameter of threads in linux
Date: Thu, 11 Mar 2004 16:04:50 +0100
To: "yang" <wchyang_hn@sina.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Yang,

You are right, I don't use the pthread_[gs]etschedparam() functions.
I use in the new thread's context the
pthread_attr_getschedpolicy(&tattr, &policy);
pthread_attr_getschedparam(&tattr, &param);

functions, and then set the new priority

param.sched_priority = newpriority;
pthread_setschedparam(pthread_self(), policy, &param);

Jaap-Jan

On Mar 11, 2004, at 14:10, yang wrote:

> Hi,
>        I did run my program as root, and the key to my problem is why
> it works well in Solaris system but not in Red Hat system.
>        Please copy the follow codes and run it in your system if you
> are spare and will. Thank you very much!
>        Best regards,
>                                                  yang
>
>
>> yang,
>>
>> Are you running your application as root? Also, try to get/set
>> the pthread schedule parameters in the pthread context itself.
>>
>> Jaap-Jan
>>
>> On Mar 11, 2004, at 2:06, yang wrote:
>>
>>>
>>> Hello,
>>>     I encounter a problem when I transplant application.
>>>     There is no effect to the pthread when I call
>>> pthread_setschedparam() function in test program,  and it's policy
>>> and
>>> priority are stilll zero, not what I expected, after call
>>> pthread_getschedparam(). The codes  is as the follow:
>>>
>>> #include <sched.h>
>>> #include <pthread.h>
>>> #include <stdio.h>
>>> #include <stdlib.h>
>>> #include <sys/types.h>
>>> #include <linux/ipc.h>
>>> #include <linux/msg.h>
>>> #include <errno.h>
>>> #include <stddef.h>
>>> #include <string.h>
>>>
>>> void * func()
>>> {
>>>         while (1);
>>>     return;
>>> }
>>>
>>> int main()
>>> {
>>>     pthread_attr_t tattr;
>>>     pthread_t tid;
>>>     int policy;
>>>     int ret;
>>>     int newprio = 20;
>>>     struct sched_param param;
>>>
>>>     ret = pthread_attr_init (&tattr);
>>>     if (ret != 0)
>>>     {
>>>         printf("Error in init: %s\n", strerror(errno));
>>>     }
>>>
>>>     ret = pthread_attr_getschedparam (&tattr, &param);
>>>     if (ret != 0)
>>>     {
>>>         printf("Error in get after init: %s\n", strerror(errno));
>>>     }
>>>     ret = pthread_attr_setdetachstate(&tattr,
>>> PTHREAD_CREATE_DETACHED);
>>>    if (ret != 0)
>>>     {
>>>         printf("Error in setdea: %s\n", strerror(errno));
>>>     }
>>>     ret = pthread_attr_setschedpolicy(&tattr, SCHED_RR);
>>>     if (ret != 0)
>>>     {
>>>         printf("Error in setpolicy: %s\n", strerror(errno));
>>>     }
>>>
>>>     param.sched_priority = newprio;
>>>     ret = pthread_attr_setschedparam (&tattr, &param);
>>>     if (ret != 0)
>>>     {
>>>         printf("Error in set: %s\n", strerror(errno));
>>>     }
>>>
>>>     ret = pthread_create (&tid, &tattr, (int*) func, NULL);
>>>     if (ret != 0)
>>>     {
>>>         printf("Error in create: %s\n", strerror(errno));
>>>     }
>>>
>>>     param.sched_priority = -1;
>>>     ret = pthread_getschedparam (tid, &policy, &param);
>>>     if (ret != 0)
>>>     {
>>>         printf("Error in get after create: %d %s\n", ret,
>>> strerror(errno));
>>>     }
>>>
>>>     printf("policy: %d\tpriority: %d\n", policy,
>>> param.sched_priority);
>>>
>>>     return 0;
>>>
>>> }
>>>
>>>     The output is :
>>>     policy: 0    priority: 0
>>>
>>>     Would you like to tell me how to set the policy and priority to
>>> pthreads in Red Hat.? Thank you very much!
>>>     Best regards,
>>>                                      yang
>>>
>>>
>>
>>
>>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
