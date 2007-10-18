Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18198.44590.721412.314409@cargo.ozlabs.ibm.com>
Date: Thu, 18 Oct 2007 10:51:58 +1000
From: Paul Mackerras <paulus@samba.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH v2 3/4] Implement clockevents driver for powerpc
In-Reply-To: <47161C38.2070305@ru.mvista.com>
References: <20070921032603.0D3EA32C887@thor> <4713A616.3090103@ru.mvista.com>
	<18195.64334.985238.848522@cargo.ozlabs.ibm.com>
	<47161C38.2070305@ru.mvista.com>
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

Sergei Shtylyov writes:

> > Tony started from an earlier patch by John Stultz, not from your
> > patches.
> 
>     Well, that I can believe, yet the clockevents patch has traces of my
> former work, and looking at read_persisitent_time() it looks suspiciously 
> close to my version too...

There is basically only one reasonably way to do a lot of this stuff.

> > The main reason your patches were rejected were that you completely
> > broke the VDSO and the deterministic time accounting, and made no
> 
>     That's just not true!
>     They didn't broke vDSO (to be precise it was John's patch that broke it), 
> they just removed the vDSO code known to already be broken by -rt patch for 
> several months by then.  And they didn't broke determinictic accounting -- 
> they just made two things mutually exclusive.  I haven't yet seen how the 
> patches that were preferred dealt with it at all.

OK.  My requirement was that the clocksource/clockevent stuff and the
VDSO were both functional.  Your patch didn't meet that requirement.

>     Really? IMO, the harware does keep a constant interrupt rate better than 
> software.

Well, if you have actual numbers to back that up, show them to us.
I don't believe you would be able to measure any difference, and so I
prefer the simplicity of only implementing the one-shot mode.

> > Because you broke important features
> 
>     That is *not true*.
>     And nobody had interest to fix them for months (quite strange if they're 
> so important) while I had neither time nor interest to deal with them anymore 
> having written the code that *did work*, and not only for me.

Well, this is the difference between having a hack that works for you,
and having something that can go upstream into mainline.

Anyway, this discussion doesn't seem to be going anywhere.  If there
are changes you want made, or any other specific concrete action you
want anyone to do, say so.  Otherwise stop whinging.

Paul.
