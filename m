Date: Thu, 29 Nov 2001 19:20:03 +0100 (CET)
From: Gabriel Paubert <paubert@iram.es>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: <linuxppc-dev@lists.linuxppc.org>,
	Dan Malek <dan@embeddededge.com>, <paulus@samba.org>
Subject: Re: 7450 bugs & fixes
In-Reply-To: <20011129150047.11980@mailhost.mipsys.com>
Message-ID: <Pine.LNX.4.33.0111291907570.3233-100000@gra-lx1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 29 Nov 2001, Benjamin Herrenschmidt wrote:

>
> After reading the 7450 errata book, I'm now trying to figure out
> what need to be done for our kernel to work properly on these.
> I'd appreciate any input from other people here as some of the
> errata exact consequences aren't that clear to me.
>
> I've figured out so far that we need to handle 7450's as far as
> rev 2.0 included. Apple seem to be the company who used the earliest
> ones in released products and according to the infos I got from them,
> they used rev 2.0 on uniprocessor desktop machines only, and rev. 2.1
> on SMP machines & laptops. They also seem to have developed a HW
> workaround for errata #38 making safe the use of the HW hashtable
> loopkups on rev. 2.1 CPUs. (at least according to an Apple engineer
> I contacted on the Darwin mailing list).
>
> Here are the errata I think we are concerned about. I didn't list
> errata for things I beleive we don't use so far, like L3 flush assist,
> but those may have impacts I didn't foresee.
>
>  - errata 15: mismatched lwarx/stwcx. pairs can cause loss of
>    atomicity. That errata basically says we mustn't issue an
>    stwcx. if we didn't have a previous lwarx. That mean our
>    instance of stwcx. in the return from exception path should
>    be added an lwarx. Any other candidate spotted ?

The return from exception path does not have to be modified. The only
purpose of this stwcx. is to clear the reservation to ensure that an
atomic operation interrupted bwteen lwarx and stwcx. will never succeed.

Besides that, note that the errata is SMP only (of if you do atomic
operations on DMA descriptors for example) and the error is that CR0 does
not properly reflect the success of the write operation. But cr0 is a
"don't care" after the stwcx. in the exception return path.

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
