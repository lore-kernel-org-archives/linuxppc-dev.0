Return-Path: <jbirch04@sbcglobal.net>
Message-ID: <20051130220235.18496.qmail@web81002.mail.mud.yahoo.com>
Date: Wed, 30 Nov 2005 14:02:35 -0800 (PST)
From: Joe Birch <jbirch04@sbcglobal.net>
To: Linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: user thread will occassionally get a mysterious floating point
	exception
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


user thread cores occassionally because of a floating
point exception

when the exception occurs it usually happens on
multiple threads, even across different processes
and they all have the same fpscr values.

As far as I can tell none of the applications are even
enabling the fp exceptions in the fpscr.
If fact the coredump shows the fp operation to be just
a 64bit move like lfd.

some details:
  2.4.20 (I know i have to go to 2.6 i just can't
right now)
  ~300 threads
  cpu             : 8270
  core clock      : 450 MHz
  CPM  clock      : 300 MHz
  bus  clock      : 100 MHz
  revision        : 32.19 (pvr 8082 2013)
  bogomips        : 299.82

The various fpscr that have occurred:
 0x6002c2ed 0110 0000 0000 0010 1100 0010 1110 1101
 0xec1642e6 1110 1100 0001 0110 0100 0010 1110 0110
 0x7649e0ea 0111 0110 0100 1001 1110 0000 1110 1010
 0x6009c7ba 0110 0000 0000 1001 1100 0111 1011 1010
 0xf30c346f 1111 0011 0000 1100 0011 0100 0110 1111
 0xe833f39d 1110 1000 0011 0011 1111 0011 1001 1101
 0xfdb3e1e3 1111 1101 1011 0011 1110 0001 1110 0011

I've put in debug to dump the thread_struct when the
exception occurs hoping to find a corruption of the
floating point registers but they look OK.

Any help is greatly appreciated

Joe 
