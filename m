Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (hermes.mlbassoc.com [76.76.67.137])
	by ozlabs.org (Postfix) with ESMTP id 2126FDE1B7
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 05:59:29 +1000 (EST)
Message-ID: <4A14611E.4000003@mlbassoc.com>
Date: Wed, 20 May 2009 13:59:26 -0600
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Albrecht_Dre=DF?= <albrecht.dress@arcor.de>
Subject: Re: Weird 5200/mtd-ram problem
References: <1242848213.3432.0@antares>
In-Reply-To: <1242848213.3432.0@antares>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Albrecht Dreß wrote:
> Am 20.05.09 16:23 schrieb(en) Gary Thomas:
>> > In Linux, when I write the file to /dev/mtdx, the last dword of each
>> block is broken, e.g. when running "dd if=pattern of=/dev/mtd5 bs=512"
>> the dword's at offset 0x1fc, 0x3fc, ... are 0x0000aaaa (instead of
>> 0x0055aaff), if I use bs=1024 the dwords at 0x3fc, 0x7fc, ... show
>> this value, if I use bs=4096 the dword at 0xffc shows this value,
>> etc.  I looked at the CS/WR lines with a scope, and I couldn't see
>> anything special.  The timing should be fine, as u-boot uses the same
>> as Linux.
>> >
>> > Any idea what goes wrong here?  I guessed I missed something in the
>> LPB setup...
>>
>> Check your cache setup - the BDI is most certainly not accessing this
>> via the Data cache whereas Linux probably will be.
> 
> Hmm, yes - I didn't touch the vanilla Lite5200B Linux setup there, which
> has a flash chip at cs1...
> 
> If it is really a cache problem (I'm away now from my test board) -
> isn't a sync sufficient after doing the copy to the external ram
> (lpb/cs1)?  What is the proper approach for devices attached to the
> localbus?

Based on the behaviour, it's probably a timing problem with
multi-beat transfers.  When the PowerPC does cache flushes,
the chip activity is very different than the single beat accesses
used by the BDI.

Try to access this without using the cache.  If it works properly
then you'll need to look at the timing setup (the local bus registers)
to see why it fails with the multi-beat accesses.

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
