Date: Tue, 1 Apr 2003 22:30:10 -0700
From: Matt Porter <porter@cox.net>
To: kas turi <inox_kas@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Disabling data cache
Message-ID: <20030401223010.A30745@home.com>
References: <20030402013434.7201.qmail@web21010.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030402013434.7201.qmail@web21010.mail.yahoo.com>; from inox_kas@yahoo.com on Tue, Apr 01, 2003 at 05:34:34PM -0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Apr 01, 2003 at 05:34:34PM -0800, kas turi wrote:
>
> Hi
>   We have a custom made board and we are running 8250
> processor. We are using DMA to transmit and receive
> data between peripheral and memory. The data is
> getting corrupted while transmitting and receiving. We
> are suspecting it might be due to data cache being
> enabled. So I disabled data cache in the routine
> enable_cache in the file arch/ppc/kernel/head.S. I
> rebuilt the kernel and when I run on my board it hangs
> after printing "Now booting the kernel". I would like
> to know why the kernel is not booting up. I have
> enclosed the console output:

Sure, you are hitting a number of places in early init
where the kernel uses dcbz.  You need to "fix" those areas
and hack the BAT setting to cache inhibit the DBATs that
map lowmem.  If you search the list archives, I recall an
old email describing what somebody did in detail to run
with dcache disabled on a classic PPC core.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
