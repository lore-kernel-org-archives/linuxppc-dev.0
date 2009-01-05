Return-Path: <av1474@comtv.ru>
Received: from akado.ru (fe02x03-cgp.akado.ru [77.232.31.165])
	by ozlabs.org (Postfix) with ESMTP id B9888DE184
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Jan 2009 03:34:35 +1100 (EST)
Date: Mon, 5 Jan 2009 19:34:36 +0300 (MSK)
From: malc <av1474@comtv.ru>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: Lock-up on PPC64
In-Reply-To: <1231158516.8367.3.camel@localhost>
Message-ID: <Pine.LNX.4.64.0901051928200.2208@linmac.oyster.ru>
References: <Pine.LNX.4.64.0812212058550.2164@linmac.oyster.ru>
	<20081222233223.GA6688@joi> <877i5rh9rm.fsf@linmac.oyster.ru>
	<20081223234513.GA8730@deepthought> <871vvy77v4.fsf@linmac.oyster.ru>
	<1230165163.7292.32.camel@pasglop>
	<Pine.LNX.4.64.0812280335070.2526@linmac.oyster.ru>
	<1231158516.8367.3.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 5 Jan 2009, Michael Ellerman wrote:

> On Sun, 2008-12-28 at 03:45 +0300, malc wrote:
>> On Thu, 25 Dec 2008, Benjamin Herrenschmidt wrote:
>>
>>> On Wed, 2008-12-24 at 03:08 +0300, malc@pulsesoft.com wrote:
>>>> Ken Moffat <zarniwhoop@ntlworld.com> writes:
>>>>
>>>>> On Tue, Dec 23, 2008 at 06:04:45AM +0300, malc@pulsesoft.com wrote:
>>
>> [..snip..]
>>
[..snip..]

>>
>> Now to the Christmas cheer, i've tried v2.6.28 and couldn't help but
>> notice that the problem is gone, bisecting v2.6.27 (which funnily i
>> had to mark good) to v2.6.28 (which has to be marked bad) wasn't fun
>> but eventually converged at ab598b6680f1e74c267d1547ee352f3e1e530f89
>>
>> commit ab598b6680f1e74c267d1547ee352f3e1e530f89
>> Author: Paul Mackerras <paulus@samba.org>
>> Date:   Sun Nov 30 11:49:45 2008 +0000
>>
>>      powerpc: Fix system calls on Cell entered with XER.SO=1
>>
>> Now the lock-up is gone, however the code never exercises the path
>> taken during the lock-up so i guess it, at least, deserves a better
>> look by PPC64 care takers.
>
> I'm confused. Which code never exercises which path, and so what
> deserves a better look?

Before this change (atleast) mono_handle_native_sigsegv was executed
(before machine locks-up hard) after the change this code path is
never touched.

The fact that machine locks up hard and not even magic sysrq works
is what deserves a better look.

[..snip..]

-- 
mailto:av1474@comtv.ru
