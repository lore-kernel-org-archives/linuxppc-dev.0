Message-Id: <199909171954.VAA27276@denx.local.net>
To: Dan Malek <dan@netx4.com>
cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Cleanup thought. 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 17 Sep 1999 14:45:43 EDT."
             <37E28C57.84668D8E@netx4.com>
Date: Fri, 17 Sep 1999 21:54:47 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <37E28C57.84668D8E@netx4.com> Dan Malek wrote:
> 
> It's distributed over a few, not any worse than any other machine
> specific information for any other Linux port.
> 
> You guys are just aware of it because you are constantly porting
> at a level most other people have already done for other systems.

That's exactly the same what I've heard form a RTOS vendor -  _their_
BSP layout was (and is) optimized for easy release and production for
several architectures, not for easy porting.

While that should be the target for the "generic" part of the kernel,
I wish the "BSP" part was optimized for easy  adaption  to  different
hardware.

> > Or (maybe better) a group of "BSP" (Board Support Package) files.
> 
> How many commercial BSPs have you used?  How many have you had

Some: I know 2 to a certain degree (pSOS and VxWorks), and I've  done
a lot of work with a third (LynxOS).

> to write from scratch for a board they didn't support when you
> received the package?  These can be very cumbersome.

Yes, I've done that before. Several times. And I was always  terribly
angry  when  they  changed  the  BSP  layout  in  the  next  release,
optimizing for production instead of porting issues.

> That is giving credit to the commercial BSPs that they do it
> right.  I don't think they do.  That is their best effort to
> provide configurability to a binary package.

I did not say it's *perfect* what they are doing, I just  think  that
it's  better  (*) than what we have now for Linux. There may be other
reasons for separating configuration options to BSP  files,  but  the
result is that porting to a new hardware is easier.

In my selfish way I here  define  "better"  to  mean  anything  which
reduces my amount of work :-)

> >   The current version of  arch/ppc/mbxboot/head.S  is  aready  pretty
> >   hard  to  read
> 
> Have you looked at the latest one in 2.3.18?

Yes, I have. It's pretty short, and pretty much useless  on  anything
else but an MBX board.

> >   I   suggest   to   rename   `head.S'   into    `head_mbx.S',    use
...
> Not gonna happen.  This is a maintenance nightmare.  It may work
> well for you, as you are only interested in one particular platform.

Ummm...  but  ".../mbxboot/..."  sounds  very  much  like  just   one
particular platform?

> >   Things that would  be  done  in  the  first  group:  disabling  the
> >   watchdog, initializing other peripherals on the board (for instance
> >   any slave 68360's :-), ...
> 
That's what boot roms are for.  The code in 'mbxboot' mirrors that
> of the other Linux booters.  There is an expected amount of system

I disagree here.

The Linux on the 8xx *is* much different  than  any  other  platform:
anything  else  is  some  type  of  "workstation",  but  the  8xx  is
epsecially for embedded systems.

Yes, I know that the out-of-the-box configuration for  Linux  expects
to  be  running  on  something  like  the  MBX8xx  board  and to have
something like the EPPCbug available for initialization.

It's nice when you have it, but I don't have it  on  the  boards  I'm
working on (hey, they are less than half the size of a credit card!).

I'm not asking that the  standard  distribution  is  supporting  such
simple  systems  out  of  the  box, but as long as there is no severe
reason against it I want to have an easy way to add such code  myself
for systems that need it.

> operation by the time you get here.  If that isn't the case, we

Well, all the firmware is doing for me  is  mapping  the  memory  and
starting my boot code - what else do I need? :-)

> need to find a place to add these functions (in another directory
> perhaps).  Most of the people I have worked with consider this

That's what I mean. But why reinvent the wheel?

> part of their "intellectual property" or board configuration
> options.  Many people have different memory/flash and other
> build options they have initialized prior to booting Linux.

Yes! That's what I'm saying. When "many" people have  done  this,  we
should think if this is not reason enough to provide an easier way of
doing  it.  I  guess  that  was one of Magnus Damm's intentions, too.
(Right?)

> We have to separate Linux booting options from the multitude of
> board configuration options.  The purpose of the boot code
> found in the 'mbxboot' directory is to locate the information
> necessary to continue the rest of the Linux boot, and ensure
> the kernel (and optionally initrd) are properly located for starting.

But booting is  just  one  part  of  the  story:  device  and  driver
configuration has to be done within the kernel, and it depends on the
specific hardware, too.

> I have been experimenting with pulling the initialization functions
> out of the "generic" drivers, using table lookup information, and
> adding the level of 8xx I/O configuration to the 'make config'
> scripts.  Nothing looks good to me yet, and believe me, I am trying.

That's good to know - and thank you very much in advance.

I can confirm from my experience with commercial RTOSes that there is
no easy way to get this right, and so far I have not  seen  one  that
has not created it's own problems.

> Well, you don't have to.  I am playing with a version right now
> where ALL of the serial ports you want are selected from the
> configuration script.  I am just working on a version to do this

Sounds pretty complex, and is probably not very easy to handle  in  a
commercial production environment.

Please keep in mind that for many projects you need to be able to run
a  full  configuration,  production   and   regression   test   cycle
automatically  after  any  changes. Do you expect that a .config file
from - say - linux-2.3.18 will be directly  re-usable  for  -  say  -
linux-2.4.2 ?

> last after it can determine how you have configured other CPM
> resources.  Of course, this is all processor dependent (823, 823e,
> 850, 855, 860, 860T 860P) as they all have different resources
> available.

Yes, I know. It's opening a *big* can of worms.

> Just remember that what is convenient and useful to you may be
> completely inappropriate for others....There are at least triple

That's why I replied to Magnus Damm's  message  -  to  discuss  these
issues,  finding  out  what  is  of  general interest and what I will
continue to use just for myself.

> the number of people that e-mail me privately and won't discuss

...which probably is a pity. OTOH you are probably  a  good  "filter"
:-)

> this on the list.  I am trying to find a solution that will make
> everyone happy....and would feel successful when we get over 50%.
> 
> The flexbility of this processor is the configuration killer, and
> what we just discussed isn't all of it.

I know, I know.

Ummm... is there anything we can help, then?

Wolfgang

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
It's not an optical illusion, it just looks like one.   -- Phil White

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
