Message-Id: <9902151757.AA75924@marc.watson.ibm.com>
To: Benjamin Herrenschmidt <bh40@calva.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: bootstrap stuffs 
In-Reply-To: Message from Benjamin Herrenschmidt <bh40@calva.net>
   of "Sun, 14 Feb 1999 19:58:05 +0100." <19990214195805.018190@smtp.calvacom.fr>
Date: Mon, 15 Feb 1999 12:57:34 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> Benjamin Herrenschmidt writes:

Benjamin> On Sun, Feb 14, 1999, David Edelsohn <dje@watson.ibm.com> wrote:
>> For correctness, "sync" must be used, but for best performance,
>> "sync" should be used sparingly, only when necessary.

Benjamin> Ok thanks. In this specific case (jump to bootstrap), I don't really care
Benjamin> about the performance loss introduced by a sync, I'll keep one just after
Benjamin> the mtmsr to make sure that the interrupt switch is fully done before I
Benjamin> hack with srr0 and the MMU.

	"isync" is used to discard instruction pre-fetch and ensure that
all previous instructions have occurred.  isync is not necessary for your
situation either.

	As Gabriel correctly explained, a "sync" instruction may be
necessary before interrupts are enabled if some off-chip operation, like
modifying an interrupt controller on the bus, was performed.  That is
because of the bus operations which need to complete before interrupts can
be enabled, not because of the enabling itself.

David

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
