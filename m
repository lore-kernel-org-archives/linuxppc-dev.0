From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Cort Dougan <cort@fsmlabs.com>, Matthew Locke <mlocke@mvista.com>
Cc: akuster <akuster@dslextreme.com>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [RFC/Patch] 4xx idle loop
Date: Thu, 25 Jul 2002 18:20:26 +0200
Message-Id: <20020725162026.19919@192.168.4.1>
In-Reply-To: <20020725105336.F2276@host110.fsmlabs.com>
References: <20020725105336.F2276@host110.fsmlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>I can only think of three ifdef's that would be necessary now but it could
>grow.  If the #ifdef snarl is unattractive in idle.c it's easy enough to
>move it to chipfamily-specific headers so that idle.c just needs to call
>arch_idle() to enter an idle state.
>
>The function pointer isn't desirable.  What the correct strategy for power
>saving is known at compile time so there shouldn't be a function pointer
>dereference.  How the #ifdef's are done doesn't really matter as long as
>the inefficiency of a function pointer is avoided.

Well, while I tend to agree with you on this, experience proved that
slightly abusing the ppc_md. indirection somewhat helped make the
code cleaner (read: more self-contained, less cruft, ...)

Also, in this specific case, we might well want to have an machine
specific power saving feature: I've had various tweaks in mind for
powermac laptops that I never ended up implementing...

ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
