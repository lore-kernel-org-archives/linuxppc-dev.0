Message-ID: <00933BFA237CD2119B3400409543582704A2BA@MEV01>
From: Ian Abbott <abbotti@mev.co.uk>
To: Embedded Linux list <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Wait queue question
Date: Wed, 14 Feb 2001 18:04:07 -0000
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ralph Blach wrote:

> If I have a wait queue thats I am using to wake up a device
> driver read
> from an interrupt service routine.
> If I get three interrupt and three wake_up_interrables, will I need to
> execute three sleep_ons to get the wait queue back to the
> null state, or
> is it just back after the first sleep_on?

They do not work like semaphores. wake_up and wake_up_interruptible have
an immediate effect on processes waiting on the specified queue, but
don't modify a counter or anything like that. This also means you can't
sleep on an event that has already happened, like you could with a
semaphore.

Also, you probably want to use interruptible_sleep_on rather than
sleep_on, unless you've already considered this.

These are general Linux driver writing questions, rather than embedded
Linux PPC questions. You may be better off addressing these sorts of
questions to a different list or newsgroup. Also, you may wish to
consider investing in Alessandro Rubini's "Linux Device Drivers",
published by O'Reilly. It's starting to get a little out-of-date in
places but is still a good introduction to writing device drivers for
Linux.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
