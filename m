Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17929.44043.728362.712648@cargo.ozlabs.ibm.com>
Date: Wed, 28 Mar 2007 09:43:07 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH] powerpc: Disable external interrupts in bootwrapper
In-Reply-To: <20070327222840.GA1266@mag.az.mvista.com>
References: <20070327222840.GA1266@mag.az.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mark A. Greer writes:

> Disable external interrupts very early in the bootwrapper in case
> the firmware left a device generating interrupts.

Sounds reasonable, except that I wonder if systems running under a
real OF want to do this...

> +	li	r9,(1<<15)@l	/* Disable external intrs (clear MSR[EE]) */

That will actually get us ffff8000 in r9.

> +	mfmsr	r10
> +	andc	r10,r10,r9

I suggest this sequence instead:

	mfmsr	r10
	rlwinm	r10,r10,0,~(1<<15)	/* clear MSR_EE */

Paul.
