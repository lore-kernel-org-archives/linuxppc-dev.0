From: benh@kernel.crashing.org
To: <paulus@samba.org>, Michael Sokolov <msokolov@ivan.Harhan.ORG>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: CONFIG_GENERIC_PPC32
Date: Wed, 10 Apr 2002 16:23:01 +0100
Message-Id: <20020410152301.17271@mailhost.mipsys.com>
In-Reply-To: <15540.15381.392984.428785@argo.ozlabs.ibm.com>
References: <15540.15381.392984.428785@argo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>The other thing I don't like is the bi_rec changes.  While I like the
>idea of passing in device information in bi_recs, I really don't like
>the use of binary tags for the various specific pieces of information
>that we want to specify for the different devices.  This is ultimately
>once again a maintainability concern.  Using an enumeration like that
>basically forces us into having a central repository for assigning the
>numbers and that is going to get us into problems down the track.
>
>Instead I think that both the names of the pieces of information, and
>the values of things like the device type, should be represented as
>strings.  Using strings just gives us orders of magnitude more
>flexibility and extensibility, and is much more suitable for the sort
>of decentralized and distributed development that we do.

Well, I don't think we really need strings. If we go tha way, we'll
soon end-up re-inventing a bastardized OF device-tree and we could
rather use a real one there ;)

What I would have liked would have to use the tag 32 bits as a 4
character constant (common practice in macos). The problem is that
it requires re-defining existing bi_rec's but that isn't really
compilicated to support them for compatibility.

That way, we have something that is more readable than an enum, less
likely to collide. Then, we define that the kernel will only define,
for example, all lowercase constants. That mean that you are free to
add your custom tags making sure you won't collide with whatever a
new kernel version can recognize (and that include drivers bundled
with the kernel).

Now, we can even define some more precise scheme for using those 4
characters, like though I really don't think it's that much needed.
We will never define bazillions of tags. Maybe a few dozen for what
is currently in bd_t, and a dozen or so more for drivers that can
get configuration infos, and that's all.

>Now if we are worried about space then we can get creative about how
>the strings are stored in the bi_recs, for instance we could store
>each unique string exactly once in a string table and then just use a
>16-bit index in each place where we want to refer to a string.  We
>could put the string table in a bi_rec of its own, and even gzip it if
>necessary.
>
>About the early_serial_init changes - using early_serial_init is nice
>when the serial driver is built in, but the problem is that when the
>serial driver is a module, we don't get given the opportunity to do
>the early_serial_init calls between when the module is loaded and when
>it runs rs_init.  Otherwise I would have decreed the use of
>early_serial_init some time ago. :)

Does Ted has an idea ? I've also been told Russel King was rewriting the
serial driver for 2.5...

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
