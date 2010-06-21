Return-Path: <paulus@ozlabs.org>
Date: Mon, 21 Jun 2010 15:27:23 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 1/2] powerpc: Rework VDSO gettimeofday to prevent time
	going backwards
Message-ID: <20100621052723.GC12055@drongo>
References: <20100621050308.GA12055@drongo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100621050308.GA12055@drongo>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Here's the test program I used to verify that the VDSO gettimeofday
and clock_gettime are giving correct results.

Paul.

/*
 * Copyright 2010 Paul Mackerras <paulus@samba.org>, IBM.
 *
 * This program is free software; it may be used and redistributed
 * under the terms of the GNU Public Licence, either version 2, or
 * (at your option) any later version.
 */
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <sys/time.h>
#include <sys/unistd.h>
#include <linux/auxvec.h>
#include <asm/unistd.h>

#define TVTIME(tv)	((tv).tv_sec * 1000000000ull + (tv).tv_usec * 1000ull)
#define TSTIME(ts)	((ts).tv_sec * 1000000000ull + (ts).tv_nsec)

main(int ac, char **av)
{
	struct timeval tv1, tv2;
	struct timespec ts1, ts2, s1, s2;
	int count;

	for (count = 0; count < 10000000; ++count) {
		gettimeofday(&tv1, NULL);
		clock_gettime(CLOCK_REALTIME, &ts1);
		syscall(__NR_clock_gettime, CLOCK_REALTIME, &s1);
		gettimeofday(&tv2, NULL);
		clock_gettime(CLOCK_REALTIME, &ts2);
		syscall(__NR_clock_gettime, CLOCK_REALTIME, &s2);
		if (TVTIME(tv1) > TSTIME(ts1) ||
		    TSTIME(ts1) > TSTIME(s1) ||
		    TSTIME(s1) - s1.tv_nsec % 1000 > TVTIME(tv2) ||
		    TVTIME(tv2) > TSTIME(ts2) ||
		    TSTIME(ts2) > TSTIME(s2)) {
			printf("ERROR:  %lld %lld %lld\n\t%lld %lld %lld\n",
			       TVTIME(tv1), TSTIME(ts1), TSTIME(s1),
			       TVTIME(tv2), TSTIME(ts2), TSTIME(s2));
			exit(1);
		}
	}
	exit(0);
}
