Return-Path: <iamatul@comcast.net>
Received: from rwcrmhc12.comcast.net (rwcrmhc14.comcast.net [216.148.227.89])
	by ozlabs.org (Postfix) with ESMTP id C0EA4689DD
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 Jan 2006 00:54:12 +1100 (EST)
Message-ID: <000b01c62023$1974ff80$02c0650a@ATULSPC>
From: "Atul Sabharwal" <iamatul@comcast.net>
To: "David Jander" <david.jander@protonic.nl>, <linuxppc-embedded@ozlabs.org>
References: <20060120194612.14F60353A3F@atlas.denx.de>
	<005301c61e54$aadb1b10$02c0650a@ATULSPC>
	<200601231032.38295.david.jander@protonic.nl>
Subject: Re: u-boot debugging
Date: Mon, 23 Jan 2006 05:44:14 -0800
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> I detect an increasing amount of resentment in your words, and that is not
> good as far as my experience goes...

This is true...  I have had quite a few bad experiences with open source 
product.
e.g. RH 6.2 the loop back driver would flush data to the driver every second 
time.
People at work would change compiler, graphic settings on me...  Swap ln 
commnad
options....  crack linux md5 passwords...  break gid/uid settings... steal 
my linux CD
roms...  This happened to me at my ex-employer for about 2.5 years for 
sure...
6 years in total (on my windows box with USB scanner, printers, boot sector 
crashes,
file/pdf corruption... Besides the usual of getting SPAM, virus, trojans 
etc... The latter
is okay but the rest is strange... ). Now when you are on a schedule 
deadline, how many
bugs can one fix... Code which runs on one day does not on another day... 
Its like
somebody (internally) is trying to sabotage my project or changing code 
without knowing
 what they are doing...  They could be doing this just to get rid of me 
either (which I dont
 know ) as I dont know *who*.  In the past, I used to just take my network 
cable off and
not be bothered with personal backups but on a shared network with clearcase 
I cant
go offline.  Cannot upgrade from 9.0 to Fedora...  Each day, there are 
different problems
with the machine...

So, this is the prime basis of resentment in my words. Its kind of happening 
again.
There are routines in u-boot e.g. cpu_post_exec_02 and cpu_post_exec_04 
which use a
stackless approach to copy a function to a given address, execute them and 
pass the values
back to the calling app.  It was working the other day and now its not.  I 
test the first instruction
it has to execute and it was supposed to be 0x38000000 and it shows as 
0x38000331.  I mentioned
it to my peer and next day its different.  I dont like hidden resources on 
my project but dont know
if I should ask ?  If its by design or by coincidence...  Generally hidden 
resources(unless very skilled
& dillignet) cause more harm than help...

I am not sure about gdb protocol support for Metrowerks but it should be an 
easy extension. Just
like changing the Phy on BDI should be easy change.  Not sure if it  has a 
FPGA or ASIC or some
controller driving the JTAG chain.  JTAG on BDI (is probably 12 or 16MHz) so 
its faster than
a 10Mbps ethernet link.  They were just saving cost as JTAG chain 
address/data cycles are long
so one wont get a full 10MHz data transfer.  JTAG by itself can go to 40MHz 
so, the next rev of
BDI can go with a faster JTAG chain and 100Mbps link or a USB link.

Advantages of Metwerks so far :
1.  Comes with the reference board from Freescale with 1 month license.
2.  I did not get any help from BDI to setup the config file for 870/885 
processor.
3.  BDI did not program the AMD 29F style flash part.
4.  BDI does not program the micro IC chip on Xscale.  If one wants to debug 
loadable modules
     using BDI it did not happen as it does before mounting the initial ram 
disk.  Seemed like
     a VECTOR LO/HIGH problem which their FAE did not or was not willing to 
explain.  Too much
     pain for the effort required to resolve the problem with external 
folks...
5.  On 8540, the BDI only worked with single stepping or running to a break 
point 5-10 instructions
     away.  Not sure what was the problem as I had to relocate the entire 
U-boot code to run from
     a pre-init DDR RAM instead of a swizzled flash in 5-7 days with no PPC 
experience.  Just schedule
     pressure becuase of lack of planning on other people's part.  On top of 
that, the mgmt wanted me to
     limit hours.  Not sure if to keep me less stressed or just be cheap!!
6.  Based on the above experience with BDI, I recommended Metrowerks.  On my 
project, one of
     the reference board was busted.  We could not get it fixed.  Each board 
was $2.5K each but they
     were useless.  The software CD ROM was erased by someone (which had all 
the manuals).
     Somebody broke into my car and started smoking ciggerettes.

So, what should I say.  How far can one complain.  I just told the 
psychologist that someone is giving me
a hard time.  Its definitely not any disorder....  Generally as engineer, we 
can differentiate between a
bug a feature and a hack.  When a hack (or a hacker) is trying to hinder 
your progress or cause grief
or spoof a website so that you have wrong u-boot code,  the individual is in 
trouble.    Based on probability,
its usually somone from the inside who changes code, crashes your 
CVS/clearcase or modifies code
without a trace(perfect bug fix or hack by clearing logs or buffer underrun 
problem to hack).  The cable
off solution along with shutting down all the server apps was an easy 
solution as the kernel is not listening
to sockets (since http server is gone from 2.4 kernel).  And if the site is 
spoofed, its usually your area ISP who can help.  (e.g. if you google for 
u-boot on source forge you only get u-boot 1.0.0 and if you access the site 
directly, you get access to 1.1.2 & 1.1.3).  Thats the main reason for the 
resentment.

Now, all one can do in these situations is complain.  Now if the complain 
falls on deaf ears, what more can
you do.  Typical answer is that you are working too hard. But this is an 
easy forced attrition method.
So, now if processors have a wireless link,  forced attrition would be a 
common problem.

And I am still objective.  Wolf does not maintain the sourceforge site. He 
is just the moderator or main
contributor.  And we are not using VPN's globally to reduce spoof web site 
problem as many open source
projects could have excess bugs in them...

--
Atul 
