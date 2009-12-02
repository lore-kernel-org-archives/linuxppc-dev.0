Return-Path: <tj@kernel.org>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CEF0B1007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Dec 2009 12:55:21 +1100 (EST)
Message-ID: <4B15C910.3030700@kernel.org>
Date: Wed, 02 Dec 2009 10:55:28 +0900
From: Tejun Heo <tj@kernel.org>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 5/5] libata/drivers: Add pata_macio,
	driver Apple PowerMac/PowerBook IDE controller
References: <20091202003630.29919100851@ozlabs.org>	
	<4B15BDCF.5020000@kernel.org> <1259718678.2076.1057.camel@pasglop>
In-Reply-To: <1259718678.2076.1057.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, jeff@garzik.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

On 12/02/2009 10:51 AM, Benjamin Herrenschmidt wrote:
> I'm not sure what media bay locking problem you mentioned tho...
> 
> The way the driver does the locking now is that I block the media-bay
> thread (lock/unlock_media_bay calls) around initial registration and
> driver removal which blocks the callback event. At any other time, the
> callback event will just schedule EH so things should be fine.
> 
> I've left the debouncing in the mediabay code as well for both insertion
> and removal so there should be no issue here with glitches.

Ah... okay, I was misunderstanding where the race was.  If there's no
race condition against hotplug/unplug events with non-probing EH, no
problem.

-- 
tejun
