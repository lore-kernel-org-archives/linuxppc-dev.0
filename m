From: Benjamin Herrenschmidt <bh40@calva.net>
To: "Joseph P. Garcia" <jpgarcia@execpc.com>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: BMAC driver issue addressed?
Date: Mon, 30 Oct 2000 19:57:52 +0100
Message-Id: <19340924122936.4247@192.168.1.2>
In-Reply-To: <39FDBC6C.1F6496CF@execpc.com>
References: <39FDBC6C.1F6496CF@execpc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>I'm still puzzled about the whole thing, like if Darwin is filtering those
>packets we should be ignoring anyway, and Linux does too, Is this really the
>problem?  And what was it I was really doing those months ago?  (sorry,
i lost
>my old code)  I recall using standard things in the kernel.  just one
>acception
>added that was in the case of it should have been ignored by the chip.
>
>According to the ppclinux sourceforge bug tracker, the problem was fixed
for a
>patched kernel or two.  <shrug>

I think the filter problem is related to a bogus multicast filter or
something like that. There is another problem, which is documented in
Darwin, and which cause the chip to corrupt packets in the chip's send
queue when there's a collision. The workaround they use is to send
additional packet datas to the chip from the chip send interrupt instead
of the DBDMA interrupt, thus preventing more than 1 packet to be queued
in the chip.

ben


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
