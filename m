Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id DECD7DDE21
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 00:29:01 +1000 (EST)
Message-ID: <47161C38.2070305@ru.mvista.com>
Date: Wed, 17 Oct 2007 18:29:12 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v2 3/4] Implement clockevents driver for powerpc
References: <20070921032603.0D3EA32C887@thor>	<4713A616.3090103@ru.mvista.com>
	<18195.64334.985238.848522@cargo.ozlabs.ibm.com>
In-Reply-To: <18195.64334.985238.848522@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, Thomas Gleixner <tglx@linutronix.de>,
	Realtime Kernel <linux-rt-users@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Paul Mackerras wrote:

>>    I don't see my own signoff or at least a reference to my prior work in
>>this patch or even at -rt patch -- despite this code ha clearly borrowed from
>>it.  And I'm not sure why this crippled version (lacking 40x/ Book E specific
>>clockevents implementation) is preferred over mine, unless this implementation
>>was only aimed at PPC64 machines...

> Tony started from an earlier patch by John Stultz, not from your
> patches.

    Well, that I can believe, yet the clockevents patch has traces of my
former work, and looking at read_persisitent_time() it looks suspiciously 
close to my version too...

> The main reason your patches were rejected were that you completely
> broke the VDSO and the deterministic time accounting, and made no

    That's just not true!
    They didn't broke vDSO (to be precise it was John's patch that broke it), 
they just removed the vDSO code known to already be broken by -rt patch for 
several months by then.  And they didn't broke determinictic accounting -- 
they just made two things mutually exclusive.  I haven't yet seen how the 
patches that were preferred dealt with it at all.

> attempt to fix them.

    I lacked time to do this, so did what I could.

> As for 40x/Book E, the main thing there is the auto-reload.  However,
> since the generic core can use a oneshot clock event source to
> generate periodic ticks, there is no advantage to using the
> auto-reload.

    Really? IMO, the harware does keep a constant interrupt rate better than 
software.

>>    Also, have the deterministic CPU accounting incompatibility with
>>clockevents been dealt with?

> The S390 guys looked at that and solved it with Ingo's and Thomas's
> help (although I did see something on linux-kernel about some further
> problems).

    Good to hear.  Nobody offered any help to me (except maybe Thomas -- but we
never came to any viable approach).

>>    I'd use (evt - 1) since the interrupt gets generated at 0xffffffff count, 
>>not 0 (on classic CPUs).  With you removing of the code that compensated for 

> See commit d968014b7280e2c447b20363e576999040ac72ef; I already fixed
> that.

    Good to hear this has been dealt with, along with that PowerMAC "IRQ 
simulation" nuisance -- I didn't care about it, sorry. :-)

>>the errors, they will accumulate.  And no, this wouldn't be enough anyway, 

> No, they don't accumulate.  See tick_setup_periodic().  The interval
> until the next tick is determined using ktime_get() rather than just
> being a constant.

    The interrupt always happens 1 clock later depsite what value
have been selected for the decrementer.  Well, OK, that should still get 
compensated by the tick_setup_periodic() by selecting shorter next period.
    Well, I'm taking comfot in that you've finally had to sutract 1. :-)

>>since on 40x and Book E you'll need to set it for evt anyway, since the 
>>interrupt happens at 0 count...
>>    NAK the patch.  And I really don't understand why you're throwing alway 
>>already tested/working code...

> Because you broke important features

    That is *not true*.
    And nobody had interest to fix them for months (quite strange if they're 
so important) while I had neither time nor interest to deal with them anymore 
having written the code that *did work*, and not only for me.

> and because you seem to have some

> fundamental misconceptions  (e.g. the comment about errors accumulating

    Where's the misconception in the patch? ;-)

> you just made).

    I see, I'm a bad guy... but still not convinced. :-)

> Paul.

WBR, Sergei
