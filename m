From: "Ron Bianco" <ronb@junction.net>
To: "Ralph Blach" <rcblach@raleigh.ibm.com>
Cc: "linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Wait queue question
Date: Wed, 14 Feb 2001 10:34:04 -0800
Message-ID: <000201c096b4$b511dba0$4d012ac7@warp-speed>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <3A8A9EB2.660A7A2D@raleigh.ibm.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Ralph, perhaps you could not attach your .vcf files anymore?

If your driver implements non-blocking read() and write() functions, then you don't
have to sleep.
Else others have commented on the alternative to sleep_on().

For non-blocking:
Just use poll_wait() in your poll() function and wakeup_interruptible when there data
available on your Qs.
Then user program's select() and poll() system calls will work properly.

Ron

> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Ralph
> Blach
> Sent: Wednesday, February 14, 2001 7:05 AM
> To: Embedded Linux list
> Subject: Wait queue question
>
>
> If I have a wait queue thats I am using to wake up a device driver read
> from an interrupt service routine.
> If I get three interrupt and three wake_up_interrables, will I need to
> execute three sleep_ons to get the wait queue back to the null state, or
> is it just back after the first sleep_on?
>
> Chip


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
