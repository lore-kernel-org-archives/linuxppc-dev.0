Return-Path: <dbruce@ll.mit.edu>
Received: from ll.mit.edu (LLMAIL.LL.MIT.EDU [129.55.12.40])
	by ozlabs.org (Postfix) with ESMTP id 3551867A78
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Mar 2005 05:11:02 +1100 (EST)
Received: (from smtp@localhost) by ll.mit.edu (8.12.10/8.8.8) id j2LIB028016109
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 21 Mar 2005 13:11:00 -0500 (EST)
Message-ID: <423F0E24.8090308@ll.mit.edu>
Date: Mon, 21 Mar 2005 13:10:44 -0500
From: David Bruce <dbruce@ll.mit.edu>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
References: <20050317125419.73A6367A79@ozlabs.org>
In-Reply-To: <20050317125419.73A6367A79@ozlabs.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: RE: LED driver (8260)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I've taken Hans Schillstrom's version of rcb8270_led-0001.bin (which is 
based on DENX status_led.c) and "generalized" it for my purposes (I have 
LED's on more that one port and not all pins can be LED's) (This is used 
on a TQM8260). This also has only been tested briefly...

What was done:
1.) put back in DENX copyright; ;^)
2.) removed unknown include files;
3.) put in compile option to NOT initialize a port pin during module 
    install, see #define DO_NOT_INIT_PORT and #ifndef DO_NOT_INIT_PORT;
4.) added "used" field to control structure to specify if LED was ever 
used (set in statusled_open());
5.) put code in statusled_cleanup() that will only shut off a LED if the 
  LED was ever used (opened);

In the led_dev_t led_dev[] control structure, all of the port A & D pins 
are specified (for my needs) but not all are used. (The project that I 
am using this for is a "moving" target and not all of the port pins have 
been specified.) Therefore in the load script, only create devices that 
_ARE_ LED's. Device minor numbers for port A is the port pin number and 
for port D it is the port pin number times 2.

It can be found at:
http://www.geocities.com/dbruce_01721/status_led_8260.c
