Return-Path: <jangiels@speakeasy.net>
Received: from mail4.speakeasy.net (mail4.speakeasy.net [216.254.0.204])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 48AA92BC0F
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Oct 2004 14:01:44 +1000 (EST)
Received: from dsl017-104-254.spk0.dsl.speakeasy.net (HELO [192.168.0.10])
	(jangiels@[69.17.104.254]) (envelope-sender <jangiels@speakeasy.net>)
	by mail4.speakeasy.net (qmail-ldap-1.03) with SMTP
	for <linuxppc-dev@ozlabs.org>; 18 Oct 2004 04:01:36 -0000
From: Jeff Angielski <jangiels@speakeasy.net>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: multipart/mixed; boundary="=-7Tt5dsV6mWXrci3EpSG7"
Message-Id: <1098072098.751.32.camel@nighteyes.localdomain>
Mime-Version: 1.0
Date: Mon, 18 Oct 2004 00:01:38 -0400
Subject: SCC UART hang
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-7Tt5dsV6mWXrci3EpSG7
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


I am seeing a problem on my EP8260 board whereby my SCC2 UART is
sometimes hanging under heavy load.  

I am using the latest DENX kernel.

My SCC2 UART is configured with no flow control.  I am trying to get it
to work with 115k and 230k baud rates.

When it hangs:  I no longer see any SCC UART interrupts, my test
application that is transmitting/receiving the data is idle, and
sometimes the application reports that it has received more data than
was actually transmitted...

I'll attach my little test program before anybody asks how I am doing
the testing.  It is pretty straightforward.  Most of the code is to help
collect the data and make the output user friendly.

Anybody run into anything similar or have any ideas on what may be
causing the problem?

Thanks,
Jeff Angielski






 

--=-7Tt5dsV6mWXrci3EpSG7
Content-Disposition: attachment; filename=uarttest.c
Content-Type: text/x-c; name=uarttest.c; charset=UTF-8
Content-Transfer-Encoding: 7bit

#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <unistd.h>
#include <termios.h>
#include <fcntl.h>
#include <asm/types.h>
#include <sys/types.h>
#include <linux/if_packet.h>
#include <linux/if_ether.h> 
#include <linux/if_arcnet.h> 
#include <linux/version.h>
#include <net/if.h>
#include <net/if_arp.h>
#include <netinet/in.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <sys/time.h>
#include <signal.h>
#include <ctype.h>
#include <pthread.h>
#include <sys/time.h>
#include <stdlib.h>
#include <errno.h>

#ifdef _NOT_USED_
#endif

#define USE_HDLC_READ
#define USE_SCC_UART
#define USE_UART_READ

#define MAX_PKT_SIZE 		1500
#define DEFAULT_PKT_SIZE 	554
#define DEFAULT_ITERATIONS	1
#define DEFAULT_BAUD_RATE	B230400
#define DEFAULT_READ_TIMEOUT	3

static int uartfd;
static int uart_tx_bytes=0;
static int uart_rx_bytes=0;

static int iterations=DEFAULT_ITERATIONS;
static int pkt_size=DEFAULT_PKT_SIZE;
static int baud_rate=DEFAULT_BAUD_RATE;

static struct termios oldtty,newtty;
static pthread_t write_uart_thread_id;
static pthread_t read_uart_thread_id;

void hexdump(unsigned char *p, int count)
{
	int i, j;

	for(i = 0; i < count; i += 16) {
		printf("%04x : ", i);
		for (j = 0; j < 16 && i + j < count; j++)
			printf("%2.2x ", p[i + j]);
		for (; j < 16; j++) {
			printf("   ");
		}
		printf(": ");
		for (j = 0; j < 16 && i + j < count; j++) {
			char c = toascii(p[i + j]);
			printf("%c", isalnum(c) ? c : '.');
		}
		printf("\n");
	}
}

static char *get_bps(int baud)
{
	char *retval;
	switch(baud)
	{
		case B0:	retval = "0";		break;
		case B300:	retval = "300";		break;
		case B600:	retval = "600";		break;
		case B1200:	retval = "200";		break;
		case B2400:	retval = "2400";	break;
		case B4800:	retval = "4800";	break;
		case B9600:	retval = "9600";	break;
		case B19200:	retval = "19200";	break;
		case B38400:	retval = "38400";	break;
		case B57600:	retval = "57600";	break;
		case B115200:	retval = "15200";	break;
		case B230400:	retval = "230400";	break;
		default:	retval ="unknwon";	break;
				   
	}

	return retval;

}

static int get_baud(char *baud_rate_bps)
{
	int newbaud;
	int retval=-1;

	/* Check if 'baudr' is really a number */
	if ((newbaud = (atol(baud_rate_bps) / 100)) == 0 && 
			baud_rate_bps[0] != '0') {
		newbaud = -1;
	}

	switch(newbaud) {
		case 0:         retval = B0;       break;
		case 3:         retval = B300;     break;
		case 6:         retval = B600;     break;
		case 12:        retval = B1200;    break;
		case 24:        retval = B2400;    break;
		case 48:        retval = B4800;    break;
		case 96:        retval = B9600;    break;
		case 192:       retval = B19200;   break;
		case 384:       retval = B38400;   break;
		case 576:       retval = B57600;   break;
		case 1152:      retval = B115200;  break;
		case 2304:      retval = B230400;  break;
	}

	return retval;
}



ssize_t writen(int fd, const void *vptr, size_t n)
{
	size_t nleft;
	ssize_t nwritten;
	const char *ptr;

	ptr=vptr;
	nleft=n;
	while(nleft>0) {
		if( (nwritten=write(fd, ptr, nleft)) <=0 ) {
			if( errno==EINTR )
				nwritten=0;
			else
				return -1;
		}

		nleft-=nwritten;
		ptr+=nwritten;
	}

	return n;
}

void *write_uart_thread(void *arg)
{
	unsigned char buf[MAX_PKT_SIZE];
	int i;
	int n;
	time_t start,finish;
	double elapsed;

	for(i=0; i<sizeof(buf); i++)
		buf[i]=i&0xff;

	time(&start);
	i=0;
	while(1)
	{
		n = writen(uartfd, buf, pkt_size);
		if (n < 0) {
			perror("write():");
		} else if(n == 0) {
			continue;
		} else {
			uart_tx_bytes+=n;
			if(++i>=iterations)
				break;
		}
	}
	time(&finish);

	elapsed=difftime(finish,start);
	if(elapsed>0) {
		printf("%.1fsec at %.1fbps\n", 
			elapsed, (iterations*pkt_size*8)/elapsed);
	} else {
		printf("%fsec\n", elapsed);
	}

	pthread_exit(NULL);

}

void *read_uart_thread(void *arg)
{
	unsigned char buf[MAX_PKT_SIZE];
	int n;
	fd_set rfds;
	struct timeval tv;

	while(1)
	{
		FD_ZERO(&rfds);
		FD_SET(uartfd, &rfds);

		tv.tv_sec=DEFAULT_READ_TIMEOUT;
		tv.tv_usec=0;

		n=select(uartfd+1,&rfds,NULL,NULL,&tv);
		if(n>0) {
			if(FD_ISSET(uartfd,&rfds)) {
				n = read(uartfd, buf, pkt_size);
				if(n>0) {
					/* hexdump(buf,n); */
					uart_rx_bytes+=n;
				}
			}
		} else if (n==0) {
			break;
		} else {
			if(errno!=EINTR) {
				printf("%s: select() error\n", __FUNCTION__);
			}
		}
	}		

	pthread_exit(NULL);
}

void display_settings(void)
{
	printf("Settings: %d x %dbytes (%dbytes) @ %sbps\n",
		iterations, pkt_size, (iterations*pkt_size),
		get_bps(baud_rate));
}


void termination_handler(int sig)
{
	printf("uart: tx=%d rx=%d : %s\n", 
		uart_tx_bytes, uart_rx_bytes,
		(uart_tx_bytes==uart_rx_bytes) ? "PASSED" : "FAILED");

	pthread_kill(write_uart_thread_id,SIGTERM);
	pthread_kill(read_uart_thread_id,SIGTERM);

	exit(0);
}

int main(int argc, char **argv)
{
	int c;
	int newbaud;


	while(1) 
	{
		c=getopt(argc,argv,"n:s:b:");
		switch(c) {
		case 'n':
			iterations=atoi(optarg);
			break;
		case 's':
			pkt_size=atoi(optarg);
			if(pkt_size>MAX_PKT_SIZE)
				pkt_size=MAX_PKT_SIZE;
			break;
		case 'b':
			newbaud=get_baud(optarg);
			if(newbaud!=-1) 
				baud_rate=newbaud;
			break;
		case -1:
			break;
		default:
			printf("usage: uarttest [-n <n>] [-s <size>] [-b <baud>]\n");
			exit(1);
		}
		
		if(c==-1)
			break;
	}

	/* register the signal handler */
	if(signal(SIGINT,termination_handler)==SIG_IGN)
		signal(SIGINT,SIG_IGN);

	display_settings();

	/* open the serial port */
	if( (uartfd=open("/dev/tts/2", O_RDWR | O_NOCTTY )) < 0 ) {
		perror("open(): serial port\n");
		exit(1);
	}

	/* save old settings */
	tcgetattr(uartfd, &oldtty);

	/* configure for raw mode */
	bzero(&newtty,sizeof(newtty));
	newtty.c_cflag = CLOCAL | CREAD | CS8;
	newtty.c_iflag = IGNPAR;
	newtty.c_oflag = 0;
	newtty.c_lflag = 0;

	/* optimize for our interface(?) */
	newtty.c_cc[VTIME] = 0;
	newtty.c_cc[VMIN] = 1; 

	cfsetospeed(&newtty, (speed_t)baud_rate);
	cfsetispeed(&newtty, (speed_t)baud_rate);

	tcflush(uartfd, TCIOFLUSH);

	tcsetattr(uartfd, TCSANOW, &newtty);

	if( pthread_create(&read_uart_thread_id, NULL, 
			    read_uart_thread, (void *)0 )!=0 ) {
		printf("Could not create thread\n");
		exit(1);
	}

	if( pthread_create(&write_uart_thread_id, NULL, 
			    write_uart_thread, (void *)0 )!=0 ) {
		printf("Could not create thread\n");
		exit(1);
	}

	pthread_join(read_uart_thread_id,NULL);
	pthread_join(write_uart_thread_id,NULL);

	tcsetattr(uartfd, TCSANOW, &oldtty);
	printf("uart: tx=%d rx=%d : %s\n", 
		uart_tx_bytes, uart_rx_bytes,
		(uart_tx_bytes==uart_rx_bytes) ? "PASSED" : "FAILED");
	exit(0);
}

--=-7Tt5dsV6mWXrci3EpSG7--
