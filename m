Message-Id: <9902141703.AA37524@marc.watson.ibm.com>
To: Benjamin Herrenschmidt <bh40@calva.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: bootstrap stuffs 
In-Reply-To: Message from Benjamin Herrenschmidt <bh40@calva.net>
   of "Sun, 14 Feb 1999 15:02:35 +0100." <19990214150235.030449@smtp.calvacom.fr>
Date: Sun, 14 Feb 1999 12:03:40 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> Benjamin Herrenschmidt writes:

>> Are all of those "sync" instructions necessary in your code?

Benjamin> Just paranoid. They were added around the interrupt switching to make
Benjamin> sure to sync an eventual second processor and everything else before
Benjamin> switching the MMU off. I beleive that for disabling the MMU, andi. is
Benjamin> probably more efficient than my ori/andc pair, could you just explain my
Benjamin> why you added &0xffff at it ?

	"andi." only operates on halfword, so one needs to make sure that
the constant is valid or the assembler will complain.  (~ 0x8000) will
produce values in the upper half of the 32-bit word.  PowerPC immediate
instructions apply to either the upper-half or lower-half of a 32-bit
word. 

	For correctness, "sync" must be used, but for best performance,
"sync" should be used sparingly, only when necessary.

	Michael's comment about the -mrelocatable flag are a more detailed
answer to your question.

David

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
