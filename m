Return-Path: <fawadlateef@gmail.com>
Received: from qb-out-0506.google.com (qb-out-0506.google.com [72.14.204.238])
	by ozlabs.org (Postfix) with ESMTP id 808DB67B6C
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 20 Oct 2006 15:13:46 +1000 (EST)
Received: by qb-out-0506.google.com with SMTP id c7so104200qbc
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 19 Oct 2006 22:13:44 -0700 (PDT)
Message-ID: <1e62d1370610192213g7502709ufcc2bce6903040d8@mail.gmail.com>
Date: Fri, 20 Oct 2006 10:13:43 +0500
From: "Fawad Lateef" <fawadlateef@gmail.com>
To: "Rahul Theraja" <rahul.theraja@gmail.com>
Subject: Re: help in block drivers
In-Reply-To: <ff9652ca0610190923vffbb981j1978ce4159489b0c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <ff9652ca0610190314u32a620b5qd0bd27a1b2700a22@mail.gmail.com>
	<d16b1c80610190808y17c516dl35cfc8ca4a7a42ad@mail.gmail.com>
	<ff9652ca0610190923vffbb981j1978ce4159489b0c@mail.gmail.com>
Cc: kernelnewbies@nl.linux.org, Shakthi Kannan <shakthimaan@gmail.com>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello Rahul,

First of all please don't do top-posting rather do bottom-posting. For
more information search google.

On 10/19/06, Rahul Theraja <rahul.theraja@gmail.com> wrote:
> Hello Shakthi Kannan,
>
>  Thanks for the reply .
>
>
> > > driver. I could not understand why the "sbd_request " is called even
> though
> > > i have given only one read call from user space file.
> >
> > Block device I/O transfer is done in blocks.
> >
> > >  And also in the driver, in the function sbd_request() how does the
> driver
> > > get the parameters  like sector, current_nr_sectors and buffer.
> >
> > VFS <-> SCSI <-> Block device?
> >

I think its VFS<->Buffer-Cache<->Block-Device and if drive is mounted
then VFS<->FS<->Buffer-Cache<->Block-Device

> > > i could move
> > > furhter fastly.
> >
> > Fastly? IMHO, learning kernel development involves lot of patience.
> >
> > SK
>
>
>  Is it necessary to use kernel_thread() in block drivers. In  drivers/block
> loop.c i could see  kernel_thread() being used but in floopy.c it is not
> used. When is this kernel_thread() function is supposed to be used ?  In the
> sbd_device also the kernel_thread() is not used.
>

First in kernel-2.6.x its better to use kthread_*() rather than
kernel_thread if threading is needed.

Threading isn't necessary in any device until unless you need it. For
example if your driver is emulating a device or performing IO directly
then you don't need it, but if your driver is sending request to a
device which generates interrupts after completing IO and you want to
do some extra work after getting IO completion interrupt then you must
use thread. As threads work in process-context, hence can do sleep and
lengthy processing but interrupt-context shouldn't sleep or nor do
long processing.

For getting more understanding about different contexts like process,
interrupt, softirqs contexts do search google.

>  Anyone please kindly clarify my doubts.
>

I hope you doubts are not clear.

>  Thanks in Advance
>
>  -Rahul
>

-- 
Fawad Lateef
