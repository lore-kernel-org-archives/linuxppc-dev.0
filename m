Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: August Hoerandl <ahoerandl@gmx.at>
Reply-To: ahoerandl@gmx.at
To: linuxppc-embedded@lists.linuxppc.org
Subject: new uart on MPC8xx 
Date: Mon, 25 Jun 2001 10:36:49 +0200
Content-Type: text/plain;
  charset="iso-8859-1"
MIME-Version: 1.0
Message-Id: <01062510364900.00667@linuxhoe>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I was checking the new uart (got the kernel from
ftp://ftp.denx.de/pub/LinuxPPC/usr/src/linux-2.4.4-2001-05-12.tar.bz2 )

I tried to use some pins on port b for handshake and it refuses to compile:
The problem is in uart.c around line 80:

#if (CONFIG_UART_DTR_CONTROL_SCC1 == PORT_B)
#define PORT_DTR1_PAR immap->im_ioport.iop_pbpar

but 8xx_immap.h reads:

typedef struct comm_proc {
        ...
        uint   cp_pbdir;

so port b is a little different from all the other ports ;-)

Has anyone got a patch to correct this ?

Thanks
Gustl

ps: is this list the right place to report such troubles ?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
