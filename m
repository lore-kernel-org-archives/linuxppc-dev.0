Subject: Re: consistent_alloc changes for 4xx/8xx
To: linuxppc-embedded@lists.linuxppc.org
Message-ID: <OF130F6EBD.EC5FA854-ON85256B4B.00683BA1@raleigh.ibm.com >
From: "Ralph Blach" <rcblach@us.ibm.com>
Date: Thu, 24 Jan 2002 14:10:07 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I just looked closely at the code for pinned tlb's head_4xx.S and there
needs to be a fix.

/* Load up the kernel context  */
2: SYNC   /*For all PTE updates to finish */
     tlbia
     sync

This is incorrect for a the pinned kernel configuration and because it
would invalidate the pinned tlb's

I verifyed this with RiscWatch.

The code needs to be changes to
/* Load up the kernel context  */
2: SYNC   /*For all PTE updates to finish */
#ifndef CONFIG_TLB_PIN
     tlbia
#endif
     sync


Thanks

Chip


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
