From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <yellowdog-devel@lists.yellowdog.com>,
	<linuxppc-dev@lists.linuxppc.org>,
	"Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Subject: Re: some questions on new dual 1Gig G4's support?
Date: Sat, 2 Feb 2002 21:11:15 +0100
Message-Id: <20020202201115.17827@smtp.wanadoo.fr>
In-Reply-To: <20020202144614.WRFZ11118.tomts10-srv.bellnexxia.net@there>
References: <20020202144614.WRFZ11118.tomts10-srv.bellnexxia.net@there>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>1. are the cpu specific things I might have to play with all in the files
>I found that reference 7450 or are there other files I need to play with
>
>2. I read the errata for the 7455 and it was quite short.  Are errata
>cumulative  in some way?  Are these just the new errata since the 7450?
>(i.e. do I need to grab and worry about the 7450 errata too?).  Or has the
>errata listed in the 7450 been dealt with by changes in the 7455 and this
>is all I need to know hardware errata-wise.
>
>3. Are there any other references I should be reading that describe
>differences in the 7450 and the 7455 that are important for getting a
>kernel up on my new machine?

Out of my mind, there are 3 places you want to look at:

cputable.c : add an entry & declare a specific setup_cpu function
for the 7455

head.S : add the setup_cpu for the 7455, possibly copying the one
of the 7450. Then go figure if the L3 is also incompatible with
NAP mode or not. If it is not, you can strip the code that clears
the "can DOZE" feature. Note that ideally, we should change that
code to be 2 different feature bits, one for can DOZE, and one for
can NAP (as the 7450/55 can only NAP, not DOZE).
You can change that easily, basically define the new bit for NAP
in cputable.h, set it for all CPUs (except 7450 rev 2.0) in
cputable, and remove DOZE capability from 7450/55. Once done,
tweak the code in arch/ppc/kernel/idle.c so that it does power
save if either of these bits is set, but also make sure it does
not try to NAP if powersave_nap isn't set (as some host bridges
can't handle it, it will be set properly by pmac_feature).
If your CPU can't DOZE but can NAP, but powersave_nap is false,
do nothing.

pmac_feature.c : add an entry in the machine table for your machine
based on OF "model" property.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
