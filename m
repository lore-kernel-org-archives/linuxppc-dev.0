From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
To: "Tom Rini" <trini@kernel.crashing.org>
Cc: "Todd Poynor" <tpoynor@mvista.com>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: consistent_free re-revisited
Date: Thu, 12 Sep 2002 09:49:07 +0200
Message-Id: <20020912074907.29155@192.168.4.1>
In-Reply-To: <20020912145146.GD13840@opus.bloom.county>
References: <20020912145146.GD13840@opus.bloom.county>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> I tend to hate anything that relies on in_interrupt() as they
>> are other contexts that will have in_interrupt() cleared but still
>> have the same limitations. Typically, anything on the VM path must
>> do either GFP_ATOMIC or GFP_NOIO allocations, wether it's running
>> at interrupt time or not.
>
>The problem is that the atomic pool is limited, iirc.

Well, ATOMIC can fail, sure, but if you do GFP_KERNEL within a
VM code path, then be prepared for deadlocks.

A driver that would need such allocations during it's request
handling path would suck anyway and should pre-allocate ;) But
if this is the case, then it must be able to say that it wants
ATOMIC or NOIO allocations, and if the driver is done properly,
it should be able to deal gracefully with failure, typically
for a block driver by triggering a timer to try the request
again later or just fail the request (but that is generally
bad for a block driver).

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
