Message-ID: <4063E4B4.1070101@embeddededge.com>
Date: Fri, 26 Mar 2004 03:07:16 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: lourens@mecalc.co.za
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Kernel Mode Software Emulation NIP: 00001FFC - cache coherency
 problem on m8xx processors
References: <002401c41303$4dae8890$8702a8c0@lcgnotebook>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


LC Geldenhuys wrote:

> This sounds distinctly familiar to the CPU13 Errata.

Not exactly.  This isn't the first instruction of the exception
handler.  It's the first instruction of the general handler
that all of them call after excuting about 30 instructions of
context saving.

There are, however, several Errata associated with the setting
of the ICTRL[IST_SER] and page boundary instruction execution.

Thanks for pointing out ensuring the ICTRL is set for normal,
"no show" operation.  It's worth checking that, too.  The
default reset is not what you want here, the boot rom should
set this register to something for normal operation.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
