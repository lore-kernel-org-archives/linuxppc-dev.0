Subject: Re: cache coherence problem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reply-To: benh@kernel.crashing.org
To: Gabriel Paubert <paubert@iram.es>
Cc: Juergen Kienhoefer <juergen@kienhoefer.com>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20031118093711.GB3924@iram.es>
References: <3FB972E8.5090701@kienhoefer.com>
	 <1069122238.7168.63.camel@gaston>  <20031118093711.GB3924@iram.es>
Content-Type: text/plain
Message-Id: <1069202105.31665.4.camel@gaston>
Mime-Version: 1.0
Date: Wed, 19 Nov 2003 11:35:06 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>  newly mapped in blank pages,
>
> If you mean zeroed pages for blanked, I believe that it is wrong.
> The reason being that 0 is an invalid instruction so that the code
> would trap in any case.
>
> Maybe I'm wrong, but I seem to remember this as an optimization
> that Paulus implemented some time ago.

And that we had to undo because glibc relied on it, not invalidating
cache lines in some conditions assuming newly mapped zeroed pages
are delivered icache-clean by the kernel.

One of the arguments of the glibc folks for not fixing that was that
it would be a security hole to let stale icache content leak, so the
kernel has to invalidate them anyway.

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
