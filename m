MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16174.17030.820826.915675@cargo.ozlabs.ibm.com>
Date: Mon, 4 Aug 2003 21:24:54 +1000
From: Paul Mackerras <paulus@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Franz Sirl <Franz.Sirl-ppc@lauterbach.com>,
	Miles Lane <miles.lane@comcast.net>, linuxppc-dev@lists.linuxppc.org,
	Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: linuxppc-2.5 (rsync mvista) -- drivers/input/evdev.c:243:
	error: invalid lvalue in asm statement
In-Reply-To: <1059990141.3232.1.camel@gaston>
References: <16172.61621.985947.378822@cargo.ozlabs.ibm.com>
	<200308021823.30382.miles.lane@comcast.net>
	<5.2.1.1.2.20030804104557.01f0fe00@mail.lauterbach.com>
	<1059990141.3232.1.camel@gaston>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt writes:

> It's still totally wrong to access userland with a variable sized
> data since my understanding is that userland doesn't know what size
> the kernel will use for access here, thus it works for little endian
> but not big endian (well... afaik).

The userland data isn't variable-sized; it's an int, and it is
accessed as an int because the pointer given to get_user is int *.
The problem is (as Franz pointed out) the use of (a? b: c) as an
lvalue.

Incidentally there is a bug in the INPUT_KEYCODE macro: the second
(dev->keycodesize == 1) should be == 2 instead (the condition for the
u16 case).

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
