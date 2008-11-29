Return-Path: <benh@kernel.crashing.org>
Subject: Re: [patch 3/4] powerpc/mpic: dont reset affinity for secondary
	MPIC on boot
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <20081128200325.075254354@arndb.de>
References: <20081128195120.869318403@arndb.de>
	<20081128200325.075254354@arndb.de>
Content-Type: text/plain
Date: Sat, 29 Nov 2008 13:22:00 +1100
Message-Id: <1227925320.7356.66.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-11-28 at 20:51 +0100, Arnd Bergmann wrote:
> plain text document attachment
> (0003-powerpc-mpic-don-t-reset-affinity-for-secondary-MPI.patch)
> Kexec/kdump currently fails on the IBM QS2x blades when the kexec happens
> on a CPU other than the initial boot CPU.  It turns out that this is the
> result of mpic_init trying to set affinity of each interrupt vector to the
> current boot CPU.
> 
> As far as I can tell,  the same problem is likely to exist on any
> secondary MPIC, because they have to deliver interrupts to the first
> output all the time. There are two potential solutions for this: either
> not set up affinity at all for secondary MPICs, or assume that a single
> CPU output is connected to the upstream interrupt controller and hardcode
> affinity to that per architecture.
> 
> This patch implements the second approach, defaulting to the first output.
> Currently, all known secondary MPICs are routed to their upstream port
> using the first destination, so we hardcode that.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
