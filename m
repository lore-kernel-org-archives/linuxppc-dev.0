Return-Path: <sonny@us.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 28DE8DDE01
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 17:15:30 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m5I7FSkk012973
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 03:15:28 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m5I7FRtL178042
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 01:15:28 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m5I7FRF0016804
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 01:15:27 -0600
Received: from us.ibm.com (zoidberg.austin.ibm.com [9.41.41.81])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m5I7FRWH016780
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 01:15:27 -0600
Resent-Message-ID: <20080618071527.GE29409@localhost.localdomain>
Date: Wed, 18 Jun 2008 01:53:46 -0500
From: Sonny Rao <sonnyrao@us.ibm.com>
To: jschopp@austin.ibm.com
Subject: Re: [PATCH] Power5,Power6 BSR driver
Message-ID: <20080618065346.GC13318@localhost.localdomain>
References: <20080616185344.GB16192@gamma>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080616185344.GB16192@gamma>
Cc: sonnyrao@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jun 16, 2008 at 01:53:44PM -0500, jschopp@austin.ibm.com wrote:
> From: Sonny Rao <sonnyrao@linux.vnet.ibm.com>
> 
> Adds a character driver for BSR support on IBM POWER systems including 
> Power5 and Power6.  The BSR is an optional processor facility not currently 
> implemented by any other processors.  It's primary purpose is large SMP 
> synchronization.  More details on the BSR are in comments to the code which 
> follows.
> 


Here's a basic, quick n' dirty testcase I have
Remember to link w/ -lpthread


#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdint.h>
#include <pthread.h>

static void rw_test(char *map, unsigned bytes)
{
	unsigned i;
	printf("reading current bsr values\n");
	for (i=0 ; i < bytes;i++) {
		printf("bsr[%u] = 0x%x\n",
		       i, map[i]);
	}
	printf("writing all 1s into bsr\n");
	for (i=0; i< bytes; i++) {
		map[i] = 0xff;
	}
	printf("reading current bsr values\n");
	for (i=0 ; i < bytes;i++) {
		printf("bsr[%u] = 0x%x\n",
		       i, map[i]);
	}
	printf("writing all byte numbers into bsr\n");
	for (i=0; i< bytes; i++) {
		map[i] = i;
	}
	printf("reading current bsr values\n");
	for (i=0 ; i < bytes;i++) {
		printf("bsr[%u] = 0x%x\n",
		       i, map[i]);
	}

}

struct thread_data {
	pthread_t thread;
	volatile char *map;
	unsigned id;
	uint64_t counter;
};

#define be_busy(cycles) do { \
  __asm__ __volatile__ ("1: addic. %0,%0,-1\n" \
			"   bne 1b\n" : :"r" (cycles) : "cr0"); } while(0)
#define  __sync() do { \
  __asm__ __volatile__ ("sync\n" ::: "memory"); } while(0)

static
void * thread_fn(void * data)
{
	struct thread_data *mydata = data;

	__sync();
	mydata->map[mydata->id]++;
	__sync();
	while (mydata->map[0] == 0) {
		/* be_busy(10); */
		mydata->counter++;
	}
	return NULL;
}

static
void pthread_test(volatile char *map, unsigned num)
{
	struct thread_data *pthreads;
	unsigned i;

	pthreads = malloc(sizeof(struct thread_data) * num);
	if (!pthreads) {
		perror("malloc");
		return;
	}
	for (i=0; i<num; i++) {
		map[i] = 0;
	}
	__sync();
	for (i=1; i< num;i++) {
		struct thread_data *cur = &pthreads[i];
		cur->map = map;
		cur->id  = i;
		if (pthread_create(&cur->thread, NULL, thread_fn, cur)) {
			perror("pthread_create");
			exit(1);
		}
	}
	for (i=1; i<num;i++) {
		char status;
		do {
			status = map[i];
		} while(status == 0);
	}
	__sync();
	map[0] = 1;
	__sync();
	for (i=1; i<num;i++) {
		if (pthread_join(pthreads[i].thread, NULL)) {
			perror("pthread_join");
		}
		printf("%03u %llu\n", pthreads[i].id, pthreads[i].counter);
	}
	free(pthreads);
}

int main (int argc, char *argv[])
{
	char *file;
	int fd;
	char *map;
	int pagesize = getpagesize();
	unsigned  bytes;

	if (argc < 3) {
		fprintf(stderr, "usage: <bsr dev> <num bytes>\n");
		return 1;
	}
	file = argv[1];
	bytes = strtoul(argv[2], NULL, 0);
	fd = open(file, O_RDWR);
	if (fd < 0) {
		perror("open");
		return 1;
	}
	map = mmap(NULL, pagesize, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
	if (!map) {
		perror("mmap");
		close(fd);
		return 1;
	}

	rw_test(map, bytes);
	pthread_test(map, bytes);
	close(fd);
	return 0;
}
