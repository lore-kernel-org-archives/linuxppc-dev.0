Return-Path: <dhlii@dlasystems.com>
Received: from outbound-mail-57.bluehost.com (outbound-mail-57.bluehost.com
	[69.89.20.37]) by ozlabs.org (Postfix) with SMTP id 24B8CDDE11
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Nov 2007 07:34:51 +1100 (EST)
Message-ID: <474B2C56.5040008@dlasystems.com>
Date: Mon, 26 Nov 2007 15:28:06 -0500
From: "David H. Lynch Jr." <dhlii@dlasystems.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Xilinx devicetrees
References: <47480CF0.7090105@dlasys.net>	
	<fa686aa40711240912r192aba72o2cbdb798370e7b7c@mail.gmail.com>	
	<47493D4F.4070605@dlasys.net>	
	<fa686aa40711251421q38f53ee3hb2a308cc5f93183f@mail.gmail.com>	
	<4749FD5E.7000408@dlasys.net>	
	<20071125235855.95B9999804D@mail138-cpk.bigfish.com>	
	<EDAE140DF1B2FC42B5867C22CA0B333F0A58E4@XMBIL132.northgrum.com>
	<fa686aa40711260830y46aeb64cy8b662cad7196af8d@mail.gmail.com>
In-Reply-To: <fa686aa40711260830y46aeb64cy8b662cad7196af8d@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "Koss, Mike \(Mission Systems\)" <mike.koss@ngc.com>,
	Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On 11/26/07, Koss, Mike (Mission Systems) <mike.koss@ngc.com> wrote:
>   
>> DL>    And once again a plea to ALWAYS make version/capabilities registers
>> DL> atleast an optional part of every design.
>> DL>    Embeddeding a device tree into a design might be fairly expensive. a
>> DL> pair of read only 32 bit registers is damn near free - basically the
>> DL> FPGA equivalent of atmost 64 diodes or resistors.
>>
>> SN> Actually, device trees actually seem to be cheaper (in the whole system
>> sense) than such registers.  Unless there is something I don't understand?
>>     
    First the decoding for the register is almost certainly already
present for the other registers for the device.
    After that - assuming that an FPGA can impliment a read only
register as easily as discrete logic -  it should be damn near the
    most trivial peice of hardware imaginable. It is simpler than 64
bits of RAM. It can be simpler than 64bits of ROM.
    I do not think there is a way in the world that devicetrees can more
cheaply provide the same information.
    They might me more flexible, or powerful, but 2 64bit read only
registers.

    Anyway I am not arguing that you should not do devicetrees. Just
that you should do version/capabilities registers - atleast as a IP
option always.
    Every OS does nto support devicetree's. Every application of an FPGA
not going to have that as an option. But every peice of software that
can access and I/O device can access its version and capabilities registers.


> *If* edk is generating our device tree(s) for us, *then* version
> registers are not needed by Linux.
>   
    I want both. I want version registers - because they are ALWAYS
available.
    They are available to software running on the FPGA that has no clue
what bit file it is running on,how it got to be running.
    Devicetrees may provide a great deal more information bit it is not
hard to come up with scenarios where that information might not
    be present. It is like the security arguments about biometric
identification. I can forget my key card, my password, ... But I am
unlikely to forget my thumbprint or retina.
   

-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
