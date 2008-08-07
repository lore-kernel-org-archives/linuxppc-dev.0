Return-Path: <torvalds@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AEA34DDF5E
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Aug 2008 10:44:33 +1000 (EST)
Date: Wed, 6 Aug 2008 17:44:19 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH]: Remove bogons from the iSeries console
In-Reply-To: <18586.14112.751080.325656@cargo.ozlabs.ibm.com>
Message-ID: <alpine.LFD.1.10.0808061742220.3462@nehalem.linux-foundation.org>
References: <20080806140629.268fcf07@lxorguk.ukuu.org.uk>
	<18586.14112.751080.325656@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: boutcher@us.ibm.com, linuxppc-dev@ozlabs.org, torvalds@linuxfoundation.org,
	devilbis@us.ibm.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



On Thu, 7 Aug 2008, Paul Mackerras wrote:
> 
> I think you want "return -ENOIOCTLCMD" rather than "return ret" since
> ret is uninitialized with your patch applied.

Actually, nobody has apparently ever even tried compiling that function 
even before. 

Yes, 'ret' became uninitialized, but since it was never declared, it 
doesn't matter - it wouldn't compile anyway.

> I agree the call to n_tty_ioctl is bogus but I think we just want to 
> return -ENOIOCTLCMD.

I made that change, and in the spirit of that file I also didn't even try 
to compile it. So if the end result sexually assaults your pets, don't 
blame me. 

			Linus
