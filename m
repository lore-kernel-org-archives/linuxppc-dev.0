Subject: Re: Would setting the CONFIG_RTC option break the powerpc kernel
	on your machine ?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: Tom Rini <trini@kernel.crashing.org>,
	Lee Braiden <jel@ntlworld.com>, debian-powerpc@lists.debian.org,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040107065458.GA20228@iliana>
References: <20031217095139.GC2283@iliana>
	 <20031217164740.GR11761@stop.crashing.org> <20031217165608.GA11653@iliana>
	 <20031217170620.GS11761@stop.crashing.org> <20031219114050.GA5650@iliana>
	 <20031219162800.GE29266@stop.crashing.org> <20031222134504.GA5964@iliana>
	 <20031222161042.GB10841@stop.crashing.org> <20031222162601.GA9021@iliana>
	 <20031222163315.GC10841@stop.crashing.org>  <20040107065458.GA20228@iliana>
Content-Type: text/plain
Message-Id: <1073460144.784.79.camel@gaston>
Mime-Version: 1.0
Date: Wed, 07 Jan 2004 18:22:25 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> BTW, i didn't manage to get the generic RTC code working on my pegasos,
> and i am actually a bit pressed for time.
>
> Do you think a workaround, for the debian powerpc packages, would be to
> add a test for the presence of a pmac in the CONFIG_RTC code, and abort
> if one is found ?
>
> If so, what would be the best way to test for a pmac subarch in the
> drivers/char/rtc.c code ?

will the kernel let you build both drivers in ?

then you can do, in 2.4, something ugly like that:

#ifdef CONFIG_ALL_PPC
if (_machine == _MACH_Pmac)
	return -ENODEV;
#endif

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
