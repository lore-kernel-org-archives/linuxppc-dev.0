MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Compiling kernel with -g option.
Date: Wed, 7 Nov 2001 12:11:35 -0500
Message-ID: <FF6CF34C346E724596A2FB5CAAB2C49750C5C0@voyager.ops.infiniswitch.com>
From: "Wright, David" <dwright@infiniswitch.com>
To: "Jerry Van Baren" <vanbaren_gerald@si.com>,
	<linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> -----Original Message-----
> From: Jerry Van Baren [mailto:vanbaren_gerald@si.com]
> Relocation truncated to fit errors are typically caused by
> your executable exceeding 16Mbytes (24 bits) in size (assuming
> it isn't caused by missing modules and thus unresolved references).

In this case, however, it was clear that the problem WAS due to
unresolved references -- specifically, the "copy_to_user" refs.
That's always going to happen if you turn off optimization, because
those are inlined functions, and you have to use at least -O1 to
get those to be compiled as inlines (at least with gcc).

I've never seen a 16 MB linux kernel, even with -g turned on; I
guess you might be able to do it if you enabled every driver and
option, but my mid-sized vmlinux, with -g, is 8 MB.

  -- David Wright, Consulting Engineer, InfiniSwitch Corp.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
