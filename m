Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (147.175.241.83.in-addr.dgcsystems.net
	[83.241.175.147]) by ozlabs.org (Postfix) with ESMTP id 7763C67B61
	for <linuxppc-dev@ozlabs.org>; Sun, 26 Nov 2006 22:05:12 +1100 (EST)
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: "'David Brownell'" <david-b@pacbell.net>,
	"'Benjamin Herrenschmidt'" <benh@kernel.crashing.org>
Subject: RE: NTP time sync
Date: Sun, 26 Nov 2006 12:04:54 +0100
Message-ID: <009a01c7114a$b429f850$020120ac@Jocke>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <200611251522.19900.david-b@pacbell.net>
Cc: akpm@osdl.org, 'Alessandro Zummo' <alessandro.zummo@towertech.it>,
	'Andi Kleen' <ak@muc.de>,
	'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>,
	ralf@linux-mips.org, linuxppc-dev@ozlabs.org,
	lethal@linux-sh.org, paulus@samba.org, kkojima@rr.iij4u.or.jp,
	davem@davemloft.net, rmk@arm.linux.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: 
> linuxppc-dev-bounces+joakim.tjernlund=transmode.se@ozlabs.org 
> [mailto:linuxppc-dev-bounces+joakim.tjernlund=transmode.se@ozl
> abs.org] On Behalf Of David Brownell
> Sent: den 26 november 2006 00:22
> To: Benjamin Herrenschmidt
> Cc: akpm@osdl.org; Alessandro Zummo; linuxppc-dev@ozlabs.org; 
> lethal@linux-sh.org; Linux Kernel Mailing List; 
> ralf@linux-mips.org; Andi Kleen; paulus@samba.org; 
> rmk@arm.linux.org.uk; davem@davemloft.net; kkojima@rr.iij4u.or.jp
> Subject: Re: NTP time sync
> 
> On Thursday 23 November 2006 3:00 am, Benjamin Herrenschmidt wrote:
> > 
> > Couldn't we have a transition period by making the kernel 
> not rely on
> > interrupts ? if the NTP irq code just triggers a work 
> queue, then all of
> > a sudden, all of the RTC drivers can be used and the 
> latency is small.
> > That might well be a good enough solution and is very simple.
> 
> Good point.  Of course, one issue is that the NTP sync code all
> seems to be platform-specific right now ... just like the code
> to set the system time from an RTC at boot (except for the new
> RTC framework stuff) and after resume.
> 
> - Dave

Looking at rtc-dev.c I don't see a MARJOR number assigned to /dev/rtcN. Seems like
it is dynamically allocated to whatever major number that is free.
Is that the way it is supposed to be? How do I create a static /dev/rtcN in my /dev
directory if the major number isn't fixed?
Maybe I am just missing something, feel free to correct me :)

 Jocke
