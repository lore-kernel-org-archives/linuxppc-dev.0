Return-Path: <glppd-linuxppc64-dev@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 903F8DDE0C
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2007 07:26:30 +1000 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IdBJs-0007e0-VR
	for linuxppc-dev@ozlabs.org; Wed, 03 Oct 2007 20:59:49 +0000
Received: from bi01p1.co.us.ibm.com ([32.97.110.142])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Wed, 03 Oct 2007 20:59:48 +0000
Received: from hollisb by bi01p1.co.us.ibm.com with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Wed, 03 Oct 2007 20:59:48 +0000
To: linuxppc-dev@ozlabs.org
From: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: Stdout console clogging => 300ms blocked
Date: Wed, 3 Oct 2007 20:49:12 +0000 (UTC)
Message-ID: <fe0v88$dt5$1@sea.gmane.org>
References: <8D433CD511BE4646B47F8B31C900818ECB97AF@kndmex01.barco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: news <news@sea.gmane.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 02 Oct 2007 09:41:28 +0200, Willaert, Bernard wrote:

> System details:
> Freescale MPC8347@200MHz
> Kernel 2.6.18
> 
> Problem:
> When we log debug output via the serial console on a multithreaded
> application, the console throughput may get clogged and then we
> experience a >300ms deadlock.
> 
> Quick and dirty test program: threadtest.c:
> //----------------------------------------------------------------------
> -------------------------
> #include <pthread.h>
> #include <stdio.h>
> #include <sys/time.h>
> 
> #define THREAD_DELAY 1000
> 
> void* thread_1(void* unused)
> {
> 	while (1)
> 	{
> 		usleep(THREAD_DELAY);
> 		fprintf(stdout," <----- thread 1\n");
> 	}
> 	return NULL;
> }
> 
> void* thread_2(void* unused)
> {
> 	static long ts_old;
> 	long ts;
> 	struct timeval tv;
> 
> 	while (1)
> 	{
> 		usleep(THREAD_DELAY);
> 		fprintf(stdout," <----- thread 2\n");
> 
> 		gettimeofday (&tv, NULL);
> 		ts = (tv.tv_sec * 1000L) + (tv.tv_usec / 1000L);
> 		if ((ts - ts_old) > 100)
> 		{
> 			fprintf(stdout, "!!!!!!!!!!! thread2 interval
> timeout = %d ms\n",(int)(ts - ts_old));
> 		}
> 		ts_old = ts;
> 	}
> 	return NULL;			
> 
> }
> 
> 
> 
> int main()
> {
> 	pthread_t pthread_id_1, pthread_id_2;
> 	
> 	pthread_create(&pthread_id_1,NULL,&thread_1,NULL);
> 	pthread_create(&pthread_id_2,NULL,&thread_2,NULL);
> 	while (1)
> 	{
> 	}
> 	return 0;
> 
> }
> 
> //----------------------------------------------------------------------
> -------------------------
> 
> Build command on our platform: 
> powerpc-linux-uclibc-gcc threadtest.c  -lpthread -o threadtest
> Execute: ./threadtest > /dev/console &
> 
> Uboot settings for the serial console:
> consoledev=ttyS0
> baudrate=115200
> stdin=serial
> stdout=serial
> stderr=serial
> boot_go=setenv bootargs console=$consoledev,$baudrate $args_rtc
> $args_mtd $args_nfs $args_debug;bootm $addr_kernel $addr_root $addr_dtb
> 
> 
> Expected output [snippet] on the console:
> .... /\ ........
>  <----- thread 1
>  <----- thread 2
>  <----- thread 1
>  <----- thread 2
>  <----- thread 1
>  <----- thread 2
>  <----- thread 1
>  <----- thread 2
>  <----- thread 1
>  <----- thread 2
>  <----- thread 1
> .... /\ ........
> 
> Real output on the console:
> 
> .... /\ ........
>  <----- thread 1
>  <----- thread 2
>  <----- thread 1
>  <----- thread 2
>  <----- thread 1
>  <----- thread 2
> !!!!!!!!!!! thread2 interval timeout = 335 ms
>  <----- thread 1
>  <----- thread 2
>  <----- thread 1
>  <----- thread 2
>  <----- thread 1
> .... /\ ........ 
> 
> This timeout shows up around every second and has always about the same
> value of 335 ms.
> Can somebody reproduce this behaviour ( the console speed and/or thread
> interval may have to be tweaked to clog the serial output) ?
> Thank you in advance for your help.

Could you not post HTML please? Thanks.

"Deadlock" means dead due to incorrect locking. Instead, you seem to be
talking about a momentary pause. :)

Are you saying that the problem does not occur when you do not use
/dev/console? What about /dev/ttyS0, or whatever your serial port device
is?

You're certain that this isn't simply a result of multitasking?

-- 
Hollis Blanchard
IBM Linux Technology Center
