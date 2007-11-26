Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id E955FDE2AE
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Nov 2007 04:13:25 +1100 (EST)
Message-ID: <474AFABE.1090702@scram.de>
Date: Mon, 26 Nov 2007 17:56:30 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [RFC/PATCHv3] powerpc: Move CPM command handling into the cpm
	drivers
References: <474886C2.7030609@scram.de> <474AEBD2.3040504@freescale.com>
In-Reply-To: <474AEBD2.3040504@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Scott,

>> +    spin_lock_irqsave(&cmd_lock, flags);
> 
> I'm a little uneasy about this -- what's the longest it can take for the
> CPM command to complete (or timeout)?  I'd rather use a mutex, if we can
> make sure that it's never called from atomic context.

Unfortunately, fs_enet may call this from interrupt context.

>> +EXPORT_SYMBOL_GPL(cpm_command);
> 
> Can we please not play the GPL DRM game here?

Arnd Bergmann proposed to change that, but you're right. This really is part
of the CPM API, so i'll revert this.

Thanks,
Jochen
