Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from www.etchedpixels.co.uk (earthlight.etchedpixels.co.uk
	[81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EA1D8B6F75
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 20 May 2011 19:53:03 +1000 (EST)
Date: Fri, 20 May 2011 10:54:17 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 6/7] tty/powerpc: introduce the ePAPR embedded
	hypervisor byte channel driver
Message-ID: <20110520105417.562c7341@lxorguk.ukuu.org.uk>
In-Reply-To: <4DD53FDD.7070503@freescale.com>
References: <1305813272-31826-1-git-send-email-timur@freescale.com>
	<1305813272-31826-7-git-send-email-timur@freescale.com>
	<20110519153358.5876f310@lxorguk.ukuu.org.uk>
	<4DD53FDD.7070503@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Thu, 19 May 2011 11:05:49 -0500
Timur Tabi <timur@freescale.com> wrote:

> Alan Cox wrote:
> >> > +		/* Pass the received data to the tty layer.  Note that this
> >> > +		 * function calls tty_buffer_request_room(), so I'm not sure if
> >> > +		 * we should have also called tty_buffer_request_room().
> >> > +		 */
> >> > +		ret = tty_insert_flip_string(ttys, buffer, len);
> 
> > You only need to request_room in advance if you can't handle the case
> > where the insert_flip_string returns less than you stuffed down it.
> 
> If tty_insert_flip_string() returns less than I stuffed down it, the characters
> it didn't accept will be dropped.  That's because once I receive them, I have
> nowhere else to put them.  I suppose I could implement a receive FIFO, but that
> seems overkill.  If calling tty_buffer_request_room() ensures that
> tty_insert_flip_string() always accepts all the characters, I would rather do that.

I was answering the question in the comment in the code...
