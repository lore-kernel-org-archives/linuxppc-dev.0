Message-Id: <9910281739.AA35624@marc.watson.ibm.com>
To: Lou Langholtz <ldl@chpc.utah.edu>
Cc: linuxppc-dev@lists.linuxppc.org, gdt@linuxppc.org, cort@cs.nmt.edu
Subject: Re: linux-2.2.13pre15 stability w/ head.S patch 
In-Reply-To: Message from Lou Langholtz <ldl@chpc.utah.edu>
   of "Thu, 28 Oct 1999 12:06:02 MDT." <3818908A.8A6539B6@chpc.utah.edu>
Date: Thu, 28 Oct 1999 13:39:04 -0400
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	The general, conservative procedure that should be followed for
any BAT change is:

	li	rX, 0
	mtdbatu N, rX
	isync
	mtdbatl N, rL
	mtdbatu N, rU
	isync

I do not see the posted assembly code performing any isync's to prevent
speculation.  mtspr does not produce complete serialization in the
pipeline, and the serialization is implementation-dependent.

David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
