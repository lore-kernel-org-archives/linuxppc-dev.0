Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3EC07D9A.6050604@embeddededge.com>
Date: Tue, 13 May 2003 01:07:38 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Jeremy Bowen <Jeremy.Bowen@opennw.com>
Cc: "'Linux PPC'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Problems with MMU: address translation for 0xXXXXXXXX failed
References: <DEA23DB61B62D4118B5900508B323B84012CC7D1@OPENMAIL>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jeremy Bowen wrote:


> BDI>mm 0xf0 0xc014f000

Don't do this.  Use 'PTBASE 0xf0' in your BDI configuration file.
Chances are the 0xc014f000 is not the right number, so just let the
software determine this on its own.

If that doesn't work, just out of curiosity use hard breakpoints (set
BREAKMODE HARD).  Just test it setting one breakpoint.  If this works,
I suspect the BDI is honoring the write protection (via the MMU) on the
kernel text pages and we can't set a soft breakpoint.  In this case, we'll
have to add a kernel configuration to allow a debugger write.  The
CONFIG_KGDB and CONFIG_XMON enable the text writing, but they also add
too much baggage and could interfere with the BDI.  It's another thing
to try that would provide some information, though.  I didn't remember
the BDI having trouble with this before, but I could have been using
different software or configurations.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
