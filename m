Message-ID: <19981220155325.E16123@radicalmedia.com>
Date: Sun, 20 Dec 1998 15:53:25 -0500
From: Mark Abene <phiber@radicalmedia.com>
To: linuxppc-user@lists.linuxppc.org
Cc: linuxppc-dev@lists.linuxppc.org, linux-pmac@samba.anu.edu.au
Subject: Re: turbo mouse woes
References: <199812200843.DAA10162@foo.icanect.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <199812200843.DAA10162@foo.icanect.net>; from J. Benjamin on Sun, Dec 20, 1998 at 03:45:30AM +0000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Dec 20, 1998 at 03:45:30AM +0000, J. Benjamin wrote:
> 
> The maintainer of the FAQoMatic created something called "mousehack" which
> worked for me but it only works with an outdated kernel, 2.1.14. Perhaps
> someone can download it's source and update it for the latest kernels? It
> can be found at <ftp://ftp.cs.dartmouth.edu/pub/jonh/linux-pmac/>
> 
> 

Actually, I wrote mousehack.  Jon Howell wrote mousemode, which works with
"generic" extended mice.  Newer Turbo Mouse trackballs need a little proprietary
nonsense (read "magic") sent to ADB register 2.  That's where my program
comes in.  It uses the ADB semantics of the 2.1.24 kernel, but could easily
be adapted to the newer kernels.  Anyways, here's the source...

---cut here---
/* mousehack.c
 *
 * A program for linux-pmac by jonh Tue Feb 18 00:46:10 EST 1997
 * hacked mercilessly by warner@lothar.com: don't blame jonh for my bugs!
 *
 * Now does magic for the Kensington turbo mouse trackball (phiber@phiber.com)
 * 8/30/98
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <fcntl.h>
#include <asm/adb_mouse.h>
#include <asm/cuda.h>

int fd;

void
send(unsigned char *y, int len)
{
    int n;

#ifdef DEBUG
    printf("send: ");
    for (n=0; n < len; n++)
	printf("0x%02x ",y[n]);
    printf("\n");
#endif

    n = write(fd, y, (size_t) len);
    if (n < len) {
	perror("writing /dev/adb");
	close(fd);
	exit (EXIT_FAILURE);
    }
}

void
listen(unsigned char *y)
{
    int n;
    
    n = read(fd, y, 80);

#ifdef DEBUG
    printf("%d: ",n);
    if (n > 0) {
	int i;
	for (i=0; i < n; i++)
	    printf("0x%02x ",y[i]);
    }
    printf("\n");
#endif

    if (n < 0) {
	perror("reading /dev/adb");
	close(fd);
	exit(EXIT_FAILURE);
    }
}

void
sethandler(int addr, int handler)
{
    unsigned char y[15];

    y[0] = ADB_PACKET;
    /* mouse (0x30) listen (0x08) reg 3 (0x03) */
    y[1] = ADB_WRITEREG(addr, 3);
    /* service request enable (0x20), device addr 3 (0x03) */
    y[2] = 0x20 + addr;
    y[3]= handler;

    send(y, 4);
    listen(y);
}

void
moveadb(int src, int dst)
{
	unsigned char y[15];
	
	y[0] = ADB_PACKET;
	y[1] = ADB_WRITEREG(src, 3);
	y[2] = 0x20 + dst;
	y[3] = 0xfe;

	send(y, 4);
	listen(y);
}

void
initreg2()
{
	unsigned char x[15];
	unsigned char y[] = { ADB_PACKET, ADB_WRITEREG(3, 2), 0xe7, 0x8c, 0, 0, 0, 0xff, 0xff, 0x94 };
	send(y, 10);
	listen(x);

	x[0] = ADB_PACKET;
	x[1] = 0x31;	/* flush device 3 */
	send(x, 2);
	listen(x);
}


void
setreg2()
{
	unsigned char y[] = { ADB_PACKET, ADB_WRITEREG(3, 2), 0xa5, 0x14, 0, 0, 0x69, 0xff, 0xff, 0x27 };
	send(y, 10);
	listen(y);
}

int
main(int argc, char **argv)
{
	fd = open("/dev/adb", O_RDWR);
	if (fd <= 0) {
		perror("opening /dev/adb");
		exit(EXIT_FAILURE);
	}
    
	sethandler(3, 4);
	moveadb(3, 15);
	initreg2();
	setreg2();

	close(fd);
	return 0;
}
---cut here---

Cheers!
-Mark


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
