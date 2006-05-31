Return-Path: <Becky.Bruce@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 18FEF67B30
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Jun 2006 09:04:52 +1000 (EST)
In-Reply-To: <B9FFC3F97441D04093A504CEA31B7C41A62B2F@msilexch01.marvell.com>
References: <B9FFC3F97441D04093A504CEA31B7C41A62B2F@msilexch01.marvell.com>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <687F6669-B58A-404A-9AC2-EDC34107F0EC@freescale.com>
From: Becky Bruce <Becky.Bruce@freescale.com>
Subject: Re: Setting I&D cache enable in the same mtspr instruction
Date: Wed, 31 May 2006 18:06:43 -0500
To: Assaf Hoffman <hoffman@marvell.com>
Cc: linuxppc-embedded@ozlabs.org, Rita Shtern <rita@marvell.com>,
	Ronen Shitrit <rshitrit@marvell.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


I think we need to hold off on this particular patch for a few days.   
I took a look at the manual section you're referencing here, and sure  
enough, it says that you shouldn't set both bits in the same mtspr  
instruction.  The manual says this in more than one place, in fact.   
However, that seemed a little bit odd to me, so I talked with a few  
of the hardware designers for the 745x family.  They assure me that  
the manual statement is false.  The normal code that sets ICE/ICFI/ 
DCE/DCFI all on one mtspr should be fully functional on this  
processor family.  I'm still working on confirming this and getting  
some history on *why* the manual says that, but for now I'd say it's  
a pretty good bet that the manual is in error.  I will let you know  
if I find out this is not the case.

You are correct, though, in that an isync is needed prior to the  
write of HID0[ICE]. It's probably missing because it's not listed in  
the synchronization table in chapter 2 of the manual.

For what it's worth, as soon as I can confirm this, I will make sure  
the publications team here at Freescale is made aware of the error so  
it can be corrected in the next printing of the manual.  I will also  
have the synchronization table updated as it also has incorrect  
information.

Thanks,
B
