Return-Path: <schwab@suse.de>
From: Andreas Schwab <schwab@suse.de>
To: Kevin Diggs <kevdig@hypersurf.com>
Subject: Re: inline assembly & r0 SOS
References: <4898EE60.9080206@hypersurf.com>
	<200808061041.50577.jk@ozlabs.org> <48990D0F.6050909@hypersurf.com>
Date: Wed, 06 Aug 2008 10:49:55 +0200
In-Reply-To: <48990D0F.6050909@hypersurf.com> (Kevin Diggs's message of "Tue,
	05 Aug 2008 19:31:43 -0700")
Message-ID: <jetzdyttn0.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org, Jeremy Kerr <jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kevin Diggs <kevdig@hypersurf.com> writes:

> Jeremy Kerr wrote:
>> Hi Kevin,
>>
>>
>>>         /*
>>>          * Turn r3 (range) into a rotate count for the selected
>>>range. * 0 -> 23, 1 -> 31
>>>          */
>>>         __asm__ __volatile__ (  "slwi %0,%0,3\n"
>>>                                 "addi %0,%0,23\n"
>>>                                 "rlwnm %0,%1,%0,30,31\n":
>>>                 "=r"(ret):
>>>                 "r"(config),"0"(range)
>>>         );
>>
>>
>> Wouldn't this be much simpler in plain C?
>>
> I just knew someone was gonna try to rain on my rlwnm'in fun parade!
> Wonder if the C code can be made to compile down to 3 instructions?

This will do:

unsigned int get_PLL_range(unsigned int range, unsigned int config)
{
  range = range * 8 + 23;
  return ((config << range) | (config >> (32 - range))) & 3;
}

The special pattern ((a << n) | (a >> (32 - n))) is recognized by gcc as
a rotate operation.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
