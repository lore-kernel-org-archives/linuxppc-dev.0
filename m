Return-Path: <orutsch@sympatec.com>
Message-ID: <474E9BC0.5010806@sympatec.com>
Date: Thu, 29 Nov 2007 12:00:16 +0100
From: Oliver Rutsch <orutsch@sympatec.com>
MIME-Version: 1.0
To: Linuxppc-dev@ozlabs.org
Subject: Re: MPC5200 I2C and 2.6 kernel
References: <20071128202245.90051247C1@gemini.denx.de>
In-Reply-To: <20071128202245.90051247C1@gemini.denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

>> hwclock --debug tells me:
> 
>> hwclock: Open of /dev/rtc failed, errno=19: No such device.
> 
> Well... did you check how your /dev/rtc is set up? It used  to  be  a
> misc  device with MAJ=10 MIN=135 in old kernel versions, but now it's
> MAJ=254 MIN=4, i. e. it should look like this:
> 
> crw-r--r-- 1 root root 254,   0 Jun 22 18:30 /dev/rtc
> 

Yes this was not correct in my filesystem. But in your filesystem
it looks like MAJ=254 MIN=0. I set MIN to 0 and applied Jon's
suggestions and now it works! So many thanks to Wolfgang and Jon,
this was really a hard problem for me!
But I should mention that I modified my dts for the M41T00 RTC
in the following way:

	rtc@68 {
		compatible = "stm,m41t00";
		reg = <68>;
	};

In some piece of an older driver I found the I2C Address for this RTC
(0x68), although the data sheet tells me that the slave address is 0xD0.
However, now it's up and running!

Thanks and bye,

-- 
Dipl. Ing. Oliver Rutsch
EMail: orutsch@sympatec.com
