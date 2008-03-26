Return-Path: <olof@lixom.net>
Date: Wed, 26 Mar 2008 10:08:28 -0500
From: Olof Johansson <olof@lixom.net>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [PATCH 2/2] pasemi_mac: Netpoll support
Message-ID: <20080326150828.GA6728@lixom.net>
References: <20080326015625.GA23103@lixom.net>
	<20080326015801.GC23103@lixom.net> <47EA445D.9090509@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47EA445D.9090509@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, pasemi-linux@ozlabs.org, jgarzik@pobox.com,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 26, 2008 at 03:41:01PM +0300, Valentine Barshak wrote:
>> +	pasemi_mac_tx_intr(mac->tx->chan.irq, mac->tx);
>> +	enable_irq(mac->tx->chan.irq);
>> +
>> +	disable_irq(mac->rx->chan.irq);
>> +	pasemi_mac_rx_intr(mac->rx->chan.irq, dev);
>
> Shouldn't this actually be pasemi_mac_rx_intr(mac->rx->chan.irq, mac->rx)?

Yeah, it should. It used to take the netdev pointer instead. And the
void * argument means I never got a compiler warning from it.

Thanks!

-Olof
