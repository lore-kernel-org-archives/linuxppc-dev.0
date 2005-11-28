Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17290.26688.710369.613144@cargo.ozlabs.ibm.com>
Date: Mon, 28 Nov 2005 13:15:28 +1100
From: Paul Mackerras <paulus@samba.org>
To: Giuliano Pochini <pochini@shiny.it>
In-Reply-To: <20051126113805.709ee538.pochini@shiny.it>
References: <20051126113805.709ee538.pochini@shiny.it>
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>
Subject: Re: CPU off power consumption
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Giuliano Pochini writes:

> Out of curiosity, what's the difference between a cpu that has never been
> enabled and one that has been disabled with echo 0>/sys/.../online ? It
> happens that when I boot with maxcpus=0 the temperature always stays low
> enoung that the fan never spins up. If I enable and then I immediately
> disable the 2nd cpu, the temperature goes a few degrees up. I have a dual
> G4-MDD.

Interesting.  A cpu that has been disabled will be in sleep mode with
interrupts disabled and its caches flushed.  One that has never been
started may possibly be held in the reset state.  The way to check
would be to check the state of the GPIO register that controls the
soft reset line of the second CPU.

Paul.
