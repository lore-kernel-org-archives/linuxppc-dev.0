Message-ID: <008601c40811$07b5aeb0$5e1312ac@yang>
From: "yang" <wchyang_hn@sina.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Problem of SCHED_RR schedule to several threads in embeded linux for ppc8xx
Date: Fri, 12 Mar 2004 16:59:26 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,
      A problem occurs when I transplant applications.

      My original intation to create serveral threads with different priorities and check whether they are scheuled on their priorities by system or not.  In my option, the higher priority of thread,  the more chance to be executed by system,Unfortunately,  what I saw is not what I expected,  they did not act on their priorities.

      In fact,  it is only the first created thread is runing,  though  I try to create two threads in the follow codes. And the second thread could not be created after the first created thread was running.  I don't know which function can help its caller to give up CPU and wait next chance of executing.

/* Codes to test System Schedule Policy to SCHED_RR / SCHED_FIFO */
#include <stdio.h>
#include <errno.h>
#include <stdlib.h>
#include <stddef.h>
#include <string.h>
#include <sched.h>
#include <pthread.h>
#include <sys/types.h>
#include <linux/ipc.h>
#include <linux/msg.h>

static ulong funcnt = 0, testcnt = 0;

void func(void)
{
    int policy;
    pthread_t pid;
    struct sched_param priority;

    pid = pthread_self();
    pthread_getschedparam(pid,&policy,&priority);
    printf("func() policy %d priority %d\t",
         policy,priority.__sched_priority);

    while(1)
    {
        ++funcnt;
//        if(funcnt <= testcnt)
            printf("\nfuncnt: %d testcnt %d\n",funcnt,testcnt);
//        pthread_cancel(pid);
    }

    return;
}

void test(void)
{
    int policy;
    pthread_t pid;
    struct sched_param priority;

    pid = pthread_self();
    pthread_getschedparam(pid,&policy,&priority);
    printf(" test() policy %d priority %d\t",
         policy, priority.__sched_priority);

    while(1)
    {
        ++testcnt;
//        if(funcnt >= testcnt)
            printf("\nfuncnt: %d testcnt %d\n",funcnt,testcnt);
//        pthread_cancel(pid);
    }

    return;
}

int main(void)
{
    #define FUNC_PRIORITY   (10)
    #define TEST_PRIORITY   (5)
    #define TASK_POLICY     (SCHED_RR)

    pthread_attr_t attr_1,attr_2;
    pthread_t funcid, testid;
    int policy = TASK_POLICY;
    int ret1,ret2,funcprio,testprio;
    struct sched_param funcparam,testparam;

    ret1 = pthread_attr_init(&attr_1);
    ret2 = pthread_attr_init(&attr_2);
    if((ret1 != 0) || (ret2 != 0))
    {
        printf("Error in pthread_attr_init(): %s\n", strerror(errno));
    }

    ret1 = pthread_attr_setschedpolicy(&attr_1, policy);
    ret2 = pthread_attr_setschedpolicy(&attr_2, policy);
    if((ret1 != 0) || (ret2 != 0))
    {
        printf("Error in pthread_attr_setschedpolicy(): %s\n", strerror(errno));
    }

    funcparam.sched_priority = FUNC_PRIORITY;
    testparam.sched_priority = TEST_PRIORITY;

    ret1 = pthread_attr_setschedparam(&attr_1, &funcparam);
    ret2 = pthread_attr_setschedparam(&attr_2, &testparam);
    if((ret1 != 0) || (ret2 != 0))
    {
        printf("Error in pthread_attr_setschedparam(): %s\n", strerror(errno));
    }

    pthread_setconcurrency(100);

#if 1
    printf("Expected: func() priority: %d => test() priority: %d\nIn  fact: ",
        FUNC_PRIORITY,TEST_PRIORITY);
    ret1 = pthread_create(&funcid, &attr_1, (void *) func, NULL);
    ret2 = pthread_create(&testid, &attr_2, (void *)test, NULL);
#else
    printf("Expected: test() priority: %d => func() priority: %d\nIn  fact: ",
        TEST_PRIORITY,FUNC_PRIORITY);
    ret2 = pthread_create(&testid, &attr_2, (void *)test, NULL);
    ret1 = pthread_create(&funcid, &attr_1, (void *) func, NULL);
#endif
    if ((ret1 != 0) || (ret2 != 0))
    {
        printf("Error in pthread_create(): %s\n", strerror(errno));
    }

#if 0
    funcparam.__sched_priority = FUNC_PRIORITY;
    ret1 = pthread_setschedparam(funcid, (int)policy, &funcparam);
    testparam.__sched_priority = TEST_PRIORITY;
    ret2 = pthread_setschedparam(testid, (int)policy, &testparam);
#endif

    memset((char *)&policy,0,sizeof(int));
    memset((char *)&funcparam,0,sizeof(funcparam));
    memset((char *)&testparam,0,sizeof(testparam));

    ret1 = pthread_getschedparam(funcid, &policy, &funcparam);
    ret2 = pthread_getschedparam(testid, &policy, &testparam);
    if((ret1 != 0) || (ret2 != 0))
    {
        printf("Error in pthread_getschedparam(): %s\n",strerror(errno));
    }
    else
    {
        printf("policy: %d\tfunc() priority: %d\tfunc() priority: %d\n", policy, funcparam.__sched_priority, testparam.__sched_priority);
    }

    while(1);

    return 0;
}

      I  found only either "func()" thread or "test()" thread is created and running, not as what I expect -- two threads were scheduled by their priorities. Because
      Thanks!
      Best regards,
                            yang

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
