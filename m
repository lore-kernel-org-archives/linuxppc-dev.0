From: Juergen Beisert <jbeisert@eurodsn.de>
Reply-To: jbeisert@eurodsn.de
To: linuxppc-embedded@lists.linuxppc.org
Subject: dcbz-instruction on PPC405GP
Date: Fri, 11 Jul 2003 16:23:45 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200307111623.45470.jbeisert@eurodsn.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I want to speed up some data copy in my Linux driver and so I want to use the
dcbz-instruction.
I get the memory with a kmalloc()-call with GFP_KERNEL argument. After that I
call a small assembler routine that uses dcbz to set this memory to zero. I
am shure this memory starts at 32 byte boundary and ends at another 32 byte
boundary. But if I call the dcbz-instruction I get an alignment exception.
I have tried to test the "Write Trough" and "Caching Inhibit" bits for this
TLB, but I'm not shure that I have found the right one. I have called
get_pteptr() with the kmalloc() returned virtual address. Is this the right
way to get informations about this TLB? The returned value seems ok (caching
enabled and write back, if Linux uses the same bit positions like the 405GP
manual).
With caching enabled and write back the dcbz-instruction should work (that's
what I have read in the manual). Right?

I have seen the alignment exception while BDI is running for debugging. If I
start my system without a connected BDI it hangs forever.

Is the dcbz-instruction broken on 405GP?

Best regards
Juergen Beisert
--
*********************************
Fa. EuroDesign
embedded technologies GmbH
Waldstr. 4a
85414 Kirchdorf a.d. Amper/Germany

Tel: +49/8166/99495-77
Fax: +49/8166/99495-81

EMAIL: jbeisert@eurodsn.de
Web: http://www.eurodsn.de
*********************************

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
