Message-Id: <m0zsJFT-001C3VC@shell.rmi.net>
From: tph@rmi.net (Tom Harrington)
Subject: TurboMouse fix
To: linuxppc-user@lists.linuxppc.org
Date: Mon, 21 Dec 1998 21:16:43 -0700 (MST)
Cc: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've updated Mark Abene's "mousehack" fix for the Kensington Turbo Mouse
to work with newer kernels.  The source code is below.

It should compile straight away-- "cc mousehack.c".  Then run the program,
abd your TurboMouse should work as a 3-button mouse.  If it works for you,
put it somewhere convenient (like /sbin) and call it from /etc/rc.d/rc.local.

This has only been tested on a G3 desktop, running 2.1.125, with a
version 5.0 TurboMouse.  I'd appreciate feedback on how it works
(or fails to work) with other setups.

See notes in the comments about tracking speed and button arrangement.

Tom Harrington

--- cut here ---
/* mousehack.c
 *
 * A program for linux-pmac by jonh Tue Feb 18 00:46:10 EST 1997
 * hacked mercilessly by warner@lothar.com: don't blame jonh for my bugs!
 *
 * Now does magic for the Kensington turbo mouse trackball (phiber@phiber.com)
 * 8/30/98
 *
 * Minor update to make it work with 2.1.125 (tph@rmi.net) 12/21/1998
 * - If tracking is too fast, use "xset" to fix it.
 * - If button arrangement seems weird, use "xmodmap".  The default is:
 *	lower left = 1, lower right = 2, upper left = 3, upper left = off.
 *	xmodmap -e "pointer = 1 3 2" works for me.
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
  
    	sethandler(15, -1);	/* tph */
	sethandler(3, 4);
	moveadb(3, 15);
	initreg2();
	setreg2();

	close(fd);
	return 0;
}
--- cut here ---


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
