Date: Tue, 2 Feb 1999 15:53:58 +1100
Message-Id: <199902020453.PAA00823@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: inet2@akos.net
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: <36B06D9F.96F2AD48@akos.net> (message from Russell Hires on Thu,
	28 Jan 1999 09:01:11 -0500)
Subject: Re: AWACS Bug
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <36B06D9F.96F2AD48@akos.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Russell Hires <inet2@akos.net> wrote:

> For some reason AWACS is causing Linux to crash. Here's the error
> message I get: AWACS: error, status 4f40da9. I have a G3/266, which I
> bought in late November 1998. 64 MB RAM, 6MB VRAM, DVD-ROM, 4 G SCSI HD
> that runs Linux on 1.5 G partition (which is, of course, divided up into
> /usr and so on...)  using the 2.2pre9 kernel (final).
> 
> About my crashes: it seems to happen when I use BootX the Application,
> and not
> BootX the Extension. Also, it happens when I try to backspace too much

What's happening is I think the same as what happens on the iMac: when
you run the BootX app to boot linux, and it asks macos to shut down,
macos shuts down the awacs, in such a fashion that the only thing that
will start it up again is a hard reset. :-(  If you do

     cat /proc/device-tree/pci/mac-io/davbus/awacs/compatible

and you see a string including "burgundy", that's the problem.

I have managed to work out quite a bit about the burgundy so far.
Its registers can be read as well as written, unlike the earlier
awacses, which makes it much easier to work out what macos is doing.
Shortly I expect to have a new dmasound.c which will support the
burgundy properly.

Paul.

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
