Message-Id: <9901132007.AA42094@marc.watson.ibm.com>
To: satadru pramanik <satadru@umich.edu>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: compiler errors 
In-Reply-To: Message from satadru pramanik <satadru@umich.edu>
   of "Wed, 13 Jan 1999 14:55:33 EST." <Pine.LNX.4.05.9901131455170.11281-100000@beer.pub.umich.edu>
Date: Wed, 13 Jan 1999 15:07:41 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> satadru pramanik writes:

satadru> egcs 1.1.1c

	Hmm, well I thought that problem had been addressed in egcs-1.1.1.
The problem is that GCC is generating a memory reference with a
displacement (65536) which is larger than 16 bits.  Someone needs to try
to track down why the PowerPC port thinks that is a valid address instead
of splitting it into an intermediate offset in a register.

	Either GCC is generating that offset itself and the normal tests
for valid types of addressing are failing.  Or, something in the PowerPC
port explicitly is generating a memory operation which bypasses the tests
and is not explicitly checking for exceeding this offset limit.

David

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
