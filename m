In-Reply-To: <Pine.LNX.4.05.9901150212250.26871-100000@netspace.org>
Date: Fri, 15 Jan 1999 14:02:45 +0100
To: linuxppc-dev@lists.linuxppc.org, Ty Hedrick <thedrick@netspace.org>
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Powerbase IDE: DMA & ohare-ata
Message-Id: <19990115140245.026852@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Jan 15, 1999, Ty Hedrick <thedrick@netspace.org> wrote:

>After looking at DMA I decided to enable the ohare register mentioned
>earlier, stuffing the new value in also resulted in a working system, and
>approximately doubled the IDE transfer rate as measured by hdparm - to a
>whopping 3.7 MB/s.
>
>Is there any way to be kind to all the Powerbase owners out there and
>enable DMA by default without breaking any other systems?  Also, the mod
>to ohare and heathrow does seem to help lots of platforms.

The test kernel I have on my web site will soon have code for both ohare
and heathrow. I've added an option do disable the speed boost in case of
troubles (a command line option, currently implemented as a "hack"
because I didn't want to touch non-arch files). I'll add the fix for
not-checking the DMA interrupts, they are not used anyway.

I'll release this version with diffs as soon as I have finished some
other little things in progress, probably during the week-end.

If the speed-boost proves to be harmless to everyone, I'll leave it in
and probably submit it 'as-is'. If it doesn't, I'll either change the
command-line arg to optionally enable it 
instead of optionally disable it, or add some drive-specific parameters
or some kind of "exception list".


-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
