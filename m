Return-Path: <greg@kroah.com>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ED5CD1007D3
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Sep 2011 09:08:48 +1000 (EST)
Date: Thu, 22 Sep 2011 16:06:40 -0700
From: Greg KH <greg@kroah.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] drivers/tty: don't use the byte channel handle as a
	parameter in ehv_bytechan.c
Message-ID: <20110922230640.GA16981@kroah.com>
References: <1316543217-13769-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1316543217-13769-1-git-send-email-timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	linux-console@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 20, 2011 at 01:26:57PM -0500, Timur Tabi wrote:
> The ePAPR hypervisor byte channel console driver only supports one byte
> channel as a console, and the byte channel handle is stored in a global
> variable.  It doesn't make any sense to pass that handle as a parameter
> to the console functions, since these functions already have access to the
> global variable.
> 
> This change also fixes this compilation warning on a 64-bit kernel:
> 
>   CC      drivers/tty/ehv_bytechan.o
> drivers/tty/ehv_bytechan.c: In function 'ehv_bc_console_write':
> drivers/tty/ehv_bytechan.c:289:24: warning: cast from pointer to integer of different size
> drivers/tty/ehv_bytechan.c: In function 'ehv_bc_console_init':
> drivers/tty/ehv_bytechan.c:355:24: warning: cast to pointer from integer of different size
> 
> This warning is because the driver is converting the integer byte channel
> handle to/from the void* 'data' field of struct console.  Rather than fix
> the warning, we just eliminate the code altogether.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>  drivers/tty/ehv_bytechan.c |    7 ++-----

This patch doesn't apply at all to my tty tree, what was it made
against?

confused,

greg k-h
