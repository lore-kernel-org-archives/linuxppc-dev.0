To: Matt Porter <mmporter@home.com>
Cc: Cort Dougan <cort@fsmlabs.com>, Alois Fertl <alois_fertl@talknet.de>,
        LinuxppcDev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Changes for IDE on PREP Hardware
References: <38710186.B7930E52@talknet.de> <20000104222421.A31468@hq.fsmlabs.com> <20000105164119.C20193@cx258813-a.chnd1.az.home.com>
From: Eric Valette <valette@crf.canon.fr>
Date: 06 Jan 2000 13:15:48 +0100
In-Reply-To: Matt Porter's message of "Wed, 5 Jan 2000 16:41:19 -0700"
Message-ID: <u8d7rfl7kb.fsf@tri-yann.crf.canon.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> "Matt" == Matt Porter <mmporter@home.com> writes:

Matt> On Tue, Jan 04, 2000 at 10:24:21PM -0700, Cort Dougan wrote:
>> 
>> } Attached is a patch which allows to work Motorola PREP hardware (like
>> } Blackhawk) to use IDE devices (disk and cdrom). The patch tries to
>> } selectively introduce the changes for the Motorola hardware only.
>> } IBM's can stay with their irq 13 for IDE and with their preferred
>> } method of non swapped data stream. I have no chance to test on IBM.
>> 
>> How would this work if both irqs arrive at the same time?
>> 
>> Johnnie, Matt - can you test this out on your systems?

Matt> Alois' IDE patch is a subset of the functionality that has made it into
Matt> 2.2.14 from our IDE patch.  This patch doesn't account for the secondary
Matt> IDE controller on irq 15 among other things.  I'm attaching our full
Matt> patch as submitted versus 2.2.14pre4 so everybody can see the code I'm
Matt> talking about.  Note that changes to ide-pci.c, ide-probe.c, and sl82c105.c
Matt> in the patch got dropped and Alan said "maybe for 2.2.15".  The full patch
Matt> was tested on every board MCG has made with IDE. 

Matt> As for the 8259 patch, I think it may help the problem but will 
Matt> probably cause some bad situations disabling interrupts like that.  I
Matt> will test it out and see if it can be used or made better so we can
Matt> get these PReP 8259 problems behind us.

Just to tell you that : 

        1) I applied the 2.2.14pre4 prepide-patch on a clean
        linux 2.2.14 tree. Effectively the ppc part is in and
        not the ide-pci.c, ide-probe.c, and sl82c105.c
        2) BUT : after applying the missing part of the patches
        the behavior is absolutely identical!!!

hdc : lost interrupt...

any other hints?



-- 
   __                 
  /  `                   	Eric Valette
 /--   __  o _.          	Canon CRF - Communication Dept
(___, / (_(_(__         	Rue de la touche lambert
				35517 Cesson-Sevigne  Cedex
				FRANCE
Tel: +33 (0)2 99 87 68 91	Fax: +33 (0)2 99 84 11 30
E-mail: valette@crf.canon.fr	http://www.crf.canon.fr

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
