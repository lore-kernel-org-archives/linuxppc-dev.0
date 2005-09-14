Return-Path: <nishant.subs@myrealbox.com>
Received: from smtp-send.myrealbox.com (smtp-send.myrealbox.com
	[192.108.102.143])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.myrealbox.com",
	Issuer "Comodo Class 3 Security Services CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4AE456828F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Sep 2005 22:28:12 +1000 (EST)
From: "Nishant Galange" <nishant.subs@myrealbox.com>
To: linuxppc-embedded@ozlabs.org
Date: Wed, 14 Sep 2005 09:12:03 +0000
MIME-Version: 1.0
Message-ID: <1126689123.c803515cnishant.subs@myrealbox.com>
Content-Type: text/plain; charset="UTF-8"
Subject: How to access linux symbols from dynamically loaded .so (dlopen)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all

Help needed desperately. Some background on the problem:

The embedded linux (built as one large elf
file) contains an important function called "board_init()"

A test module (built as a shared object test.so) contains a function
called start_test()

void start_test() {
=09board_init(); /* The shared object has to call a function defined in the=
 embedded linux elf image */
=09/*Do board tests here... */
}

1. Linux comes up to the command prompt on the board.
2. A GUI application communicates with the board via Ethernet=20
3. The GUI
transfers the test module test.so over Ethernet=20
4. The downloaded test.so is loaded via dlopen().=20
5. dlopen() and dlsym() calls succeed. start_test() starts executing=20
6. It barfs at board_init() saying "Undefined symbol: board_init"

So the dynamically loaded shared object cannot get a reference to a functio=
n define in the linux that loaded it...

How do we solve this problem? How do I make sure that symbols in the linux =
image are exposed to dynamically loaded libraries?

Most probably, it has a simple solution to tweak some compiler/linker
options. But I may be wrong...

Waiting,
Nishant
