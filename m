Message-ID: <36B1932A.2AB39305@mailserv.rz.fh-muenchen.de>
Date: Fri, 29 Jan 1999 11:53:30 +0100
From: Christian Zankel <zankel@tarantel.rz.fh-muenchen.de>
MIME-Version: 1.0
To: minyard@acm.org
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: LinuxPPC and Force CompactPCI cards
References: <m290en9kfi.fsf@wf-rch.cirr.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello Corey,

> 
> Is anyone working on or interested in Linux of the for CompactPCI
> cards with the 750 processor?  Just curious...
> 

Actually, I have a 750 VME board here I want to start working on it as
soon as I can find some time for it. (Probably in a week, when I have
finished my exams).

I don't see much difficulties porting linux to the board as it mostly
uses standard components. And the main work seems to be already done
(Thanks to everyone working on the ppc-port! You did a great job!). 
Perhaps it might take more effort to write an own booter, like the
'milo' on alpha architectures, to replace the Powerboot/vxWorks-booter.

However, what concerns me more is the structure of the ppc-arch
directory. 
Perhaps I'm missing here something, but adding a new platform to the
ppc-arch means changing almost every common file (in ppc/kernel) and
adding more #ifdef's and if(architecture==FRC750) to them. I think,
these files are getting more and more unreadable. Besides, a lot of
platform specific files are also located in the ppc/kernel directory
(pmac_xxx.c, apus_xxx.c, etc.). So, adding new platforms means adding
new files to the common ppc/kernel directory. 
I don't see this as a problem if there should only be support for the
mainstream ppc platforms (like mac, perhaps chrp, prep). But I'm not
sure it's worth it blowing up the ppc/kernel directory and files only to
support another and probably less common used platform (like e.g. Force
750) (?).

So, I hoped, that the ppc-arch directory get changed to be more like the
m68k-arch structure. 
Here, each platform has its own directory. Most system functions with a
platform-specific implementation are variables of function pointers.
These variables are initialized by a platform dependend config routine
(e.g. config_mvme16x(...), config_amiga(...), etc.).
So, adding a new platform 'just' means to add a new directory and make
some minor changes to the rest of the files.

As I stated above, I hadn't had much time recently, so there might be
changes in this direction already on the way. Though it might be
unacceptable to make these changes in the 2.2 kernel.

I might be completely on the wrong way, so I'd really appreciate any
comments, if the arch/ppc should be and will be restructured or if less
common used platforms should be left out of the mainstream kernel, etc.


Thanks,
Christian



-- 
Christian Zankel       <zankel@mailserv.rz.fh-muenchen.de>

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
