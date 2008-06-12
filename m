Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18512.32267.636550.47385@cargo.ozlabs.ibm.com>
Date: Thu, 12 Jun 2008 11:38:19 +1000
From: Paul Mackerras <paulus@samba.org>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: linux-next: powerpc build failure
In-Reply-To: <20080611095951.GB14033@elte.hu>
References: <20080611192748.686236fd.sfr@canb.auug.org.au>
	<20080611095951.GB14033@elte.hu>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org,
	linux-next@vger.kernel.org, amodra@bigpond.net.au,
	"H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ingo Molnar writes:

> could this be a tool chain limitation perhaps, or a gcc bug? Or does the 
> allyesconfig size go beyond some fundamental hardware limitation. (i 
> doubt it's the latter)

Direct unconditional branches, including procedure calls, can only
reach +/- 32MB from the address of the branch on powerpc.  So if the
image grows to more than 32MB of text there is a problem unless the
linker is smart enough to insert trampolines.  I don't know whether
GNU ld is that smart.  I'm cc'ing Alan Modra who would know the answer
to that.

Paul.
