Subject: Re: Patch boot/common/relocate.S to start kernel at 0x000c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dale Farnsworth <dale@farnsworth.org>
Cc: Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20030305042834.GA5355@rover.farnsworth.org>
References: <15973.18737.651334.824024@argo.ozlabs.ibm.com>
	 <20030305010318.6A4D3C6E0C@atlas.denx.de>
	 <15973.24544.124365.553602@argo.ozlabs.ibm.com>
	 <20030305042834.GA5355@rover.farnsworth.org>
Content-Type: text/plain
Message-Id: <1046858087.890.104.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Date: 05 Mar 2003 10:54:48 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Well, that does add the requirement that kernel data be mapped at its
> linked-at address before __secondary_hold references said variable.
>
> By the way, the recent addition of the call to smp_call_init_cpu,
> places the same requirement on __secondary_start, unfortunately.

smp_call_init_cpu() is broken in various ways, and I'm about to kill
it, sorry for the inconvenient. I'm finishing tests of the replacement
in my tree now (and already pushed it to 2.5).

However, I'm replacing it with some cleaner assembly code that still
has to access the kernel memory. secondary_start has to be called
with MSR:DR=0 and kernel at it' linked location (but the later shouldn't
be a problem, and clearing MSR:DR neither).

I'll push the new code today

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
