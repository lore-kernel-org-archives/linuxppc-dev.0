Message-ID: <67505026E29DD311A9AA00508B7315F33B739F@EXCHANGE>
From: Mike Flynn <mflynn@enerdyne.com>
To: "'linuxppc-embedded@lists.linuxppc.org'"
	 <linuxppc-embedded@lists.linuxppc.org>
Subject: restart on LinuxPPC kernel 2.2.13.
Date: Wed, 20 Sep 2000 13:41:51 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan,

Does anyone have any idea why the LinuxPPC 2.2.13 kernel will not respond to
"shutdown -nr now,"
but HardHat's 2.2.13 kernel will? We are finding things broken in our
drivers and
applications with the HH version, and that is probably due to the HH version
a more straightforward
and honest interface than the ones we got "just to work." To solve an
immediate need, we need the
remote restart function working in LinuxPPC.

Thanks,
Mike Flynn

> -----Original Message-----
> From:	Mike Flynn
> Sent:	Wednesday, September 20, 2000 1:21 PM
> To:	'MVista support'
> Subject:	Differences between HardHat 2.2.13 PPC kernel on CDK 1.0 and
> the LinuxPPC 2.2.13 kernel.
>
> After modifying m8xx_setup.c in linux/arch/ppc/kernel/
> and executing "shutdown -nr now," linux would stop, but not restart.
> The kernel (LinuxPPC 2.2.13) is what we have been shipping in
> our products. I tried it with your hardhat kernel (CDK1.0) and not
> only does the OS shutdown, the Embedded Planet PROM is
> accessed and the CLLF will restart. This is good.
>
> However, with the HH kernel, our video stream glitches. This is bad.
> We found that we had to block reading of 4k worth of video and the
> video now runs correctly. This is good.
>
> However, we could no longer read our E2 on our mother board hosting
> the CLLF. That's bad. After some time with a scope, we found
> that instructions were running faster under your kernel, therefore, our
> time delays were now too short. We adjusted them and we read our
> E2 just fine and life is good.
>
> Our applications are compiled on the same system using the
> same compiler, but they run differently on the two kernels. It appears
> the earlier kernel does not cache instructions and yours does
> which means there are differences between them. What are
> they?
>
> We are not able to telnet to our box running your kernel with our
> video. It appears no other application gets priority except our
> video stream. We need to know what is different about your
> kernel to determine how our drivers and applications are being
> effected.
>
> Thank you,
>
> Mike Flynn
> Principal Software Engineer
> Enerdyne Technologies
> 8402 Magnolia Ave.
> Suite C
> Santee, CA 92041
> Voice: 619-562-3061
> Fax: 619-562-8802
> MFlynn@Enerdyne.com
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
