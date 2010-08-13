Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100813093438.GA18112@riccoc20.at.omicron.at>
References: <cover.1276615626.git.richard.cochran@omicron.at>
	<4a030d2bace90f089f2f3f61496b918c6f1dfb52.1276615626.git.richard.cochran@omicron.at>
	<AANLkTinYjzfChsN0AB5W6kOh6xJYPJtoEq941pG8WbmS@mail.gmail.com>
	<20100813093438.GA18112@riccoc20.at.omicron.at>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 13 Aug 2010 17:54:42 -0600
Message-ID: <AANLkTi=f0i7vetMvr4mK1cNJK6TYj1J6iCxjFeka00jc@mail.gmail.com>
Subject: Re: [PATCH 08/12] ptp: Added a brand new class driver for ptp clocks.
To: Richard Cochran <richardcochran@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: netdev@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org, Krzysztof Halasa <khc@pm.waw.pl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 13, 2010 at 3:34 AM, Richard Cochran
<richardcochran@gmail.com> wrote:
> On Tue, Jun 15, 2010 at 01:11:30PM -0600, Grant Likely wrote:
>> On Tue, Jun 15, 2010 at 10:09 AM, Richard Cochran
>> > +static DEFINE_SPINLOCK(clocks_lock); /* protects 'clocks' */
>>
>> Doesn't appear that clocks is manipulated at atomic context. =A0Mutex in=
stead?
> ...
>> If the spinlock is changed to a mutex that is held for the entire
>> function call, then the logic here can be simpler.
>
> Grant,
>
> I am working on another go at this patch series. Stupid question:
>
> The caller of ptp_clock_register(), which takes the clocks_lock, is
> always a module_init() function. Is this always a safe context in
> which to call mutex_lock?

Yes, you can take mutexes in the module_init context.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
