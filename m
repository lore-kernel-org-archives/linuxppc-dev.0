Date: Tue, 21 Mar 2000 15:30:12 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Dave Weis <djweis@plconline.com>
cc: David Edelsohn <dje@watson.ibm.com>, Florian Lohoff <flo@rfc822.org>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: PPC/MCA RS/6000 port ? 
In-Reply-To: <Pine.LNX.4.10.10003210642540.11206-100000@catbert.desm.plconline.com>
Message-ID: <Pine.HPX.4.10.10003211521460.28648-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 21 Mar 2000, Dave Weis wrote:

>
> On Mon, 20 Mar 2000, Gabriel Paubert wrote:
>
> > However, if the use direct store segments is _unavoidable_, significant
> > kernel modifications are required.
>
> I know we've (Gabriel and I) discussed this, but could you elaborate?
> Based on what I've read in my docs, I think it is unavoidable. I'm getting
> closer to having the boot process figured out. Once I've got some more
> questions, I'm going to send my info to the list and see if my data looks
> accurate.

Right now the segment registers are only changed on task switches.
To access devices which are addressed through direct store segments, you
have to load one segment register (which occupies 256Mb of virtual address
space) when you enter the driver for this device.

You might also have to save/restore the segment register on interrupts,
and you'd better remove this segment when returning to user space or you
may create a huge security hole.

The best solution might be to designate one segment as reserved for this
purpose (say the last one) and use a save/restore mechanism in each
routine which needs to acces this kind of device. You have to make sure
that all paths restore it to the state it had on entry, but at least you
don't have to muck with the low level system call and interrupt entry and
exit code.

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
