Return-Path: <jarno.manninen@tut.fi>
Received: from pne-smtpout3-sn2.hy.skanova.net
	(pne-smtpout3-sn2.hy.skanova.net [81.228.8.111])
	by ozlabs.org (Postfix) with ESMTP id 34C45DE01C
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Feb 2008 06:17:31 +1100 (EST)
From: Jarno Manninen <jarno.manninen@tut.fi>
To: Nick <ndroogh@rogers.com>
Subject: Re: DTS question - MPC5200b
Date: Tue, 12 Feb 2008 20:07:41 +0200
References: <47B1D943.6020708@rogers.com>
In-Reply-To: <47B1D943.6020708@rogers.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200802122007.41259.jarno.manninen@tut.fi>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 12 February 2008 19:37:07 Nick wrote:

> How do I specify the timer based on the cell-index?

I don't know if that is possible to do in a one call, but maybe using the 
approach from mpc52xx_uart might help?

--clip--
        for_each_node_by_type(np, "serial") {
                if (!of_match_node(mpc52xx_uart_of_match, np))
                        continue;

                /* Is a particular device number requested? */
                devno = of_get_property(np, "port-number", NULL);
                mpc52xx_uart_of_assign(of_node_get(np), devno ? *devno : -1);
        }
--clip--

And change  serial->gpt, port-number to cell-index and add some logic to 
select the devices you want. Or if you wan't to do it a bit differently you 
could add a pseudo device outside the main tree like

	mydev {
		gpt-dev = <&the_gpt_dev>:
	};

And get it that way. However I don't know if this is recommended approach, but 
I've used it for some simple stuff like binding gpt in PWM mode to 
framebuffer backlight, along with power-pin.

Please correct any mistakes you who know better. 

- Jarno
