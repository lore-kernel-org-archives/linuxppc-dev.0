Message-Id: <5.1.0.14.2.20011107122743.00bc8ba0@falcon.si.com>
Date: Wed, 07 Nov 2001 12:33:55 -0500
To: <linuxppc-embedded@lists.linuxppc.org>
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: RE: Compiling kernel with -g option.
In-Reply-To: <FF6CF34C346E724596A2FB5CAAB2C49750C5C0@voyager.ops.infinis
 witch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks for the clarification.  "copy_to_user" didn't ring any bells with me
(will now :-) and the original message didn't show it as an obvious
unresolved reference.  This means that this could also be fixed by removing
the "inline" attribute, but -O1 is a MUCH better option.

I also was incorrect on my allowable relative branch range (stoopid memory
going flaky on me again -- one of these days I'll to look things up before
saying stupid things).  The branch is a signed 26 bit number (2 LSBs are
zero because the destination must be 32-bit aligned) which gives a
+/-32MByte range.  Pretty generous.

gvb


At 12:11 PM 11/7/01 -0500, Wright, David wrote:

> > -----Original Message-----
> > From: Jerry Van Baren [mailto:vanbaren_gerald@si.com]
> > Relocation truncated to fit errors are typically caused by
> > your executable exceeding 16Mbytes (24 bits) in size (assuming
> > it isn't caused by missing modules and thus unresolved references).
>
>In this case, however, it was clear that the problem WAS due to
>unresolved references -- specifically, the "copy_to_user" refs.
>That's always going to happen if you turn off optimization, because
>those are inlined functions, and you have to use at least -O1 to
>get those to be compiled as inlines (at least with gcc).
>
>I've never seen a 16 MB linux kernel, even with -g turned on; I
>guess you might be able to do it if you enabled every driver and
>option, but my mid-sized vmlinux, with -g, is 8 MB.
>
>   -- David Wright, Consulting Engineer, InfiniSwitch Corp.
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
