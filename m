Message-ID: <3817D7C5.24905FE3@jlc.net>
Date: Thu, 28 Oct 1999 00:57:41 -0400
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: wung_y@263.net
CC: linuxppc embedded mail list <linuxppc-embedded@lists.linuxppc.org>,
        linux-ce-devel <linuxce-devel@linuxce.org>,
        linux embedded maillist <linux-embedded@waste.org>
Subject: Re: Root FS on Flash?
References: <3817A40D.F62BC2FA@263.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wang Yong wrote:


> .... i have a question: how to make root file system on the
> flash memory? by now, most embedded linux employ NFS as root file
> system.

The diskless NFS root file system is simply used for convenience and
to reduce application development time.  You can put a root file
system on anything that will hold the bits.


>         does anyone has any experience on it? is there a embedded linux
> has done it? any comment and suggestion are welcome. thank you.

Yes, there are many systems using a variety of solutions to Flash rom
root file systems.  You have to consider your own application
requirements to choose what is appropriate for you.  You can use
a compressed initrd stored in flash rom, which is uncompressed into
a ram disk.  Another popular alternative is PCMCIA flash disks,
compact flash or Smart Media cards.  You can put a file system on them,
partition them, and compress some or all of the data.  Least favorite
on my list, but used by some people, is soldered on-board flash rom
parts.  Wear leveling and dynamic allocation are complex algorithms,
and above a rather small size compact flash cards are more cost effective.

All of this is supported by standard Linux distributions, and the boot
code in the PPC port handles it well.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
