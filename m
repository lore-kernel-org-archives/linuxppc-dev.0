Return-Path: <wojciech.kromer@dgt.com.pl>
Received: from dgt.com.pl (mail.dgt.com.pl [195.117.141.2])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ED6A367A60
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 21 Nov 2005 18:41:42 +1100 (EST)
Message-ID: <43817ACF.1030903@dgt.com.pl>
Date: Mon, 21 Nov 2005 08:44:15 +0100
From: Wojciech Kromer <wojciech.kromer@dgt.com.pl>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Subject: Strange results with changing HZ
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

My system is:
 - 2.4.25 kernel from denx.de
 - uclibc (gcc 3.4.2) + busybox
 - changed HZ to 1000
 - rebuild kernel only

AFAIR there souldn't be any need to recompile user apps.

I have strange results.
Sleep and timeout selects works fine, but alarm functions seems to be 
too fast.
For example included program or ping waits too short.



it is OK:

# time alarm_test
alarm fired after 0.099166s
real    0m 0.11s
user    0m 0.00s
sys     0m 0.00s
#
# time sleep 1
real    0m 1.01s
user    0m 0.00s
sys     0m 0.00s
# time sleep 10
real    0m 10.01s
user    0m 0.00s
sys     0m 0.00s


but:

# alarm_test
alarm fired after 0.099709s
# alarm_test
alarm fired after 0.099710s


------------------------------------ alarm_test.c :

#include <stdio.h>
#include <signal.h>
#include <unistd.h>
#include <sys/time.h>

static void sighand(int sig)
{
}

int main()
{
 struct timeval tv1, tv2;
 sigset_t set;

 sigfillset(&set);
 sigdelset(&set, SIGALRM);
 sigdelset(&set, SIGINT);

 signal(SIGALRM, sighand);
 gettimeofday(&tv1, NULL);

 alarm(1);
 sigsuspend(&set);
 gettimeofday(&tv2, NULL);

 tv1.tv_sec = tv2.tv_sec - tv1.tv_sec - (tv2.tv_usec < tv1.tv_usec);
 tv1.tv_usec = tv2.tv_usec - tv1.tv_usec + (tv2.tv_usec < tv1.tv_usec) * 
1000000;

 printf("alarm fired after %ld.%06lds\n",
 tv1.tv_sec, tv1.tv_usec);

 return 0;
}
