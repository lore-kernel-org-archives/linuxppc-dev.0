Date: Wed, 13 Jan 1999 13:21:19 -0600 (CST)
From: "David A. Gatwood" <marsmail@globegate.utm.edu>
To: a sun <asun@saul9.u.washington.edu>
cc: linuxppc-dev@lists.linuxppc.org, bh40@calva.net
Subject: Re: Porting to NuBus PowerMacs
In-Reply-To: <199901131910.LAA28570@saul9.u.washington.edu>
Message-ID: <Pine.LNX.3.96.990113131521.9183I-100000@globegate.utm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 12 Jan 1999, a sun wrote:

>     Oh, and the i/o base address is different, which may or may not be
>     a problem, and supporting certain pieces of hardware (which will
>     remain nameless) will also require speed penalties (this is the
>     other reason MkLinux is slower than LinuxPPC...).
> 
> heh. am i correct in assuming then that just using memory barriers
> just won't cut it for a certain device that seems to have a bunch of
> delay()'s sprinkled throughout it? strangely, this same piece of
> hardware seems to be necessary to get the newer tech g3 extension and
> the mklinux booter happy... any insights there?

Oh, so you heard about that one, eh?  :-)  I got the impression from
sources that will remain nameless that if a certain register is set to
certain values, that certain piece of hardware will either write data to
or read data from the address stored in the register (details are fuzzy,
sorry), and that the issue is forcing the instructions to execute in the
correct order, thus putting a safe value into the register before the sync
instruction (I think) gets called, by means of delays, carefully crafted
branch instructions and other stuff to keep from having to do anything
nasty like a pipeline flush (i.e. even worse delay).  I think I remember
hearing that it only caused problems if the motherboard 601 was running
the machine (i.e. not an upgrade card), but I could be remembering wrong.


David

David A. Gatwood                         Visit globegate's internet
dgatwood@globegate.utm.edu                  talker, Deep Space 36
http://globegate.utm.edu                telnet globegate.utm.edu:9624

-----BEGIN GEEK CODE BLOCK-----
Version 3.1
GCS/CC/FA/H/L/MC/M/MU/PA/TW d-@ s:>- a-- C++ ++>$ UBLAS*++ ++>$
P+?>$ L++ +>$ !E--- W++ +>$ N++(++ +)>++ +$ !o? K-? !w--- !O
M++>$ !V-- PS+>$ !PE- Y+>$ PGP+>$ t++ +>$ 5+>++ ++$ !X- !R tv+>$
b++>$ !DI !D- G++(++ +)>$ e>++ ++ h--! r--- !y-

------END GEEK CODE BLOCK------


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
