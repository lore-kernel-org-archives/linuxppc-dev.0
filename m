Return-Path: <kyle@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1F685DDDA9
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Feb 2009 04:48:46 +1100 (EST)
Date: Tue, 24 Feb 2009 12:48:38 -0500
From: Kyle McMartin <kyle@infradead.org>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH/RFC] powerpc: avoid generating .eh_frame sections with
	gcc-4.4
Message-ID: <20090224174838.GB6690@bombadil.infradead.org>
References: <20090224065112.GA6690@bombadil.infradead.org>
	<20090224084034.GA11847@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090224084034.GA11847@uranus.ravnborg.org>
Cc: kyle@redhat.com, Kyle McMartin <kyle@infradead.org>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	aoliva@redhat.com, roland@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 24, 2009 at 09:40:34AM +0100, Sam Ravnborg wrote:
> x86 has a specific ".section .eh_frame,"a",@progbits" in vdso32/int80.S as one example.
> 
> Have you analyzed all these hits?
> 

These aren't effected by the patch. All the occurances of it inside the
kernel are explicitly written for the vdso/vsyscall functionality (which
needs it, since it's mapped into a userspace task, and you obviously
might be running a debugger on it.) The other hit in x86_64 is just a
discard section of the linker script.

regards, Kyle
