Message-ID: <002501c281dc$c92182c0$0200a8c0@telia.com>
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Dan Malek" <dan@embeddededge.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <IGEFJKJNHJDCBKALBJLLAEIPFHAA.joakim.tjernlund@lumentis.se> <3DC2BAD9.5020907@embeddededge.com>
Subject: Re: dc* (Data Cache)  instructions in mem*() and *_page() functions not used on 8xx
Date: Fri, 1 Nov 2002 20:27:58 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


----- Original Message -----
From: "Dan Malek" <dan@embeddededge.com>
To: <joakim.tjernlund@lumentis.se>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sent: den 1 november 2002 18:33
Subject: Re: dc* (Data Cache) instructions in mem*() and *_page() functions not used on 8xx


> Joakim Tjernlund wrote:
>
> > Dan, could you add the missing code for 8xx to detect the exception conditions when
> > the cache instructions faulted? I would like to give it a try.
>
> It's not very high on my list of things to do.  As I recall, the VM fault
> handler may need knowledge of a dcbz fault and use a different method to
> determine the address.  I also have this funny feeling that it isn't a
> restartable operation, so we may have to emulate the instruction when
> the fault occurs.

I don't follow you here, do you need to do all this for a modern(>=D4) 8xx CPU?
I hope not, but something needs to be done since copytofrom_user does not
work for me.

>
> I know you can write a test that would show this to be a performance
> benefit, which would just copy/zero lots of data, but that's not a real
> world application.
>
> IMHO, it's lots of work for little, if any, gain.  It has some specific
> uses in specialized applications, but I don't think it's a general speed up
> solution.
>
>  > Maybe add a new CONFIG option to allow 8xx to use these optimizations when
> > explicitly enabled.
>
> How would you know when to do this?  It seldom appeared in any errata
> so you couldn't know for certain if a particular chip version would
> allow this.  I suspect people (like I have chosen to do) will just never
> use the optimization because the software will always work in this case.
> I don't like solutions that depend on luck or trial and error.

Pretty much like the 8xx_CPU6 errata. If a user has a CPU with this bug,
he must enable it. If you have a fairly new CPU you don't have to.

The same resoning goes for the new option. If you have a new enough(>=D4) CPU,
then you can enable this optimization(I think?!). I am not talking about enabling
workarounds for non functioning CPUs in runtime. Take me for example,
our boards will never use anything older than D4 since it's a new design.

      Jocke
>
> I'll do some research into this again, it's been many years since I
> thought about it.
>
> -- Dan
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
