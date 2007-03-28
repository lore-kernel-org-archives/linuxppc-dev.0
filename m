Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <4609BF47.6030306@am.sony.com>
References: <20070327222840.GA1266@mag.az.mvista.com>
	<4609BF47.6030306@am.sony.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <a1b0c825d8e7446e1f755e820661b30a@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Disable external interrupts in bootwrapper
Date: Wed, 28 Mar 2007 18:57:09 +0200
To: Geoff Levand <geoffrey.levand@am.sony.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Disable external interrupts very early in the bootwrapper in case
>> the firmware left a device generating interrupts.
>
> This is just a guess at what is happening, but I think the OF on my
> G5 uses the timer interrupt as a kind of watchdog timer, so that if
> the loaded code hangs, OF will regain control.  If you disable
> interrupts, you may loose this functionality.

Apple OF uses the decrementer to implement all kinds of
alarms.  Calling "quiesce" will shut off EE.  Shutting
it off manually before that might result in weird behaviour.


Segher
