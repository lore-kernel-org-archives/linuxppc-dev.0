Date: Wed, 24 Jul 2002 10:30:40 +1000
From: Anton Blanchard <anton@samba.org>
To: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>
Cc: linuxppc-dev@lists.linuxppc.org,
	yellowdog-devel@lists.terrasoftsolutions.com
Subject: Re: why isync in atomic icc and return and atomic dec and return for CONFIG_SMP
Message-ID: <20020724003040.GE6355@krispykreme>
References: <200207231725.30067.kevin.hendricks@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200207231725.30067.kevin.hendricks@sympatico.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Kevin,

> Can anyone tell me the reason why we need to use an isync in the
> atomic_add_return and atomic_sub_return (see kernel source in
> asm/atomic.h) only for SMP machiens and only when a value is returned?

We are using isync here as an "import barrier". The stwcx., bne, isync
sequence ensures that any instructions following the isync are not
performed until the lock has been taken. Basically it prevents anything
inside the spinlock protected region from leaking outside.

We dont need this on a UP machine because the local cpu sees everything
in program order.

Anton

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
