From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Wolfgang Denk <wd@denx.de>
Cc: <paulus@samba.org>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: boot methods 
Date: Mon, 15 Oct 2001 14:42:14 +0200
Message-Id: <20011015124214.18780@smtp.adsl.oleane.com>
In-Reply-To: <20011014154453.1829E10887@denx.denx.de>
References: <20011014154453.1829E10887@denx.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>* When porting Linux to new hardware the wrapper adds  an  additional
>  layer which must be adapted and ported. If you have PPCBoot running
>  on  a  board,  all  that's  needed to "port" Linux to that board is
>  copying things like ethernet intialization from the PPCBoot sources
>  - since PPCBoot is based on Linux device driver  code,  this  is  a
>  simple copy & paste.

No. When porting to new hardware, you expect your bootloader to pass
the proper bi_recs your kernel need and your wrapper will be either
empty, or just the standard one. In some case, I expect a same
kernel could even work with a wide range of boards as base addresses
and config for some legacy drivers could be passed via bi_recs as well.

The goal of bi_rec's here is to replace bd_t with a tagged structure.

One thing I want here is to stop parsing the bi_rec's once for all in
the kernel, but on the contrary keep them available all the time a bit
like the device-tree. For custom boards like the one(s) I'm working for
this is a flexible mecanism for my firmware to pass some HW informations
to the kernel, which stays the same for the whole range of products.

>* With PPCBoot, you can use the same kernel image on different boards
>  without need to recompile it just because you want differend  default
>  boot arguments.

Which is also what the bi_recs will help do in a more generic way.
The point of the wrapper is to handle firmware that don't already pass
the bi_recs we need, or more "interactive" firmwares like OF.

>* With PPCBoot, you can use the same kernel image in combination with
>  different ramdisk images without need to recompile it.

I don't see the problem neither. Our proposed mecanism won't replace
bootloaders like ppcboot.

>Etc. etc. It was one of our design goals with PPCBoot to get  rid  of
>all the (IMHO) unneccessary maintenance of the bootstap loader code.
>
>
>I can understand that the wrappers make sense for  boards  that  come
>with  some  firmware that cannot or shall not be changed; but this is
>the only reason I see for it's existence.

It handles whatever translation is needed between the firmware and the
kernel. If your firmware (ppcboot) already pass in good shaped birecs
and no translation is needed, just use an empty (or no) wrapper.
>
>Your argumentation sounds as if you expect many frequent  changes  of
>the kernel boot interface. Is that true? In sucha case I'd suggest we
>spend some more thoughts on that interface before changing it.

>> That's great, but I wonder what happens when someone upgrades their
>> PPCBoot to your new version and then wants to boot the old 2.4.2
>> kernel that they have lying around to check whether it shows a
>> particular problem they're chasing.
>
>This is not the first incompatible change we've  seen:  for  instance
>the  switch  from passing the clock frequencies in HZ (instead of MHz
>as it was before Patch 1.1.1.6) is such an incompatible change of the
>kernel interface.
>
>We will deal with it.
>
>> If we absolutely *have* to boot a vmlinux directly without a wrapper,
>> then probably the best thing is to use bi_recs and pass in a pointer
>> to them, since that is reasonably flexible and can be made to be
>> forwards and backwards compatible without too much pain.  Changing to
>
>It was my assumption from the  previous  discussions  that  this  was
>going  to  happen. I like it because you have the option to chose the
>implementation that fits best: if a wrapper seems appropriate it  can
>be  used  easily; if another solution seems simpler this can be used,
>too. Enforcing want to be forced to use of a wrapper  in  all  cases.
>want.
>
>> this scheme is going to cause considerable pain in the short term,
>> though.
>
>I don't see much difference to the status quo: f or all  the  systems
>using  a  wrapper  it is a transparent change like any other; for the
>other systems it's a new, incompatible  kernel  interface  just  like
>what happened with the Mhz / Hz change.
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
