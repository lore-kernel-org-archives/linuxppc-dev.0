MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16312.6414.636754.888007@cargo.ozlabs.ibm.com>
Date: Mon, 17 Nov 2003 11:40:46 +1100
From: Paul Mackerras <paulus@samba.org>
To: David Edelsohn <dje@watson.ibm.com>
Cc: benh@kernel.crashing.org, Olaf Hering <olh@suse.de>,
	Alan Modra <amodra@bigpond.net.au>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: kernel oops due to unaligned access with lswi 
In-Reply-To: <200311162304.hAGN4CT32140@makai.watson.ibm.com>
References: <20031115210449.GA10105@suse.de>
	<20031115222430.GA13820@suse.de>
	<200311152230.hAFMUwT32990@makai.watson.ibm.com>
	<20031115224342.GA16897@suse.de>
	<200311152259.hAFMxGT27464@makai.watson.ibm.com>
	<1068977831.681.8.camel@gaston>
	<200311162304.hAGN4CT32140@makai.watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


David Edelsohn writes:

> 	The information that you received about lwsi are overly
> simplistic.  The instructions are neither overly good nor overly bad --
> they should not be used for everything, but neither should they be avoided
> at all cost.  They are particularly good for producing compact code and
> preserving the instruction cache.  Remember, programming, including
> assembly language programming, is an art.

In the experiments that I did comparing different memcpy loops, I
didn't find any combination of alignment, size of copy and processor
implementation where using string loads/stores was as fast as than
ordinary loads and stores.  So I am inclined to think that the only
advantage of the string load/store instructions is in saving a little
bit of icache.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
