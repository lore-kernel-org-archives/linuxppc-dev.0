Date: Thu, 19 Apr 2001 20:07:18 +0100
Subject: Re: XF4 (mach64) help please
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ani Joshi <ajoshi@shell.unixbox.com>,
	William Blew <wblew@home.com>, michel dnzer <michdaen@iiic.ethz.ch>,
	kaoru fukui <k_fukui@highway.ne.jp>, linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010419190740.A697B2EFF6@apollo.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  Thu, Apr 19, 2001, Geert Uytterhoeven wrote:
> On Thu, 19 Apr 2001, Iain Sandoe wrote:
>> On Thu, Apr 19, 2001,  Ani Joshi wrote:
>> > On Thu, 19 Apr 2001, William Blew wrote:
>> >> On Thu, 19 Apr 2001, Iain Sandoe wrote:
>> >> > 2/  how difficult would it be to plumb the scroll acceleration back into
>> the
>> >> > console driver?  (would one need access to the NDA stuff?) -- the
scrolling
>> >> > of console is a real problem in blocking sound :-/
>> >>
>> >> For mach64 at least, I would start by porting the CopyScreen2Screen XXA
>> >> operation into the kernel and then using it during scrolling.
>> >
>> > This is already done by atyfb in the kernel,
>>
>> then why is the atyfb scroll (and fbdevhw) _so_ much slower than the X
>> 'native' driver ... the same reason as below?
>
> Because xterm uses jump scroll? Try scrolling line by line in X11.

hmmm.  I was comparing "before" and "after" changing to Ani's new ati_drv.o
(before was using libfbdevhw.a) - in all other respects the configuration
was identical.

this is mach64 (3DU Pro) on G3/beige - the difference seemed to be striking
enough to comment (but I guess I could wind it back and do an X11Perf).

>> >however the problem lies in
>> > the entire fbcon layer where there is some improper locking/interrupts
>
> Read: the entire console layer. Fbcon cannot (read: couldn't) use interrupts
> because the upper console layer disables (disabled) interrupts.
>
>> > going on there.  This was discussed here and on linux-fbdev a few months
>> > ago and I believe will be addressed in 2.5.
>>
>> and there is a (temporary) fix for it (I believe) involving a patch from
>> Andrew Morton - (which I haven't had time to try on PPC yet).  Will that fix
>> the slow console scroll as well?
>
> It's supposed to. Haven't tried it yet, though.

I will ASAP - AFAICT the various blocking issues are the main problem with
(pmac) sound now.

ciao,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
