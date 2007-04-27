Return-Path: <petermendham@computing.dundee.ac.uk>
Received: from uncle.computing.dundee.ac.uk (unknown [134.36.36.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C1F7FDDF05
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Apr 2007 18:48:59 +1000 (EST)
Received: from mailex.computing.dundee.ac.uk (mailex.computing.dundee.ac.uk
	[134.36.36.15])
	by uncle.computing.dundee.ac.uk (8.13.1/8.13.1) with ESMTP id
	l3R8mmgD031761
	for <linuxppc-embedded@ozlabs.org>; Fri, 27 Apr 2007 09:48:49 +0100
Message-ID: <4631B8EE.10903@computing.dundee.ac.uk>
Date: Fri, 27 Apr 2007 09:48:46 +0100
From: Peter Mendham <petermendham@computing.dundee.ac.uk>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Some advice needed with Xilinx Framebuffer
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

Dear all,

Thanks to Andrei, and others, I have a working framebuffer on my device, 
nicely driving a standard VGA screen.  I have just discovered that my 
*actual* target display is rotated VGA, i.e. 480x640.  I would like to 
use it as a 640x480 display.  I would love some advice from you 
knowledgeable people as to how best to go about this.  I have had some 
(rather naive) thoughts:
1. Modify the hardware to read pixels from non-contiguous locations thus 
leaving the framebuffer structure (as far as software is concerned) 
completely intact.  The major problem with this is that the hardware is 
no longer doing burst reads (because locations are not contiguous) so 
will be using the bus a lot less efficiently.
2. Modify the hardware to expect the framebuffer memory to be arranged 
column-wise, rather than row-wise (i.e. as a 480x640 rotated display in 
memory).  Is there a way to get the framebuffer to still present this as 
a 640x480 display?
3. Be honest about the whole thing and make the framebuffer report a 
480x640 display and hope that I can rotate everything else.  I believe 
the console can be rotated(?) I'd also really like to run the Links 
browser in direct framebuffer mode, and/or maybe X.  Don't know if 
that's possible but it certainly sounds like a minefield...
4. Some other secret magic hidden fourth option I don't know about.  
Maybe there's a standard way of doing this?

My feeling is that I should keep the whole nasty rotated business as low 
level as possible without affecting performance too much, but maybe I'm 
wrong.  Anything you can suggest would be greatly appreciated.

Thanks in advance,
-- Peter


-- 
This message has been scanned for viruses and
dangerous content by MailScanner, and is
believed to be clean.
MailScanner thanks transtec Computers for their support.
