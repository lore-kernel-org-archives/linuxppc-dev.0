Return-Path: <NWilson@Airspan.com>
Received: from mail.airspan.com (mail.airspan.com [62.189.116.4])
	by ozlabs.org (Postfix) with ESMTP id 096AB2BDEB
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 Nov 2004 00:59:42 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Wed, 10 Nov 2004 13:58:29 -0000
Message-ID: <3506EDCDEC47904CBE6FD2E1DEEA8984020CFB71@fs5.airspan.com>
From: "Neil Wilson" <NWilson@Airspan.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: mmap64/open64/pread etc on 440GX
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I am trying to write a command line utility for our dev board
(440GX,2.6.9 kernel) in order to provide support for our hardware
engineers.  As a test I am trying to dump the first few bytes of the
U-boot header.

I though that this would work but using /dev/mem gives me a bad address
error on the pread64, using /dev/kmem only reads back 0 bytes.  Is there
something blindingly obvious that I am missing for using 36bit addresses
? I believe the address is correct as I can see the boot code from
within the kernel. Thanks.

#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>

unsigned char buf[10240];

int main(int argc,char **argv)
{
	unsigned long long memAddr=3D0x00000001fff80000ULL;
	int x;
	int fd;
	int readSize;
	int pageSize;
=09
	pageSize=3Dsysconf(_SC_PAGESIZE);
=09
	fd=3Dopen64("/dev/mem", O_RDWR);
	if(fd=3D=3D-1)
	{
		perror("open64");
		return 0;
	}
=09
	readSize=3Dpread64(fd,(void*)buf,pageSize,memAddr);
=09
	if(readSize !=3D pageSize)
	{
		perror("pread64 ");
		printf("only read %d of %d requested bytes\n", readSize,
pageSize);
	}
=09
	close(fd);
=09
	// show some of it
	if(readSize>0)
	{
		for(x=3D0;x<25;x++)
		{
			printf("%02x(%c)
",buf[x],isprint(buf[x])?buf[x]:'.');
		}
		printf("\n");
	}
}

Neil

--
Neil Wilson
Airspan Communications Ltd.
Cambridge House, Oxford Road,
Uxbridge, Middx, UB8 1UN, UK.
Tel: +44(0)1895-467265

neilwilson@airspan.com
www.airspan.com
