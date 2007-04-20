Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id AB0E3DDE39
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 21 Apr 2007 02:08:57 +1000 (EST)
Message-ID: <4628E642.1050702@grandegger.com>
Date: Fri, 20 Apr 2007 18:11:46 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: FDT for MPC5200, CPU revision, MSCAN
References: <462864CA.7050601@grandegger.com> <46286A0F.9080608@grandegger.com>
	<528646bc0704200702i328ba9dbvc62473e5a634d5ac@mail.gmail.com>
In-Reply-To: <528646bc0704200702i328ba9dbvc62473e5a634d5ac@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Grant Likely wrote:
> On 4/20/07, Wolfgang Grandegger <wg@grandegger.com> wrote:
>> Wolfgang Grandegger wrote:
>> > Hello,
>> >
>> > is there a way to distinguish the CPU revision (Rev.A vs. Rev.B) of the
>> > MPC5200, preferably at run time? Or should this be defined in the FDT?
>> > I ask, because some settings depend on the CPU revision due to hardware
>> > bugs, like the clock source used for MSCAN.
> 
> This stuff is defined in the device tree.  If you need to detect the
> version at runtime, then ideally your bootloader will read the PVR/SVR
> to determine the chip version and then pass the correct FDT to the
> kernel.

OK, I already realized the revision field in the DTS.

>> I found the information here:
>>
>> $ cat Documentation/powerpc/mpc52xx-device-tree-bindings.txt
> <snip>
>> Sorry for the noise.
> 
> Not noise; good question.

OK, then more questions for MSCAN related properties. The clock source 
for MSCAN is either derived from IPB or directly from the oscillator 
clock via CLKSRC bit. I guess that the property "system-clock" should 
provide that frequency:

$ cat Documentation/powerpc/mpc52xx-device-tree-bindings.txt
...
system-frequency        int             Fsystem frequency; source of all
                                         other clocks.

It needs also to be defined by the boot loader.

Thanks.

Wolfgang.
