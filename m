Return-Path: <916@mcd.com.pl>
Received: from v00722.home.net.pl (v00722.home.net.pl [212.85.98.214])
	by ozlabs.org (Postfix) with SMTP id CFF146842D
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 10 Oct 2005 21:42:10 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Date: Mon, 10 Oct 2005 13:37:12 +0200
Message-ID: <99477CB23E7ACB4EA366A2B6970DA618060F7E@mcdserver.mcd.com.pl>
From: "Tomasz Prochownik" <916@mcd.com.pl>
To: <linuxppc-embedded@ozlabs.org>
Subject: MPC5200,PSC in uart mode, receiving problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello.
I'm beginner in ppc linux, so I believe, you can help me. I hope you'll =
be able to understand my english :o).

I have MPC5200Lite board with Linux from Denx (kernel 2.4.25).
I try to use PSC in UART mode to read chars from other system.

My init ttyS function:

   i_Fd =3D open("/dev/ttyS2", O_RDWR | O_NOCTTY |O_NDELAY);

   if (i_Fd =3D=3D -1 )
   {DEBUG_OUT("[ERROR]\r\n");}
   else
   {
	 tcgetattr(i_Fd,&strBufOptions);=09
	 bzero(&strOptions, sizeof(strOptions));
	 strOptions.c_cflag =3D Baud | CS8 |CREAD |CLOCAL;
	 strOptions.c_iflag =3D 0;
	 strOptions.c_oflag =3D 0;
	 strOptions.c_lflag =3D 0;
	 strOptions.c_cc[VTIME] =3D 0;
	 strOptions.c_cc[VMIN] 	=3D 0;
	 tcflush(i_Fd, TCIFLUSH);
         tcsetattr(i_Fd,TCSANOW,&strOptions);
   }


Everything works fine until first framing error (FE)  in receiver. Since =
then function read(i_Fd,DataBuffer,CO_MAX_BUF_LEN-1) returns number of =
received chars, but value of every char in DataBuffer is zero.

I have done some experiments and noticed one more strange things:

1. I use hyperterminal in 115200 baud as root console
2. If I change speed to 9600, send one char to MPC5200 (framing error?) =
and change speed back to 115200 -> uart blocks (there is no response in =
the console).
..so maybe bug isn't in my code...?
I have read in errata about blocking uart receiver(bug ID: 364) , but I =
don't know it can be in my application.

Best regards

-=3D=3D=3D-
Tomasz Prochownik
MCD Electronics
33 861 60 35 w. 13
916@mcd.com.pl
