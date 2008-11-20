Return-Path: <miltonm@bga.com>
Received: from mercury.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 531ECDDE0E
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2008 06:08:53 +1100 (EST)
In-Reply-To: <20081119004220.GE29577@yookeroo.seuss>
References: <20081024035434.GF4267@yookeroo.seuss>
	<20081119004220.GE29577@yookeroo.seuss>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4569571e317d43f1b26b087fcdebcba3@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: powerpc: udbg based backend for hvc_console
Date: Thu, 20 Nov 2008 13:07:11 -0600
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linux-ppc <linuxppc-dev@ozlabs.org>, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

[I'm going to reply to several points in this thread in one reply.  I  
have restored context that was trimmed in later replys when I wanted to  
speak to.]

David Gibson wrote at 2008-11-18 00:28:28:
> On Mon, Nov 17, 2008 at 01:41:24PM -0600, Timur Tabi wrote:
>> On Thu, Oct 23, 2008 at 9:54 PM, David Gibson
>> <david@gibson.dropbear.id.au> wrote:
>>> This patch adds a new backend for the hvc console based on the
>>> low-level udbg callbacks.  This effectively implements a working
>>> runtime console in terms of the simple udbg primitives.  This is kind
>>> of a hack - since udbg isn't something you really want to be using
>>> routinely - but it's really useful during bringup.

Why is udbg hvc something you want to not use routinely?

Stated differently, if your routine (1) fundamently works one character  
at a time and (2) is not interrupt driven, and (3) only supports one  
channel, what avantage is there to an explicit hvc driver?

>>> This can be used to quickly implement a userspace usable console  
>>> while
>>> you're working on a proper driver for whatever console I/O device the
>>> hardware has.  Or, it can be used to avoid writing a full blown
>>> tty/console driver entirely for quick-and-dirty I/O hardware that  
>>> will
>>> later be replaced by something else.

Actually it looks remarkably similar to a cleaned up version of a patch  
i've been using since hvc_console was split to be a hookable shell.  Or  
was it the motivation for adding the hooks?  The code is different in  
how it structures the error checks and that it is implemented in  
drivers/char where it belongs (hence the cleaned up comment) but the  
fact that David recreated what I did does speak to its general utility.

>> David, I have a stupid question.  I already have an HVC console driver
>> that works.  Do I need to do anything, other than enable HVC_UDBG, to
>> get my hvc console drive to use udbg?

As was pointed out elsewhere, this is hvc calling udbg not udbg hooks  
calling hvc_cosole methods, which might need a different context.  But  
I wanted to comment on David's reply:

> Um.. well.. if you have both activated, I think you can select which  
> HVC console backend will be used by using console=/dev/hvcNN on the  
> commandline, where values of NN correspond to different backends, in  
> order depending on link order in some complex fashion.

It doesn't just work that way because of the way the hvc_console shell  
implements the console hooks.

If the drivers request different hvc channel numbers, then yes, you can  
select which hvc backend is used by choosing console=hvcNN.  If all  
request 0, then which ever one registers with hvc_console first wins  
the slot, and the others get a busy error return.   They can still  
register their tty later, at which point they get a dynamically  
determined /dev/hvcN slot, above all registered console slots.

There are multiple reasons for this design.  The original user, pseries  
vterm, wants to assign the channel number based on what the hypervisor  
tells it the channel should be.  There are two loops though the device  
tree, searching for different protocols (and consequently different  
backends), so they need to be able to specify the number and not just  
use the order they are found.  The platform describes not only the  
protocol, but which instance that is, and the backend currently  
registers with that number.  Another reason is its a bad idea to have  
console=/dev/hvc0 depend on link order instead of knowing which driver  
is selected.  If a user is specifing what the console is, it should not  
depend on other linked drivers.

Until this point, all mainline drivers have been exclusive in that only  
one will actually register with hvc_console midlayer on any given  
platform.  This is the first backend that is not exclusive, and  
therefore its coexistence needs special attention.

In my internal tree, I register (my version of) this not as hvc0 but as  
hvc4.  hvc0 is rtas, hvc1-3 are an internal backend, and this one is  
hvc4.  The order I chose is arbitrary, but the main point is it does't  
compete with hvc_rtas for slot 0.  (All of these drivers coexist, and I  
can choose which one I want to use based on my needs for that boot.)   
We could make it configurable via Kconfig, or just choose a slot.  (I  
think vterm can have 2 channels on some boxes where they drive real  
serial ports on the box.)

> But if you already have a working HVC console driver, I don't see why
> you'd want to use HVC_UDBG - it's essentially a bringup hack.

As I said, why should we need a fancier hvc_console backend if you are  
polling and gain no efficency processing  multiple characters at once.

The udbg drivers know if they are sharing the interface with a  
hvc_console some other driver.  If we trigger the registration of this  
backend on the udbg hook saying its useful (eg by setting a flag word  
in the function where we assign the udbg putc and getc pointers) then  
this driver will not need to be compiled out for "production" kernels.

David Gibson wrote at 2008-11-19 00:42:20:
> On Tue, Nov 18, 2008 at 09:06:17AM -0600, Timur Tabi wrote:
>> David Gibson wrote: [at 2008-11-18 05:14:08]
>>> Given the variety of strange I/O configurations in prototype and
>>> embedded platforms, I can't imagine this was a unique situation.  So
>>> I've pushed my patch out, so anyone else in a similar situation can
>>> immediately turn their little udbg methods for whatever strange I/O
>>> they have into a fully-functional console.  Maybe it's not something
>>> you'd want to go to release with, but it certainly simplifies life
>>> during bringup.
>>
>> Ok, I understand now.  However, I would like to see two changes:
>>
>> 1) Re-arrange the Makefile as I pointed out in another post.
[the other post]
Timur Tabi - 2008-11-17 20:18:31
>> One other thing ...
>> HVC console drivers must be compiled before hvc_console.o
>>
>> see  
>> http://git.kernel.org/?p=linux/kernel/git/paulus/powerpc.git; 
>> a=commit;h=938473b24636d77dc5e9c3f41090d071b6cf4389
[end other post]
>
> Um.. yeah.. I'm a bit baffled by this.. all the existing backends
> are listed after hvc_console, I just added hvc_udbg to the end.  I
> didn't really understand the rationale in that commit, but then I
> haven't had time to look at it very much yet.

I too challanged the necessity of that change.  I carefully designed  
the hvc_console layer to find the selected console weither it was  
registered before or after the console_initcall of hvc_console.

I am very disapointed that the changelog is so sparse.

However, I think the bottom line was that add_preferred_console is  
suppsoed to be called by architecture setup code.   Doing it the  
console_initcall is almost abuse.  But if the console_initcall is going  
to call add_preferred_console, then it must link before the hvc_console  
driver.   I would have to go back and find the discussion to remember  
the exact details.  (maybe it only needed to call  
add_preferreed_console before registering itself if its the only hvc  
backend).

Which does bring up the point of avoinding calling  
add_preferred_console to udbg just because it is linked in.  The udbg  
getc routines might work for xmon, but one would probably not like the  
result of the real driver and udbg trying to read the same device at  
the same time.  Perhaps the same flag that says "consider me or  
udbg_hvc" should apply, or we do add_preferred_console in arch code  
before console_initcall.  (its ok to preferr a console that never  
registers as long as another preferred console does register).

>> 2) Update the Kconfig help file to be very clear that this feature
>> is only meaningful if the platform has a udbg back-end but no other
>> console or TTY driver.
>
> Alrighty...

That does bring up the point, I don't see any kconfig help for this  
user-selectable option.

And if we don't have the udbg hooks say to enable it, then we really  
need to have text discouraging its use as it might break their console.

milton
