Message-Id: <9910291811.AA21080@marc.watson.ibm.com>
To: Gabriel Paubert <paubert@iram.es>
Cc: Lou Langholtz <ldl@chpc.utah.edu>, linuxppc-dev@lists.linuxppc.org,
        gdt@linuxppc.org, cort@cs.nmt.edu
Subject: Re: linux-2.2.13pre15 stability w/ head.S patch 
In-Reply-To: Message from Gabriel Paubert <paubert@iram.es>
   of "Fri, 29 Oct 1999 12:34:30 +0200." <Pine.HPX.4.10.9910291132120.18743-100000@gra-ux1.iram.es>
Date: Fri, 29 Oct 1999 14:11:16 -0400
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> Gabriel Paubert writes:

Gabriel> OTOH when address translation is turned on (or when the its state is
Gabriel> unknown) I would have put an isync _before_ the first mtdbatu to make
Gabriel> sure that it does not interfere with previous instructions (this is
Gabriel> required from the manuals AFAICT).

	You are correct, I mistyped the example.  The isync's should go
before the entire block of DBAT updates and after.  The PowerPC
Microprocessor Programming Environments book synchronization requirements
state that a "context-synchronizing instruction" is REQUIRED PRIOR and
REQUIRED AFTER a mtspr (DBAT) instruction.  Context Synchronizing
Instructions are "sc", "rfi", "rfid", and "isync".  Disabling the valid
bits by zeroing the upper BAT register before modifying the lower BAT
register is necessary.

	If address translation is off, the context sychronization is
unnecessary. 

David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
