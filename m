Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 8CF28DDEB9
	for <linuxppc-dev@ozlabs.org>; Sun, 12 Aug 2007 09:41:22 +1000 (EST)
Date: Sat, 11 Aug 2007 18:57:41 -0500
From: Olof Johansson <olof@lixom.net>
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [PATCH] remove gratuitous reads from pasemi pci config space
	methods
Message-ID: <20070811235741.GA8543@lixom.net>
References: <11866954472463-git-send-email-ntl@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <11866954472463-git-send-email-ntl@pobox.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 09, 2007 at 04:37:27PM -0500, Nathan Lynch wrote:
> The pasemi pci configuration space write method reads the written
> location immediately after the write is performed, presumably in order
> to flush the write.  However, configuration space writes are not
> allowed to be posted, making these reads gratuitous.  Furthermore,
> this behavior potentially causes us to violate the PCI PM spec when
> changing between e.g. D0 and D3 states, because a delay of up to 10ms
> may be required before the OS accesses configuration space after the
> write which initiates the transition.
> 
> Remove the unnecessary reads from pa_pxp_write_config.

Thanks!

> Signed-off-by: Nathan Lynch <ntl@pobox.com>

Acked-by: Olof Johansson <olof@lixom.net>


-Olof
