Message-Id: <9912040156.AA54326@marc.watson.ibm.com>
To: Hollis R Blanchard <hollis+@andrew.cmu.edu>
Cc: "David W. Patmore" <dwp@bluesteelnet.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: endian-swapping 
In-Reply-To: Message from Hollis R Blanchard <hollis+@andrew.cmu.edu>
   of "Fri, 03 Dec 1999 20:13:09 EST." <Pine.LNX.3.96L.991203200537.7714B-100000@unix47.andrew.cmu.edu>
Date: Fri, 03 Dec 1999 20:56:23 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> Hollis R Blanchard writes:

Hollis> On Fri, 3 Dec 1999, David Edelsohn wrote:
>> 
>> Linux already provides macros like le16_to_cpu(), etc. for this. 

Hollis> For the sake of someone (like me) who doesn't know how to use these, can you
Hollis> give an example?

	See drivers/net/pcnet32.c for one example of its use.  There are
no #ifdef's like NetBSD uses.  le16_to_cpu() is a no-op on LE machines, so
one uses it directly like 

short x = le16_to_cpu(dev_flag);

Hollis> Also, the macros are in which header? I'm having trouble finding them too...

	The macros seem to be included via <asm/bitops.h> which then
include <linux/byteorder/big_endian.h> (for example).

David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
