Return-Path: <willy@parisc-linux.org>
Received: from mail.parisc-linux.org (palinux.external.hp.com [192.25.206.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.parisc-linux.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9C88DDDFAD
	for <linuxppc-dev@ozlabs.org>; Wed, 28 May 2008 08:04:09 +1000 (EST)
Date: Tue, 27 May 2008 15:42:41 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: MMIO and gcc re-ordering issue
Message-ID: <20080527214241.GA22636@parisc-linux.org>
References: <1211852026.3286.36.camel@pasglop>
	<20080526.184047.88207142.davem@davemloft.net>
	<1211854540.3286.42.camel@pasglop>
	<20080526.192812.184590464.davem@davemloft.net>
	<1211859542.3286.46.camel@pasglop>
	<alpine.LFD.1.10.0805270833060.2958@woody.linux-foundation.org>
	<1211922621.3286.80.camel@pasglop>
	<alpine.LFD.1.10.0805271421570.2958@woody.linux-foundation.org>
	<1211924335.3286.89.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1211924335.3286.89.camel@pasglop>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	tpiepho@freescale.com, linuxppc-dev@ozlabs.org, scottwood@freescale.com,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Miller <davem@davemloft.net>, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 28, 2008 at 07:38:55AM +1000, Benjamin Herrenschmidt wrote:
> A problem with __raw_ though is that they -also- don't do byteswap,
> which is a pain in the neck as people use them for either one reason
> (relaxed ordering) or the other (no byteswap) without always knowing the
> consequences of doing so...

That's why there's __readl() which does byteswap, but doesn't do
ordering ...

> I'm happy to say that __raw is purely about ordering and make them
> byteswap on powerpc tho (ie, make them little endian like the non-raw
> counterpart).

That would break a lot of drivers.

> Some archs started providing writel_be etc... I added those to powerpc a
> little while ago, and I tend to prefer that approach for the byteswap
> issue.

Those are for people who use big endian chips on little endian
architectures.

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
