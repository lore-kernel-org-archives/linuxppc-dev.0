MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: problems using 823 serial port
Date: Thu, 25 Oct 2001 16:57:33 -0200
Message-ID: <54B8AA990A254541B84ACE91146CC9C6089652@MAILSRV2.aquarius.cpqd.com.br>
From: "Sergio Massami Sakai" <Sakai@cpqd.com.br>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi everybody,

I´ve been trying to use the serial port of a FADS 823 board to control
an external hardware and I had some problems.

I´ve implemented and tested some functions using the serial port of my
PC (running Red Hat 6.2) to make this hardware control and everything
worked fine.
But, when I tried to use the same functions (with the same serial port
configuration) in my FADS board running the 2.4.4 Linux kernel version
(from denx.de), I couldn´t read the messages that I received at my
serial port (read returns -1).

I´ve made another test using the non canonical example mentioned in
Peter Baumann´s howto (Serial Programming Howto) to receive, at my
board, messages that I sent from my PC using miniterm (I´ve used the non
canonical example because the configuration that I use for receiving the
messages at the serial port is similar).
When I tried this, the board´s serial port driver didn´t buffer any
message (well, I think so, cause I coudn´t read nothing) before I sent a
Carriage Return or a Line Feed.
For each message I send, I must to send a CR ou LF before. For example:
 PC               FADS BOARD
1234              No response
<CR>1234          1234
<LF>1234           1234

This fact doesn´t happen when I use the PC´s serial port to receive
messages (using the same program).
Does anyone know what could be the problem?

Thanks,

	Sakai

PS:
The program that I have used for reading the serial port:

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <termios.h>
#include <stdio.h>

#define BAUDRATE B9600
#ifdef PPC
#define MODEMDEVICE "/dev/ttyS0"
#else
#define MODEMDEVICE "/dev/ttyS1"
#endif

#define _POSIX_SOURCE 1 /* POSIX compliant source */
#define FALSE 0
#define TRUE 1

volatile int STOP=FALSE;

main()
{
  int fd,c, res;
  struct termios oldtio,newtio;
  char buf[255];

  fd = open(MODEMDEVICE, O_RDWR | O_NOCTTY );
  if (fd <0) {perror(MODEMDEVICE); exit(-1); }

  tcgetattr(fd,&oldtio); /* save current port settings */

  bzero(&newtio, sizeof(newtio));
  newtio.c_cflag = BAUDRATE | CRTSCTS | CS8 | CLOCAL | CREAD;
  newtio.c_iflag = IGNPAR;
  newtio.c_oflag = 0;

  /* set input mode (non-canonical, no echo,...) */
  newtio.c_lflag = 0;

  newtio.c_cc[VTIME]    = 0;   /* inter-character timer unused */
  newtio.c_cc[VMIN]     = 5;   /* blocking read until 5 chars received
*/

  tcflush(fd, TCIFLUSH);
  tcsetattr(fd,TCSANOW,&newtio);


  while (STOP==FALSE) {       /* loop for input */
    res = read(fd,buf,5);   /* returns after 5 chars have been input */
    //buf[res]=0;               /* so we can printf... */
    for (c=0;c<res;c++)
    	printf("%02x ",buf[c]);
    printf(":%d\n",res);
    //printf(":%s:%d\n", buf, res);
    if (buf[0]=='z') STOP=TRUE;
  }
  tcsetattr(fd,TCSANOW,&oldtio);
}


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
