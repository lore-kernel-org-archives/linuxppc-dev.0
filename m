Return-Path: <kevdig@hypersurf.com>
Received: from smtpauth.hypersurf.com (smtpauth.hypersurf.com [209.237.0.8])
	by ozlabs.org (Postfix) with ESMTP id BE6B7DDED3
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Dec 2008 07:55:08 +1100 (EST)
Received: from [192.168.1.37] (66-81-71-92.bayarea.dialup.o1.com [66.81.71.92])
	(authenticated bits=0)
	by smtpauth.hypersurf.com (8.14.2/8.14.2) with ESMTP id mBNKslgq009024
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Dec 2008 12:55:01 -0800 (PST)
Message-ID: <49514F57.2050705@hypersurf.com>
Date: Tue, 23 Dec 2008 12:51:35 -0800
From: Kevin Diggs <kevdig@hypersurf.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: schizophrenic G5 ...
References: <494EDB3F.4090604@hypersurf.com>
	<20081223172245.792a9e2b@bopserverein.de>
In-Reply-To: <20081223172245.792a9e2b@bopserverein.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Christian Krafft wrote:
> On Sun, 21 Dec 2008 16:11:43 -0800
> Kevin Diggs <kevdig@hypersurf.com> wrote:
> 
> 
>>Hi,
>>
>>	I have a water cooled dual 2.5 GHz G5 (Powermac7,3). It has
>>YDL 6.0 on it. Using the stock YDL 2.6.23 kernel this machine
>>"appears" to work fine.
>>
>>	After finally getting it to boot under 2.6.27, it will shut
>>itself off if put under any significant load. And it is doing it very
>>quickly. Like within a few seconds of becoming busy. I just
>>discovered it is spitting out messages about "temperature way above
>>maximum" (from therm_pm72.c).
>>
> 
> 
> I have a very similar problem on my mac at work.
> I don't know atm how to look up the critical temperature that is
> fused. My mac reported only 55 degrees for the one cpu.
> The critical temperature can be read from the device-tree if i remember
> it correctly.
> I heard that there exists a bootable CD which contains a tool to refuse
> the CPU. Dont know where to download it, so my pragmatic solution was to
> relocate the machine to a room with air conditioning ;-)
> And I also run the ONE cpu at lowest frequency.
> 
> ck
> 

Critical temperature? If it is in the device tree are we sure it isn't 
(from the 970fx_thermal_diode_an, page 2, second paragraph):

In the PowerPC970FX family, the thermal diode is calibrated at a 
specified calibration temperature, usually around 70C, with no power on 
the chip, VDD = 0.0V, and 100 micro-amps being driven through the diode. 
The voltage across the diode is measured; it should be between 0.60V and 
0.80V. The measured voltage and temperature is stored in Thermal Diode 
Calibration fuse bits. A second lower temperature value is used to set 
the second calibration point, refer to the datasheet for this value.

On page 3 it also has:

Reading Thermal Diode Calibration Data Via JTAG
In order to access the Thermal Diode Calibration data stored in each 
processor, a sequence of JTAG commands must be issued, usually over the 
IIC bus. By using JTAG commands, the desired data will appear serially 
on the PowerPC970FX TDO pin or can be read using IIC. The detailed 
information on how to perform the read operation of the calibration 
registers is found in the PowerPC970FX User s Manual. Reading the 
thermal diode calibration register should be a one-time-only procedure. 
It is assumed that the Thermal Diode Calibration data stored in each 
processor will be captured and stored in system ROM for subsequent use.

kevin
