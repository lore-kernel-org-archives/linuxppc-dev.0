Return-Path: <annamaya@yahoo.com>
Received: from web53805.mail.yahoo.com (web53805.mail.yahoo.com
	[206.190.36.200]) by ozlabs.org (Postfix) with SMTP id CB8062BDB8
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Oct 2004 03:51:02 +1000 (EST)
Message-ID: <20041011175055.93158.qmail@web53805.mail.yahoo.com>
Date: Mon, 11 Oct 2004 10:50:54 -0700 (PDT)
From: annamaya <annamaya@yahoo.com>
To: Dan Malek <dan@embeddededge.com>
In-Reply-To: <079593FC-1BA4-11D9-A165-003065F9B7DC@embeddededge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Booting Linux using a PlanetCore BootLoader
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I loaded a zImage into address 0x100000 in RAM and
verified that this was indeed an ELF file. I then said
"go 0x100040" which would start executing the code
after skipping the 64 bytes of ELF header. But this is
what I see happen. 

BDI>info
    Target CPU        : MPC8280/8220/5200 (Zeppo)
    Target state      : debug mode
    Debug entry cause : <reserved 0>
    Current PC        : 0x00100040
    Current CR        : 0x20004022
    Current MSR       : 0x00000000
    Current LR        : 0xfff0531c

It looks like address 0x0 is reserved for some weird
reason. When I do a dump of the 0x0 area, it looks
like there is copy of the planetcore bootloader here
since I see some text indicating that. If I dont have
the BDI hooked up, I see an immediate reboot of the
device, consistant with executing the bootloader at
0x0. 

Any inputs on why this is happenning? I just
understand the PlanetCore bootloader very well.

--- Dan Malek <dan@embeddededge.com> wrote:

> 
> On Oct 11, 2004, at 12:04 PM, annamaya wrote:
> 
> > I am trying to boot a linux kernel using a
> PlanetCore
> > BootLoader on an embedded planet board. I am used
> to
> > always using U-Boot for my Kernel booting needs. I
> am
> > not sure how to get this going on a PlanetCore
> boot
> > loader.
> 
> You need to build a zImage so you get the simple
> bootloader that will read the information from the
> EEPROM
> and format the board structure.
> 
> Load the zImage file as a binary.  It has a 64K ELF
> header
> on it, so you can either use 'dd' to strip that
> before the
> download or add 64K to the load address to use as
> the
> start address.  The start address is the first
> instruction of
> the image (or +64K if you didn't remove the ELF
> header).
> 
> 
> 	-- Dan
> 
> 



		
_______________________________
Do you Yahoo!?
Declare Yourself - Register online to vote today!
http://vote.yahoo.com
