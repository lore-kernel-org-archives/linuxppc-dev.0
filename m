Message-Id: <l03130301b972e8973ac8@[192.168.1.2]>
In-Reply-To: <200208031028.20491.kevin.hendricks@sympatico.ca>
References: <20020728022655.GA19087@krispykreme>
 <200207231725.30067.kevin.hendricks@sympatico.ca>
 <200207240804.36472.kevin.hendricks@sympatico.ca>
 <20020728022655.GA19087@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sun, 4 Aug 2002 10:26:39 -0400
To: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>
From: "Michael R. Zucca" <mrz5149@acm.org>
Subject: Re: why isync in atomic icc and return and atomic dec and return
 for CONFIG_SMP
Cc: Anton Blanchard <anton@samba.org>,
	linuxppc-dev@lists.linuxppc.org,
	yellowdog-devel@lists.terrasoftsolutions.com
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 10:28 AM -0400 8/3/02, Kevin B. Hendricks wrote:

>In userland code, say with a fully pre-emptible kernel, if a signal comes
>in to thread A and before returning another thread (call it B)  is run,
>couldn't the same problem happen with prefetching data being old since
>thread B may in fact be the one holding the lock and allowed to change the
>data.
>
>I guess what I am asking is would we need the isync for a userland version
>of this code if threads could actually be pre-empted even for a UP
>machine?

I would imagine this still isn't necessary because a preemption must happen
as the result of an interrupt, which means an rfi gets executed. rfi is
context synchronizing, just like isync.

Voluntary context switching would involve making a syscall and sc is also
context synchronzing.

So I think all of the bases are covered for UP.


----------------------------------------------
 Michael Zucca - mrz5149@acm.org
----------------------------------------------
 "I'm too old to use Emacs." -- Rod MacDonald
----------------------------------------------


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
