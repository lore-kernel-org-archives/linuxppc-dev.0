Return-Path: <nvbolhuis@aimvalley.nl>
Received: from smtp-vbr10.xs4all.nl (smtp-vbr10.xs4all.nl [194.109.24.30])
	by ozlabs.org (Postfix) with ESMTP id A664B474E4
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Nov 2008 01:33:02 +1100 (EST)
Message-ID: <492D5B38.3080709@aimvalley.nl>
Date: Wed, 26 Nov 2008 15:20:40 +0100
From: Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: too few bogoMips on MPC8313E-RDB ?
References: <492D1CA5.2090007@aimvalley.nl>
	<20081126102042.GA11397@mail.gnudd.com>
In-Reply-To: <20081126102042.GA11397@mail.gnudd.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Thanks for the answer, but that's not it.

I checked the jiffies variable, it increases about 250 times
per second.
So the (mpc83xx_defconfig) kernel perception (#define CONFIG_HZ 250) is OK.

It must be something else, I still think 83.20 BogoMIPS
can't be correct for a MPC8313 running at 333 MHz.


Alessandro Rubini wrote:
>> This is what a linux-2.6.x reports (for the MPC8313E running at 333 MHz):
>> Calibrating delay loop... 83.20 BogoMIPS (lpj=166400)
>>
>> Which can't be correct.
>>
>> A MPC870 (running at 133 mhz) has ~ 131.07 BogoMIPS
> 
> Actaully, one-instruction-per-clock leads to BogoMIPS = MHz.
> 
> Your "loop per jiffies" value shows you make 332800 instructions per
> jiffy (a loop is two instructions: increment and jump).
> 
> So most liker your timer tick runs at 1000 Hz but Linux is thinking
> it's at 250Hz (332800 * 250 = 83.20 millions).
> 
>> Of course it's only a benchmark figure.
> 
> No, it's not a benchmark figure. It's the metric by which udelay() is
> calculated. So your udelays (and mdelays) will be 4 times shorter than
> required, and some hardware may be misbehaving as a result.
> 
> Hope this help
> /alessandro, who however is not runing a powerPC these times
> 
