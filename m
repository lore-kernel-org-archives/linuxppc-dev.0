Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8A3C0100991
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2011 19:26:00 +1100 (EST)
Subject: Re: [PATCH] serial: Add missing call to init UCC UART port timeout
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4C1B7312.6080708@ThePTRGroup.com>
Date: Thu, 24 Nov 2011 02:25:50 -0600
Message-Id: <5C543245-7785-4698-818A-6C8970FF1FB6@kernel.crashing.org>
References: <4C1B7312.6080708@ThePTRGroup.com>
To: Chuck Meade <chuck@ThePTRGroup.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 18, 2010, at 8:22 AM, Chuck Meade wrote:

> From: Chuck Meade <chuck@ThePTRGroup.com>
> 
> The UCC UART driver is missing a call to uart_update_timeout().
> Without this call, attempting to close the port after outputting large
> amounts of data (i.e. using tty and uart buffering) results in long
> timeouts before the port will actually be shut down.
> 
> For example, cat a large file to a UCC UART port.  With the current
> driver, the port will stay open for 30 seconds after the last byte
> of data is output.  But with this patch, the port is closed as
> expected, just after the data has been output (tx fifos empty).
> 
> Signed-off-by: Chuck Meade <chuck@ThePTRGroup.com>
> ---
> drivers/serial/ucc_uart.c |    3 +++
> 1 files changed, 3 insertions(+), 0 deletions(-)

applied to next

- k
