In-Reply-To: <20040114181350.B40506@forte.austin.ibm.com>
References: <20040114161107.GM2658@adapter.n0skillz.org> <20040114181350.B40506@forte.austin.ibm.com>
Mime-Version: 1.0 (Apple Message framework v609)
Message-Id: <70D6BF86-473D-11D8-A8C3-000A95A4DC02@kernel.crashing.org>
Cc: valvoline <valvoline@vrlteam.org>,
	linuxppc-dev@lists.linuxppc.org
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Broadcom BCM94306
Date: Thu, 15 Jan 2004 10:30:21 +0100
To: linas@austin.ibm.com
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 15-jan-04, at 1:13, linas@austin.ibm.com wrote:
> totally irrelevent and off-topic, but ... the ppc can (or used
> to be able to) switch endianess dynamically.  To be more correct,
> it can run some user-space code that was little endian, by having
> the kernel set the appropriate bit in the MSR before it ran the
> app.  I have no idea is the linux kernel saves/restores this bit(s),
> or if this is still supported on the newest processors.

It can also run supervisor-level code in little endian mode.

The 2.0 PEM still doesn't show this support as optional [look at the
ILE and LE bits in the MSR], but it does say that "the code sequence
used to switch from big to little-endian mode may differ among
processors".

Also note that the 970 does not support wrong^H^H^H^H^Hlittle-endian
mode
at all.

As these bits are in the MSR, and you are supposed to leave alone the
bits
that you don't explicitly touch, I suppose the Linux kernel
saves/restores
the bits just fine.  But I didn't check whether it actually does, so
YMMV.


Segher


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
