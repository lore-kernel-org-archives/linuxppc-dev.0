To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: paulus@samba.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: boot methods 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 15 Oct 2001 14:42:14 +0200."
             <20011015124214.18780@smtp.adsl.oleane.com>
Date: Mon, 15 Oct 2001 15:32:42 +0200
Message-Id: <20011015133247.50A5910887@denx.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <20011015124214.18780@smtp.adsl.oleane.com> you wrote:
> >
> >* When porting Linux to new hardware the wrapper adds  an  additional
> >  layer which must be adapted and ported. If you have PPCBoot running
> >  on  a  board,  all  that's  needed to "port" Linux to that board is
> >  copying things like ethernet intialization from the PPCBoot sources
> >  - since PPCBoot is based on Linux device driver  code,  this  is  a
> >  simple copy & paste.
>
> No. When porting to new hardware, you expect your bootloader to pass
> the proper bi_recs your kernel need and your wrapper will be either
> empty, or just the standard one. In some case, I expect a same
> kernel could even work with a wide range of boards as base addresses
> and config for some legacy drivers could be passed via bi_recs as well.

No what? I don't see any discrepance in yout statement and  mine.  We
will  switch  to  bi_rec's without complaining once the interface has
been defined.

> The goal of bi_rec's here is to replace bd_t with a tagged structure.

That's fine for me.

> One thing I want here is to stop parsing the bi_rec's once for all in
> the kernel, but on the contrary keep them available all the time a bit

What does that mean? You want to replace the old  bd_t  by  bi_rec's,
and  then  add  a  wrapper that parses tthe bi_rec's and builds a new
bd_t type stucture, just to be able to easily change the bd_t layout?

> Which is also what the bi_recs will help do in a more generic way.
> The point of the wrapper is to handle firmware that don't already pass
> the bi_recs we need, or more "interactive" firmwares like OF.

Agreed.

> I don't see the problem neither. Our proposed mecanism won't replace
> bootloaders like ppcboot.

Ummm... I'm sorry, but I seem to be missing something.  What  exactly
is  your "proposed mechanism"? I haven't seen any real proposals yet.
The statements I've seen so far are not clear at all.

You write "your wrapper will be either empty, or  just  the  standard
one".  Dan  Malek  wrote  "we  keep  suggesting a piggyback loader is
always used rather than trying to boot vmlinux (or compressed version
of it) directly" (mind that he talks about a LOADER,  which  probably
includes a lot more functions than a wrapper that just satisfies some
interface conversion).

Can you please explain:

- which interface will there be between the firmware and the "wrapper"?
- which interface will there be between the Linux kernel and the "wrapper"?
- which functions are _required_ in all cases by the wrapper?

> It handles whatever translation is needed between the firmware and the
> kernel. If your firmware (ppcboot) already pass in good shaped birecs
> and no translation is needed, just use an empty (or no) wrapper.

This would be perfectly fine to me - but  it  sounds  different  from
what I hear from others.


Please understand me: I don't oppose the change,  on  contrary:  I've
been  bitten  often  enough  by  the  limitations of the current bd_t
stuff. I want to get rid of it as soon as  possible.  But  so  far  I
haven't  seen  a  clear  proposal,  nor  seen  any  code.  I  got the
impression that different people have very differenti deas of what is
going to happen, and I'm just trying to find out  to  whom  I  should
listen ;-)

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
To the systems programmer,  users  and  applications  serve  only  to
provide a test load.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
