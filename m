Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D6ECFB6F8B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 20 May 2011 02:06:09 +1000 (EST)
Message-ID: <4DD53FDD.7070503@freescale.com>
Date: Thu, 19 May 2011 11:05:49 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 6/7] tty/powerpc: introduce the ePAPR embedded hypervisor
	byte channel driver
References: <1305813272-31826-1-git-send-email-timur@freescale.com>	<1305813272-31826-7-git-send-email-timur@freescale.com>
	<20110519153358.5876f310@lxorguk.ukuu.org.uk>
In-Reply-To: <20110519153358.5876f310@lxorguk.ukuu.org.uk>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: kumar.gala@freescale.com, linux-kernel@vger.kernel.org, akpm@kernel.org,
	linux-console@vger.kernel.org, greg@kroah.com,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alan Cox wrote:
>> > +		/* Pass the received data to the tty layer.  Note that this
>> > +		 * function calls tty_buffer_request_room(), so I'm not sure if
>> > +		 * we should have also called tty_buffer_request_room().
>> > +		 */
>> > +		ret = tty_insert_flip_string(ttys, buffer, len);

> You only need to request_room in advance if you can't handle the case
> where the insert_flip_string returns less than you stuffed down it.

If tty_insert_flip_string() returns less than I stuffed down it, the characters
it didn't accept will be dropped.  That's because once I receive them, I have
nowhere else to put them.  I suppose I could implement a receive FIFO, but that
seems overkill.  If calling tty_buffer_request_room() ensures that
tty_insert_flip_string() always accepts all the characters, I would rather do that.

-- 
Timur Tabi
Linux kernel developer at Freescale
