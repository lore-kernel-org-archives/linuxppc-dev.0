Return-Path: <r.buergel@unicontrol.de>
Received: from mo-p00-ob.rzone.de (mo-p00-ob.rzone.de [81.169.146.160])
	by ozlabs.org (Postfix) with ESMTP id 1A19CDDF43
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Nov 2008 04:02:13 +1100 (EST)
Message-ID: <491322DC.30208@unicontrol.de>
Date: Thu, 06 Nov 2008 18:01:16 +0100
From: =?ISO-8859-1?Q?Ren=E9_B=FCrgel?= <r.buergel@unicontrol.de>
MIME-Version: 1.0
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: [PATCH V2] workaround for mpc52xx erratum #364 (serial may not
	be reset in break state)
References: <490F51E7.3020309@unicontrol.de>	<fa686aa40811031255w3d9a065dgb0eb7ad4b26c9651@mail.gmail.com>
	<4910274E.5030305@unicontrol.de> <49109323.2040603@genesi-usa.com>
In-Reply-To: <49109323.2040603@genesi-usa.com>
Content-Type: multipart/mixed; boundary="------------090701070903030209080209"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------090701070903030209080209
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Matt Sealey schrieb:
>
>
> René Bürgel wrote:
>> But as the serial driver is also used for the MPC5121, we may have to 
>> distinguish anyway. Does anyone have the possibility to test if the 
>> bug in still present  on MPC5121?
>
> Tell us what to do to get it to occur and what we're looking for and we
> have a bunch of boards at Genesi, someone will find the time to test it
> (if not them, then me :)
>
> Right now I'm having a hell of a time getting a 2.6.27.x kernel running
> on it though, some driver support is still missing from mainline making
> it just that little bit extra frustrating to work with.. (if you're
> using the system over a serial console, how are you supposed to test
> serial port operation? USB doesn't work in >2.6.24 so I guess I have to
> hope netconsole works :)
>
Hi, Matt

Thanks for your offer. I'm using telnet to debug the serial port.  I'll 
append a testcase for you, which is just opening a serial port, trying 
to receive for a second, switching the baudrate and doing it receiving 
again. Just run it and connect a slow device to the serial port sending 
data continuously. I'm using a GPS mouse here, working at 9600baud. The 
higher the rate you are receiving at, the higher the chance to falsely 
receive a break. When the serial port is switch off in that moment (the 
filedescriptor is closed), the serial won't receive anything from that 
time, if the bug is present

Alternativly, if you have more control over your serial device, just 
send breaks continuously, open and close the serial port. Open it again 
and receiving data fails, if the bug is present.

Just btw: if USB is not working, did you miss the initialisation of the 
USB-controller in your bootloader? I had similar problems getting from 
2.6.22 to 2.6.25 with my mpc5200.

-- 
René Bürgel
Software Engineer
Unicontrol Systemtechnik GmbH
OT Dittersbach
Sachsenburger Weg 34
09669 Frankenberg
 
Tel.: 03 72 06/ 88 73 - 19
Fax: 03 72 06/ 88 73 - 60
E-Mail: r.buergel@unicontrol.de
Internet: www.unicontrol.de
 
Unicontrol Systemtechnik GmbH
Geschäftsführer: Dipl.-Ing. Siegfried Heinze
Sitz der Gesellschaft: Frankenberg
Registergericht: Amtsgericht Chemnitz, HRB 15 475


--------------090701070903030209080209
Content-Type: text/plain;
 name="erratum364-tc.c"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="erratum364-tc.c"

#include <linux/serial.h>
#include <poll.h>
#include <fcntl.h>
#include <termios.h>
#include <sys/ioctl.h>
#include <stdio.h>
#include <errno.h>
#include <unistd.h>
#include <string.h>

#define DEV_UART "/dev/tts/0"


void initUart(int uart, struct pollfd* pfd, speed_t speed, struct serial_icounter_struct* last_icounter)
{
  struct termios options;
  tcgetattr( uart, &options );

  cfmakeraw( &options );
  cfsetispeed( &options, speed );
  cfsetospeed( &options, speed );

  options.c_cflag &= ~CSIZE;    //clear charsize-bits
  options.c_cflag |= CS8;
  options.c_iflag &= ~PARENB;
  options.c_cflag &= ~CSTOPB;
  options.c_iflag &= ~IGNPAR; // do not ignore framing and parity errors

  tcsetattr( uart, TCSANOW, &options );
  tcflush( uart, TCIOFLUSH );

  //read garbage
  if (poll( pfd, 1, 1000 ) > 0)
  {
    usleep( 500 /*ms*/ * 1000 /*us*/ );

    unsigned char buffer[16384 + 1];
    read( uart, buffer, sizeof( buffer ) );
    ioctl( uart, TIOCGICOUNT, last_icounter );
  }
}

void readUart(int uart, struct pollfd* pfd, struct serial_icounter_struct* last_icounter)
{
  int retval = poll( pfd, 1, 1000 );

  if ( retval > 0 )
  {
    if ( pfd->revents & POLLIN )
    {
      // etwas warten, damit nicht ständig einzelne Zeichen von der Seriellen geholt werden
      // TODO: für z.B. A/D-Probe ggf. reduzieren (Template-Argument?)
      usleep( 2 /*ms*/ * 1000 /*us*/ );

      unsigned buffer[16384 + 1];
      int countBytes = read( uart, buffer, sizeof( buffer ) );

      printf("received something: ");
      {
        int i = 0;
        for (;  i < countBytes; ++i)
          printf("%x ", (unsigned short) buffer[i]);
      }
      printf("\n");

      struct serial_icounter_struct icounter;
      ioctl( uart, TIOCGICOUNT, &icounter );

      if (icounter.brk     != last_icounter->brk    ) printf("Break ");
      if (icounter.frame   != last_icounter->frame  ) printf("Framing Error ");
      if (icounter.parity  != last_icounter->parity ) printf("Parity Error ");
      if (icounter.overrun != last_icounter->overrun) printf("Overrun");
      printf("\n");

      *last_icounter = icounter;
    }
    else
    {
      printf("received nothing\n");
    }
  }
  else
  {
	int error = errno;
	printf("error while waiting for data on serial port: %s\n", strerror( error ) );
  }
}

speed_t getNextSpeed(speed_t curSpeed)
{
	switch (curSpeed)
        {
          case   B4800: return   B9600;
          case   B9600: return  B19200;
          case  B19200: return  B38400;
          case  B38400: return  B57600;
          case  B57600: return B115200;
          case B115200: return   B4800;
        }
	return B4800;
}

int main()
{
	struct pollfd pfd;
	pfd.events = POLLIN;
	speed_t cur_speed=B4800;
        struct serial_icounter_struct last_icounter;

	while(1)
	{
		pfd.fd = open( DEV_UART, O_RDWR | O_NONBLOCK );
		
		printf("trying %d\n", cur_speed);
		initUart(pfd.fd, &pfd, cur_speed, &last_icounter);
		readUart(pfd.fd, &pfd, &last_icounter );
		close( pfd.fd );
		cur_speed = getNextSpeed( cur_speed );
	}
	return 0;
}


--------------090701070903030209080209--
