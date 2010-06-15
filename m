Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100615170806.GB10668@riccoc20.at.omicron.at>
References: <cover.1276615626.git.richard.cochran@omicron.at>
	<1b8219e7d7993d0e8204b94e959477e3007534ce.1276615626.git.richard.cochran@omicron.at>
	<AANLkTikeae2t4KmnawOCo2LqfSI57BKjNnUayY09DfEC@mail.gmail.com>
	<20100615170806.GB10668@riccoc20.at.omicron.at>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 15 Jun 2010 12:29:15 -0600
Message-ID: <AANLkTin8RI4UKzA58k_qER_urdwnD037u5GZrVQS8IoS@mail.gmail.com>
Subject: Re: [PATCH 05/12] phylib: Allow reading and writing a mii bus from
	atomic context.
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

On Tue, Jun 15, 2010 at 11:08 AM, Richard Cochran
<richardcochran@gmail.com> wrote:
> On Tue, Jun 15, 2010 at 10:43:08AM -0600, Grant Likely wrote:
>> On Tue, Jun 15, 2010 at 10:08 AM, Richard Cochran
>> <richardcochran@gmail.com> wrote:
>> > In order to support hardware time stamping from a PHY, it is necessary=
 to
>> > read from the PHY while running in_interrupt(). This patch allows a mi=
i
>> > bus to operate in an atomic context. An mii_bus driver may declare its=
elf
>> > capable for this mode. Drivers which do not do this will remain with t=
he
>> > default that bus operations may sleep.
>> >
>> > Signed-off-by: Richard Cochran <richard.cochran@omicron.at>
>>
>> Last I checked, the MDIO bus is very slow. =A0Is this really a good
>> idea? =A0How much latency does MDIO access have on the hardware you are
>> working with?
>
> Yes, MDIO access is slow, and it can vary (eg bit banging
> implementations). It clear that getting PHY timestamps is costly, but
> for applications that want PTP synchronization, one is willing to pay
> the price.
>
>> I also don't like the idea of taking a spin lock during MDIO
>> operations, and the dual locking mode in the core code.
>
> Originally, the phylib used a spinlock for this. It was replaced with
> a mutex in 35b5f6b1a82b5c586e0b24c711dc6ba944e88ef1 in order to
> accommodate mdio busses that may need to sleep. So, keeping the option
> to use a spinlock is similar to the previous implementation.

That's right, and I fully agree with that change.  To me, going back
to allowing spin locks is a regression because it adds a new source of
scheduling latency.  Using a mutex forces users to take into account
the slow nature of MDIO access.  For existing callers, this isn't a
problem because they already are designed for this characteristic.  A
new user which depends on atomic access should use a different API
which doesn't take the lock with the understanding that it is may
return a failure if it doesn't support it or if it cannot perform the
operation atomically.

That still leaves the troubling MDIO induced latency issue.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
