Return-Path: <jonathan@jonmasters.org>
Received: from mailhub-node1.mailbox.net.uk (relay-1.mailbox.net.uk
	[195.82.125.30]) by ozlabs.org (Postfix) with ESMTP id 855312BDB3
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 11 Oct 2004 08:20:53 +1000 (EST)
Message-ID: <4169B598.8060600@jonmasters.org>
Date: Sun, 10 Oct 2004 23:20:08 +0100
From: Jon Masters <jonathan@jonmasters.org>
MIME-Version: 1.0
To: Tony Lee <tony.p.lee@gmail.com>
References: <000001c4aace$245a5060$6500a8c0@PortatileLG>	
	<35fb2e5904100508157a393ee2@mail.gmail.com>	
	<4162C649.6060900@ru.mvista.com>	
	<35fb2e590410051507367017a@mail.gmail.com>	
	<41641222.6080405@ru.mvista.com>	
	<470b63970410071534422f6617@mail.gmail.com>	
	<4165DB83.8080001@jonmasters.org>	
	<470b6397041007195371655afb@mail.gmail.com>	
	<35fb2e59041009122710ab6d53@mail.gmail.com>
	<470b6397041009212664b9c80e@mail.gmail.com>
In-Reply-To: <470b6397041009212664b9c80e@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Andrei Konovalov <akonovalov@ru.mvista.com>,
	Luca Giuliani <l.giuliani@tiscali.it>, linuxppc-embedded@ozlabs.org
Subject: Re: Linux on Memec Virtex II Pro V4P7 Rev. 3
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Tony Lee wrote:

| On Sat, 9 Oct 2004 20:27:15 +0100, Jon Masters <jonmasters@gmail.com>
wrote:
|
|>On Thu, 7 Oct 2004 19:53:52 -0700, Tony Lee <tony.p.lee@gmail.com> wrote:
|>
|>
|>>The problem I saw was that I can't turn off the interrupt at all.
|>
|>On the Memec board? really?

| No, not on Memec,  just on our own HW.

Ah ok. Like you said, it's probably tied lines probably in the hardware
definition at fault here.

| I have the memec board, but I don't have time to play on that one.

Ah ok. I have a wonderful mixture of Memec and custom board also.

| I got to debug the HW one week after I was hired.

Indeed. Fun huh.

| As far as I can tell, our linux for memec board doesn't load
| the sysace driver.

Ok if you're not using it I guess.

|>>Once I start one write command, the ISR keep coming in.

|>Ouch.

| Tell me about it.  It tooks me 3+ days to id this.

It's taken me a long time on and off to fix these kinds of problem
because of the usual case of balancing other bits and pieces.

|>Perhaps. But that's down to your hardware guys to check the error
|>output from your synthesis tool to see if this weirdly has happened.
|>Our board doesn't have lines hard tied together, if that was the
|>notion you were offering.

| I tried to synthesize chipscope into into our VP20.

It apparently doesn't work if you're using sysace inline on the same
JTAG line that you want to use for chipscope interfacing. Having said
that I've not used chipscope other than seeing a very biref demo, and I
only heard this from a third party...so it might actually work ok.

| It is less of a priority since the sysace is working
| now for 1.5 months (without ISR).

I also have moved on to fixing other bits, bodging in a NULL ioctl in
smc91111.c to handle ethtool requests that aren't wanted, etc. Usual
case of fixing it up good enough for the current project and problem at
hand but wanting to find a better solution for next time around.

| Also, we use linux as Xilinux dev environment

We don't mostly for historical reasons, but I'm planning on moving the
development the way soon - I want this all nice and scriptable and this
just aint gonna be pretty on Windows. [OT] I just spent two hours on a
train with an MSFT employee sitting next to me...we didn't kill each
other but had a variety of interesting conversation.

|>>I try turn off the ISR on write with SYSACE register and
|>>the ppc interrupt control register.  None of them worked.

|>Did you do it as per my patch, or what?

| No, where can I find your patch?

In the list archives. It's only a quickie few lines, there's other stuff
I need to cleaup. Having mentioned that, I'm still working on the stuff
I mentioned in another thread on OpenFirmware tonight, having not got as
far as I planned this weekend. Less sleep tonight then.

|>Yes. We come up in 8 seconds to my firmware, and total boot time is
|>around 20 seconds, without any effort to make it less. That includes
|>cunning DHCP+ZeroConf scripts I wrote.

| That's about right,  We don't do DHCP, it comes up a bit faster.

I'd love to create a special interest group of Linux on Virtex II Pro
users - not really a mailing list, just a group of us who use it and are
willing to share experiences with eachother and perhaps newcomers as the
documentation for all of this is shockingly absent :-).

Jon.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBabWXeTyyexZHHxERAtB9AJ4yfwsoMfABgwtSB5hZfIRafuszrgCbBM83
UBVQN83pPbwi1PnMpFvCg+0=
=QH8A
-----END PGP SIGNATURE-----
