Message-ID: <E1836A7F3557D311A14000805F9F36FCD4E4FF@usdfo011.usac.danfoss.net>
From: "Pergola, Michael" <MichaelPergola@Danfoss.com>
To: "'Sergio Massami Sakai'" <Sakai@cpqd.com.br>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: problems using 823 serial port
Date: Thu, 25 Oct 2001 21:25:01 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Sergio,

Try incorporating these into your code:
   	io = open(MODEMDEVICE, O_RDONLY | O_NOCTTY | O_NDELAY);
   	cfsetispeed(&newtio, BAUDRATE);   /*  change port baud rate */
   	cfsetospeed(&newtio, BAUDRATE);
      /* ignore ^C interrupt but enable flow control on input */
	new_opts.c_iflag |= (IGNBRK | IXOFF);
      /* disable flow control on output */
	new_opts.c_iflag &= ~(IXON);
	     	fcntl(fd, F_SETFL, 0);

Regards,
     Michael Pergola
     Software Engineer
     Danfoss Air-Conditioning & Refrigeration Division
     7941 Corporate Blvd.
     Baltimore, MD  21236


> -----Original Message-----
> From:	Sergio Massami Sakai [SMTP:Sakai@cpqd.com.br]
> Sent:	Thursday, October 25, 2001 2:58 PM
> To:	linuxppc-embedded@lists.linuxppc.org
> Subject:	problems using 823 serial port
>
>
> Hi everybody,
>
> I´ve been trying to use the serial port of a FADS 823 board to control
> an external hardware and I had some problems.
>
> I´ve implemented and tested some functions using the serial port of my
> PC (running Red Hat 6.2) to make this hardware control and everything
> worked fine.
> But, when I tried to use the same functions (with the same serial port
> configuration) in my FADS board running the 2.4.4 Linux kernel version
> (from denx.de), I couldn´t read the messages that I received at my
> serial port (read returns -1).
>
> I´ve made another test using the non canonical example mentioned in
> Peter Baumann´s howto (Serial Programming Howto) to receive, at my
> board, messages that I sent from my PC using miniterm (I´ve used the non
> canonical example because the configuration that I use for receiving the
> messages at the serial port is similar).
> When I tried this, the board´s serial port driver didn´t buffer any
> message (well, I think so, cause I coudn´t read nothing) before I sent a
> Carriage Return or a Line Feed.
> For each message I send, I must to send a CR ou LF before. For example:
>  PC               FADS BOARD
> 1234              No response
> <CR>1234          1234
> <LF>1234           1234
>
> This fact doesn´t happen when I use the PC´s serial port to receive
> messages (using the same program).
> Does anyone know what could be the problem?
>
> Thanks,
>
> 	Sakai
>
> PS:
> The program that I have used for reading the serial port:
>
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <fcntl.h>
> #include <termios.h>
> #include <stdio.h>
>
> #define BAUDRATE B9600
> #ifdef PPC
> #define MODEMDEVICE "/dev/ttyS0"
> #else
> #define MODEMDEVICE "/dev/ttyS1"
> #endif
>
> #define _POSIX_SOURCE 1 /* POSIX compliant source */
> #define FALSE 0
> #define TRUE 1
>
> volatile int STOP=FALSE;
>
> main()
> {
>   int fd,c, res;
>   struct termios oldtio,newtio;
>   char buf[255];
>
>   fd = open(MODEMDEVICE, O_RDWR | O_NOCTTY );
>   if (fd <0) {perror(MODEMDEVICE); exit(-1); }
>
>   tcgetattr(fd,&oldtio); /* save current port settings */
>
>   bzero(&newtio, sizeof(newtio));
>   newtio.c_cflag = BAUDRATE | CRTSCTS | CS8 | CLOCAL | CREAD;
>   newtio.c_iflag = IGNPAR;
>   newtio.c_oflag = 0;
>
>   /* set input mode (non-canonical, no echo,...) */
>   newtio.c_lflag = 0;
>
>   newtio.c_cc[VTIME]    = 0;   /* inter-character timer unused */
>   newtio.c_cc[VMIN]     = 5;   /* blocking read until 5 chars received
> */
>
>   tcflush(fd, TCIFLUSH);
>   tcsetattr(fd,TCSANOW,&newtio);
>
>
>   while (STOP==FALSE) {       /* loop for input */
>     res = read(fd,buf,5);   /* returns after 5 chars have been input */
>     //buf[res]=0;               /* so we can printf... */
>     for (c=0;c<res;c++)
>     	printf("%02x ",buf[c]);
>     printf(":%d\n",res);
>     //printf(":%s:%d\n", buf, res);
>     if (buf[0]=='z') STOP=TRUE;
>   }
>   tcsetattr(fd,TCSANOW,&oldtio);
> }
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
