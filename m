Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 33D08679E0
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 31 Mar 2006 22:50:52 +1100 (EST)
Date: Fri, 31 Mar 2006 15:50:47 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Carlos Mitidieri <carlos.mitidieri@sysgo.com>
Subject: Re: pci-x
Message-ID: <20060331155047.0411cbf6@vitb.ru.mvista.com>
In-Reply-To: <200603310852.29987.carlos.mitidieri@sysgo.com>
References: <200603231435.01008.carlos.mitidieri@sysgo.com>
	<200603281651.53196.carlos.mitidieri@sysgo.com>
	<621AE6AC-D37E-4EB5-9390-7050B654C692@freescale.com>
	<200603310852.29987.carlos.mitidieri@sysgo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 31 Mar 2006 08:52:28 +0200
Carlos Mitidieri <carlos.mitidieri@sysgo.com> wrote:

> Hi,
> 
> I am using  a Rev PILOT board, S/N:0251
> To my discernment, a Rev PILOT is lower than a Rev A. 
> Is that correct?  
>    
> By the way, thank you very much.
> 
Yes, that is correct. 

There are some notes in u-boot documentation also, that might be interesting for you:

<citate>
1.0 Nomenclature

    For some reason, the HW designers describe the switch settings
    in terms of 0 and 1, and then map that to physical switches where
    the label "On" refers to logic 0 and "Off" (unlabeled) is logic 1.
    Luckily, we're SW types and virtual settings are handled daily.

    The switches for the Rev A board are numbered differently than
    for the Pilot board.  Oh yeah.

    Switch bits are numbered 1 through, like, 4 6 8 or 10, but the
    bits may contribute to signals that are numbered based at 0,
    and some of those signals may be high-bit-number-0 too.  Heed
    well the names and labels and do not get confused.

    "Off" == 1
    "On"  == 0

    SW18 is switch 18 as silk-screened onto the board.
    SW4[8] is the bit labled 8 on Switch 4.
    SW2[1:6] refers to bits labeled 1 through 6 in order on switch 2
    SW3[7:1] refers to bits labeled 7 through 1 in order on switch 3

1.1 For the MPC85xxADS Pilot Board

    First, make sure the board default setting is consistent with the document
    shipped with your board. Then apply the following changes:
    SW3[1-6]="all OFF"	(boot from 32bit flash, no boot sequence is used)
    SW10[2-6]="all OFF" (turn on CPM SCC for serial port,works for 8540/8560)
    SW11[2]='OFF for 8560, ON for 8540' (toggle 8540.8560 mode)
    SW11[7]='ON' (rev2), 'OFF' (rev1)
    SW4[7-8]="OFF OFF" (enable serial ports,I'm using the top serial connector)
    SW22[1-4]="OFF OFF ON OFF"
    SW5[1-10[="ON ON OFF OFF OFF OFF OFF OFF OFF OFF"
    J1 = "Enable Prog" (Make sure your flash is programmable for development)

    If you want to test PCI functionality with a 33Mhz PCI card, you will
    have to change the system clock from the default 66Mhz to 33Mhz by
    setting SW15[1]="OFF" and SW17[8]="OFF". After that you may also need
    double your platform clock(SW6) because the system clock is now only
    half of its original value. For example, if at 66MHz your system
    clock showed SW6[0:1] = 01, then at 33MHz SW6[0:1] it should be 10.

	SW17[8] ------+	   SW6
	SW15[1] ----+ |	  [0:1]
		    V V	   V V
	33MHz	    1 1	   1 0
	66MHz	    0 0	   0 1

    Hmmm... That SW6 setting description is incomplete but it works.


1.3 For the MPC85xxADS Rev A Board

    As shipped, the board should be a 33MHz PCI bus with a CPU Clock
    rate of 825 +/- fuzz:

	Clocks: CPU: 825 MHz, CCB: 330 MHz, DDR: 165 MHz, LBC:	82 MHz

    For 33MHz PCI, the switch settings should be like this:

	SW18[7:1] = 0100001 = M==33 =>	  33MHz
	SW18[8]	  =	  1	    => PWD Divider == 16
	SW16[1:2] =	 11	    => N == 16 as PWD==1

    Use the magical formula:
	Fout (MHz) = 16 * M / N = 16 * 33 / 16 = 33 MHz

	SW7[1:4]  =    1010 = 10    => 10 x 33	 = 330	CCB Sysclk
	SW7[5:6]  =	 01	    => 5:2 x 330 = 825	Core clock


    For 66MHz PCI, the switch settings should be like this:

	SW18[7:1] = 0100001 = M==33 =>	  33MHz
	SW18[8]	  =	  0	    => PWD Divider == 1
	SW16[1:2] =	 01	    => N == 8 as PWD == 0

    Use the magical formula:
	Fout (MHz) = 16 * M / N = 16 * 33 / 8 = 66 MHz

	SW7[1:4]  =    0101 =  5    => 5 x 66	 = 330	CCB
Sysclk SW7[5:6]  =	 01	    => 5:2 x 330 = 825	Core
clock

</citate>

> > Are you using a Rev A or higher board?  PCI-X doesn't work on earlier
> > systems.
> >
> > Also, make sure your board is configured to run PCI at 66 MHz.  PCI-X
> > doesn't work at 33 MHz.
> >
> >
> > Andy Fleming
> 
> Best regards,
> -- 
> Carlos Mitidieri
> SYSGO AG - Office Ulm
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 


-- 
Sincerely, 
Vitaly
