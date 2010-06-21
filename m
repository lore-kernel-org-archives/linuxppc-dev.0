Return-Path: <timur.tabi@gmail.com>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179]) by ozlabs.org (Postfix) with ESMTP id A21BEB6F14
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Jun 2010 03:55:51 +1000 (EST)
Received: by pvc22 with SMTP id 22so499546pvc.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 21 Jun 2010 10:55:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4C1B7312.6080708@ThePTRGroup.com>
References: <4C1B7312.6080708@ThePTRGroup.com>
From: Timur Tabi <timur.tabi@gmail.com>
Date: Mon, 21 Jun 2010 12:55:18 -0500
Message-ID: <AANLkTimcsYA04Qo9IZ2B-nULW0-WEkQvG2KxorwE34Zd@mail.gmail.com>
Subject: Re: [PATCH] serial: Add missing call to init UCC UART port timeout
To: Chuck Meade <chuck@theptrgroup.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 18, 2010 at 8:22 AM, Chuck Meade <chuck@theptrgroup.com> wrote:
> From: Chuck Meade <chuck@ThePTRGroup.com>
>
> The UCC UART driver is missing a call to uart_update_timeout().
> Without this call, attempting to close the port after outputting large
> amounts of data (i.e. using tty and uart buffering) results in long
> timeouts before the port will actually be shut down.
>
> For example, cat a large file to a UCC UART port. =A0With the current
> driver, the port will stay open for 30 seconds after the last byte
> of data is output. =A0But with this patch, the port is closed as
> expected, just after the data has been output (tx fifos empty).
>
> Signed-off-by: Chuck Meade <chuck@ThePTRGroup.com>

Acked-by: Timur Tabi <timur@freescale.com>

--=20
Timur Tabi
Linux kernel developer at Freescale
