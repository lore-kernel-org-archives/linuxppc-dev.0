From: "James S Lande" <jslande@crnotes.collins.rockwell.com>
To: linuxppc-dev@lists.linuxppc.org
Message-ID: <862567B0.0065DE1F.00@crnotes.collins.rockwell.com>
Date: Fri, 16 Jul 1999 13:28:01 -0500
Subject: research for a new booting mechanism
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




Say,

First some background....

I am in the processing of trying to find a different way to boot my 7500
into linux.  I am currently using BootX and/or OF via the system disk
application that comes with the Darwin Source.  Both of these work very
well, except that my wife and daughter (3 yrs old) sometimes inadvertently
boot into linux.  So I decided to come up with a different plan....

Research: [Doing this from memory of a couple of nights ago, since my Mac
is at home and I am at work]

I looked at the boot mechanism for the Macintosh at
http://developer.apple.com/techpubs/mac/OSUtilities/OSUtilities-189.html#MA
RKER-9-12 and found something that may be worthwhile....

excerpt form page >>>

 bbEntry
The entry point to the boot code stored in the boot blocks. This field
contains machine-language instructions that translate to BRA.S *+$90 (or
BRA.S *+$88, if the older block header format is used), which jumps to the
main boot code following the boot block header. This field is ignored,
however, if bit 6 is clear in the high-order byte of the bbVersion field or
if the low-order byte in that field contains $D.
bbVersion
A flag byte and boot block version number. The high-order byte of this
field is a flag byte whose bits have the following meanings: Bit Meaning
0-4 Reserved; must be 0
5 Set if relative system heap sizing is to be used
6 Set if the boot code in boot blocks is to be executed
7 Set if new boot block header format is used

If bit 7 is clear, then bits 5 and 6 are ignored and the version number is
found in the low-order byte of this field. If that byte contains a value
that is less than $15, the Operating System ignores any values in the
bb128KSHeap and bbSysHeapSize fields and configures the system heap to the
default value contained in the bbSysHeapSize field. If that byte contains a
 value that is greater than or equal to $15, the Operating System sets the
system heap to the value in bbSysHeapSize. In addition, the Operating
System executes the boot code in the bbEntry field only if the low-order
byte contains $D.
If bit 7 is set, the Operating System inspects bit 6 to determine whether
to execute the boot code contained in the bbEntry field and inspects bit 5
to determine whether to use relative sizing of the system heap. If bit 5 is
 clear, the Operating System sets the system heap to the value in
bbSysHeapSize. If bit 5 is set, the system heap is extended by the value in
 bbSysHeapExtra plus the fraction of available RAM specified in
bbSysHeapFract.

<<< End of excerpt

Then I used/modified the hdisk.pl script to look at how macos sets some
things up.  I noticed that the bbVersion field of the bootblock entry was
set to 0x44 or something
, basically bit 6 was not set.  So I thought of this plan....


Plan:

What if a person set bit 6 of the bbVersion field of the bootblock of a
dummy HFS partition and then at the end of the boot-block, put in the
/boot/first.b code?
My first attempt was to just dd the first.b to the first block of the dummy
 HFS partition.  Then I used System Disk from Darwin to boot off of this
disk.  Much to my surprise
quik actually kicked in and I was at the boot prompt.  But I couldn't boot
linux because it couldn't find the second.b chunk or the root filesystem.
I couldn't readily find the quik source at work, and don't have the source
RPM so, I stopped for now, mainly because I am going on a computer-less
vacation.
I thought I could look at/modify the source to read blocks from the disk/
or add hfs support/ to find/write the quik.conf file.
I also decided to post this to the dev list to see if anyone else had ever
tried something like this, so that I wouldn't be wasting my time if it had
been tried and found unsuccessful.


What do you guys think? Should something like this work, or am I just
wasting my time?  If I am wasting my time, I apologize if I wasted
yours.....


Thanks,
James "Bud" Lande


BTW... I wouldn't classify myself as a C guru, more of a hacker...



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
