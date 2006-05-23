Return-Path: <Josef.Angermeier@informatik.uni-erlangen.de>
Received: from max71.rrze.uni-erlangen.de (max71.rrze.uni-erlangen.de
	[131.188.3.181]) by ozlabs.org (Postfix) with ESMTP id BB9C467A44
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 May 2006 01:41:04 +1000 (EST)
Received: from fau-vscan-1.rrze.uni-erlangen.de ([131.188.3.181]
	[131.188.3.181]) by faurelaysmart-1.rrze.uni-erlangen.de with
	ESMTP for linuxppc-embedded@ozlabs.org;
	Tue, 23 May 2006 17:40:27 +0200
Received: from max71.rrze.uni-erlangen.de ([131.188.3.181])
	by fau-vscan-1.rrze.uni-erlangen.de (fau-vscan-1.rrze.uni-erlangen.de
	[131.188.2.91]) (amavisd-new)
	with ESMTP id 16381-04 for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 May 2006 17:40:27 +0200 (MEST)
Received: from [131.188.51.43] ([131.188.51.43] [131.188.51.43]) by
	smtp-auth.uni-erlangen.de with ESMTP for
	linuxppc-embedded@ozlabs.org; Tue, 23 May 2006 17:40:26 +0200
Message-Id: <44732CEA.9030604@cs.fau.de>
Date: Tue, 23 May 2006 17:40:26 +0200
From: Josef Angermeier <Josef.Angermeier@informatik.uni-erlangen.de>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: MPC8xx Debugging: function call vs. no function call
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hello,

I am not yet pretty familiar with 8xx system programming, so maybe you 
could give me some debugging hint. My C code which programs the the CPM 
(USB) has to execute the following commands:

    eieio();
    usbregs->usb_uscom = 0x80 | 0;
    mb();


If i put those instructions in an new function, the CPM behaves as 
wished, elsewise it depends on the remaining code. E.g. the number of 
NOP machine code instructions before make a difference:

1.)
   ...< remaining C function code>
   __asm__("nop\n\t");
    eieio();
    usbregs->usb_uscom = 0x80 | 0;
    mb();
   ... <other code>

2.)
   ...< remaining C function code>
   __asm__("nop\n\t");
   __asm__("nop\n\t");
    eieio();
    usbregs->usb_uscom = 0x80 | 0;
    mb();
   ... <other code>

Every hint howto find my mistake is appreciated! Thanks
Josef
