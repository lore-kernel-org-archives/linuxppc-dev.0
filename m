Message-Id: <l03130300b3d4eea03d9f@[209.226.106.243]>
In-Reply-To: <l03130300b3cf9d4b53d0@[209.226.106.188]>
References: 
  <Pine.LNX.4.10.9907211505370.15642-100000@mercator.cs.kuleuven.ac.be>
 "References:" <"Pine.LNX.4.10.9907111312360.392-100000"@cassiopeia.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sun, 15 Aug 1999 16:28:31 -0400
To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>,
        linuxppc-dev@lists.linuxppc.org
From: Eric Dorland <dorland@lords.com>
Subject: Re: Problems with the atyfb driver on Power Mac G3
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>And so I did: not the GUI thing, but a small command line utility. And a
>>patch
>>for atyfb, of course:
>>
>>    http://www.cs.kuleuven.ac.be/~geert/bin/atyfb_dsp_debug.tar.gz
>
>I finally got a chance to apply this patch to my kernel (thanks very much
>Geert:). The patch applied cleanly to the 2.2.10 kernel and compiled with
>no problems. The atyclk program compiled fine as well, but whenever I try
>to use it I get the error:
>
>ioctl ATYIO_CLKR: Invalid argument
>
>Have I missed something? Has anyone else gotten the patch to work?

I thought I posted a reply to this message already, but it didn't  appear
to hit the list, so my apologies if you've seen it before.

The above problem I was having with atyclk was not a problem with the patch
at all. I was using BootX 1.1.2, which has an annoying bug in it, which
caused it to always select the first kernel in the list. Upgrading to 1.1.3
cured the problem.

So now atyclk works, and through some experimenting, I've found that
changing the dsp_on value from 24 to 29 removes all the snow I have been
experiencing, without any noticeable slow down. Hooray! Now, the problem is
that this value does not get retained when switching virtual consoles, ie
whenever I switch virtual consoles or start X the dsp_on value gets reset
back to 24. How can I get this value to stay fixed? Should I just hardcode
it into my own kernel compile?

Eric Dorland
mailto:dorland@lords.com



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
