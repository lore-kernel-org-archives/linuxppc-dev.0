Message-Id: <199908122005.WAA00317@piglet.cpu.lu>
Date: Thu, 12 Aug 1999 22:05:47 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Trying a Promise Ultra/66 on powerpc
To: drow@false.org
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <19990808232621.B352@them.org>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On   8 Aug, this message from Daniel Jacobowitz echoed through cyberspace:
> On Sun, Aug 08, 1999 at 09:54:12PM +0200, Michel Lanners wrote:
>> >> > /dev/hdc:
>> >> >   Timing buffered disk reads:  32 MB in  5.83 seconds = 5.49 MB/sec
>> ;-)) How about this:
>> 
>> /dev/hde:
>>  Timing buffered disk reads:  64 MB in  6.60 seconds = 9.70 MB/sec
>> Maxtor 91024D4; 10G 7200 RPM, UDMA-2 ie 33 MB/s.
> 
> Eek.  I want that :)

No, you'd rather want _this_:

/dev/hda:
 Timing buffered disk reads:  64 MB in  4.67 seconds =13.70 MB/sec

bonnie looks even more impressive:

              -------Sequential Output-------- ---Sequential Input-- --Random--
              -Per Char- --Block--- -Rewrite-- -Per Char- --Block--- --Seeks---
Machine    MB K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU  /sec %CPU
max       200 12816 86.2 12382 38.7  5104 32.4 12365 84.6 20219 50.6 156.4  2.7

This is still with the Maxtor drive, but with forcing the burst bit
enabled:

PDC202XX_FORCE_BURST_BIT=y

I suppose this changes the way data is transfered across the PCI bus,
making the Promise send bursts of data rather than single longs.

So try it for yourself....

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
