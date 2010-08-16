Return-Path: <johnstul.lkml@gmail.com>
MIME-Version: 1.0
Sender: johnstul.lkml@gmail.com
In-Reply-To: <AANLkTik_2MKMhOuDGOmu8Kzyq-ipLe+Bxrb3FaD+Tv4U@mail.gmail.com>
References: <cover.1281956490.git.richard.cochran@omicron.at>
	<363bd749a38d0b785d8431e591bf54c38db4c2d7.1281956490.git.richard.cochran@omicron.at>
	<AANLkTik_2MKMhOuDGOmu8Kzyq-ipLe+Bxrb3FaD+Tv4U@mail.gmail.com>
Date: Mon, 16 Aug 2010 12:38:06 -0700
Message-ID: <AANLkTikb3HxRSjfnDbDr3DbOJcAONahkdTiNAngoGGnk@mail.gmail.com>
Subject: Re: [PATCH 1/5] ptp: Added a brand new class driver for ptp clocks.
From: john stultz <johnstul@us.ibm.com>
To: Richard Cochran <richardcochran@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Rodolfo Giometti <giometti@linux.it>, netdev@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org, Krzysztof Halasa <khc@pm.waw.pl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 16, 2010 at 12:24 PM, john stultz <johnstul@us.ibm.com> wrote:
> On Mon, Aug 16, 2010 at 4:17 AM, Richard Cochran
> A few comments below....
>
>> +** PTP user space API
>> +
>> + =A0 The class driver creates a character device for each registered PT=
P
>> + =A0 clock. User space programs may control the clock using standardize=
d
>> + =A0 ioctls. A program may query, enable, configure, and disable the
>> + =A0 ancillary clock features. User space can receive time stamped
>> + =A0 events via blocking read() and poll(). One shot and periodic
>> + =A0 signals may be configured via an ioctl API with semantics similar
>> + =A0 to the POSIX timer_settime() system call.
>
> As I mentioned earlier, I'm not a huge fan of the char device
> interface for abstracted PTP clocks.
> If it was just the direct hardware access, similar to RTC, which user
> apps then use as a timesource, I'd not have much of a problem. But as
> I mentioned in an earlier private mail, the abstraction level concerns
> me.

[snip]

> 2) As Arnd already mentioned, the chardev interface seems to duplicate
> the clock_gettime/settime() and adjtimex() interfaces.

And maybe just to clarify, as I saw your response to Arnd, I'm not
suggesting using PTP clocks as clocksources for the internal
timekeeping core. Instead I'm trying to understand why PTP clocks need
the equivalent of the existing posix clocks/timer interface. Why would
only having a read-time interface not suffice?

thanks
-john
