Return-Path: <clifford@clifford.at>
Received: from phoenix.clifford.at (phoenix.clifford.at [88.198.7.52])
	by ozlabs.org (Postfix) with ESMTP id 36AD9DE01B
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  7 Jul 2007 18:36:59 +1000 (EST)
Date: Sat, 7 Jul 2007 10:41:14 +0200
From: Clifford Wolf <clifford@clifford.at>
To: Timur Tabi <timur@freescale.com>
Subject: Re: Mem-2-Mem DMA - Generalized API
Message-ID: <20070707084114.GD8448@clifford.at>
References: <20070624193932.GA11797@clifford.at>
	<200706242221.57507.arnd@arndb.de>
	<467FA0EA.3000607@genesi-usa.com> <467FBABD.9040103@anagramm.de>
	<467FD1DF.4000602@genesi-usa.com>
	<20070625180110.GH20463@clifford.at>
	<20070704090554.GA30693@clifford.at>
	<468F239B.5070800@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <468F239B.5070800@freescale.com>
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

Hi,

On Sat, Jul 07, 2007 at 12:24:43AM -0500, Timur Tabi wrote:
> Clifford Wolf wrote:
>> Hi,
>> On Mon, Jun 25, 2007 at 08:01:10PM +0200, Clifford Wolf wrote:
>>> I've put a 'draft header file' of an api as I would have expected it
>>> online: [...]
>> Ok, so here comes the first implementation:
>> (I also have other projects, so it took a while.. ;-)
>> 	http://www.clifford.at/priv/dmatransfer-20070704.diff
>
> Why aren't you following the DMA API in include/linux/dmaengine.h?

because dmaengine statically assigns dma channels to drivers. it does trhat
becaus it is in fact not a generic api but only designed for speeding up
TCP using the Intel I/OAT engine. If more drivers would try to use it one
would need to decide at compile time which driver should be the one that
may use the dmaengine.

My dmatransfer api assigns the dma channels dynamically and there is no
limit how many drivers could use dmatransfer instead of ioremap and memcpy.

Also my framework has support for scatter/gather dma, fifo modes and all
that stuff (but the mpc8349dma driver doen't implement it yet).

'Extending' dmaengine in a way so it supports all this would result in
replacing every public api function of dmaengine and having a much more
complicated backend. The only current dmaengine user is the tcp/ip code
which is just a few (less than 10 if i remember correctly) lines of code.

Imo dmaengine should be replaced by an entirely different api instead of
hacking around its shortcommings. Thats why I propose the dmatransfer api.

yours,
 - clifford

-- 
for(var d,i=<>just</>,j=function(){d~=i~(defined(i=next[*],i)?" ":"
");},just,another,SPL,hacker;defined i||({debug d;return 0;});j());
