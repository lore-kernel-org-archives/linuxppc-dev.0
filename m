Return-Path: <m.fortini@selcomgroup.com>
Received: from xseries02.selcomgroup.com (mail.selcomgroup.com [85.18.34.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0E749DDF4C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Sep 2008 18:22:42 +1000 (EST)
Received: from [172.26.6.73] ([172.26.6.73]) (authenticated bits=0)
	by xseries02.selcomgroup.com (8.13.4/8.13.4) with ESMTP id
	m8I8Mbkk002523
	for <linuxppc-embedded@ozlabs.org>; Thu, 18 Sep 2008 10:22:37 +0200
Message-ID: <48D20FCC.6070602@selcomgroup.com>
Date: Thu, 18 Sep 2008 10:22:36 +0200
From: Matteo Fortini <m.fortini@selcomgroup.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: gdbserver not working with pthreads
Content-Type: multipart/mixed; boundary="------------020603050406000106050609"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------020603050406000106050609
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

I'm using gdbserver & gdb-cross built on OpenEmbedded, both versions 6.6 
and 6.8 on FSL kernel 2.6.24.6 with an MPC5121 cpu, glibc 2.6.1

Gdb on the target is working properly, and can debug threads the usual way.

When debugging with gdbserver/gdb the debugger loses control of the 
threads. I did set the sysroot variable right, and I don't get the ld 
not found error message.
 Basically, I cannot step into pthread_create, without losing control, 
with the software not running and gdb going timeout. Sometimes the 
gdbserver shell prints out "ptrace(): pid not found", or I get E01 reply 
on the gdb-cross. Putting breakpoints into threads works sometimes.
My ultimate goal would be to make it work with Eclipse, but it's a long 
way from having it working with such a system.

I attach the simple software I'm using to test it.

I also tried setting the target architecture to values other than 
powerpc:common, but it didn't help.

Thank you for any clue,
Matteo

--------------020603050406000106050609
Content-Type: text/plain;
 name="test1.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="test1.c"

/*
 *  * p_hello.c -- a hello program (in pthread)
 *   */
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <pthread.h>

#define MAX_THREAD 5

typedef struct {
	int id;
} parm;

void *hello(void *arg)
{
	int i;

	parm *p=(parm *)arg;

	for(i=0;i<100;i++) {
		printf("Hello from node %d iteration %d\n", p->id, i);
	
		sleep (1);
	}

	return (NULL);
}

void *hello2(void *arg)
{
	int i;

	parm *p=(parm *)arg;

	for(i=0;i<100;i++) {
		printf("Hello2 from node %d iteration %d\n", p->id, i);

		sleep (1);
	}

	return (NULL);
}


int main(int argc, char* argv[]) {
	int n,i;
	pthread_t *threads;
	pthread_attr_t pthread_custom_attr;
	parm *p;

	if (argc != 2)
	{
		printf ("Usage: %s n\n  where n is no. of threads\n",argv[0]);
		exit(1);
	}

	n=atoi(argv[1]);

	if ((n < 1) || (n > MAX_THREAD))
	{
		printf ("The no of thread should between 1 and %d.\n",MAX_THREAD);
		exit(1);
	}

	threads=(pthread_t *)malloc(n*sizeof(*threads));
	pthread_attr_init(&pthread_custom_attr);

	p=(parm *)malloc(sizeof(parm)*n);
	/* Start up thread */

	for (i=0; i<n; i++)
	{
		p[i].id=i;
		if(i % 2)
			pthread_create(&threads[i], &pthread_custom_attr, hello, (void *)(p+i));
		else 	pthread_create(&threads[i], &pthread_custom_attr, hello2, (void *)(p+i));

	}

	/* Synchronize the completion of each thread. */

	for (i=0; i<n; i++)
	{
		pthread_join(threads[i],NULL);
	}
	free(p);
}


--------------020603050406000106050609--
