Date: Mon, 31 May 1999 18:05:24 +0200
To: linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Fwd: NVRAM
Message-Id: <19990531180524.002487@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This may interest some people here. Note that this was experimented by
Terry on MacOS 8.6, but the behaviour is probably the same on older versions:


On Mon, May 31, 1999, T Greeniaus <tmg@gpu.srv.ualberta.ca> wrote:

---------------- Begin Forwarded Message ----------------
Hi Ben,

Here's some info I thought you or someone on the LinuxPPC team might like to
know.  As you know, MacOS likes to wipe a modified (but valid - i.e. correct
checksum) NVRAM and replace it with a default one.  I have tracked the
problem down to a deficient checksum routine in MacOS.  MacOS replaces the
code with the default one if it thinks the checksum is incorrect, when in
fact the checksum _is_ correct.  The problem is that MacOS the following
routine to do the checksum:

unsigned long sum = 0;
unsigned short* p = nvramOFPartitionStart;	// Offset 0x1800 in NVRAM
for(unsigned long i=0;i<1024;i++)
	sum += *p++;
if(sum != 0x0057FFA8)
	ReplaceNVRAM();

That's pseudo-code, but the deal is that MacOS isn't shifting the upper
16-bits and adding them to the lower ones.  If you do that, you'll get:

0x0057 + 0xFFA8 = 0xFFFF

which indicates a valid checksum.  Thus, if you want to mess with the NVRAM,
you have to fudge it by adding dummy data in unused space so that the
MacOS checksum comes out as 0x0057FFA8.  One solution is to have all your
NVRAM strings live in the first 4K of NVRAM (the "other operating systems"
part of NVRAM) and have the entire OF partition as 0's plus enough 0xFFFF
dummy data to make a valid MacOS checksum.  OF will still run your nvramrc
code fine and nobody tries to wipe anything out of NVRAM.

I don't know if LinuxPPC uses any NVRAM or not these days (with BootX it
probably isn't necessary to apply any nvram patches) but someone on the team
might like to know, so please forward it to whoever you think is
appropriate.

TG



----------------- End Forwarded Message -----------------

-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>




[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
