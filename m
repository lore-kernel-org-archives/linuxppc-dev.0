Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910809220645g129eba73jc952d4bb2746f5db@mail.gmail.com>
Date: Mon, 22 Sep 2008 09:45:21 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Sergei Shtylyov" <sshtylyov@ru.mvista.com>
Subject: Re: solution to printk() blocking interrupts?
In-Reply-To: <48D77FCB.8000404@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910809211353k1f06fb5bi219c124d0c44b47a@mail.gmail.com>
	<9e4733910809211443l5638887aw856377d39fcca85c@mail.gmail.com>
	<48D77FCB.8000404@ru.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Sep 22, 2008 at 7:21 AM, Sergei Shtylyov
<sshtylyov@ru.mvista.com> wrote:
> Hello.
>
> Jon Smirl wrote:
>
>>> Does anyone have a solution to the problem of printk() to a serial
>>> console blocking interrupts for too long? I'm losing interrupts I need
>>> because my hardware is getting overrun.
>>>
>
>  It's a strange piece of hardware that loses interrupts on getting overrun.
> :-)

The 4 second pause slows down the debug/test cycle a lot. I'm using a
net booted monolithic kernel on the hardware and using the reset
button every time I make a change.

When you boot there are two classes of output, printk() output and
users space generated output. Right now I'm getting the printk()
output. Is there some way to see the user space output so that I can
tell if a user space server failed to start?

I changed poll to this code, but I don't know how network drivers
work. I can make changes and test them if you tell me what needs to be
fixed.


#ifdef CONFIG_NET_POLL_CONTROLLER
static void mpc52xx_fec_poll_controller(struct net_device *dev)
{
	struct mpc52xx_fec_priv *priv = netdev_priv(dev);

	disable_irq(priv->t_irq);
	mpc52xx_fec_tx_interrupt(priv->t_irq, dev);
	enable_irq(priv->t_irq);
	disable_irq(priv->r_irq);
	mpc52xx_fec_rx_interrupt(priv->r_irq, dev);
	enable_irq(priv->r_irq);
}
#endif






-- 
Jon Smirl
jonsmirl@gmail.com
