From: benh@kernel.crashing.org
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Dan Malek <dan@embeddededge.com>,
	Paul Mackerras <paulus@samba.org>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: Re: More details on the telnet with CONFIG_PIN_TLB problems
Date: Tue, 4 Jun 2002 21:31:30 +0200
Message-Id: <20020604193130.2384@mailhost.mipsys.com>
In-Reply-To: <20020605032241.GD2630@zax>
References: <20020605032241.GD2630@zax>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>I've committed a patch to use 'sync' before changing the PID (to flush
>any loads/stores through the MMU before we change the context) and
>'isync' afterwards to flush the shadow TLBs.  I'm guessing that isync
>flushes both shadow TLBs, not just the ITLB, and that the missing
>infomation is a documentation error.  I've sent some email to the IBM
>PPC support people to check.

Sounds good. In my local tree, I also replaced the icbi's in
flush_dcache_icache & flush_instruction_cache with iccci's to
make sure we don't have stale aliases. I haven't yet checked
glibc for this though.

Ben.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
