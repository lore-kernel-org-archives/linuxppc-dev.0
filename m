Return-Path: <morten.banzon@axxessit.no>
Received: from pt20-qms-01.ptn.no (pt20-qms-01.ptn.no [64.28.25.138])
	by ozlabs.org (Postfix) with SMTP id A4D182BF09
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Nov 2004 13:24:35 +1100 (EST)
To: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
Message-ID: <OF61CEAAAA.29CF7624-ONC1256F51.000647B4-C1256F51.000D37AD@axxessit.no>
From: morten.banzon@axxessit.no
Date: Fri, 19 Nov 2004 03:24:23 +0100
Content-Type: text/plain; charset="us-ascii"
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC82xx -- DPRAM1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dan Malek <dan@embeddededge.com>
19.11.2004 00:11

 
        To:     morten.banzon@axxessit.no
        cc:     linuxppc-embedded@ozlabs.org, Wolfgang Denk <wd@denx.de>
        Subject:        Re: MPC82xx -- DPRAM1



On Nov 18, 2004, at 3:08 PM, morten.banzon@axxessit.no wrote:

> > If you know the reason to why it is "a very bad idea" to relocate 
these
> > resources within dpram1 I am very curious to learn. On the other hand 
> > if
> > you do not know, then please refrain from giving such a stupid answer.

> As you have discovered, there are many dependencies on the
> configuration of the cpm smc from the boot rom to bootloaders to
> the Linux kernel itself.  It's a bad idea to be changing one of these
> without changing all of the others to match ....  and then you end
> up with a custom piece of software that you have to constantly
> maintain.  If you make it configurable, then you end up with even
> more confusion when people mismatch the configurations on
> a board.

I aggree with that, I will strive to avoid such changes.

> There isn't any reason to change the current SMC buffering configuration
> on the CPM2 (and future) devices.  If you like change for the sake
> of change, then go ahead and do it.  We answered the questions
> you asked and specifically said the changes you were making at
> the time weren't a good idea.  Just because you didn't agree
> doesn't make it a stupid response, especially since it's pretty easy
> to figure out on your own from looking at the code.

You might be right that there is no reason to change this cofiguration.
I guess you know that no one would change this for the sake of change.
No, you did not answer my questions. Just to recap a few questions and 
answers:

1. I had trouble understanding the use of the CPM_DATAONLY_BASE constant, 
or more precisely what was located at the addresses below 
CPM_DATAONLY_BASE.  It turns out that it is the smc parameter tables that 
are placed there. But the real mystery was how the cpm was told where to 
find these locations.  The end of the story is that the cpm uart driver is 
dependent on this particular configuration (writing these adresses into 
the SMC1_BASE@0x87FC and SMC2_BASE@0x88FC) beeing set-up before being 
loaded. At one point I was asking if this was intentional or not. The 
answer to this I still do not know, but maybe it is not important either.

2. I stated that I relocated the buffer descriptors. This was done by 
replacing cpm_dpalloc with cpm_dpalloc_fixed and an offset adress of my 
choice. Your reply to this was the "very bad idea". Well, on my target I 
can move these buffer descriptors around as I please within the dpram1, 
and the smc1/console just keeps working. I do not say that this is not 
problematic, just that I do not detect any problems neither do I see any 
problems by reading the code. So, why this is a bad idea remains unclear. 
What seems to be a bad idea, or at least a little messy, is  to relocate 
the smc parameter ram located below the first 128 bytes of dpram1.

Now you go on about "just because you didn't agree"? Where did that come 
frome ? Maybe I am expressing myself very unclear, but as far as I know I 
have not disagreed with anything. I am just asking questions and trying to 
understand this peace of the system, and to be frank not many correct 
answers have been provided.

Regarding "stupid response" I am baffled. Wolfgang presents a few very 
clear statement, which are equally clearly wrong regarding this subject, 
the cpm uart driver (smc). Your mail contradicts his mail. I have come to 
the same conclusion as you have summarised in your previous mail. That is 
why I call "read  the code" a stupid answer. I think somebody else should 
take a break and read the code. Besides saying "stupid" about that 
particular answer, I have not called any other answer, suggestion, or 
anything else stupid. I hope we are clear on that.

How you can say it is "pretty easy to figure out on your own from looking 
at the code" I do not get, but that is not important. If you think it is 
easy, that is fine for you. I think I have described the reason why it is 
difficult to understand several times now, just a final point; in terms of 
configuring the smc hardware I think the only thing missing from the 
driver is to setup the now famous SMCx_BASE pointers. This is ofcourse 
possible to do, but there might be good reasons why it is not done. How it 
is supposed to be obvious that some boot code/loader set up these 
particular pointers I disagree with, especially in light of Wolfgang's 
mail.


Have a nice day,
-- Morten
