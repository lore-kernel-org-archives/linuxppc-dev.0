Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3BCD5B30.5396ADEC@disca.upv.es>
Date: Wed, 17 Oct 2001 12:19:28 +0200
From: David de =?iso-8859-1?Q?Andr=E9s=20Mart=EDnez?= <ddandres@disca.upv.es>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Access to registers of MPC823E
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I'm trying to write a program to run in Linux 2.4.4 (booting from
PPCBoot) on a TQM823L (MPC823E), but I'm having some problems.

I have the following definitions in the headers:
----------------
#define TCGR IMR_USHORT(0x0980)
#define IMR_USHORT(addr) V_USHORT(CFG_IMMR + addr)
#define IMR_USHORT(addr) (addr)
#define V_USHORT(a) (*(volatile unsigned short *)(a))
#define CFG_IMMR 0xFFF00000
----------------

When my main program tries to access to TCGR to read or write it simply
exits out of the program without a warning into the shell.
----------
> ./main
> START....
>
----------

Just to check if something is wrong, I have tested this code:
-----------------
 unsigned long immr;

 asm( "mfspr %0,638": "=r"(immr) : );
 printf("IMMR = %li\n", immr);
----------------

But it didn't printf anything, just gets out of the program as before.

Got any idea of what can be going on?

--
----------------------------------------------------------------------
| David de Andrés Martínez   | Fault Tolerant Systems research Group |
|                            |                                       |
| Computer Science Engineer  | Email: ddandres@disca.upv.es          |
| Doctorate Student          | Phone: +34 96 387.75.74 Ext 75774     |
|                            | Fax: +34 96 387.75.79                 |
-------Address--------------------------------------------------------
|                 DISCA-EUI                                          |
|                 Universidad Politécnica de Valencia                |
|                 Campus de Vera #14                                 |
|                 Valencia E-46021                                   |
|                 Spain                                              |
----------------------------------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
