Return-Path: <bouncefilter+linuxppc-embedded=wd=denx.de@lists.linuxppc.org>
Message-ID: <CA78D1B723D8D411AF0300508BDCF74FDEFF5C@NTCORREO>
From: GOTZON ASTONDOA <gastondoa@fagorautomation.es>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Serial line bug?
Date: Thu, 26 Sep 2002 17:01:24 +0200
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

We have a custom board based on mpc823. This board has two serial lines, one
on the SMC1 and on the SCC2 the other. We are using linux-2.4.4-2001-07-23
kernel.

We have configured the kernel to have those two serial lines, ttyS0 on SMC1
using BRG1 and ttyS1 on SCC2 using BRG2. Doing this, ttsyS1 doesn't work.

With the following aplication and some printks in the kernel

int main (void)
{
      int fd, result;
       char buffer[255];
       struct termios tio;

      /* Abrir el device*/
      fd = open("/dev/ttyS1", O_RDWR | O_NDELAY | O_NOCTTY);

      if(fd < 0)
      {
        printf("OPEN  ERROR\n");
        perror("\n");
       }
       printf(" FD: %d\n", fd);

       tio.c_cflag = 57600 | CS8 | CREAD | CLOCAL;
       tio.c_cflag &= ~HUPCL;
       tio.c_lflag = 0;
       tio.c_iflag = IGNPAR;
       tio.c_oflag = 0;
       tio.c_cc[VTIME] = 0;
       tio.c_cc[VMIN] = 0;

       tcflush(fd, TCIFLUSH);
       tcsetattr(fd, TCSANOW, &tio);

       fcntl(fd, F_SETFL, FNDELAY);

       result = 0;
       result = write(fd,"AUPA\n", ( sizeof("AUPA\n")  );

       close(fd);
}


we have realized that the funcion change_speed of uart.c is called 2 times,
and this function, in the same time, calls the function m8xx_cpm_setbrg of
commproc.c. The first
time, m8xx_cpm_setbrg function is called with right values but the second
time is called with wrong values: the baudrate is 0.

This has a terrible efect:  m8xx_cpm_setbrg function does a 0 division
operation and modifies brgc2 value to 0x3ffff.

We have done the following modification in the m8xx_cpm_setbrg function

void m8xx_cpm_setbrg(uint brg, uint rate)
{
	volatile uint	*bp;

            if(rate == 0)    return;  ------------------------------->
MODIFICATION DONE

            /* This is good enough to get SMCs running.....
	*/
	bp = (uint *)&cpmp->cp_brgc1;
            ..................
            ...............


and now the the second serial line ttyS1 works properly.

Also, we have realized that changing the BRG number of first serial line,
that we use as system console, from BRG1 to BRG2 or BRG3, the kernel
crashes.

We don't know if both cases are the same problem or no.


We have a last question. Our board has Ethernet on the SCC3, and this is not
compatible with the SMC1. We know that we have to install SMC microcode
patch.

Do we have  to  modify the uart.c file to support the microcode patch? (we
think yes, but we don't know how)

Thaks for your help.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
