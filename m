From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg Allen <gallen@arlut.utexas.edu>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: Directly accessing I/O ports
Date: Sat, 20 Jul 2002 20:10:58 +0200
Message-Id: <20020720181058.30333@192.168.4.1>
In-Reply-To: <p05111b16b95d05434f09@[10.8.16.89]>
References: <p05111b16b95d05434f09@[10.8.16.89]>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>For that matter, what's the *right* way to access this sort of thing
>from userland?

mmap /proc/bus/pci with proper flags. By defaults it's PIO,
but you can use ioctl after the open() call and before the mmap()
call to set the requested mapping type to MMIO, PIO, ...

The code handling this is in drivers/pci/proc.c

The important point is that on PPC, the PIO space isn't limited
to one 64k space like on x86, but is a full set of separate address
spaces (one per host PCI bus).

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
