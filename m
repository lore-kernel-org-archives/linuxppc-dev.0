From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <libc-alpha@sources.redhat.com>
Cc: <linuxppc-dev@lists.linuxppc.org>, Dan Malek <dan@mvista.com>,
	<cort@fsmlabs.com>, <paulus@samba.org>
Subject: Re: PPC sysdep additions & problem
Date: Fri, 6 Apr 2001 14:22:27 +0200
Message-Id: <20010406122227.17368@mailhost.mipsys.com>
In-Reply-To: <20010406101714.12391@mailhost.mipsys.com>
References: <20010406101714.12391@mailhost.mipsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Note that so far, I had some problems loading binaries if I add
>3 entries to the aux table from the kernel with numbers 1000,1001,1002.
>I'm not sure what would have caused binaries not to load properly
>(apparently, their command line gets screwed, I'm not too sure yet).
>The glibc code that fills the "seen" mask definitely couldn't set
>bits for those entries, but this shouldn't have caused any problem.

Correcting myself, the behaviour of 1<<X with X>31 beeing undefined, the
compiler was free to do a modulo, and so caused some real "seen" bits to
be garbled.

So I would suggest modifying slightly glibc to not mask bits above 31,
thus allowing platform-specific high-value tags to be passed there in
the future.

In the meantime, I still need a <31 number allocated for those cache
line sizes ;)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
