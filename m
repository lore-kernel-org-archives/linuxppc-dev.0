Return-Path: <schwab@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 44398DDEE8
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Feb 2007 22:31:28 +1100 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Richard Purdie <rpurdie@rpsys.net>
Subject: Nvidiafb broken in 2.6.21-rc1
Date: Sat, 24 Feb 2007 12:31:11 +0100
Message-ID: <jezm737pxc.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

With 2.6.21-rc1 I get no video signal from nvidiafb on PowerMac G5.
Bisection has identified this patch:

commit 599a52d12629394236d785615808845823875868
Author: Richard Purdie <rpurdie@rpsys.net>
Date:   Sat Feb 10 23:07:48 2007 +0000

    backlight: Separate backlight properties from backlight ops pointers
    
    Per device data such as brightness belongs to the indivdual device
    and should therefore be separate from the the backlight operation
    function pointers. This patch splits the two types of data and
    allows simplifcation of some code.
    
    Signed-off-by: Richard Purdie <rpurdie@rpsys.net>

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
